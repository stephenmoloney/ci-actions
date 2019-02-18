#!/bin/sh

IMAGE=${2}
IMAGE="${IMAGE:-ci/helm}"
RELATIVE_PATH=${3}
RELATIVE_PATH="${RELATIVE_PATH:-./helm}"
HOST_VOLUME_PATH=${4}
HOST_VOLUME_PATH="${HOST_VOLUME_PATH:-${PWD}/test/ci-helm}"
VERSION=${5}
VERSION="${VERSION:-2.12.3}"
WORKSPACE=${6}
WORKSPACE="${WORKSPACE:-/ci-actions/workspace}"

export cwd_dir
cwd_dir="${PWD}"

ci_actions_exists() {
  docker image ls --filter=reference="${IMAGE}" -q
}

oneTimeSetUp() {
  case "${IMAGE}" in
    *smoloney/ci-actions-helm:latest*)
      echo "skipping image build in dockerhub"
      ;;
    *)
      cd "${RELATIVE_PATH}" && \
      cp ../common/argbash.sh ./ && \
      cp ../common/entrypoint.sh ./ && \
      cp ../common/functions.sh ./ && \
      docker build \
      --build-arg VERSION="${VERSION}" \
      --build-arg WORKSPACE="${WORKSPACE}" \
      --quiet \
      --no-cache \
      --tag "${IMAGE}" > /dev/null \
      ./ && \
      rm argbash.sh && \
      rm entrypoint.sh && \
      rm functions.sh && \
      cd "${cwd_dir}" || exit;
      ;;
  esac
}

testValidHelmTemplatesPass() {
  pass="$(
  docker run --rm -v "${HOST_VOLUME_PATH}":"${WORKSPACE}":ro "${IMAGE}" \
    --exec-args='helm lint ./pass' \
    2>&1
  )"

  assertContains "${pass}" "no failures"
}

testInvalidHelmTemplatesFail() {
  fail=$(
  docker run --rm -v "${HOST_VOLUME_PATH}":"${WORKSPACE}":ro "${IMAGE}" \
    --exec-args='helm lint ./fail' \
    2>&1
  )

  assertContains "${fail}" "render error"
}

oneTimeTearDown() {
  case "${IMAGE}" in
    *smoloney/ci-actions-helm:latest*)
      echo "skipping image tear down in dockerhub"
      ;;
    *)
      if [ -n "$(ci_actions_exists)" ]; then
        docker rmi "${IMAGE}"
      fi
      ;;
  esac
}
