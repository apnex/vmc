#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR="${BASH_REMATCH[1]}"
fi

PAYLOAD=$(${WORKDIR}/drv.org.list.sh)
read -r -d '' JQSPEC <<CONFIG
	. |
		["id", "name", "display_name", "project_state"]
		,["-----", "-----", "-----", "-----"]
		,(.[] | [.id, .name, .display_name, .project_state])
	| @csv
CONFIG

RAW=${1}
if [[ "$RAW" == "json" ]]; then
	echo "$PAYLOAD" | jq --tab .
else
	echo "$PAYLOAD" | jq -r "$JQSPEC" | sed 's/"//g' | column -s ',' -t
fi
