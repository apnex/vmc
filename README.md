## Scripts for VMware Cloud on AWS (VMC) REST API

#### 1: Ensure you have JQ and CURL installed
Ensure you meet the pre-requisites on linux to execute to scripts.
Currently, these have been tested on Centos.

##### Centos
```shell
yum install curl jq
```

##### Ubuntu
```shell
apt-get install curl jq
```

##### Mac OSX
Install brew.
```shell
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null 2> /dev/null
```

Install curl/jq/coreutils
```shell
brew install curl jq coreutils
```

#### 2: Clone repository from GitHub
Perform the following command to download the scripts - this will create a directory `vmc` on your local machine
```shell
git clone https://github.com/apnex/vmc
```

#### 3: Set up SDDC parameters
Modify the `sddc.parameters` file to reflect the parameters for your lab.
Configure the VMC Console `endpoint` with a newly generated REFRESH_TOKEN from your "My Account -> API Tokens -> New Token".  
Configure current working `org` with its *uuid*- all command will be executed within this context.  
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

#### 4: Profit!
Execute individual scripts as required.
For all `list` commands below, the `json` optional parameter can be added to see raw JSON output instead.
i.e `./sddc.list.sh json` will bypass table formatting and show raw JSON for SDDCs. 

##### sddc.list: List sddc
```shell
./sddc.list.sh [json]
```

##### sddc.create: Create sddc
```shell
./sddc.create.sh <sddc-spec-json>
# example
./sddc.create.sh spec.sddc-01.json
```

##### sddc.delete: Delete sddc
```shell
./sddc.delete.sh <sddc-id>
# example
./sddc.delete.sh a73851a4-4262-4308-81cc-af261c20f3f2
```
