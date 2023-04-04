COLOR_REST="$(tput sgr0)"
COLOR_GREEN="$(tput setaf 2)"
COLOR_RED="$(tput setaf 1)"
COLOR_YELLOW="$(tput setaf 3)"
TEXT_BOLD="$(tput bold)"
TEXT_STANDOUT="$(tput smso)"
PREFIX="${COLOR_YELLOW}${TEXT_BOLD}»${COLOR_REST}  "

TITLE_TEXT=$(cat "$(dirname "$0")/title.txt")
TITLE="${COLOR_YELLOW}${TITLE_TEXT}${COLOR_REST}${NEW_LINE}"

CR=`echo $'\n »'`
CR=${cr%.}
NEW_LINE=$'\n'