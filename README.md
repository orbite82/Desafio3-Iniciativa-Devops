# Desafio3-Iniciativa-Devops
https://iniciativadevops.com.br/aula3/

* Comandos

```
┌─[orbite]@[orbite-desktop]:~/Iniciativa-Devops/terraform-digitalocean
└──> $ ls
kube_config.yaml  main.tf  output.tf  referencia.txt  resource.tf  terraform.tfstate  terraform.tfstate.backup  terraform.tfvars
┌─[orbite]@[orbite-desktop]:~/Iniciativa-Devops/terraform-digitalocean
└──> $ kubectl get nodes --kubeconfig kube_config.yaml 
NAME            STATUS   ROLES    AGE   VERSION
premium-clhr0   Ready    <none>   40m   v1.22.8
premium-clhr1   Ready    <none>   40m   v1.22.9
```
* Copiando o kube config

```
┌─[orbite]@[orbite-desktop]:~/Iniciativa-Devops/terraform-digitalocean
└──> $ cp kube_config.yaml ~/.kube/config 
```

```
┌─[orbite]@[orbite-desktop]:~/Iniciativa-Devops/terraform-digitalocean
└──> $ kubectl get nodes
NAME            STATUS   ROLES    AGE   VERSION
premium-clhr0   Ready    <none>   42m   v1.22.8
premium-clhr1   Ready    <none>   42m   v1.22.8
```
* Direcionar até seu projeto

```
┌─[orbite]@[orbite-desktop]:~/Iniciativa-Devops/kube-news
└──> $ cd k8s/
┌─[orbite]@[orbite-desktop]:~/Iniciativa-Devops/kube-news/k8s
└──> $ ls
deployment.yaml
```

```
┌─[orbite]@[orbite-desktop]:~/Iniciativa-Devops/kube-news/k8s
└──> $ kubectl apply -f deployment.yaml 
deployment.apps/postgre created
service/postgre created
deployment.apps/kubenews created
service/kube-news created
```

```
┌─[orbite]@[orbite-desktop]:~/Iniciativa-Devops/kube-news/k8s
└──> $ kubectl get pods
NAME                        READY   STATUS              RESTARTS   AGE
kubenews-55554d8b4f-26lqr   0/1     ContainerCreating   0          24s
kubenews-55554d8b4f-7knc9   0/1     ContainerCreating   0          24s
kubenews-55554d8b4f-9psc4   0/1     ContainerCreating   0          24s
kubenews-55554d8b4f-9pv5m   0/1     ContainerCreating   0          24s
kubenews-55554d8b4f-c6gdz   0/1     ContainerCreating   0          24s
kubenews-55554d8b4f-d2jsb   0/1     ContainerCreating   0          24s
kubenews-55554d8b4f-ghkqz   0/1     ContainerCreating   0          24s
kubenews-55554d8b4f-hlw5k   0/1     ContainerCreating   0          24s
kubenews-55554d8b4f-jmwcd   0/1     ContainerCreating   0          24s
kubenews-55554d8b4f-k9xvw   0/1     ContainerCreating   0          24s
kubenews-55554d8b4f-kbmdl   0/1     ContainerCreating   0          24s
kubenews-55554d8b4f-m55w7   0/1     ContainerCreating   0          24s
kubenews-55554d8b4f-mq58p   0/1     ContainerCreating   0          24s
kubenews-55554d8b4f-p8xfn   0/1     ContainerCreating   0          24s
kubenews-55554d8b4f-q6d58   0/1     ContainerCreating   0          24s
kubenews-55554d8b4f-qcjn6   0/1     ContainerCreating   0          24s
kubenews-55554d8b4f-qnxnv   0/1     ContainerCreating   0          24s
kubenews-55554d8b4f-vbbkl   0/1     ContainerCreating   0          24s
kubenews-55554d8b4f-vnfgn   0/1     ContainerCreating   0          24s
kubenews-55554d8b4f-vwc4b   0/1     ContainerCreating   0          24s
postgre-786bc7b694-7hnzs    0/1     ContainerCreating   0          25s
```

```
┌─[orbite]@[orbite-desktop]:~/Iniciativa-Devops/kube-news/k8s
└──> $ kubectl get services
NAME         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
kube-news    NodePort    10.245.90.131    <none>        80:30000/TCP   70s
kubernetes   ClusterIP   10.245.0.1       <none>        443/TCP        49m
postgre      ClusterIP   10.245.255.203   <none>        5432/TCP       71s
```

