# ci-actions-prettier
![License](https://img.shields.io/github/license/stephenmoloney/ci-actions.svg?style=flat-square)
![Image Size](https://img.shields.io/microbadger/image-size/smoloney/ci-actions-prettier/latest.svg?style=flat)
![Image Version](https://images.microbadger.com/badges/version/smoloney/ci-actions-prettier.svg)
![Docker Pulls](https://img.shields.io/docker/pulls/smoloney/ci-actions-prettier.svg?style=flat)

`ci-actions-prettier` is an action for linting and/or formatting files types 
including typescript, css, scss, json, graphql, markdown, yaml, html and others.

The image is available on the
[dockerhub](https://hub.docker.com/r/smoloney/ci-actions-prettier).

## Usage

Prettier can be used in a multitude of ways, primarily as
either a linting tool and/or a formatting tool.

These examples are of using prettier as a linting tool:

### Github actions workflow example

```text
action "prettier-yaml-lint" {
  uses = "stephenmoloney/ci-actions/prettier@master"
  args = [
          "--exclude='./k8s/charts'",
          "--file-glob='*.y*ml'",
          "--exec-args='prettier --check --parser yaml --config ./.prettierrc.yml'"
         ]
}
```

### Gitlab-CI workflow example

```bash
docker run --rm -v "${PWD}":/ci-actions/workspace:ro smoloney/ci-actions-prettier:1.16.4 \
  --exclude='./test' \
  --file-glob='*.y*ml' \
  --exec-args='prettier --check --parser yaml --config ./.prettierrc.yml'
```

## Arguments

```text
Usage:
docker run \
  --rm \
  -v "${PWD}:${WORKSPACE}" smoloney/ci-actions-prettier:latest \
  [--exec-args EXEC_ARGS] [--exclude EXCLUDE...] [--file-glob FILE_GLOB]

Options:
  --exec-args Executable arguments to be passed to yammlint
  --exclude (repeatable arg) directories to be ignored
  --file-glob  file types to be inspected (eg, '*.y*ml')
```

### Arguments - exclusion paths

To exclude paths, enter them as follows:

```shell
--exclude='./k8s/test-charts' --exclude='.prettierrc.yml'
```

### Arguments - executable arguments

The exec-args string which will be passed directly as arguments to
the `prettier` command. Check `prettier --help` for more
information.

```shell
--exec-args='prettier --check --parser yaml --config ./.prettierrc.yml'
```

### Arguments - file glob

The `entrypoint.sh` script will attempt to gather all the files
with the argument from `--file-glob` using the `find` command.

```shell
--file-glob='*.y*ml'
```

## License

[MIT](../LICENSE.txt)
