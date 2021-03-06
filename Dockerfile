FROM python:3-alpine

COPY container-build  /opt/setup/container-build
COPY requirements.txt /opt/setup/requirements.txt

RUN set -ex \
 && apk --no-cache add \
      bash \
      cargo \
      rust \
 && /opt/setup/container-build \
 && apk --no-cache del \
      bash \
      cargo \
      rust

ENTRYPOINT ["/usr/local/bin/docker-compose"]
CMD ["help"]
