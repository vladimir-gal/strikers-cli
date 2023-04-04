open(){
  path=$(dirname "$0")
  source "$path/common.sh"

  pr_status=$(gh pr status --json id --jq .currentBranch.id)
  if [ -z "$pr_status" ]; then
    echo "${PREFIX}${COLOR_RED}There is no PR for this branch, aborting..."
    exit 1
  fi

  gh pr view --web
}