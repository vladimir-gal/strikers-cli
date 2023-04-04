#!/bin/bash

selection=$1
path=$(readlink -f "${BASH_SOURCE:-$0}")
path=$(dirname "$path")

source $path/common.sh
source $path/push.sh
source $path/update.sh
source $path/open.sh
source $path/help.sh

case $selection in
  push)
    shift
    push "$@"
    ;;
  update)
    update
    ;;
  open)
    open
    ;;
  help)
    help
    ;;
  *)
    echo "${TITLE}"
    echo "${PREFIX}${COLOR_RED}Invalid argument, use ${TEXT_BOLD}sts help ${COLOR_REST}${COLOR_RED}to see available commands."
    ;;
esac