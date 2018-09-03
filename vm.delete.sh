#!/bin/bash
source drv.core
source drv.vsp.client

ID=${1}
if [[ -n "${ID}" ]]; then
	if [[ -n "${VSPHOST}" ]]; then
		ITEM="vm"
		CALL="/${ID}"
		URL=$(buildURL "${ITEM}${CALL}")
		if [[ -n "${URL}" ]]; then
			printf "[$(cgreen "INFO")]: vsp [$(cgreen "vm.delete")] ${ITEM} [$(cgreen "$URL")]... " 1>&2
			vspDelete "${URL}"
		fi
	fi
else
	printf "[$(corange "ERROR")]: command usage: $(cgreen "vm.delete") $(ccyan "<uuid>")\n" 1>&2
fi
