# Kubernetes on Alpine Linux

Inspired from various things/by various people:
* Hearing about 'Kubernetes the hard way', and deliberately not reading the guides
* Alpine linux (which is systemd-free, hurrah!) 
* This very helpful guide: https://wiki.alpinelinux.org/wiki/K8s
* Annoyance of very little in the way of decent examples in the documentation
* Being akward and wanting to learn by breaking things immediately and learning how to fix them, becoming an 'expert' in the process
* An old collegue who wanted some help with openshift
* A very good friend who keeps trying to employ me.
* A couple of friends at ~~RedHat~~ IBM who have/had had to endure openshift
* A sleepy friend who kept on pointing me to the EXACT documentation I was looking for.

## So how do I use this?

Firstly, I suggest you don't. It's geared up to **MY** setup and needs, and not yours

## So why is it on github then?

As an aid memoire for me on how to set things up, as kubernetes is awfully complicated and terribly documented

## Okay, so let me at it ...

Sure, but remember **HERE BE DRAGONS**

1. look first in the `00-FIRST` folder
  * alpine-core-dns-fix.sh
    * Because someone assumed systemd and didn't know that /etc/resolv.conf is the correct place for that file
  * alpinekube.sh
    * Run this once and your alpine system should be ready to make into a master/worker node
    * Check `kubectl taint ...` line, as you probably don't want this in production/HA
  * first-master-node.sh
    * Run this, and you've got your first one node kubernetes cluster!
  * worker-nodes.sh
    * This will ssh into a box called gamma (change this for the correct hostname of your setup) and join your current machine to it as a worker node
    * You might prefer the commented out awkward version, that includes your fqdn if your box was set up correctly.
  * quick-and-nasty-lvm.sh
    * You may have a second storage device (/dev/sdb) that you want to attach and use for separate storage
    * This is just a reminder on how to quickly make a lvm/ext4 volume
  * prep-for-longhorn.sh
    * Assume you prepped sdb with instructions in quick-and-nasty-lvm.sh
      * set it up to permantly mount it in /opt/storage
      * mount it
      * ensure /opt/storage/longhorn exists
2. ingress-nginx
  * ingress-ngix-nodeports.yaml
    * Edit this file to open appropriate ports on your baremetal install
    * On success, you'll have the ability to access pods 'inside' your cluster on the `ingress-nginx` namespace
    * externalIPs will be the hosts in your cluster you want to expose
    * NB. I'm not sure I like exposing the nodePort entries YMMV
    * NB. port 80 and port 443 are open
    * The `ingressClassName` will be ngnix
3. example-website
  * example-website-ingress.yaml
    * change 'example-website.k.rm-rfstar.com' to your needs
  * deploy.sh
    * A namespace `example-website` will be created and a bare ngnix site will be served.
    * If you followed the instructions in `../ingress-nginx` you'll be able to look at it through http/https
4. kubernetes-dashboard
  * 00-README.txt
    * Read this to install it via helm (namespace `kubernetes-dashboard`)
  * 03-ingress.yaml
    * Change 'kubernetes-dasboard.k.rm-rfstar.com' to your needs
    * Take notice of the annotations section, as the dashboard runs as tls
  * deploy.sh
    * Sets things up so you can access the dashboard via a bearer token
    * Accessing using port 80 will redirect to https
5. longhorn-system
  * ingress.yaml
    * Change 'longhorn-system.k.rm-rfstar.com' to your needs
    * If you followed the instructions in `../ingress-nginx` you'll be able to look at it through http/https
  * deploy.sh
    * Sets things up so you can access the longhorn dashboard without access control
    * You now will have longhorn instances all over your cluster
    * By default it creates a storage pool at `/var/lib/longhorn/` which might not be suitable for you (disable scheduling)
    * If you followed the `../00-FIRST/prep-for-longhorn.sh` directions you can now configure each node in turn to only use `/opt/storage/longhorn/` and enable sheduling



If you followed this, [Dear friend, you have built a Kubernetes](https://www.macchaffee.com/blog/2024/you-have-built-a-kubernetes/) but you didn't do it [The hard way](https://github.com/kelseyhightower/kubernetes-the-hard-way)


