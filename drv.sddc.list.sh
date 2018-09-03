#!/bin/bash
source drv.core
source drv.vmc.client

SDDCID=${1}
if [[ -n "${VMCTOKEN}" ]]; then
	ITEM="sddc"
	#CALL="/${SDDCID}"
	#URL=$(buildURL "${ITEM}${CALL}")
	URL=$(buildURL "orgs/decf0b75-dd3c-4d70-ab52-646f55053356/sddcs")
	if [[ -n "${URL}" ]]; then
		printf "[$(cgreen "INFO")]: vmc [$(cgreen "$ITEM.list")] ${ITEM} [$(cgreen "$URL")]... " 1>&2
		vmcGet "${URL}"
	fi
fi
