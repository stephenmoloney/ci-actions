#!/bin/bash

set -eo pipefail

show_changed_files() {
  local changed_files

  echo "The following files were changed in the most recent commit: "
  readarray -t changed_files <<< "$(git diff HEAD~1 --name-only)"
  for changed_file in "${changed_files[@]}"; do
    echo "${PWD%/*}/${changed_file}"
  done
}

have_files_changed() {
  local file_match
  local changed_files
  local local_files
  local common_files

  file_match='false'
  readarray -t changed_files <<< "$(git diff HEAD~1 --name-only)"
  readarray -t local_files <<< "$(find "${PWD}")"
  readarray -t common_files <<< "$(find ${PWD%/*}/common)"

  for local_file in "${local_files[@]}"; do
    for changed_file in "${changed_files[@]}"; do
      if [[ "${local_file}" -ef "${PWD%/*}/${changed_file}" ]]; then
        file_match='true'
      fi
    done
  done

  for common_file in "${common_files[@]}"; do
    for changed_file in "${changed_files[@]}"; do
      if [[ "${common_file}" -ef "${PWD%/*}/${changed_file}" ]]; then
        file_match='true'
      fi
    done
  done

  echo -n "${file_match}"
}

get_excluded_args() {
  local exclude
  local excluded_paths
  local excluded_dirs
  exclude="${1}"
  excluded_paths=""
  excluded_dirs=""
  IFS=' ' read -r -a exclude <<< "${exclude}"

  if [[ -z "${exclude[*]}" ]]; then
    echo -n ""
  else
    for path in "${exclude[@]}"; do
      if [[ -d "${path}" ]]; then
        excluded_dirs+=" -not ( -path ${path} -prune )"
      elif [[ -e "${path}" ]]; then
        excluded_paths+=" -not -path ${path}"
      fi
    done

    if [[ -z ${excluded_dirs} ]]; then
      echo -n "${excluded_paths}"
    elif [[ -z ${excluded_paths} ]]; then
      echo -n "${excluded_dirs}"
    elif [[ -z ${excluded_paths} ]] && [[ -z ${excluded_dirs} ]]; then
      echo -n ""
    else
      echo -n "${excluded_dirs} ${excluded_paths}"
    fi
  fi
}

get_file_paths() {
  local exclude
  local file_glob
  local excluded_args
  exclude="${1}"
  file_glob="${2}"
  IFS=' ' read -r -a excluded_args <<< "$(get_excluded_args "${exclude}")"

  if [[ -z "${excluded_args[*]}" ]]; then
    readarray -t results <<< "$(find . -type f -name "${file_glob}")"
  else
    readarray -t results <<< "$(find . "${excluded_args[@]}" -type f -name "${file_glob}")"
  fi

  echo -n "${results[@]}"
}
