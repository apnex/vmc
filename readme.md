## Scripts for VMware Cloud on AWS (VMC) REST API

### Setup Instructions  
You can use `vmc-cli` via either:  
- **DOCKER** - pre-packaged container from [dockerhub](https://hub.docker.com/r/apnex/vmc-cli)
- **LOCAL Installation** - clone this repo and execute scripts directly

### 1: First, set up local SDDC parameters  
Modify the `sddc.parameters` file to reflect the parameters for your lab.  
Configure the VMC Console `endpoint` with a newly generated **REFRESH_TOKEN** from your "My Account -> API Tokens -> Generate New Token".  
Configure current working `org` with its **UUID** - all commands will be executed within this context.  
You can get a list of orgs for your account by issuing the `org.list` command.  
For endpoint type `vmc` - `domain` and `dns` parameters will be ignored.  
```json
{
	"dns": "172.16.0.1",
	"domain": "lab",
	"endpoints": [
		{
			"type": "vmc",
			"org": "<org-uuid>",
			"token": "<refresh-token>",
			"online": "true"
		}
	]
}
```

### 2: SETUP
#### LOCAL Installation
Ensure you have JQ and CURL installed.  
Ensure you meet the pre-requisites to execute to scripts.  
Currently, these have been tested on Centos / Ubuntu / MacOSX.  

##### Centos
```shell
yum install curl jq
```

##### Ubuntu
```shell
apt-get install curl jq
```

##### Mac OSX
Install brew
```shell
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null 2> /dev/null
```

Install curl & jq
```shell
brew install curl jq
```

##### Clone repository from GitHub
Perform the following command to download the scripts - this will create a directory `vmc` on your local machine
```shell
git clone https://github.com/apnex/vmc
```

#### DOCKER
Docker Option 1: Daemon + Exec  
```shell
docker rm -f vmc-cli 2>/dev/null
docker run -id --name vmc-cli -v ${PWD}/sddc.parameters:/cfg/sddc.parameters --entrypoint=/bin/sh apnex/vmc-cli
docker exec -t vmc-cli vmc <cmd>
docker exec -t vmc-cli vmc <cmd>
docker exec -t vmc-cli vmc <cmd>
```
**Where:**
- `<cmd>` is a command - enter `list` to view available commands or see **USAGE** below  

Docker Option 2: Single Run  
```shell
docker rm -f vmc-cli 2>/dev/null
docker run -it --rm -v ${PWD}/sddc.parameters:/cfg/sddc.parameters apnex/vmc-cli <cmd>
```
**Where:**
- `<cmd>` is a command - enter `list` to view available commands or see **USAGE** below

#### 3: PROFIT! (USAGE)
Execute individual scripts as required.
For all `list` commands below, the `json` optional parameter can be added to see raw JSON output instead.
i.e `./sddc.list.sh json` will bypass table formatting and show raw JSON for SDDCs. 

##### sddc.list
List sddc
```shell
sddc.list [json]
```

##### sddc.create
Create sddc
```shell
sddc.create <sddc-spec-json>
# example
sddc.create spec.sddc-01.json
```

##### sddc.delete
Delete sddc
```shell
sddc.delete <sddc-id>
# example
sddc.delete a73851a4-4262-4308-81cc-af261c20f3f2
```

##### task.list
List tasks
```shell
task.list [json]
```
