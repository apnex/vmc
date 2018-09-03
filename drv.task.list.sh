#!/bin/bash
source drv.core
source drv.vmc.client

SDDCID=${1}
if [[ -n "${VMCTOKEN}" && -n "${VMCORG}" ]]; then
	ITEM="task"
	#CALL="/${SDDCID}"
	#URL=$(buildURL "${ITEM}${CALL}")
	URL=$(buildURL "orgs/${VMCORG}/tasks")
	if [[ -n "${URL}" ]]; then
		printf "[$(cgreen "INFO")]: vmc [$(cgreen "$ITEM.list")] ${ITEM} [$(cgreen "$URL")]... " 1>&2
		vmcGet "${URL}"
	fi
fi
