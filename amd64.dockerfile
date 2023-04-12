# :: Build
	FROM golang:alpine as telegraf
	ENV checkout=v1.26.1

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
	FROM alpine:latest
	COPY --from=telegraf /usr/local/bin/ /usr/local/bin

# :: Run
	USER root

	# :: prepare
        RUN set -ex; \
            mkdir -p /telegraf; \
            mkdir -p /telegraf/etc;

		RUN set -ex; \
			apk add --update --no-cache \
				shadow;

		RUN set -ex; \
			addgroup --gid 1000 -S telegraf; \
			adduser --uid 1000 -D -S -h /telegraf -s /sbin/nologin -G telegraf telegraf;

    # :: copy root filesystem changes
        COPY ./rootfs /

    # :: docker -u 1000:1000 (no root initiative)
        RUN set -ex; \
            chown -R telegraf:telegraf \
				/telegraf

# :: Start
	RUN set -ex; chmod +x /usr/local/bin/entrypoint.sh
	USER telegraf
	ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]