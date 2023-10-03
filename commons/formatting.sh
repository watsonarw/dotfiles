setup_color() {
  # Only use colors if connected to a terminal
  if [ -t 1 ]; then
    RED=$(printf '\033[31m')
    GREEN=$(printf '\033[32m')
    YELLOW=$(printf '\033[33m')
    BLUE=$(printf '\033[34m')
    BOLD=$(printf '\033[1m')
    INVERT=$(printf '\033[7m')
    RESET=$(printf '\033[m')
  else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    INVERT=""
    RESET=""
  fi
}

red () {
  echo "${RED}$1${RESET}"
}

green () {
  echo "${GREEN}$1${RESET}"
}

yellow () {
  echo "${YELLOW}$1${RESET}"
}

blue () {
  echo "${BLUE}$1${RESET}"
}

bold() {
  echo "${BOLD}$1${RESET}"
}

invert() {
  echo "${INVERT}$1${RESET}"
}

h1() {
  echo ""
  bold "$(blue "********** $1 **********")"
  echo ""
}

h2() {
  bold "$(yellow "========== $1 ==========")"
}

h3() {
  bold "---------- $1 ----------"
}

green_tick() {
  local message="${1-}"
  echo "${BOLD}${GREEN}✓${RESET} $message"
}

setup_color
