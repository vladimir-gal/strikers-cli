#!/bin/bash

install=''

path=$(readlink -f "${BASH_SOURCE:-$0}")
path=$(dirname "$path")

source "$path/lib/common.sh"

INSTALL_TITLE_TEXT=$(cat "$(dirname "$0")/lib/title.txt")
INSTALL_TITLE="${COLOR_YELLOW}${INSTALL_TITLE_TEXT}${COLOR_REST}${NEW_LINE}"

echo "${INSTALL_TITLE}"
echo "${PREFIX}Welcome to Strikers CLI, a tool to automate git push and pull request creation with opinionated conventions."

read -e -p "${PREFIX}Do you want to install Strikers CLI? (y/n): " install

if [ "$install" != "y" ]; then
  echo "${PREFIX}Installation cancelled."
  exit 0
fi

echo "${PREFIX}Adding sts command to zshrc file..."
echo "alias sts='/bin/bash $path/lib/sts.sh'" >> ~/.zshrc