* Modificação no deployment

---
apiVersion: v1
kind: Service
metadata:
  name: kube-news
spec:
  selector:
    app: kubenews
  ports:
  - port: 80
    targetPort: 8080
    nodePort: 30000
  type: LoadBalancer  

```
┌─[orbite]@[orbite-desktop]:~/Iniciativa-Devops/kube-news/k8s
└──> $ kubectl apply -f deployment.yaml 
deployment.apps/postgre unchanged
service/postgre unchanged
deployment.apps/kubenews unchanged
service/kube-news configured
```

```
┌─[orbite]@[orbite-desktop]:~/Iniciativa-Devops/kube-news/k8s
└──> $ kubectl get pods
NAME                        READY   STATUS    RESTARTS   AGE
kubenews-55554d8b4f-26lqr   1/1     Running   0          4m20s
kubenews-55554d8b4f-7knc9   1/1     Running   0          4m20s
kubenews-55554d8b4f-9psc4   1/1     Running   0          4m20s
kubenews-55554d8b4f-9pv5m   1/1     Running   0          4m20s
kubenews-55554d8b4f-c6gdz   1/1     Running   0          4m20s
kubenews-55554d8b4f-d2jsb   1/1     Running   0          4m20s
kubenews-55554d8b4f-ghkqz   1/1     Running   0          4m20s
kubenews-55554d8b4f-hlw5k   1/1     Running   0          4m20s
kubenews-55554d8b4f-jmwcd   1/1     Running   0          4m20s
kubenews-55554d8b4f-k9xvw   1/1     Running   0          4m20s
kubenews-55554d8b4f-kbmdl   1/1     Running   0          4m20s
kubenews-55554d8b4f-m55w7   1/1     Running   0          4m20s
kubenews-55554d8b4f-mq58p   1/1     Running   0          4m20s
kubenews-55554d8b4f-p8xfn   1/1     Running   0          4m20s
kubenews-55554d8b4f-q6d58   1/1     Running   0          4m20s
kubenews-55554d8b4f-qcjn6   1/1     Running   0          4m20s
kubenews-55554d8b4f-qnxnv   1/1     Running   0          4m20s
kubenews-55554d8b4f-vbbkl   1/1     Running   0          4m20s
kubenews-55554d8b4f-vnfgn   1/1     Running   0          4m20s
kubenews-55554d8b4f-vwc4b   1/1     Running   0          4m20s
postgre-786bc7b694-7hnzs    1/1     Running   0          4m21s
┌─[orbite]@[orbite-desktop]:~/Iniciativa-Devops/kube-news/k8s
└──> $ kubectl get services
NAME         TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
kube-news    LoadBalancer   10.245.90.131    <pending>     80:30000/TCP   4m25s
kubernetes   ClusterIP      10.245.0.1       <none>        443/TCP        53m
postgre      ClusterIP      10.245.255.203   <none>        5432/TCP       4m26s
```

* Esperar a saída de IP

```
┌─[orbite]@[orbite-desktop]:~/Iniciativa-Devops/terraform-digitalocean
└──> $ kubectl get services
NAME         TYPE           CLUSTER-IP       EXTERNAL-IP     PORT(S)        AGE
kube-news    LoadBalancer   10.245.90.131    164.90.252.85   80:30000/TCP   6m27s
kubernetes   ClusterIP      10.245.0.1       <none>          443/TCP        55m
postgre      ClusterIP      10.245.255.203   <none>          5432/TCP       6m28s
```

OU

```
┌─[orbite]@[orbite-desktop]:~/Iniciativa-Devops/kube-news/k8s
└──> $ watch 'kubectl get services'
```

* Testar com ip externo

[Ip da Aplicação Digital Ocean](164.90.252.85)

===============

* Terraform init

Após subir o cluster:

```
┌─[orbite]@[orbite-desktop]:~/Iniciativa-Devops/terraform-digitalocean
└──> $ cp ./kube_config.yaml ~/.kube/config
```

```
┌─[orbite]@[orbite-desktop]:~/Iniciativa-Devops/terraform-digitalocean
└──> $ kubectl get nodes
NAME            STATUS   ROLES    AGE    VERSION
premium-clz5a   Ready    <none>   7m1s   v1.22.8
premium-clz5e   Ready    <none>   7m1s   v1.22.8
```

