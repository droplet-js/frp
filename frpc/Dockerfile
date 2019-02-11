# --- clone ---

FROM alpine:3.8 as clone

ENV FRP_VERSION 0.23.3
ENV FRP_ARCH amd64

RUN wget https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_${FRP_ARCH}.tar.gz
RUN tar xzf frp_${FRP_VERSION}_linux_${FRP_ARCH}.tar.gz

# --- prod ---

FROM alpine:3.8 as prod

ENV FRP_VERSION 0.23.3
ENV FRP_ARCH amd64

RUN apk --no-cache add curl bash tree tzdata

# 让 Linux 像 Mac 一样支持 host.docker.internal
RUN apk --no-cache add iproute2
COPY docker-host.sh /docker-host.sh
RUN chmod +x docker-host.sh; \
    /docker-host.sh

COPY --from=clone frp_${FRP_VERSION}_linux_${FRP_ARCH}/frpc /frpc

WORKDIR /

ENTRYPOINT ["/frpc"]
