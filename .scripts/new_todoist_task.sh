#!/bin/bash

# construct JSON payload for new task
read content
json_payload=$(jq -n --arg content "$content" '{content: $content}')

# obtain API token
api_token=$(secret-tool lookup uuid todoist_api_token)

# send to API
if curl "https://api.todoist.com/rest/v2/tasks" \
  --fail-with-body \
  -X POST \
  --json "$json_payload" \
  -H "Authorization: Bearer $api_token"; then
  notify-send "Successfully added new task"
  exit 0
else
  notify-send -u critical "Todoist API call FAILED"
  exit 1
fi
