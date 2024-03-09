Kubernetes Cluster

#!/bin/bash
swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab
sudo hostnamectl set-hostname "master-node"
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF
sudo modprobe overlay
sudo modprobe br_netfilter
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF
sudo sysctl --system
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gpg
sudo mkdir /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
sudo apt install -y docker.io
sudo mkdir /etc/containerd
sudo sh -c "containerd config default > /etc/containerd/config.toml"
sudo sed -i 's/ SystemdCgroup = false/ SystemdCgroup = true/' /etc/containerd/config.toml
sudo systemctl restart containerd.service
sudo systemctl restart kubelet.service
sudo systemctl enable kubelet.service
sudo kubeadm config images pull
sudo kubeadm init --pod-network-cidr=10.10.0.0/16
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/tigera-operator.yaml 
curl https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/custom-resources.yaml -O
sed -i 's/cidr: 192\.168\.0\.0\/16/cidr: 10.10.0.0\/16/g' custom-resources.yaml
kubectl create -f custom-resources.yaml
kubectl get all --all-namespaces
sudo apt-get install bash-completion
echo 'source <(kubectl completion bash)' >>~/.bashrc
source ~/.bashrc
kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null
history

kubeadm join 172.31.82.246:6443 --token 6bv7p3.iyj660yk7yw88zkp \
        --discovery-token-ca-cert-hash sha256:5059c25e0753b8bf25c8d9c75a43b32a85a83d2f5606b81eae75241348f40675


Install Kube-Flannel
https://github.com/flannel-io/flannel #deploying-flannel-manually
wget https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml
If you use custom podCIDR (not 10.244.0.0/16) you first need to download the above manifest and modify the network to match your one.
  net-conf.json: |
    {
      "Network": "10.10.0.0/16",
      "Backend": {
        "Type": "vxlan"
      }
    }


Kubernetes Nodes

#!/bin/bash
swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab
sudo hostnamectl set-hostname “worker-node-01”
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF
sudo modprobe overlay
sudo modprobe br_netfilter
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF
sudo sysctl --system
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gpg
sudo mkdir /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
sudo apt install -y docker.io
sudo mkdir /etc/containerd
sudo sh -c "containerd config default > /etc/containerd/config.toml"
sudo sed -i 's/ SystemdCgroup = false/ SystemdCgroup = true/' /etc/containerd/config.toml
sudo systemctl restart containerd.service
sudo systemctl restart kubelet.service
sudo systemctl enable kubelet.service

kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: efs-sc
provisioner: efs.csi.aws.com
parameters:
  provisioningMode: efs-ap
  directoryPerms: "700"
  fileSystemId: fs-094aac002cb1dfc2d  # 

---
apiVersion: v1
kind: PersistentVolume
metadata:
  name: efs-pv
spec:
  capacity:
    storage: 5Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain
  storageClassName: efs-sc
  csi:
    driver: efs.csi.aws.com
    volumeHandle: fs-094aac002cb1dfc2d

---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: efs-claim
spec:
  accessModes:
    - ReadWriteMany
  storageClassName: efs-sc
  resources:
    requests:
      storage: 5Gi

apiVersion: v1
kind: Pod
metadata:
  name: efs-app
spec:
  containers:
    - name: app
      image: centos
      command: ["/bin/sh"]
      args: ["-c", "while true; do echo $(date -u) >> /data/out.txt; sleep 5; done"]
      volumeMounts:
        - name: persistent-storage
          mountPath: /data
  volumes:
    - name: persistent-storage
      persistentVolumeClaim:
        claimName: efs-claim

apiVersion: apps/v1
kind: Deployment
metadata:
  name: pvdeploy
spec:
  replicas: 1
  selector:      # tells the controller which pods to watch/belong to
    matchLabels:
     app: mypv
  template:
    metadata:
      labels:
        app: mypv
    spec:
      containers:
        - name: app
          image: centos
          command: ["/bin/sh"]
          args: ["-c", "while true; do echo $(date -u) >> /data/out.txt; sleep 5; done"]
          volumeMounts:
          - name: mypd
            mountPath: /data
      volumes:
        - name: mypd
          persistentVolumeClaim:
            claimName: efs-claim


