ID=$(uuidgen) && aws route53 create-hosted-zone --name kube.devfire.io --caller-reference $ID | jq .DelegationSet.NameServers
aws route53 list-hosted-zones | jq '.HostedZones[] | select(.Name=="devfire.io.") | .Id'
# aws route53 change-resource-record-sets --hosted-zone-id /hostedzone/ZOS99SVT5SCMK --change-batch file://subdomain.json
aws s3api create-bucket --bucket state.kube.devfire.io
aws s3api put-bucket-versioning --bucket state.kube.devfire.io --versioning-configuration Status=Enabled
aws s3api put-bucket-encryption --bucket state.kube.devfire.io --server-side-encryption-configuration '{"Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"}}]}'

#local environment prep
export NAME=dev.kube.devfire.io
export KOPS_STATE_STORE=s3://state.kube.devfire.io

kops create cluster --zones us-east-1a ${NAME}

