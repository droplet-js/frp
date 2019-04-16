# --- clone ---

FROM alpine:3.9.3 as clone

ENV FRP_VERSION 0.26.0
ENV FRP_ARCH amd64

RUN wget https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_${FRP_ARCH}.tar.gz
RUN tar xzf frp_${FRP_VERSION}_linux_${FRP_ARCH}.tar.gz

# --- prod ---

FROM alpine:3.9.3 as prod

MAINTAINER v7lin <v7lin@qq.com>

ENV FRP_VERSION 0.26.0
ENV FRP_ARCH amd64

RUN apk --no-cache add curl bash tree tzdata

COPY --from=clone frp_${FRP_VERSION}_linux_${FRP_ARCH}/frpc /frpc

WORKDIR /

ENTRYPOINT ["/frpc"]
