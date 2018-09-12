#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi
source ${WORKDIR}/drv.core
source ${WORKDIR}/drv.vmc.client

SDDCID=${1}
if [[ -n "${VMCTOKEN}" && -n "${VMCORG}" ]]; then
	ITEM="sddc"
	#CALL="/${SDDCID}"
	#URL=$(buildURL "${ITEM}${CALL}")
	URL=$(buildURL "orgs/${VMCORG}/features")
	if [[ -n "${URL}" ]]; then
		printf "[$(cgreen "INFO")]: vmc [$(cgreen "$ITEM.list")] ${ITEM} [$(cgreen "$URL")]... " 1>&2
		vmcGet "${URL}"
	fi
fi
