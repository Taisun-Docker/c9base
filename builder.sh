#! /bin/bash
DOCKER_TAG=$1
DOCKER_ARCH=$2

# Grab the qemu binaries
wget https://s3-us-west-2.amazonaws.com/taisun-builds/qemu/qemu-aarch64-static
wget https://s3-us-west-2.amazonaws.com/taisun-builds/qemu/qemu-arm-static
chmod +x qemu-*
# Build image
docker build --no-cache -f Dockerfile.${DOCKER_ARCH} -t ${DOCKERHUB_LIVE}:${DOCKER_ARCH}-${TRAVIS_COMMIT}-${DOCKER_TAG} .
# Tag image
docker tag ${DOCKERHUB_LIVE}:${DOCKER_ARCH}-${TRAVIS_COMMIT}-${DOCKER_TAG} ${DOCKERHUB_LIVE}:${DOCKER_ARCH}-${DOCKER_TAG}
# Login to DockerHub
echo $DOCKERPASS | docker login -u $DOCKERUSER --password-stdin
# Push image
docker push ${DOCKERHUB_LIVE}:${DOCKER_ARCH}-${TRAVIS_COMMIT}-${DOCKER_TAG}
docker push ${DOCKERHUB_LIVE}:${DOCKER_ARCH}-${DOCKER_TAG}
