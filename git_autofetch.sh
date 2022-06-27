#!/bin/sh

NOW=`date +%FT%T`
CODE_LOCATION="${HOME}/Code"
LOG_FILE="${CODE_LOCATION}/autofetch.log"

EXEC_OUTPUT=""
for REPO in ${CODE_LOCATION}/*/; do
    if ! [ -d "${REPO}/.git/" ]; then
        continue
    fi
    REPO_OUTPUT=""
    for REMOTE in $(git -C ${REPO} remote); do
        REMOTE_OUTPUT=$(git -C ${REPO} fetch ${REMOTE} --verbose --prune 2<&1)
        REMOTE_OUTPUT=$(printf "%s" "${REMOTE_OUTPUT}" | sed -e '/^remote:/d' -e '/^Unpacking objects:/d' -e '/^ = /d')
        if [ $(printf "%s" "${REMOTE_OUTPUT}" | grep -c '^') -gt 1 ]; then
            REPO_OUTPUT="${REPO_OUTPUT}\nFetching ${REMOTE}\n${REMOTE_OUTPUT}"
        fi
    done
    if [ $(printf "%s" "${REPO_OUTPUT}" | grep -c '^') -gt 0 ]; then
        EXEC_OUTPUT="${EXEC_OUTPUT}\nRepository ${REPO}${REPO_OUTPUT}\n"
    fi
done

touch ${LOG_FILE}
if [ $(printf "%s" "${EXEC_OUTPUT}" | grep -c '^') -gt 0 ]; then
    EXEC_OUTPUT="|-- ${NOW} --|-- Check for updates for repositories at ${CODE_LOCATION} --|\n${EXEC_OUTPUT}\n"
    printf "${EXEC_OUTPUT}%s" "$(/bin/cat ${LOG_FILE})" > ${LOG_FILE}
fi
