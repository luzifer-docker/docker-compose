FROM alpine

RUN set -ex \
 && apk --no-cache add \
      docker-cli-compose

ENTRYPOINT ["/usr/bin/docker-compose"]
CMD ["help"]
