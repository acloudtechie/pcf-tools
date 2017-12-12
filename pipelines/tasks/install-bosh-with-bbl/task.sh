#!/bin/bash
set -eu
bbl up --aws-access-key-id "${aws_access_key_id}" \
       --aws-secret-access-key "${aws_secret_access_key}" \
       --aws-region $aws_region \
      --iaas aws
bbl print-env
echo $(bbl print-env) > bbl-env/bbl-env
