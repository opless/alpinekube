# here gamma is the master node
# if you want to copy and paste the kubeadm command onward to do it manually!
$(ssh gamma kubeadm token create --print-join-command )

# if you're being very akward ;-)
# $(ssh gamma kubeadm token create --print-join-command ) --node-name $(hostname -f)