* Aplicar deploymente do outro repo:

```
┌─[orbite]@[orbite-desktop]:~/Iniciativa-Devops/kube-news
└──> $ kubectl apply -f k8s/deployment.yaml 
deployment.apps/postgre created
service/postgre created
deployment.apps/kubenews created
service/kube-news created
```

```
┌─[orbite]@[orbite-desktop]:~/Iniciativa-Devops/kube-news
└──> $ kubectl get all
NAME                            READY   STATUS    RESTARTS   AGE
pod/kubenews-55554d8b4f-2pv8m   1/1     Running   0          3m54s
pod/kubenews-55554d8b4f-hn5bv   1/1     Running   0          3m54s
pod/postgre-786bc7b694-4nnnw    1/1     Running   0          3m55s

NAME                 TYPE           CLUSTER-IP       EXTERNAL-IP     PORT(S)        AGE
service/kube-news    LoadBalancer   10.245.118.75    164.90.254.26   80:30000/TCP   3m54s
service/kubernetes   ClusterIP      10.245.0.1       <none>          443/TCP        15m
service/postgre      ClusterIP      10.245.152.215   <none>          5432/TCP       3m55s

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/kubenews   2/2     2            2           3m55s
deployment.apps/postgre    1/1     1            1           3m55s

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/kubenews-55554d8b4f   2         2         2       3m55s
replicaset.apps/postgre-786bc7b694    1         1         1       3m55s
```

```
┌─[orbite]@[orbite-desktop]:~/Iniciativa-Devops/terraform-digitalocean
└──> $ kubectl get svc
NAME         TYPE           CLUSTER-IP       EXTERNAL-IP     PORT(S)        AGE
kube-news    LoadBalancer   10.245.118.75    164.90.254.26   80:30000/TCP   4m24s
kubernetes   ClusterIP      10.245.0.1       <none>          443/TCP        15m
postgre      ClusterIP      10.245.152.215   <none>          5432/TCP       4m25s
```

* Deletar o manifesto e criar a pipeline

"Obs": Atento ao Repo

```
┌─[orbite]@[orbite-desktop]:~/Iniciativa-Devops/kube-news
└──> $ kubectl delete -f k8s/deployment.yaml 
deployment.apps "postgre" deleted
service "postgre" deleted
deployment.apps "kubenews" deleted
service "kube-news" deleted
```

```
┌─[orbite]@[orbite-desktop]:~/Iniciativa-Devops/terraform-digitalocean
└──> $ kubectl get pods
No resources found in default namespace.
```

* Pipeline kube-news

[Github](https://github.com/orbite82/kube-news)

ir até actions: https://github.com/orbite82/kube-news/actions/new

clicar em : set up a workflow yourself 

* Deploy CI | CD

```
┌─[orbite]@[orbite-desktop]:~/Iniciativa-Devops/kube-news
└──> $ kubectl get pods
NAME                        READY   STATUS    RESTARTS   AGE
kubenews-859cfdc6f5-cffqz   1/1     Running   0          82s
kubenews-859cfdc6f5-kzsnh   1/1     Running   0          82s
postgre-786bc7b694-5wbzc    1/1     Running   0          83s
```

[CI/CD](https://github.com/orbite82/kube-news/runs/6818040114?check_suite_focus=true)

```
┌─[orbite]@[orbite-desktop]:~/Iniciativa-Devops/kube-news
└──> $ kubectl get all
NAME                            READY   STATUS    RESTARTS   AGE
pod/kubenews-859cfdc6f5-cffqz   1/1     Running   0          2m58s
pod/kubenews-859cfdc6f5-kzsnh   1/1     Running   0          2m58s
pod/postgre-786bc7b694-5wbzc    1/1     Running   0          2m59s

NAME                 TYPE           CLUSTER-IP       EXTERNAL-IP     PORT(S)        AGE
service/kube-news    LoadBalancer   10.245.171.128   167.172.0.140   80:30000/TCP   2m58s
service/kubernetes   ClusterIP      10.245.0.1       <none>          443/TCP        4h35m
service/postgre      ClusterIP      10.245.25.246    <none>          5432/TCP       2m59s

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/kubenews   2/2     2            2           2m58s
deployment.apps/postgre    1/1     1            1           2m59s

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/kubenews-859cfdc6f5   2         2         2       2m58s
replicaset.apps/postgre-786bc7b694    1         1         1       2m59s
```