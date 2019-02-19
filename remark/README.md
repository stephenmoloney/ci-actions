# ci-actions-remark
![License](https://img.shields.io/github/license/stephenmoloney/ci-actions.svg?style=flat-square)
![Image Size](https://img.shields.io/microbadger/image-size/smoloney/ci-actions-remark/latest.svg?style=flat)
![Image Version](https://images.microbadger.com/badges/version/smoloney/ci-actions-remark.svg)
![Docker Pulls](https://img.shields.io/docker/pulls/smoloney/ci-actions-remark.svg?style=flat)

`ci-actions-remark` is an action for linting markdown.

The image is available on the
[dockerhub](https://hub.docker.com/r/smoloney/ci-actions-remark).

## Usage

Remark can be used in a multitude of ways, primarily as
either a linting tool and/or a formatting tool for text
including markdown documents.

These examples are of using remark as a linting tool:

### Github actions workflow example

```shell
action "remark" {
  uses = "stephenmoloney/ci-actions/remark@master"
  args = [
          "--exclude=./k8s/charts",
          "--file-glob='*.md'",
          "--exec-args='remark --frail --rc-path ./.remarkrc'"
         ]
}
```

### Gitlab-CI workflow example

```shell
docker run --rm -v "${PWD}":/ci-actions/workspace smoloney/ci-actions-remark:6.0.4 \
  --file-glob='*.md' \
  --exec-args='remark --frail --rc-path ./.remarkrc'
```

## Arguments

```text
Usage:
docker run \
  --rm \
  -v ${PWD}:${WORKSPACE} smoloney/ci-actions-remark:latest \
  [--exec-args EXEC_ARGS] [--exclude EXCLUDE...] [--file-glob FILE_GLOB]

Options:
  --exec-args Executable arguments to be passed to remark
  --exclude (repeatable arg) directories to be ignored
  --file-glob file types to be inspected. Needs to be set to '*.md'.
```

### Arguments - exclusion paths

To exclude paths, enter them as follows:

```shell
--exclude='./k8s/test-charts'
```

### Arguments - executable arguments

The command to execute, eg

```shell
--exec-args='remark --frail --rc-path ./.remarkrc'
```

### Arguments - file glob

The file types to be found based on the file extension.
Needs to be set to `*.md` to get markdown files.

```shell
--file-glob='*.md'
```

## License

[MIT](../LICENSE.txt)