Upgrade Cluster to 1.27
#!/bin/bash
apt update
apt-cache madison kubeadm
apt-mark unhold kubeadm && apt-get update && apt-get install -y kubeadm=1.27.6-00 && apt-mark hold kubeadm
kubeadm version
kubeadm upgrade plan
sudo kubeadm upgrade apply v1.27.6
sudo kubeadm upgrade node
sudo kubeadm upgrade apply
apt-mark unhold kubelet kubectl &&  apt-get update && apt-get install -y kubelet=1.27.6-00 kubectl=1.27.6-00 && sudo apt-mark hold kubelet kubeadm kubectl
sudo systemctl daemon-reload
sudo systemctl restart kubelet

Upgrade Nodes to 1.27
kubectl drain <node-to-drain> --ignore-daemonsets
#!/bin/bash
apt-mark unhold kubelet kubectl &&  apt-get update && apt-get install -y kubelet=1.27.6-00 kubectl=1.27.6-00 && apt-mark hold kubelet kubectl
sudo systemctl daemon-reload
sudo systemctl restart kubelet

Upgrade Cluster to 1.28
#!/bin/bash
apt update
apt-cache madison kubeadm
apt-mark unhold kubeadm && apt-get update && apt-get install -y kubeadm=1.28.2-00 && apt-mark hold kubeadm
kubeadm version
kubeadm upgrade plan
sudo kubeadm upgrade apply v1.28.2
sudo kubeadm upgrade node
apt-mark unhold kubelet kubectl &&  apt-get update && apt-get install -y kubelet=1.28.2-00 kubectl=1.28.2-00 && apt-mark hold kubelet kubectl
sudo systemctl daemon-reload
sudo systemctl restart kubelet

Upgrade Nodes to 1.28
kubectl drain <node-to-drain> --ignore-daemonsets
#!/bin/bash
apt-mark unhold kubelet kubectl &&  apt-get update && apt-get install -y kubelet=1.28.2-00 kubectl=1.28.2-00 && apt-mark hold kubelet kubectl
sudo systemctl daemon-reload
sudo systemctl restart kubelet

--cert-file=/etc/kubernetes/pki/etcd/server.crt
--trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
--key-file=/etc/kubernetes/pki/etcd/server.key


kubectl describe cm kube-proxy -n kube-system
clusterCIDR: 10.10.0.0/16

Kubectx and Kubens – Command line Utilities
Through out the course, you have had to work on several different namespaces in the practice lab environments. In some labs, you also had to switch between several contexts.

While this is excellent for hands-on practice, in a real “live” kubernetes cluster implemented for production, there could be a possibility of often switching between a large number of namespaces and clusters.

This can quickly become and confusing and overwhelming task if you had to rely on kubectl alone.

This is where command line tools such as kubectx and kubens come in to picture.

Reference: https://github.com/ahmetb/kubectx

Kubectx:
With this tool, you don't have to make use of lengthy “kubectl config” commands to switch between contexts. This tool is particularly useful to switch context between clusters in a multi-cluster environment.

Installation:
* 		sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
* 		sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx

Syntax:
To list all contexts:
kubectx

To switch to a new context:
kubectx <context_name>

To switch back to previous context:
kubectx -

To see current context:
kubectx -c

Kubens:
This tool allows users to switch between namespaces quickly with a simple command.
Installation:
* 		sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
* 		sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens

Syntax:
To switch to a new namespace:
kubens <new_namespace>

To switch back to previous namespace:
kubens -

docker run -it -v /root/data_volume:/data --name ubuntu ubuntu

wget https://github.com/coredns/coredns/releases/download/v1.11.1/coredns_1.11.1_linux_amd64.tgz