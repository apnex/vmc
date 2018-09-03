#!/bin/bash
source drv.core
source drv.vmc.client
SDDCSPEC=${1}
VMCORG="decf0b75-dd3c-4d70-ab52-646f55053356"

function makeBody {
	BODY=$(cat "${1}")
	printf "${BODY}"
}

if [[ -n "${SDDCSPEC}" ]]; then
	if [[ -n "${VMCTOKEN}" ]]; then
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

