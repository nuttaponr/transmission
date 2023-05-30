FROM docker.io/library/transmission:4.0.3.base AS builder
ARG DEBIAN_FRONTEND=noninteractive 
ENV TZ=Etc/UTC 

FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive 
ENV TZ=Etc/UTC 
ENV TRANSMISSION_WEB_HOME=/transmission-web-control
RUN apt-get update && apt-get install -y ca-certificates \
    libcurl4-openssl-dev \
    libevent-dev \
    libminiupnpc-dev \
    libssl-dev

COPY --from=builder /transmission/transmission-web-control/src /transmission-web-control
COPY --from=builder /transmission/build/daemon/transmission-daemon /usr/bin/transmission-daemon

EXPOSE 9091 51413/tcp 51413/udp

ENTRYPOINT ["transmission-daemon", "--foreground", "--config-dir", "/config"]