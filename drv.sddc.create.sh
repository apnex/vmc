#!/bin/bash
source drv.core
source drv.vmc.client
SDDCSPEC=${1}

function makeBody {
	BODY=$(cat "${1}")
	printf "${BODY}"
}

if [[ -n "${SDDCSPEC}" ]]; then
	if [[ -n "${VMCTOKEN}" && -n "${VMCORG}" ]]; then
		BODY=$(makeBody "${SDDCSPEC}")
		echo "$BODY"
		ITEM="sddc"
		CALL=""
		URL=$(buildURL "orgs/${VMCORG}/sddcs")
		if [[ -n "${URL}" ]]; then
			printf "[$(cgreen "INFO")]: vmc [$(cgreen "sddc.create")] ${ITEM} [$(cgreen "${URL}")]... " 1>&2
			vmcPost "${URL}" "${BODY}"
		fi
	fi
else
	printf "[$(corange "ERROR")]: command usage: $(cgreen "sddc.create") $(ccyan "<spec-name>")\n" 1>&2
fi

