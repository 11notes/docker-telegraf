#!/bin/ash
if [ -z "${1}" ]; then
    set -- "telegraf" \
        --config /telegraf/etc/telegraf.conf
fi

exec "$@"