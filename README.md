# Alpine :: Telegraf
![size](https://img.shields.io/docker/image-size/11notes/telegraf/1.28.3?color=0eb305) ![version](https://img.shields.io/docker/v/11notes/telegraf?color=eb7a09) ![pulls](https://img.shields.io/docker/pulls/11notes/telegraf?color=2b75d6) ![activity](https://img.shields.io/github/commit-activity/m/11notes/docker-telegraf?color=c91cb8) ![commit-last](https://img.shields.io/github/last-commit/11notes/docker-telegraf?color=c91cb8)

Run Telegraf based on Alpine Linux. Small, lightweight, secure and fast 🏔️

## Run
```shell
docker run --name telegraf \
  -v ../telegraf.conf:/telegraf/etc/telegraf.conf:ro \
  -d 11notes/telegraf:[tag]
```

## Defaults
| Parameter | Value | Description |
| --- | --- | --- |
| `user` | docker | user docker |
| `uid` | 1000 | user id 1000 |
| `gid` | 1000 | group id 1000 |
| `home` | /telegraf | home directory of user docker |
| `config` | /telegraf/etc/telegraf.conf | default configuration |

# Examples telegraf.conf
```shell
[agent]
  interval = "10s"
  round_interval = true
  metric_batch_size = 1000
  metric_buffer_limit = 10000
  collection_jitter = "0s"
  flush_interval = "10s"
  flush_jitter = "0s"
  precision = "0s"
  hostname = "telegraf"

[[outputs.influxdb_v2]]
  urls = ["https://influxdb"]
  token = "**********************************************"
  organization = "influxdb"
  bucket = "global"

[[inputs.prometheus]]
  urls = ["http://localhost:8080/metrics"]
```

## Parent image
* [11notes/alpine:stable](https://github.com/11notes/docker-alpine)

## Built with and thanks to
* [telegraf](https://github.com/influxdata/telegraf)
* [Alpine Linux](https://alpinelinux.org/)

## Tips
* Only use rootless container runtime (podman, rootless docker)
* Don't bind to ports < 1024 (requires root), use NAT/reverse proxy (haproxy, traefik, nginx)