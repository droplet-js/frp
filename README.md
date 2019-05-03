# frp

[![Build Status](https://cloud.drone.io/api/badges/v7lin/frp/status.svg)](https://cloud.drone.io/v7lin/frp)
[![Docker Pulls](https://img.shields.io/docker/pulls/v7lin/frps.svg)](https://hub.docker.com/r/v7lin/frps)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://github.com/v7lin/frp/blob/master/LICENSE)

### 项目源码

[fatedier/frp](https://github.com/fatedier/frp)

### 用法示例

.env
````
# 顶级域名
SERVER_DOMAIN={your domain}

# Time Zone
TIME_ZONE=Asia/Shanghai

# frp - frps.${SERVER_DOMAIN}
FRP_TOKEN={your frp token}
FRP_DASHBOARD_USER={your frp admin user}
FRP_DASHBOARD_PWD={your frp admin password}
# 域名模式: frp.${SERVER_DOMAIN}
# 本地模式: mac -> host.docker.internal
FRP_SERVER_DOMAIN=frp.{your domain}
````

frps
````
  frps:
    image: v7lin/frps
    ports:
      - 80:80 # vhost - http
      - 443:443 # vhost - https
      - 6000-6010:6000-6010 # ssh
      - 7000:7000 # bind
      - 7500:7500 # dashboard
    environment:
      - TZ=${TIME_ZONE:-Asia/Shanghai}
    command:
      - "--log_level=info"
      - "--token=${FRP_TOKEN:-frp}"
      - "--dashboard_port=7500" # 没有默认值
      - "--dashboard_user=${FRP_DASHBOARD_USER:-frp}"
      - "--dashboard_pwd=${FRP_DASHBOARD_PWD:-frp}"
      - "--vhost_http_port=80"
      - "--vhost_https_port=443"
      - "--subdomain_host=frp.${SERVER_DOMAIN:-localhost}"
````

frpc-ssh
````
# 版本
version: "3.7"

# 服务
services:

  # SSH内网服务器
  frpc-ssh:
    container_name: frpc-ssh
    image: v7lin/frpc
    restart: always
    environment:
      - TZ=${TIME_ZONE:-Asia/Shanghai}
    command:
      - "tcp"
      - "--proxy_name=frpc-ssh"
      - "--local_ip=host.docker.internal"
      - "--local_port=22" # 没有默认值
      - "--remote_port=6000" # TODO 为不同机器分配不同端口
      - "--server_addr=${FRP_SERVER_DOMAIN:-host.docker.internal}:7000"
      - "--token=${FRP_TOKEN:-frp}"
      - "--log_level=info"
````

frpc-http
````
# 版本
version: "3.7"

# 服务
services:

  test:
    container_name: test
    image: nginx:1.15.8-alpine
    restart: always
#    ports:
#      - 80
    environment:
      - TZ=${TIME_ZONE:-Asia/Shanghai}

  test-frpc:
    container_name: test-frpc
    image: v7lin/frpc
    restart: always
    environment:
      - TZ=${TIME_ZONE:-Asia/Shanghai}
    command:
      - "http"
      - "--proxy_name=test"
      - "--local_ip=test"
      - "--local_port=80"
#      - "--sd=test" # subdomain
      - "--custom_domain=test.${SERVER_DOMAIN:-localhost}"
      - "--server_addr=${FRP_SERVER_DOMAIN:-host.docker.internal}:7000"
      - "--token=${FRP_TOKEN:-frp}"
      - "--log_level=trace"
    depends_on:
      - test
````
