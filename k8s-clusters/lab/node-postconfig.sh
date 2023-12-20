# in master node
# kubeadm reset -f
kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=192.168.56.11
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml

# in worker node
kubeadm join 192.168.56.11:6443 --token xeqwmz.rxx2lykvr9duz5ly --discovery-token-ca-cert-hash sha256:9462afd936118e5ce5939312e489564c6ad343bc7a783a3d4a8b71d76188d08b