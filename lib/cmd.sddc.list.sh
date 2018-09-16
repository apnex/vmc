#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi

PAYLOAD=$(${WORKDIR}/drv.sddc.list.sh)
read -r -d '' JQSPEC <<CONFIG
	(
		["id", "name", "sddc_type", "region", "nsxt", "vc_url", "sddc_state", "created"]
		| ., map(length * "-")
	),(
		.[] | [
			.id,
			.name,
			.sddc_type,
			.resource_config.region,
			.resource_config.nsxt,
			.resource_config.vc_url,
			.sddc_state,
			.created
		]
	) | @tsv
CONFIG

RAW=${1}
if [[ -n "${PAYLOAD}" ]]; then
	if [[ "${RAW}" == "json" ]]; then
		echo "$PAYLOAD" | jq --tab .
	else
		echo "$PAYLOAD" | jq -r "$JQSPEC" | sed 's/"//g' | column -t -s $'\t'
	fi
fi
