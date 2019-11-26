#!/bin/bash -e

HOST_OS=$(uname -s)

### ---- ###

echo "Switch back to master"
git checkout master
git reset --hard origin/master

### ---- ###

if ! [ -e jq ]; then
	echo "Loading local copy of jq-1.5"

	case ${HOST_OS} in
	Linux)
		curl -sSLo ./jq https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64
		;;
	Darwin)
		curl -sSLo ./jq https://github.com/stedolan/jq/releases/download/jq-1.5/jq-osx-amd64
		;;
	*)
		echo "/!\\ Unable to download jq for ${HOST_OS}"
		exit 1
		;;
	esac

	chmod +x jq
fi

### ---- ###

echo "Fetching latest version number of docker-compose"

COMPOSE_VERSION=$(curl -sSL https://pypi.python.org/pypi/docker-compose/json | ./jq -r .info.version)

if (git tag -l ${COMPOSE_VERSION} | grep -q ${COMPOSE_VERSION}); then
	echo "/!\\ Already got a tag for version ${COMPOSE_VERSION}, stopping now"
	exit 0
fi

echo "Writing requirements.txt"
echo "docker-compose==${COMPOSE_VERSION}" >requirements.txt

### ---- ###

echo "Testing build..."
docker build .

### ---- ###

echo "Updating repository..."
git add requirements.txt
git -c user.name='Travis Automated Update' -c user.email='travis@luzifer.io' \
	commit -m "docker-compose ${COMPOSE_VERSION}"
git tag ${COMPOSE_VERSION}

git push -q https://${GH_USER}:${GH_TOKEN}@github.com/luzifer-docker/docker-compose master --tags
