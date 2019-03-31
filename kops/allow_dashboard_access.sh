kubectl create serviceaccount admin-user -n kube-system
kubectl create clusterrolebinding admin-user -n kube-system --clusterrole=cluster-admin --serviceaccount=kube-system:admin-user
kubectl get sa -n kube-system | grep admin-user
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}')
