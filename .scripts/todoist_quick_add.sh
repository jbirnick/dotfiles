#!/bin/bash

# read content string of task
read content

# obtain API token
api_token=$(secret-tool lookup uuid todoist_api_token)

# send to API
if curl "https://api.todoist.com/sync/v9/quick/add" \
  --fail-with-body \
  -X POST \
  -H "Authorization: Bearer $api_token" \
  -d text="$content"; then
  notify-send "Todoist API call SUCCESSFUL"
  exit 0
else
  notify-send -u critical "Todoist API call FAILED"
  exit 1
fi
