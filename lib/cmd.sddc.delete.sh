#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi
source ${WORKDIR}/drv.core
source ${WORKDIR}/drv.vmc.client

ID=${1}
if [[ -n "${ID}" ]]; then
	if [[ -n "${VMCTOKEN}" && -n "${VMCORG}" ]]; then
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
