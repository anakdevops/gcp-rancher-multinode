

```
instance_internal_ips = [
  "10.0.0.3",
  "10.0.0.2",
]
instance_ips = [
  "34.68.131.157",
  "35.202.95.97",
]
```

# Single Node | RKE v1.6.1 | Rancher 2.9 | Kubernetes v1.29.7

```
ssh -i rancher-multinode/rancher-key.pem rancher@34.68.131.157
```


```
sudo su
cat /home/serverdevops/cluster.yml
su serverdevops
cat /home/serverdevops/.ssh/id_rsa.pub
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDFaATFGYWAn8tfTRUOFonNHG7v+h36xU7gz0/0uiXxaiIT7LTiE2i81VdjujZKhS3yqReHnyHK7hOG9TPmQC68cxDLcflddzowpgGE9WZT+maUG+SG81N5csMuilAxy+WVtRN7p9D1uBS8YCJ1V3rUeOX+26GZvN7SkfNzwDvuogRcLxCnjJYw0mHeg3cMo7b+CViog49B5Io0nGGPIlQJXW4TSHBUn9OfTdDUCStkfUoeidkrynUVENJtNwkzhrH1Z33yFTIdMGlCdAmHGEpeeqewvherE+EAhT0NMUNgJZi8FzzTgyHqi8YcV7AikJ06fJ/ghRlgFU6pXN87Ep7/ ansible-generated on rancher-node-1" >> ~/.ssh/authorized_keys
ssh serverdevops@10.0.0.3 # tes ssh
```

```
cd /home/serverdevops/
nano cluster.yml # sesuaikan IP
rke up --config cluster.yml
INFO[0176] Finished building Kubernetes cluster successfully
export KUBECONFIG=$HOME/kube_config_cluster.yml
kubectl get nodes
```

```
helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
kubectl create namespace cattle-system
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.2/cert-manager.crds.yaml
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v1.13.2
helm install rancher rancher-latest/rancher --namespace cattle-system --set hostname=ranchergcp.anakdevops.online
helm list --namespace cattle-system
kubectl -n cattle-system get deploy rancher
kubectl scale --replicas=1 deployment rancher -n cattle-system #scale down
kubectl -n cattle-system get deploy rancher -w
```
![image](../node1.png)



# Add Worker Node | RKE v1.6.1 | Rancher 2.9 | upgrade Kubernetes v1.29.7 to v1.30.3

```
instance_internal_ips = [
  "10.0.0.3",
  "10.0.0.2",
]
instance_ips = [
  "34.68.131.157",
  "35.202.95.97",
]
```

```
ssh -i rancher-multinode/rancher-key.pem rancher@35.202.95.97
sudo su
su serverdevops
cat /home/serverdevops/.ssh/id_rsa.pub
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCbeUyswaHpbMtuTQzVjX2fByEEY8Mh3p6OQ5Do2G1NAaRQZXS8dWlyStmEv/LLD0kWpLpHMrThVhS70WjRrCmGq4vr0+sehtqt6s9nLVaNBHGsjL8Nb0BmbNHF9njW2fr/QhvfvbYFratnelhP0eCkhrit4C7p+TEDvlsGpxclcQr0zqNJl8RQXjVtDAHdROIeiKvYyOR7yLjvbT77vsifaS0rQ48QPVirUvz/5DOBUZDEx7Gcv0Fu+8qA+qwyEa5B3GoblDDvR1xvDEM+d+OeZYh39vWlrbPp0i7HUj2YaCe7E6fjUO4dYI+3RIhpaRF4ayEklWg0HegBk3GmuIs1 ansible-generated on rancher-node-2" >> ~/.ssh/authorized_keys
ssh serverdevops@10.0.0.3 # node 1
ssh serverdevops@10.0.0.2 # node 2
rke config --list-version --all #cek kubernetes version
cd /home/serverdevops/
nano cluster.yml #Add IP Node 2
cat cluster.yml #pastikan sudah sesuai
rke up --config cluster.yml 
```

![image](../nodes.png)
![image](../pods.png)