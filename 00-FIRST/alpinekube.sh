# building on the work of giants, see: https://wiki.alpinelinux.org/wiki/K8s

cat << EOF > /etc/apk/repositories
http://dl-cdn.alpinelinux.org/alpine/v3.20/main
http://dl-cdn.alpinelinux.org/alpine/v3.20/community
http://dl-cdn.alpinelinux.org/alpine/edge/community
http://dl-cdn.alpinelinux.org/alpine/edge/testing
EOF

apk update

echo "br_netfilter" > /etc/modules-load.d/k8s.conf
modprobe br_netfilter
sysctl net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf

echo "net.bridge.bridge-nf-call-iptables=1" >> /etc/sysctl.conf
sysctl net.bridge.bridge-nf-call-iptables=1

apk add cni-plugin-flannel
apk add cni-plugins
apk add flannel
apk add flannel-contrib-cni
apk add kubelet
apk add kubeadm
apk add kubectl
apk add containerd
apk add uuidgen
apk add nfs-utils

cp -av /etc/fstab /etc/fstab.bak
sed -i '/swap/s/^/#/' /etc/fstab
swapoff -a

mount --make-rshared /

echo "#!/bin/sh" > /etc/local.d/sharemetrics.start
echo "mount --make-rshared /" >> /etc/local.d/sharemetrics.start
chmod +x /etc/local.d/sharemetrics.start
rc-update add local

uuidgen > /etc/machine-id

sed -i 's/pause:3.8/pause:3.9/' /etc/containerd/config.toml

rc-update add containerd
rc-update add kubelet
rc-service containerd start

rc-update add ntpd
rc-service ntpd start

apk add 'kubelet=~1.30'
apk add 'kubeadm=~1.30'
apk add 'kubectl=~1.30'
