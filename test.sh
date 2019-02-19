#!/bin/bash

if [[ ! -d /tmp/shunit2 ]]; then
  export current_dir
  current_dir="${PWD}"
  git clone -q https://github.com/kward/shunit2.git /tmp/shunit2 && \
  cd /tmp/shunit2 && \
  git checkout -q a35d3c && \
  cd "${current_dir}" || exit;
fi

/tmp/shunit2/shunit2 test/helm_tests.sh && \
/tmp/shunit2/shunit2 test/prettier_tests.sh
