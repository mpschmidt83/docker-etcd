#!/usr/bin/env bash



function create() {

  kubectl create namespace rejoinable-etcd

  kubectl --namespace=rejoinable-etcd create -f services/etcd-lb.yaml
  kubectl --namespace=rejoinable-etcd create -f services/etcd1.yaml
  kubectl --namespace=rejoinable-etcd create -f services/etcd2.yaml
  kubectl --namespace=rejoinable-etcd create -f services/etcd3.yaml

  kubectl --namespace=rejoinable-etcd create -f rcs/etcd1.yaml
  kubectl --namespace=rejoinable-etcd create -f rcs/etcd2.yaml
  kubectl --namespace=rejoinable-etcd create -f rcs/etcd3.yaml

}



function delete() {

  kubectl --namespace=rejoinable-etcd delete deployments etcd-001
  kubectl --namespace=rejoinable-etcd delete deployments etcd-002
  kubectl --namespace=rejoinable-etcd delete deployments etcd-003

  kubectl --namespace=rejoinable-etcd delete svc etcd-001
  kubectl --namespace=rejoinable-etcd delete svc etcd-002
  kubectl --namespace=rejoinable-etcd delete svc etcd-003
  kubectl --namespace=rejoinable-etcd delete svc etcd-lb

  kubectl delete namespace rejoinable-etcd

}



command=$1

if [[ "${command}" == "create" ]]; then
  create
elif [[ "${command}" == "delete" ]]; then
  delete
else
  echo "Command not supported ${command}"
  echo "Supported command [create, delete]"
fi
