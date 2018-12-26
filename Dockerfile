FROM alpine:3.8

RUN apk --no-cache add curl bash tree tzdata

COPY frp_linux_amd64 /

WORKDIR /
EXPOSE 80 443 6000 7000 7500

ENTRYPOINT ["/frps"]