# Alpine :: Telegraf
Run Nodejs based on Alpine Linux. Small, lightweight, secure and fast 🏔️

## Run
```shell
docker run --name telegraf \
  -v /.../telegraf.conf:/telegraf/etc/telegraf.conf:ro \
  -d 11notes/telegraf:[tag]
```

## Defaults
| Parameter | Value | Description |
| --- | --- | --- |
| `user` | docker | user docker |
| `uid` | 1000 | user id 1000 |
| `gid` | 1000 | group id 1000 |

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
  urls = ["http://localhost:8086"]
  token = "**********************************************"
  organization = "influxdb"
  bucket = "global"

[[inputs.prometheus]]
  urls = ["http://localhost:8080/metrics"]
```

## Parent
* [11notes/alpine:stable](https://github.com/11notes/docker-alpine)

## Built with
* [telegraf](https://github.com/influxdata/telegraf)
* [Alpine Linux](https://alpinelinux.org/)

## Tips
* Don't bind to ports < 1024 (requires root), use NAT/reverse proxy
* [Permanent Stroage](https://github.com/11notes/alpine-docker-netshare) - Module to store permanent container data via NFS/CIFS and more