# syntax=docker/dockerfile:1.2

# e.g.: `docker build --rm --build-arg "NODE_VERSION=latest" -f ./Dockerfile .`
# e.g.: `docker build --rm --build-arg "NODE_VERSION=11.8-alpine" -f ./Dockerfile .`
ARG NODE_VERSION

FROM node:${NODE_VERSION:-alpine}

RUN set -x \
    && . /etc/os-release \
    && case "$ID" in \
        alpine) \
            apk add --no-cache bash git tar \
            ;; \
        debian) \
            apt-get update \
            && apt-get -yq install bash git tar \
            && apt-get -yq clean \
            && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
            ;; \
    esac \
    && npm i -g bun\
    && npm i -g pnpm\
    && bash --version && npm -v && node -v && pnpm -v && bun -v && git -v