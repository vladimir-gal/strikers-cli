help() {
  path=$(readlink -f "${BASH_SOURCE:-$0}")
  path=$(dirname "$path")
  source "$path/common.sh"
  echo "${TITLE}"
  echo "${PREFIX}Strikers CLI is a tool to automate git push and pull request creation with opinionated conventions."
  echo "${PREFIX}Usage: ${TEXT_BOLD}sts <command> [options]${COLOR_REST}"
  echo "${PREFIX}Commands:"
  echo "${PREFIX}  ${TEXT_BOLD}push [options]${COLOR_REST} - Pushes the current branch to the remote repository and creates a pull request."
  echo "${PREFIX}  ${TEXT_BOLD}update${COLOR_REST} - Updates Strikers CLI to the latest version."
  echo "${PREFIX}  ${TEXT_BOLD}open${COLOR_REST} - Opens the current branch's pull request in the browser."
  echo "${PREFIX}  ${TEXT_BOLD}help${COLOR_REST} - Shows this help message."
  echo "${PREFIX}Options:"
  echo "${PREFIX}  ${TEXT_BOLD}-n${COLOR_REST} - No-PR flag. If used, the pull request will not be created."
}