ID=$(uuidgen) && aws route53 create-hosted-zone --name kube.devfire.io --caller-reference $ID | jq .DelegationSet.NameServers
aws route53 list-hosted-zones | jq '.HostedZones[] | select(.Name=="devfire.io.") | .Id'
