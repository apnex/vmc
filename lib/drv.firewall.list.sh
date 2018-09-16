#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi
source ${WORKDIR}/drv.core
source ${WORKDIR}/drv.vmc.client

SDDCID=${1}
if [[ -n "${SDDCID}" ]]; then
	if [[ -n "${VMCTOKEN}" && -n "${VMCORG}" ]]; then
		ITEM="sddc"
		URL=$(buildURL "orgs/${VMCORG}/sddcs/${SDDCID}/networks/4.0/edges/edge-1/firewall/config")
		if [[ -n "${URL}" ]]; then
			printf "[$(cgreen "INFO")]: vmc [$(cgreen "$ITEM.list")] ${ITEM} [$(cgreen "$URL")]... " 1>&2
			vmcGet "${URL}"
		fi
	fi
else
	printf "[$(corange "ERROR")]: command usage: $(cgreen "firewall.list") $(ccyan "<sddc-id>")\n" 1>&2
fi
