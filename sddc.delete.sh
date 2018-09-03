#!/bin/bash
source drv.core
source drv.vmc.client

ID=${1}
VMCORG="decf0b75-dd3c-4d70-ab52-646f55053356"
if [[ -n "${ID}" ]]; then
	if [[ -n "${VMCTOKEN}" ]]; then
		ITEM="orgs/${VMCORG}/sddcs"
		CALL="/${ID}"
		URL=$(buildURL "${ITEM}${CALL}")
		if [[ -n "${URL}" ]]; then
			printf "[$(cgreen "INFO")]: vmc [$(cgreen "sddc.delete")] ${ITEM} [$(cgreen "$URL")]... " 1>&2
			vmcDelete "${URL}"
		fi
	fi
else
	printf "[$(corange "ERROR")]: command usage: $(cgreen "sddc.delete") $(ccyan "<sddc-id>")\n" 1>&2
fi
