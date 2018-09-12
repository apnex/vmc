#!/bin/bash
docker rmi -f apnex/vmc-cli 2>/dev/null
docker build --no-cache -t apnex/vmc-cli -f alpine.dockerfile .
