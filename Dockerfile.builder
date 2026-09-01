# Stage 1: Build Environment
FROM alpine:latest AS builder

# Install necessary build dependencies for Transmission
RUN apk add --no-cache \
    build-base \
    cmake \
    git \
    libevent-dev \
    curl-dev \
    openssl-dev \
    zlib-dev \
    linux-headers \
    miniupnpc-dev \
    libnatpmp-dev


# Fetch and replace the default Web UI
WORKDIR /tmp
RUN mkdir -p /usr/local/share/transmission/web/ 
RUN git clone https://github.com/ronggang/transmission-web-control.git && \
    cp -r transmission-web-control/src/* /usr/local/share/transmission/web/    

# Set up source directory and copy the local Transmission tree
WORKDIR /src
COPY . .

RUN git config --global --add safe.directory /src && \
    git submodule update --init --recursive

# Configure and compile Transmission (Daemon and CLI)
WORKDIR /src/build

RUN cmake -DCMAKE_BUILD_TYPE=Release \
          -DCMAKE_CXX_FLAGS="-Wno-maybe-uninitialized -Wno-error" \
          -DCMAKE_C_FLAGS="-Wno-maybe-uninitialized -Wno-error" \
          -DENABLE_DAEMON=ON \
          -DENABLE_MAC=OFF \
          -DENABLE_QT=OFF \
          -DENABLE_GTK=OFF \
          -DENABLE_CLI=ON .. && \
    make -j$(nproc) && \
    make install
