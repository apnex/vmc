#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi

PAYLOAD=$(${WORKDIR}/drv.sddc.list.sh)
read -r -d '' JQSPEC <<CONFIG
	. |
		["id", "name", "sddc_type", "region", "sddc_state", "created"]
		,["-----", "-----", "-----", "-----", "-----", "-----"]
		,(.[] | [.id, .name, .sddc_type, .resource_config.region, .sddc_state, .created])
	| @csv
CONFIG

RAW=${1}
if [[ "$RAW" == "json" ]]; then
	echo "$PAYLOAD" | jq --tab .
else
	echo "$PAYLOAD" | jq -r "$JQSPEC" | sed 's/"//g' | column -s ',' -t
fi
