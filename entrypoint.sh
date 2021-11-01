#!/bin/sh

set -eu

INSTANCE="http://localhost:9200"

INDICES_WITH_DATE=$(
  curl -s "${INSTANCE}/_cat/indices" \
    | awk '{ print $3 }' \
    | grep -P '^(filebeat|journalbeat)' \
    | grep -P '\d{4}.\d{2}.\d{2}$'
)

TOMORROW=$(date --date="1 day" +'%Y.%m.%d')
TODAY=$(date --date="today" +'%Y.%m.%d')
DAY_1=$(date --date="1 day ago" +'%Y.%m.%d')
DAY_2=$(date --date="2 days ago" +'%Y.%m.%d')
DAY_3=$(date --date="3 days ago" +'%Y.%m.%d')
DAY_4=$(date --date="4 days ago" +'%Y.%m.%d')
DAY_5=$(date --date="5 days ago" +'%Y.%m.%d')
DAY_6=$(date --date="6 days ago" +'%Y.%m.%d')
DAY_7=$(date --date="7 days ago" +'%Y.%m.%d')

INDICES_TO_DELETE=$(
  echo "${INDICES_WITH_DATE}" | grep -P \
    -v "(${TOMORROW}|${TODAY}|${DAY_1}|${DAY_2}|${DAY_3}|${DAY_4}|${DAY_5}|${DAY_6}|${DAY_7})$" \
    | tr '\n' ',' \
    | sed 's/,$//'
)

if [ -z "${INDICES_TO_DELETE}" ]; then
  echo "No indices to delete!"
else
  echo "Delete some indices…"
  set -x
  curl -X DELETE "${INSTANCE}/${INDICES_TO_DELETE}"
fi
