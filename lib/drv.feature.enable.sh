#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi
source ${WORKDIR}/drv.core
source ${WORKDIR}/drv.vmc.client

read -r -d '' BODY <<CONFIG
{
	"applicable_scope": {
		"whitelisted_keys": [
			"a30b23c6-5267-4951-8ca1-4414e0ed57c8",
			"edaf811b-34ee-45e9-b3cd-0cfd8589d144",
			"4ea24553-b6b0-487c-86fe-d7983d900d23",
			"4df7c72b-9fe9-3bf0-8e85-3ddad6330067"
		]
	}
}
CONFIG

function vmcPatch {
	local URL=${1}
	printf "${BODY}\n" 1>&2
	if [[ "$VMCONLINE" == "true" ]]; then
		RESPONSE=$(curl -k -w "%{http_code}" -G -X PATCH \
			-H "Content-Type: application/json" \
			-H "csp-auth-token: $(cat $VMCSESSION)" \
			--data-urlencode "$BODY" \
			"https://vmc.vmware.com/vmc/api/orgs/${VMCORG}/features/enableNsxtDeployment" \
		2>/dev/null)
		RESULT=$(isSuccess "${RESPONSE}")
	else
		printf "[$(ccyan "OFFLINE")] - SUCCESS\n" 1>&2
	fi
	printf "%s\n" "${RESULT}" | jq --tab .
}

SDDCID=${1}
if [[ -n "${VMCTOKEN}" && -n "${VMCORG}" ]]; then
	ITEM="sddc"
	#CALL="/${SDDCID}"
	#URL=$(buildURL "${ITEM}${CALL}")
	URL="https://vmc.vmware.com/vmc/api/operator/org/${VMCORG}/features"
	if [[ -n "${URL}" ]]; then
		printf "[$(cgreen "INFO")]: vmc [$(cgreen "$ITEM.list")] ${ITEM} [$(cgreen "$URL")]... " 1>&2
		vmcGet "${URL}"
	fi
fi


