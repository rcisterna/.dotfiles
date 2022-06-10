#!/bin/sh

NOW=`date +%FT%T`

CODE_LOCATION="${HOME}/Code"
LOG_FILE="${CODE_LOCATION}/cron.log"

printf "|-- %s --|-- Fetching repos at %s --|\n" "${NOW}" "${CODE_LOCATION}" >> ${LOG_FILE} 2<&1
find ${CODE_LOCATION} -type d -execdir test -d '{}/.git' \; -execdir printf '\nRepo {}\n' \; -execdir git -C {} fetch --all --prune \; -prune >> ${LOG_FILE} 2<&1
printf "\n" >> ${LOG_FILE} 2<&1
