set -x

mkdir -p /run/systemd/resolve/
ln -s /etc/resolv.conf /run/systemd/resolve/
