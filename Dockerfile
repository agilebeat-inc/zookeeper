#
# Copyright (c) 2025 Agilebeat Inc., or its subsidiaries. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#

ARG DOCKER_REGISTRY
ARG ZK_VERSION=latest

# Stage 1
FROM ${DOCKER_REGISTRY:+$DOCKER_REGISTRY/}eclipse-temurin:11-jdk AS builder
RUN mkdir /zu
COPY zu /zu
WORKDIR /zu
RUN ./gradlew --console=verbose --info shadowJar

# stage 2
FROM ${DOCKER_REGISTRY:+$DOCKER_REGISTRY/}zookeeper:3.7.2 AS runner
COPY bin /usr/local/bin
RUN chmod +x /usr/local/bin/*
COPY --from=builder /zu/build/libs/zu.jar /opt/libs/

RUN apt-get -q update && \
    apt-get install -y dnsutils curl procps socat


ARG VCS_REF
ARG BUILD_DATE
# Metadata
LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/agilebeat-inc/zookeeper" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.docker.dockerfile="/Dockerfile"
