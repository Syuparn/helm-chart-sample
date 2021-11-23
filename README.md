# helm-chart-sample
Helm chart template sample of Dapr applications which can reduce boilerplates

# about

This is a helm chart of Dapr sample application [Distributed Calculator](https://github.com/dapr/quickstarts/tree/master/distributed-calculator).

# usage

## print manifests

```bash
$ helm template ./distributed-calculator/
```

## deploy apps

### use Helm command

```bash
# prepare kind cluster
$ kind create cluster
# deploy dependent resources in advance
# Dapr (see https://docs.dapr.io/operations/hosting/kubernetes/kubernetes-deploy/#add-and-install-dapr-helm-chart)
$ helm upgrade --install dapr dapr/dapr \
--version=1.5 \
--namespace dapr-system \
--create-namespace \
--wait
# Redis (see https://github.com/bitnami/charts/tree/master/bitnami/redis)
$ helm install redis bitnami/redis
# deploy distributed-calculator
$ helm install distributed-calculator ./distributed-calculator/
# connect to frontend
$ kubectl port-forward svc/calculator-front-end 8080:80
# connect to tracer
$ kubectl port-forward svc/zipkin 9411:9411
# now you can access the calculator on localhost:8080 and the tracer on localhost:9411
```

### use Skaffold

```bash
$ skaffold run --port-forward
# you can access the calculator on localhost:8080 and the tracer on localhost:9411
```
