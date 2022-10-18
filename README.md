# Info
The plugin-driven server agent for collecting & reporting metrics. 

This container provides an easy and simple way to use telegraf without the hassle of library dependencies and compiling the source yourself.

## Volumes
None

## Run
```shell
docker run --name telegraf \
    -v /.../telegraf.conf:/telegraf/etc/telegraf.conf:ro \
    -d 11notes/telegraf:[tag]
```

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

## Build with
* [telegraf](https://github.com/influxdata/telegraf) - Telegraf
* [Alpine Linux](https://alpinelinux.org/) - Alpine Linux