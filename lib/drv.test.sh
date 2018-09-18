#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi
source ${WORKDIR}/drv.core

if [ -z ${SDDCDIR} ]; then
	SDDCDIR=${WORKDIR}
fi
PARAMS=$(cat ${SDDCDIR}/sddc.parameters)
DOMAIN=$(echo "$PARAMS" | jq -r .domain)
DNS=$(echo "$PARAMS" | jq -r .dns)
echo ${DOMAIN}
echo ${DNS}

# 1 get the parameters
# 2 get API endpoint (via drv.client?)
# 3 resolve endpoint
# 3 ping the hostname || or if IP - ping the IP address
# 4 get the SSL thumbprint
# 5 attempt auth? maybe default command
function getHost {
	local SPEC=${1}
	echo "$SPEC"
	local HOST=$(echo "${SPEC}" | jq -r '.hostname')
	if [[ -n "${HOST}" ]]; then
		#local TYPE=$(echo "${SPEC}" | jq -r '.type')
		#local CHECKFWD=""
		#local CHECKREV=""
		#if [[ "$HOST" =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
		#	CHECKFWD="$HOST"
		#else
			#if [[ ! "$HOST" =~ [.] ]]; then
				#HOST+=".$DOMAIN"
			#fi
		#fi
		printf "${HOST}"
	fi
}

FINAL=""
COMMA=""
for KEY in $(echo "$PARAMS" | jq -c '.endpoints[]'); do
	FINAL+="$COMMA"
	#FINAL+=$(buildItem "$KEY")
	echo "$KEY"
	FINAL+=$(getHost "$KEY")
	COMMA=","
done
printf "[${FINAL}]" | jq --tab . >"${WORKDIR}/state/state.sddc.status.json"
printf "[${FINAL}]" | jq --tab .
