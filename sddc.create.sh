#!/bin/bash

REFRESH_TOKEN=f16143c8-4f82-416d-b6e5-1711e725ca3d
VMCORG=decf0b75-dd3c-4d70-ab52-646f55053356

# Login with Refresh token and store Access token for future calls
AUTH_RESPONSE=$(curl -s -X POST \
-H "accept: application/json" \
-H "content-type: application/x-www-form-urlencoded" \
-d "refresh_token=$REFRESH_TOKEN" \
"https://console.cloud.vmware.com/csp/gateway/am/api/auth/api-tokens/authorize")

ACCESS_TOKEN=$(echo $AUTH_RESPONSE | awk -F '"access_token":"' '{print $2}' | awk -F '","' '{print $1}')
#echo $ACCESS_TOKEN

# Create
URL="https://vmc.vmware.com/vmc/api/orgs/decf0b75-dd3c-4d70-ab52-646f55053356/sddcs/a73851a4-4262-4308-81cc-af261c00f3f2"
curl -s -X GET \
-H "Content-Type: application/json" \
-H "csp-auth-token: $ACCESS_TOKEN" \
"$URL"
