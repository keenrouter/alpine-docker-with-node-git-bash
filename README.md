# Motiviation

Light Docker image with Node.js and auxiliary commands for running in CI/CD.

## Installed applications

Commands available in the image:

- `git`
- `bash`
- `node`
- `npm`
- `pnpm`
- `bun`
- `opnessh`

> The image is based on the Debian OS (trixie).

### Docker registries:

You can check all existing tags in one of the following docker-registries:

| Registry                                   | Image                      |
|--------------------------------------------|----------------------------|
| [Docker Hub][docker-hub]                   | `skipero/node-cli`         |
| 

Supported architectures:
- linux/amd64


## Supported tags

- `latest`
- `24`


## How can I use this?

For example:

```bash
$ docker run --rm \
    --volume "$(pwd):/app" \
    --workdir "/app" \
    --user "$(id -u):$(id -g)" \
    skipero/node-git-bun:24 \
    yarn install
```

Or using with `docker-compose.yml`:

```yml
services:
  node:
    image: skipero/node-git-bun:24
    volumes:
      - ./src:/app:rw
    working_dir: /app
    command: []
```

