# syntax=docker/dockerfile:1.2

# e.g.: `docker build --rm --build-arg "NODE_VERSION=latest" -f ./Dockerfile .`
# e.g.: `docker build --rm --build-arg "NODE_VERSION=11.8-alpine" -f ./Dockerfile .`
ARG NODE_VERSION

FROM node:${NODE_VERSION:-trixie-slim}

RUN set -x \
    && . /etc/os-release \
    && case "$ID" in \
        alpine) \
            apk add --no-cache bash git openssh doas \
            && adduser admin -D -G wheel \
            && echo "admin:admin" | chpasswd \
            && echo 'permit :wheel as root' > /etc/doas.d/doas.conf \
            ;; \
        debian) \
            apt-get update \
            && apt-get -yq install bash git openssh-server \
            && apt-get -yq clean \
            && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
            && curl https://get.volta.sh | bash \
            && useradd admin \
            && echo admin | passwd admin --stdin \
            && usermod -aG sudo admin \
            ;; \
    esac


COPY sshd-actions.conf /etc/ssh/sshd_config.d/sshd-actions.conf

RUN ssh-keygen -A \
    && npm i -g bun \
    && npm i -g pnpm \
    && bash --version && npm -v && node -v && pnpm -v && bun -v && git -v

