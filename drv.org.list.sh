#!/bin/bash
source drv.core
source drv.vmc.client

if [[ -n "${VMCTOKEN}" ]]; then
	ITEM="sddc"
	#CALL="/${SDDCID}"
	#URL=$(buildURL "${ITEM}${CALL}")
	URL=$(buildURL "orgs")
	if [[ -n "${URL}" ]]; then
		printf "[$(cgreen "INFO")]: vmc [$(cgreen "$ITEM.list")] ${ITEM} [$(cgreen "$URL")]... " 1>&2
		vmcGet "${URL}"
	fi
fi
