# :: Build
  FROM golang:alpine as build
  ENV APP_VERSION=v1.28.3

  RUN set -ex; \
    apk add --update --no-cache \
      make \
      git; \
    git clone https://github.com/influxdata/telegraf.git; \
    cd /go/telegraf; \
    git checkout ${APP_VERSION}; \
    make build -j $(nproc); \
    mv telegraf /usr/local/bin;

# :: Header
  FROM 11notes/alpine:stable
  ENV APP_ROOT=/telegraf
  COPY --from=build /usr/local/bin/ /usr/local/bin

  # :: Run
  USER root

  # :: prepare image
    RUN set -ex; \
      mkdir -p ${APP_ROOT}; \
      mkdir -p ${APP_ROOT}/etc; \
      apk --no-cache upgrade;

  # :: copy root filesystem changes and add execution rights to init scripts
    COPY ./rootfs /
    RUN set -ex; \
      chmod +x -R /usr/local/bin;

  # :: change home path for existing user and set correct permission
    RUN set -ex; \
      usermod -d ${APP_ROOT} docker; \
      chown -R 1000:1000 \
        ${APP_ROOT};

# :: Start
  USER docker
  ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]