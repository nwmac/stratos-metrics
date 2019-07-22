#!/bin/bash

# Colours
CYAN="\033[96m"
YELLOW="\033[93m"
RESET="\033[0m"
BOLD="\033[1m"

__DIRNAME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

printf "${BOLD}${CYAN}Generating ${YELLOW}imagelist.txt${RESET}\n"
echo ""

helm version -c

CHART_FOLDER=${1}
echo "Chart folder: ${CHART_FOLDER}"
ls
echo ""
echo "Rendering template locally..."
echo ""
helm template -f ${__DIRNAME}/imagelist.values.yaml ${CHART_FOLDER} | grep "image:" | grep --extended --only-matching '([^"/[:space:]]+/)?[^"/[:space:]]+/[^:[:space:]]+:[a-zA-Z0-9\._-]+' | sort | uniq | awk -F'/' '{print $2}' > imagelist.txt

echo ""
printf "${CYAN}"
cat ${CHART_FOLDER}/imagelist.txt
printf "${RESET}"
echo ""