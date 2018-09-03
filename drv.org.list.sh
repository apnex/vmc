#!/bin/bash

REFRESH_TOKEN=f16143c8-4f82-416d-b6e5-1711e725ca3d

# Login with Refresh token and store Access token for future calls
AUTH_RESPONSE=$(curl -s -X POST \
-H "accept: application/json" \
-H "content-type: application/x-www-form-urlencoded" \
-d "refresh_token=$REFRESH_TOKEN" \
"https://console.cloud.vmware.com/csp/gateway/am/api/auth/api-tokens/authorize")

ACCESS_TOKEN=$(echo $AUTH_RESPONSE | awk -F '"access_token":"' '{print $2}' | awk -F '","' '{print $1}')

# List Orgs
curl -s -X GET \
-H "Content-Type: application/json" \
-H "csp-auth-token: $ACCESS_TOKEN" \
"https://vmc.vmware.com/vmc/api/orgs"
