#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi

PAYLOAD=$(${WORKDIR}/drv.sddc.status.sh)
read -r -d '' JQSPEC <<-CONFIG
	(
		["type", "hostname", "online", "dnsfwd", "dnsrev", "ping", "thumbprint"]
		| ., map(length * "-")
	),(
		.[] | [
			.type,
			.hostname,
			.online,
			.dnsfwd,
			.dnsrev,
			.ping,
			.thumbprint
		]
	) | @tsv
CONFIG

RAW=${1}
if [[ "$RAW" == "json" ]]; then
	echo "$PAYLOAD" | jq --tab .
else
	echo "$PAYLOAD" | jq -r "$JQSPEC" | sed 's/"//g' | column -t -s $'\t'
fi
