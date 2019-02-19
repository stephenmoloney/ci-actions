# ci-actions-helm
![License](https://img.shields.io/github/license/stephenmoloney/ci-actions.svg?style=flat-square)
![Image Size](https://img.shields.io/microbadger/image-size/smoloney/ci-actions-helm/latest.svg?style=flat)
![Image Version](https://images.microbadger.com/badges/version/smoloney/ci-actions-helm.svg)
![Docker Pulls](https://img.shields.io/docker/pulls/smoloney/ci-actions-helm.svg?style=flat)

`ci-actions-helm` is part of a collection of actions
for running github actions tasks and also running
those same tasks in another ci tool such as
[gitlab-ci](https://about.gitlab.com/product/continuous-integration)
or [travis](https://travis-ci.org).

The image is available on the
[dockerhub](https://hub.docker.com/r/smoloney/ci-actions-helm).

## Usage

Helm is a tool for kubernetes related tasks.

These examples are of using helm as a linting tool:

### Github actions workflow example

```shell
action "helm" {
  uses = "stephenmoloney/ci-actions/helm@master"
  args = [
          "--exclude=./k8s/charts",
          "--exec-args='helm lint ./charts'"
         ]
}
```

### Gitlab-CI workflow example

```shell
docker run --rm -v ${PWD}:/ci-actions/workspace \
  smoloney/ci-actions-helm:latest \
  --exec-args='helm lint ./charts'
```

## Arguments

```text
Usage:
docker run \
  --rm \
  -v ${PWD}:${WORKSPACE} smoloney/ci-actions-helm:latest \
  [--exec-args EXEC_ARGS

Options:
  --exec-args The command to be executed, eg `helm lint ./charts`
```

### Arguments - executable arguments

This is the exact command to be run. Eg

```shell
--exec-args='helm lint ./charts'
```

### Arguments - exclusion paths

For the helm lint task, the `--exclude` cli argument
should not be used.

### Arguments - file glob

For the helm lint task, the `--file-glob` cli argument
should not be used.

## License

[MIT](../LICENSE.txt)
