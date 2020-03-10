#!/usr/bin/env bash

cat << EOF > letsencrypt-wildcard.json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "route53:GetChange",
            "Resource": "arn:aws:route53:::change/*"
        },
        {
            "Effect": "Allow",
            "Action": "route53:ChangeResourceRecordSets",
            "Resource": "arn:aws:route53:::hostedzone/*"
        },
        {
            "Effect": "Allow",
            "Action": "route53:ListHostedZonesByName",
            "Resource": "*"
        }
    ]
}
EOF

aws iam create-policy --policy-name letsencrypt-wildcard --policy-document file://letsencrypt-wildcard.json

LE_POLICY_ARN=$(aws iam list-policies --output json --query 'Policies[*].[PolicyName,Arn]' --output text | grep letsencrypt-wildcard | awk '{print $2}')
aws iam create-group --group-name letsencrypt-wildcard
aws iam attach-group-policy --policy-arn ${LE_POLICY_ARN} --group-name letsencrypt-wildcard
aws iam create-user --user-name letsencrypt-wildcard
aws iam add-user-to-group --user-name letsencrypt-wildcard --group-name letsencrypt-wildcard
aws iam create-access-key --user-name letsencrypt-wildcard
