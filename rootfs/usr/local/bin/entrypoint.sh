#!/bin/ash
  if [ -z "${1}" ]; then
    set -- "telegraf" \
      --config ${APP_ROOT}/etc/telegraf.conf
  fi

  exec "$@"