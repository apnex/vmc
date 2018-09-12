#!/bin/bash
if [[ $0 =~ ^(.*)/[^/]+$ ]]; then
	WORKDIR=${BASH_REMATCH[1]}
fi
source ${WORKDIR}/drv.core
source ${WORKDIR}/drv.vmc.client

function makeBody {
	BODY=$(cat "${1}")
	printf "${BODY}"
}

SDDCSPEC=${1}
if [[ -n "${SDDCSPEC}" ]]; then # input provided
	SPEC="${SDDCDIR}/${SDDCSPEC}"
	# function ValidInput
	if [[ -n "${VMCTOKEN}" && -n "${VMCORG}" ]]; then # system valid
		if [[ -f "${SPEC}" ]]; then # input valid
			BODY=$(makeBody "${SPEC}")
			echo "$BODY"
			ITEM="sddc"
			CALL=""
			URL=$(buildURL "orgs/${VMCORG}/sddcs")
			if [[ -n "${URL}" ]]; then
				printf "[$(cgreen "INFO")]: vmc [$(cgreen "sddc.create")] ${ITEM} [$(cgreen "${URL}")]... " 1>&2
				vmcPost "${URL}" "${BODY}"
			fi
		else
			printf "[$(corange "ERROR")]: <spec-name> [$(ccyan "${SDDCSPEC}")] not found!\n" 1>&2
		fi
	fi
else
	printf "[$(corange "ERROR")]: command usage: $(cgreen "sddc.create") $(ccyan "<spec-name>")\n" 1>&2
fi

