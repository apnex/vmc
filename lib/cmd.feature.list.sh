#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi

PAYLOAD=$(${WORKDIR}/drv.feature.list.sh)
read -r -d '' JQSPEC <<CONFIG
	. |
		["feature", "enabled"]
		,["-----", "-----"]
		,(
			to_entries |
				map(
					[(.key),(.value | .applicable_status)]
				)
			| .[]
		)
	| @csv
CONFIG

RAW=$1
if [[ "$RAW" == "json" ]]; then
	echo "$PAYLOAD" | jq --tab .
else
	echo "$PAYLOAD" | jq -r "$JQSPEC" | sed 's/"//g' | column -s ',' -t
fi
