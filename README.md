# Luzifer / docker-compsoe

This repository contains a simple build for the `docker-compose` util as a replacement for a local installation of the utility.

## Usage

```bash
$ docker run --rm -ti \
    -v "/var/run/docker.sock:/var/run/docker.sock" \
    -v "$(pwd):$(pwd)" \
    luzifer/docker-compose help
```

Or you could create a shell alias for that command and use it like a local installation of docker-compose:

```bash
$ alias docker-compose='docker run --rm -ti -v "/var/run/docker.sock:/var/run/docker.sock" -v "$(pwd):$(pwd)" luzifer/docker-compose'
$ docker-compose help
```
