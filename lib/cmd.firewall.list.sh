#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi

SDDCID=$1
PAYLOAD=$(${WORKDIR}/drv.firewall.list.sh ${SDDCID})
read -r -d '' JQSPEC <<CONFIG
	(
		["ruleId", "name", "source", "destination", "application", "action"]
		| ., map(length * "-")
	),(
		.firewallRules.firewallRules[] | [
			.ruleId,
			.name,
			(if (.source?) then
				.source |
					(if (.ipAddress | length) > 0 then
						(.ipAddress | tostring)
					elif (.groupingObjectId | length) > 0 then
						(.groupingObjectId | tostring)
					elif (.vnicGroupId | length) > 0 then
						(.vnicGroupId | tostring)
					else ""	end)
			else
				"any"
			end),
			(if (.destination?) then
				.destination |
					(if (.ipAddress | length) > 0 then
						(.ipAddress | tostring)
					elif (.groupingObjectId | length) > 0 then
						(.groupingObjectId | tostring)
					elif (.vnicGroupId | length) > 0 then
						(.vnicGroupId | tostring)
					else ""	end)
			else
				"any"
			end),
			(if (.application?) then
				.application |
					(if (.applicationId | length) > 0 then
						(.applicationId | tostring)
					elif (.service | length) > 0 then
						(.service | tostring)
					else ""	end)
			else
				"any"
			end),
			.action
		]
	) | @tsv
CONFIG

RAW=${2}
if [[ -n "${PAYLOAD}" ]]; then
	if [[ "${RAW}" == "json" ]]; then
		echo "$PAYLOAD" | jq --tab .
	else
		echo "$PAYLOAD" | jq -r "$JQSPEC" | sed 's/"//g' | column -t -s $'\t'
	fi
fi
