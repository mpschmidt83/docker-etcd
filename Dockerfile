FROM oberthur/docker-ubuntu:16.04

MAINTAINER Michal Balinski <m.balinski@oberthur.com>

ENV _ETCD_VERSION=v2.3.7

ADD run.sh run.sh

RUN chmod +x run.sh && \
    curl -LO https://github.com/coreos/etcd/releases/download/$_ETCD_VERSION/etcd-$_ETCD_VERSION-linux-amd64.tar.gz && \
    tar xzvf etcd-$_ETCD_VERSION-linux-amd64.tar.gz && \
    mv etcd-$_ETCD_VERSION-linux-amd64/etcd* /bin/ && \
    rm -Rf etcd-$_ETCD_VERSION-linux-amd64* 

EXPOSE  2379 2380

CMD ["./run.sh"]

ENTRYPOINT [ "bash", "-c" ]