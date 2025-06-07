# Kubernetes Client

### Build GitHub Action Status
![Build and Publish kubectl container](https://github.com/agilebeat/zookeeper-docker/workflows/Build%20and%20Publish%20kubectl%20container/badge.svg)

### Container Details
[![](https://images.microbadger.com/badges/image/agilebeat/k8s-kubectl.svg)](http://microbadger.com/images/agilebeat/k8s-kubectl "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/agilebeat/k8s-kubectl.svg)](http://microbadger.com/images/agilebeat/k8s-kubectl "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/commit/agilebeat/k8s-kubectl.svg)](http://microbadger.com/images/agilebeat/k8s-kubectl "Get your own commit badge on microbadger.com")

# Supported tags and respective `Dockerfile` links
* `3.93.3`, `latest`    [(v3.93.3/Dockerfile)](https://github.com/agilebeat/k8s-kubectl/blob/v1.31.4/Dockerfile)


## Overview
This container provides the Kubernetes client kubectl which can be used to interact with a Kubernetes cluster.

## Supported OS/ARCH
   * linux/amd64
   * linux/arm64
   * linux/s390x
   * linux/ppc64le

Massive thanks to [barthy1](https://github.com/barthy1) via [PR](https://github.com/agilebeat/k8s-helm/pull/89) for contributing this work.

## Build
`make docker_build`

## Run
`docker run --rm agilebeat/k8s-kubectl:``git rev-parse --abbrev-ref HEAD`` --server=http://<server-name>:8080 get pods`

## Data Container

In order to get kube spec files accessible via the kubectl container please use the following data container that exposes a data volume under /data. It dumps everything under cwd in the data container.

```
cat ~/bin/mk-data-container 
#!/usr/bin/env sh

WORKDIR="$1"

if [ -z $WORKDIR ]; then
    WORKDIR='.'
fi

cd $WORKDIR
echo "FROM debian:jessie\n\nVOLUME [ '/data' ]\n\nCOPY * /data/" > ./Dockerfile.data-container
docker rm data
docker build -f ./Dockerfile.data-container -t temp/data .
docker run --name data temp/data
rm ./Dockerfile.data-container
```

## Data container with kubectl container
```
docker run --rm -it --volumes-from data k8s/kubectl:<tag> --server=http://<server-name>:8080 create -f /data/controller.yml
```

