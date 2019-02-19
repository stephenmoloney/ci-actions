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

if [ "${RELATIVE_PATH}" = "./helm" ]; then
  TEST_PATH="${PWD}/test"
else
  TEST_PATH="${PWD%/*}/test"
fi

oneTimeSetUp() {
  "${TEST_PATH}/common/setup.sh" \
    "${IMAGE}" \
    "${RELATIVE_PATH}" \
    "${VERSION}" \
    "${WORKSPACE}"
}

oneTimeTearDown() {
  "${TEST_PATH}/common/tear_down.sh" \
    "${IMAGE}"
}

testValidHelmTemplatesPass() {
  pass="$(
  docker run --rm -v "${HOST_VOLUME_PATH}:${WORKSPACE}":ro "${IMAGE}" \
    --exec-args='helm lint ./pass' \
    2>&1
  )"

  assertContains "${pass}" "no failures"
}

testInvalidHelmTemplatesFail() {
  fail=$(
  docker run --rm -v "${HOST_VOLUME_PATH}:${WORKSPACE}":ro "${IMAGE}" \
    --exec-args='helm lint ./fail' \
    2>&1
  )

  assertContains "${fail}" "render error"
}
