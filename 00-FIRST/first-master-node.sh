set -x 

#initialise everything
kubeadm init --pod-network-cidr=10.244.0.0/16 --node-name=$(hostname)

#important! sets up networking!
kubectl -n kube-system apply -f https://raw.githubusercontent.com/coreos/flannel/bc79dd1505b0c8681ece4de4c0d86c5cd2643275/Documentation/kube-flannel.yml


# so you can use a master node to run things on!
kubectl taint nodes gamma.rm-rfstar.com node-role.kubernetes.io/control-plane=:NoSchedule-
