# ci-actions-bundle
![License](https://img.shields.io/github/license/stephenmoloney/ci-actions.svg?style=flat-square)
![Image Size](https://images.microbadger.com/badges/image/smoloney/ci-actions-bundle.svg)
![Image Version](https://images.microbadger.com/badges/version/smoloney/ci-actions-bundle.svg)
![Docker Pulls](https://img.shields.io/docker/pulls/smoloney/ci-actions-bundle.svg?style=flat)

`ci-actions-bundle` is an image bundled with a collection of actions. This image is 
useful if one does not want to download each docker image separately.

The image is available on the dockerhub as 
[smoloney/ci-actions-bundle](https://hub.docker.com/r/smoloney/ci-actions-bundle).

## Usage

See the table below of links to `README.md` files for detailed information on each actions.

| Package                                                                                      |
| -------------------------------------------------------------------------------------------- |
| [helm](https://github.com/stephenmoloney/ci-actions/tree/master/helm/README.md)              | 
| [remark](https://github.com/stephenmoloney/ci-actions/tree/master/remark/README.md)          | 
| [prettier](https://github.com/stephenmoloney/ci-actions/tree/master/prettier/README.md)      | 

### Gitlab-CI workflow example (helm lint)

```shell
docker run --rm -v ${PWD}:/ci-actions/workspace \
  smoloney/ci-actions-bundle:latest \
  --exec-args='helm lint ./charts'
```

### Gitlab-CI workflow example (remark lint)

```shell
docker run --rm -v ${PWD}:/ci-actions/workspace \
  smoloney/ci-actions-bundle:latest \
  --file-glob='*.md' \
  --exec-args='remark --frail --rc-path ./.remarkrc'
```

### Gitlab-CI workflow example (prettier lint)

```shell
docker run --rm -v ${PWD}:/ci-actions/workspace \
  smoloney/ci-actions-bundle:latest \
  --file-glob='*.yaml' \
  --exec-args='prettier --check --parser yaml --config ./.prettierrc.yml'
```

## License

[MIT](../LICENSE.txt)
