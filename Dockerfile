# Stage 1: Build Environment
FROM transmission:builder AS builder

# Stage 2: Minimal Runtime Environment
FROM alpine:latest

ENV TRANSMISSION_WEB_HOME=/usr/local/share/transmission

# Install only the required runtime libraries
RUN apk add --no-cache \
    libevent \
    curl \
    openssl \
    miniupnpc \
    libnatpmp \
    zlib \
    libstdc++ \
    libgcc

# Copy compiled binaries and the updated Web UI from the builder stage
COPY --from=builder /usr/local/bin/transmission-* /usr/local/bin/
COPY --from=builder /usr/local/share/transmission/web /usr/local/share/transmission

# Expose standard Web UI and Peer listening ports
EXPOSE 9091 51413/tcp 51413/udp

# Set up volumes for persistent configuration and downloads
VOLUME ["/config", "/downloads"]

# Start the daemon in the foreground
ENTRYPOINT ["transmission-daemon", "--foreground", "--config-dir", "/config"]