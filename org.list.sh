#!/bin/bash

RAW=$1
PAYLOAD=$(./drv.org.list.sh)
read -r -d '' JQSPEC <<CONFIG
	. |
		["id", "name", "display_name", "project_state"]
		,["-----", "-----", "-----", "-----"]
		,(.[] | [.id, .name, .display_name, .project_state])
	| @csv
CONFIG
if [[ "$RAW" == "json" ]]; then
	echo "$PAYLOAD" | jq --tab .
else
	echo "$PAYLOAD" | jq -r "$JQSPEC" | sed 's/"//g' | column -s ',' -t
fi
