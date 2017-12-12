#!/bin/bash
set -eu

echo "$aws_access_json" | jq '.'

export new_key_id=$(echo $aws_access_jso | jq '.AccessKeyId')
export new_key_secret=$(echo $aws_access_jso | jq '.SecretAccessKey')

echo "new_key_id=$new_key_id"
echo "new_key_secret=$new_key_secret"



bbl up --aws-access-key-id "${new_key_id:-aws_access_key_id}" \
       --aws-secret-access-key "${new_key_secret:-aws_secret_access_key}" \
       --aws-region $aws_region \
      --iaas aws
bbl print-env
echo $(bbl print-env) > bbl-env/bbl-env
