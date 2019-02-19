# ci-actions
![Build Status](https://img.shields.io/travis/stephenmoloney/ci-actions/master.svg?style=flat)
![License](https://img.shields.io/github/license/stephenmoloney/ci-actions.svg?style=flat-square)

ci-actions is a collection of tasks targetting ci pipelines

The collections are outlined in the tables below with
links to the readme of the specific action.

## Linting

| Linting Package                                                                          | Purpose                           | Dockerhub Image Name                                                                     | Recent Image Tags          |
| ---------------------------------------------------------------------------------------- | --------------------------------- | ---------------------------------------------------------------------------------------- | -------------------------- |
| [helm](https://github.com/stephenmoloney/ci-actions/tree/master/helm/README.md)          | For linting helm templates        | [smoloney/ci-actions-helm](https://hub.docker.com/r/smoloney/ci-actions-helm)            | `latest`, `2.12.3`         | 
| [prettier](https://github.com/stephenmoloney/ci-actions/tree/master/prettier/README.md)  | For linting various file types    | [smoloney/ci-actions-prettier](https://hub.docker.com/r/smoloney/ci-actions-prettier)    | `latest`, `1.16.4`         | 

## Formatting

| Formatting Package                                                                       | Purpose                           | Dockerhub Image Name                                                                     | Recent Image Tags          |
| ---------------------------------------------------------------------------------------- | --------------------------------- | ---------------------------------------------------------------------------------------- | -------------------------- |
| [prettier](https://github.com/stephenmoloney/ci-actions/tree/master/prettier/README.md)  | For formatting various file types | [smoloney/ci-actions-prettier](https://hub.docker.com/r/smoloney/ci-actions-prettier)    | `latest`, `1.16.4`         | 


## Tests

Run the tests

```shell
bash test.sh
```

## License

[MIT](LICENSE.txt)
