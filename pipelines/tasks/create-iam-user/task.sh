#!/bin/bash
#set -eu

export AWS_ACCESS_KEY_ID="$aws_access_key_id"
export AWS_SECRET_ACCESS_KEY="$aws_secret_access_key"
aws iam get-user  --user-name $aws_iam_user_name 2>/dev/null
if [[ $? -eq 0  ]]
then
  echo "User $aws_iam_user_name already exists"
else
  aws iam create-user --user-name "$aws_iam_user_name"
  read -r -d '' bbl_policy_json <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:*",
                "cloudformation:*",
                "elasticloadbalancing:*",
                "route53:*",
                "iam:*",
                "logs:*",
                "kms:*"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF

  echo "$bbl_policy_json" | jq '.'

  aws iam put-user-policy --user-name "$aws_iam_user_name" \
        --policy-name "bbl-policy" \
        --policy-document "$bbl_policy_json"
  #mkdir aws_output && cd aws_output
  aws_access_json = $(aws iam create-access-key --user-name "$aws_iam_user_name")
fi
