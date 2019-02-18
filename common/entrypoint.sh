#!/bin/bash

set -eo pipefail

source /entrypoint/argbash.sh
source /entrypoint/functions.sh

exclude_paths="${_arg_exclude[*]}"
file_glob="${_arg_file_glob}"
exec_args="${_arg_exec_args}"

#  If the `--file-glob` command line argument is left empty, then `--exec-args` is run as is.
#  This is to facilitate instances where `--exclude` and `--file-glob` are not wanted/needed.
if [[ -z "${file_glob}" ]]; then
  bash -c "${exec_args}"
else
  IFS=' ' read -r -a file_paths <<< "$(get_file_paths "${exclude_paths}" "${file_glob}")"

  if [[ -n "${file_paths[*]}" ]]; then
    for file_path in "${file_paths[@]}"; do
      if [[ -n "${file_path}" ]]; then
        bash -c "${exec_args} ${file_path}"
      fi
    done
  fi
fi


