#!/bin/sh

IMAGE="${1}"
RELATIVE_PATH="${2}"
VERSION="${3}"
WORKSPACE="${4}"

case "${IMAGE}" in
  *smoloney/ci-actions-*)
    echo "skipping image build in dockerhub"
    ;;
  *)
    export cwd_dir
    cwd_dir="${PWD}"
    cd "${RELATIVE_PATH}" && \
    cp ../common/argbash.sh ./ && \
    cp ../common/entrypoint.sh ./ && \
    cp ../common/functions.sh ./ && \
    docker build \
    --build-arg VERSION="${VERSION}" \
    --build-arg WORKSPACE="${WORKSPACE}" \
    --quiet \
    --no-cache \
    --tag "${IMAGE}" \
    ./ > /dev/null && \
    rm argbash.sh && \
    rm entrypoint.sh && \
    rm functions.sh && \
    cd "${cwd_dir}" || exit;
    ;;
esac
