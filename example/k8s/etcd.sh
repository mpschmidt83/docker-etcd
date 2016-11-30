#!/usr/bin/env bash



function create() {

  kubectl create namespace rejoinable-etcd

  kubectl --namespace=rejoinable-etcd create -f etcd-lb-srv.yaml
  kubectl --namespace=rejoinable-etcd create -f etcd1-srv.yaml
  kubectl --namespace=rejoinable-etcd create -f etcd2-srv.yaml
  kubectl --namespace=rejoinable-etcd create -f etcd3-srv.yaml

  kubectl --namespace=rejoinable-etcd create -f etcd1-rc.yaml
  kubectl --namespace=rejoinable-etcd create -f etcd2-rc.yaml
  kubectl --namespace=rejoinable-etcd create -f etcd3-rc.yaml
}



function delete() {

  kubectl --namespace=rejoinable-etcd delete rc etcd-node-001
  kubectl --namespace=rejoinable-etcd delete rc etcd-node-002
  kubectl --namespace=rejoinable-etcd delete rc etcd-node-003

  kubectl --namespace=rejoinable-etcd delete svc etcd-001-node-001
  kubectl --namespace=rejoinable-etcd delete svc etcd-001-node-002
  kubectl --namespace=rejoinable-etcd delete svc etcd-001-node-003
  kubectl --namespace=rejoinable-etcd delete svc etcd-001

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
