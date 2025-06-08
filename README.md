# Kubernetes Client

### Build GitHub Action Status
[![Build and Publish](https://github.com/agilebeat-inc/zookeeper/actions/workflows/dockerimage.yaml/badge.svg?branch=3.7.2)](https://github.com/agilebeat-inc/zookeeper/actions/workflows/dockerimage.yaml)

## Overview
This container provides the basic image zookeeper which can be used by Zookeeper Operator [pravega/zookeper-operator](https://hub.docker.com/r/pravega/zookeeper-operator).

## Build

* Uses Amazon Corretto 11 (a distribution of OpenJDK) as the base image used to build a fat JAR zu.jar (includes all dependencies).
* Uses official zookeeper image and makes it runnable by Kubernetes Operator pravega/zookeper-operator](https://hub.docker.com/r/pravega/zookeeper-operator)

## Supported OS/ARCH
   * linux/amd64
   * linux/arm64

## Build
`make docker_build`

## Trigger Commit Number
1

