# ci-actions-bundle
![Image Size](https://images.microbadger.com/badges/image/smoloney/ci-actions-bundle.svg)
![Image Version](https://images.microbadger.com/badges/version/smoloney/ci-actions-bundle.svg)
![License](https://img.shields.io/github/license/stephenmoloney/ci-actions.svg?style=flat-square)
![Docker Pulls](https://img.shields.io/docker/pulls/smoloney/ci-actions-bundle.svg?style=flat)

`ci-actions-bundle` is an image bundled with a collection of actions. This image is 
useful if one does not want to download each docker image separately.

The image is available on the [dockerhub](https://hub.docker.com/r/smoloney/ci-actions-bundle).

## Usage

See the `README.md` of the respectively action to understand usage.

This is an example are of using helm as a linting tool with the `ci-action-bundle`
image rather than the separate `ci-action-helm` image. The approach is
the same except the bundle image is being used.

See the table below of links to `README.md` files for further information on each actions.

| Linting Package                                                                  |
| -------------------------------------------------------------------------------- |
| [helm](https://github.com/stephenmoloney/ci-actions/tree/master/helm/README.md)  | 

### Gitlab-CI workflow example (helm lint)

```shell
docker run --rm -v ${PWD}:/ci-actions/workspace \
  smoloney/ci-actions-bundle:latest \
  --exec-args='helm lint ./charts'
```

## License

[MIT](../LICENSE.txt)
