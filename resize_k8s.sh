CLUSTER=cluster-1
ZONE=us-central1-a
gcloud container clusters resize $CLUSTER --size=0 --zone=$ZONE
