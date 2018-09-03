#!/bin/bash

RAW=$1
PAYLOAD=$(./drv.task.list.sh)
read -r -d '' JQSPEC <<CONFIG
	. |
		["id", "task_type", "estimated_remaining_minutes", "progress_percent", "status", "sub_status"]
		,["-----", "-----", "-----", "-----", "-----", "-----"]
		,(.[] | [.id, .task_type, .estimated_remaining_minutes, .progress_percent, .status, .sub_status])
	| @csv
CONFIG
if [[ "$RAW" == "json" ]]; then
	echo "$PAYLOAD" | jq --tab .
else
	echo "$PAYLOAD" | jq -r "$JQSPEC" | sed 's/"//g' | column -s ',' -t
fi
