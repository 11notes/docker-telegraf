# :: Build
  FROM golang:alpine as build
  ENV checkout=v1.26.3

  RUN set -ex; \
    apk add --update --no-cache \
      make \
      git; \
    git clone https://github.com/influxdata/telegraf.git; \
    cd /go/telegraf; \
    git checkout ${checkout}; \
    make build -j $(nproc); \
    mv telegraf /usr/local/bin;

# :: Header
  FROM 11notes/alpine:stable
  COPY --from=build /usr/local/bin/ /usr/local/bin

  # :: Run
  USER root

  # :: update image
    RUN set -ex; \
      apk update; \
      apk upgrade;

  # :: prepare image
    RUN set -ex; \
      mkdir -p /telegraf; \
      mkdir -p /telegraf/etc;

  # :: copy root filesystem changes and add execution rights to init scripts
    COPY ./rootfs /
    RUN set -ex; \
      chmod +x -R /usr/local/bin;

  # :: change home path for existing user and set correct permission
    RUN set -ex; \
      usermod -d /telegraf docker; \
      chown -R 1000:1000 \
        /telegraf;

# :: Start
  USER docker
  ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]