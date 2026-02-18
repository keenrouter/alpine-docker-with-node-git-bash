# syntax=docker/dockerfile:1.2
# e.g.: `docker build --rm --build-arg "FROM_IMAGE=node:24-trixie-slim" -f ./Dockerfile .`
ARG FROM_IMAGE

FROM ${FROM_IMAGE}

RUN set -x \
    && apt-get update \
    && apt-get -yq install bash git curl unzip gnupg

RUN curl https://get.volta.sh | bash

RUN useradd admin \
    && echo admin | passwd admin --stdin \
    && usermod -aG sudo admin

COPY sshd-actions.conf /etc/ssh/sshd_config.d/sshd-actions.conf

RUN curl -fsSL https://get.opentofu.org/install-opentofu.sh -o install-opentofu.sh
RUN chmod +x install-opentofu.sh \
    && ./install-opentofu.sh --install-method standalone \
    && rm -f install-opentofu.sh

RUN ssh-keygen -A \
    && npm i -g bun \
    && npm i -g pnpm \
    && bash --version && npm -v && node -v && pnpm -v && bun -v && git -v

RUN apt-get -yq install openjdk-25-jdk openssh-server \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \

