kubectl -n cert-manager logs -f $(kubectl -n cert-manager get pods -l app=cert-manager -o jsonpath="{.items[0].metadata.name}") cert-manager
