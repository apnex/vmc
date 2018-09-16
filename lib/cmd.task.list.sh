#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR="${BASH_REMATCH[1]}"
fi

PAYLOAD=$(${WORKDIR}/drv.task.list.sh)
read -r -d '' JQSPEC <<CONFIG
	(
		["id", "task_type", "estimated_remaining_minutes", "progress_percent", "status", "sub_status"]
		| ., map(length * "-")
	),(
		.[] | [
			.id,
			.task_type,
			.estimated_remaining_minutes,
			.progress_percent,
			.status,
			.sub_status
		]
	) | @tsv
CONFIG

RAW=${1}
if [[ "RAW" == "json" ]]; then
	echo "$PAYLOAD" | jq --tab .
else
	echo "$PAYLOAD" | jq -r "$JQSPEC" | sed 's/"//g' | column -t -s $'\t'
fi
