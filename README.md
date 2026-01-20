# Motiviation

Light Docker image with Node.js and auxiliary commands for running CI/CD.

## Installed applications

Commands available in the image:

- `git`
- `bash`
- `node` (version 24)
- `npm`
- `pnpm`
- `bun`
- `volta`
- `openssh`, e.g. `/usr/sbin/sshd`
- `openjdk` (version 25), e.g. `java --version`

> The image is based on the Debian OS (trixie).

### Docker registries:

You can check all existing tags in one of the following docker-registries:

| Registry                                   | Image                      |
|--------------------------------------------|----------------------------|
| [Docker Hub][docker-hub]                   | `skipero/neat-ci`         |
| 

Supported architectures:
- linux/amd64


## Supported tags

- `latest`
- `1`


## How can I use this?

For example:

```bash
$ docker run --rm \
    --volume "$(pwd):/app" \
    --workdir "/app" \
    --user "$(id -u):$(id -g)" \
    skipero/neat-ci:latest \
    npm ci
```

Or using with `docker-compose.yml`:

```yml
services:
  node:
    image: skipero/neat-ci:1
    volumes:
      - ./src:/app:rw
    working_dir: /app
    command: []
```

SSH into container with username:password `admin:admin`.

