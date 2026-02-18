# syntax=docker/dockerfile:1.2

# e.g.: `docker build --rm --build-arg "FROM_IMAGE=node:24-trixie-slim" -f ./Dockerfile .`
ARG FROM_IMAGE

FROM ${FROM_IMAGE}
FROM ghcr.io/opentofu/opentofu:minimal AS tofu

# Copy the tofu binary from the minimal image
COPY --from=tofu /usr/local/bin/tofu /usr/local/bin/tofu

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
            && apt-get -yq clean openjdk-25-jdk \
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

