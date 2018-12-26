# --- clone ---

FROM alpine:3.8 as clone

ENV FRP_VERSION 0.22.0

RUN wget https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz
RUN tar xzf frp_${FRP_VERSION}_linux_amd64.tar.gz

# --- prod ---

FROM alpine:3.8 as prod

ENV FRP_VERSION 0.22.0

RUN apk --no-cache add curl bash tree tzdata

COPY --from=clone frp_${FRP_VERSION}_linux_amd64/frps /frps

WORKDIR /
EXPOSE 80 443 6000 7000 7500

ENTRYPOINT ["/frps"]