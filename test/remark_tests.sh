#!/bin/sh

IMAGE=${2}
IMAGE="${IMAGE:-ci/remark}"
RELATIVE_PATH=${3}
RELATIVE_PATH="${RELATIVE_PATH:-./remark}"
HOST_VOLUME_PATH=${4}
HOST_VOLUME_PATH="${HOST_VOLUME_PATH:-${PWD}/test/ci-remark}"
VERSION=${5}
VERSION="${VERSION:-6.0.4}"
WORKSPACE=${6}
WORKSPACE="${WORKSPACE:-/ci-actions/workspace}"

if [ "${RELATIVE_PATH}" = "./remark" ]; then
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

testValidMarkdownPasses() {
  pass_1="$(
  docker run --rm -v ${HOST_VOLUME_PATH}:${WORKSPACE}:ro ${IMAGE} \
    --exclude='./FAIL.md' \
    --file-glob='*.md' \
    --exec-args='remark --frail --rc-path ./.remarkrc.1' \
    2>&1
  )"

  pass_2="$(
  docker run --rm -v ${HOST_VOLUME_PATH}:${WORKSPACE}:ro ${IMAGE} \
    --exclude='./FAIL.md' \
    --file-glob='*.md' \
    --exec-args='remark --frail --rc-path ./.remarkrc.2' \
    2>&1
  )"

  assertContains "${pass_1}" "no issues found"
  assertContains "${pass_2}" "no issues found"
}

testInvalidMarkdownFails() {
  pass_1=$(
  docker run --rm -v ${HOST_VOLUME_PATH}:${WORKSPACE}:ro ${IMAGE} \
    --exclude='./PASS.md' \
    --file-glob='*.md' \
    --exec-args='remark --frail --rc-path ./.remarkrc.1' \
    2>&1
  )

  pass_2=$(
  docker run --rm -v ${HOST_VOLUME_PATH}:${WORKSPACE} ${IMAGE} \
    --exclude='./PASS.md' \
    --file-glob='*.md' \
    --exec-args='remark --frail --rc-path ./.remarkrc.2' \
    2>&1
  )

  assertContains "${pass_1}" "5:4"
  assertContains "${pass_1}" "6:3"
  assertContains "${pass_1}" "10:16-10:21"
  assertContains "${pass_1}" "20:3"
  assertContains "${pass_1}" "20:3-20:54"
  assertContains "${pass_1}" "20:3-20:54"

  assertContains "${pass_2}" "5:4"
  assertContains "${pass_2}" "6:3"
  assertContains "${pass_2}" "10:16-10:21"
  assertContains "${pass_2}" "20:3"
  assertContains "${pass_2}" "20:3-20:54"
  assertContains "${pass_2}" "20:3-20:54"
}
