#!/bin/bash
source drv.core
source drv.vmc.client

SDDCID=${1}
if [[ -n "${VMCTOKEN}" && -n "${VMCORG}" ]]; then
	ITEM="sddc"
	#CALL="/${SDDCID}"
	#URL=$(buildURL "${ITEM}${CALL}")
	URL=$(buildURL "orgs/${VMCORG}/sddcs")
	if [[ -n "${URL}" ]]; then
		printf "[$(cgreen "INFO")]: vmc [$(cgreen "$ITEM.list")] ${ITEM} [$(cgreen "$URL")]... " 1>&2
		vmcGet "${URL}"
	fi
fi
