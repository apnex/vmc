#!/bin/bash
docker rm -f vmc-cli 2>/dev/null

# persist (run & exec)
#docker run -id --name vmc-cli -v ${PWD}/cfg:/cfg --entrypoint=/bin/sh apnex/vmc-cli
#docker exec -t vmc-cli vmc sddc.list

# single (run)
docker run -it --rm -v ${PWD}/cfg:/cfg apnex/vmc-cli $1 $2
#docker run -it --rm -v ${PWD}/sddc.parameters:/cfg/sddc.parameters apnex/vmc-cli $1 $2
