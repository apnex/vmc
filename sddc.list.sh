#!/bin/bash

RAW=$1
PAYLOAD=$(./drv.sddc.list.sh)
read -r -d '' JQSPEC <<CONFIG
	. |
		["id", "name", "sddc_type", "region", "sddc_state", "created"]
		,["-----", "-----", "-----", "-----"]
		,(.[] | [.id, .name, .sddc_type, .resource_config.region, .sddc_state, .created])
	| @csv
CONFIG
if [[ "$RAW" == "json" ]]; then
	echo "$PAYLOAD" | jq --tab .
else
	echo "$PAYLOAD" | jq -r "$JQSPEC" | sed 's/"//g' | column -s ',' -t
fi
