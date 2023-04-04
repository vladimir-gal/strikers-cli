#! /usr/bin/env bash
  # shellcheck disable=SC2162

push() {
path=$(dirname "$0")
branch=$(git symbolic-ref --short HEAD)
no_pr_flag=''

source "$path/common.sh"

while getopts ":n" opt; do
  case $opt in
    n)
      no_pr_flag='true'
      ;;
    \?)
      echo "${PREFIX}${COLOR_RED}Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

echo "${TITLE}"

echo "${PREFIX}Current branch: ${TEXT_STANDOUT}$branch${COLOR_REST}"

function createPR {
  if [ "$no_pr_flag" == "true" ]; then
    echo "${PREFIX}${COLOR_GREEN}No-PR flag used, skipping PR creation and finishing...${COLOR_REST}"
    exit 0
  fi
  if [ "$(gh pr status --json id --jq .currentBranch.id)" ]; then
    echo "${PREFIX}${COLOR_GREEN}There is already a PR for this branch, finishing...${COLOR_REST}"
    exit 0
  fi

  ticket=$1
  title=$(git log --format=%B -n 1)
  read -e -p "${PREFIX}${COLOR_GREEN}(PR Context)${COLOR_REST} " context

  echo "${PREFIX}${COLOR_GREEN}(PR Changes)${COLOR_REST} (press enter after each line, press ctrl+d when done):"
  while read -e -r line; do
    changes+="- $line
"
  done

  read -e -p "${PREFIX}${COLOR_GREEN}(PR Notes)${COLOR_REST}: " notes

  template=$(ticket=$ticket title=$title context=$context changes=$changes notes=$notes envsubst < "$path"/template.txt)

  gh pr create --title "$title" --body "$template" --web
  exit 0
}

function commit {
  echo "${PREFIX}Moving to root directory..."
  cd "$(git rev-parse --show-toplevel)" || exit 1
  echo "${PREFIX}Adding changes..."
  git add .
  echo "${PREFIX}Changes that will be committed:"
  echo "$(git status --short | awk '{print "'"${PREFIX}   ${COLOR_YELLOW}"'"$0}' | grep -v '^[ |??]')${COLOR_REST}"

  ticket=$1
  read -p "${PREFIX}${COLOR_GREEN}(Commit message)${COLOR_REST} ${ticket}: " message

  if [ -z "$message" ]; then
    echo "${PREFIX}${COLOR_RED}Commit message not provided, aborting...${COLOR_REST}"
    exit 1
  fi

  echo "${PREFIX}Committing changes..."
  git commit -m "$ticket: $message" --quiet
}

if [ "$branch" == "master" ] || [ "$branch" == "main" ]; then
  read -e -p "${PREFIX}You are on the $branch branch, do you want to create a branch for this commit? [y/n]" -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    read -e -p "${PREFIX}${COLOR_GREEN}(Ticket number)${COLOR_REST} (e.g. IR2-1001): " ticket

    if [ -z "$ticket" ]; then
      echo "${PREFIX}${COLOR_RED}Ticket number not found, aborting...${COLOR_REST}"
      exit 1
    fi

    read -e -p "${PREFIX}${COLOR_GREEN}(Branch name)${COLOR_REST} (without ticket number): " branch

    newBranch=""
    if [ -z "$branch" ]; then
      newBranch="$ticket"
    else
      newBranch="$ticket-$branch"
    fi

    git checkout -b "$newBranch"
    commit "$ticket"

    echo "${PREFIX}Pushing changes..."
    git push --set-upstream --quiet origin "$newBranch"

    createPR "$ticket"
  else
    echo "${PREFIX}${COLOR_RED}We can not push to $branch directly. Aborting...${COLOR_REST}"
  fi
else
  ticket=$(echo $branch | grep -o -E 'IR[0-9]{1,4}-[0-9]{1,4}')

  if [ -z "$ticket" ]; then
    echo "${PREFIX}${COLOR_RED}Ticket number not found or in wrong format, aborting...${COLOR_REST}"
    exit 1
  fi

  if [ -z "$(git status --porcelain)" ]; then
    echo "${COLOR_RED}No changes to commit, aborting...${COLOR_REST}"
    exit 1
  fi

  commit "$ticket"

  echo "${PREFIX}Pushing changes..."
  git push --set-upstream --quiet origin $branch
  createPR "$ticket"
fi
}