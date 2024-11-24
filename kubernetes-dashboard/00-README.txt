# Install helm somewhere convienient, and run this to install.

helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/

helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard



# I'm not a fan of helm, but this is the only way to get the dashboard onto the system
