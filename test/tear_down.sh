#!/bin/sh

IMAGE="${1}"

case "${IMAGE}" in
  *smoloney/ci-actions-*)
    echo "skipping image tear down in dockerhub"
    ;;
  *)
    if [ -n "$(docker image ls --filter=reference="${IMAGE}" -q)" ]; then
      docker rmi "${IMAGE}" > /dev/null
    fi
    ;;
esac
