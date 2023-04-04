#!/bin/bash

update() {
  path=$(readlink -f "${BASH_SOURCE:-$0}")
  path=$(dirname "$path")

  source "$path/common.sh"
  echo "${TITLE}"
  echo "${PREFIX}Updating Strikers CLI..."

  cd "$path" || exit 1
  git pull origin main --quiet
  echo "${PREFIX}Strikers CLI updated successfully."
}