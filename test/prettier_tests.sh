#!/bin/sh
# file: test/test.sh

IMAGE=${2}
IMAGE="${IMAGE:-ci/prettier}"
RELATIVE_PATH=${3}
RELATIVE_PATH="${RELATIVE_PATH:-./prettier}"
HOST_VOLUME_PATH=${4}
HOST_VOLUME_PATH="${HOST_VOLUME_PATH:-${PWD}/test/ci-prettier}"
VERSION=${5}
VERSION="${VERSION:-1.16.4}"
WORKSPACE=${6}
WORKSPACE="${WORKSPACE:-/ci-actions/workspace}"

if [ "${RELATIVE_PATH}" = "./prettier" ]; then
  TEST_PATH="${PWD}/test"
else
  TEST_PATH="${PWD%/*}/test"
fi

BEFORE="$(cat "${HOST_VOLUME_PATH}/format/format.yaml")"

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

  echo "${BEFORE}" > "${HOST_VOLUME_PATH}/format/format.yaml"
}

testValidYamlLintingPasses() {
  pass="$(
  docker run --rm -v "${HOST_VOLUME_PATH}/lint:${WORKSPACE}:ro" "${IMAGE}" \
    --exclude='./ignore-dir' \
    --exclude='./ignore-fail.yaml' \
    --file-glob='*.y*ml' \
    --exec-args='prettier --check --parser yaml --config ./.prettierrc.yml' \
    2>&1
  )"

  assertContains "${pass}" "All matched files use Prettier code style!"
}

testInvalidYamlLintingFails() {
  fail="$(
  docker run --rm -v "${HOST_VOLUME_PATH}/lint:${WORKSPACE}:ro" "${IMAGE}" \
    --exclude='./ignore-dir.yaml' \
    --file-glob='*.y*ml' \
    --exec-args='prettier --check --parser yaml --config ./.prettierrc.yml' \
    2>&1
  )"

  assertContains "${fail}" "error"
  assertContains "${fail}" "^^^^^^^^^"
}

testYamlBeforeFormat() {
  local before
  before=$(cat "${HOST_VOLUME_PATH}/format/format.yaml")

  assertEquals "${BEFORE}" "${before}"
}

testYamlAfterFormat() {
  local after

  docker run --rm -v "${HOST_VOLUME_PATH}/format:${WORKSPACE}" "${IMAGE}" \
    --file-glob='*.y*ml' \
    --exec-args='prettier --write --parser yaml --config ./.prettierrc.yml'

  after="$(cat "${HOST_VOLUME_PATH}/format/format.yaml")"
  assertNotEquals "${BEFORE}" "${after}"
}
