FROM alpine:3.9

ARG VERSION="latest"
ARG HELM_VERSION="2.12.3"
ARG PRETTIER_VERSION="1.16.4"
ARG REMARK_VERSION="6.0.4"
ARG WORKSPACE="/github/workspace"
ARG VCS_REF
ARG BUILD_DATE

LABEL \
      # https://github.com/opencontainers/image-spec/blob/master/annotations.md
      "org.opencontainers.image.created"="${BUILD_DATE}" \
      "org.opencontainers.image.authors"="Stephen Moloney <stephen@stephenmoloney.com>" \
      "org.opencontainers.image.homepage"="https://github.com/stephenmoloney/ci-actions/tree/master/bundle" \
      "org.opencontainers.image.documentation"="https://github.com/stephenmoloney/ci-actions/tree/master/bundle/README.md" \
      "org.opencontainers.image.source"="https://github.com/stephenmoloney/ci-actions" \
      "org.opencontainers.image.version"="\
      ci-actions=${VERSION}, \
      helm=${HELM_VERSION} \
      prettier=${PRETTIER_VERSION} \
      remark=${REMARK_VERSION} \
      " \
      "org.opencontainers.image.revision"="${VCS_REF}" \
      "org.opencontainers.image.title"="ci-actions-bundle" \
      "org.opencontainers.image.description"="An image bundled with helm, prettier and remark utilities for linting"

RUN \
    apk add --no-cache \
      bash='4.4.19-r1' \
      ca-certificates='20190108-r0' \
      nodejs-current='11.3.0-r0' \
      npm='10.14.2-r0'

COPY --from=smoloney/ci-actions-helm:2.12.3 /linux-amd64/LICENSE /licenses/helm/
COPY --from=smoloney/ci-actions-helm:2.12.3 /usr/local/bin/helm /usr/local/bin/helm
COPY --from=smoloney/ci-actions-remark:6.0.4 /usr/lib/node_modules /usr/lib/node_modules/
COPY --from=smoloney/ci-actions-prettier:1.16.4 /usr/lib/node_modules/prettier /usr/lib/node_modules/prettier/

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN \
    chmod +x /usr/local/bin/helm && \
    helm init --client-only && \
    ln -s /usr/lib/node_modules/remark-cli/cli.js /usr/bin/remark && \
    ln -s /usr/lib/node_modules/prettier/bin-prettier.js /usr/bin/prettier && \
    apk del ca-certificates npm

COPY *.sh /entrypoint/
RUN \
    chmod +x /entrypoint/*.sh

WORKDIR ${WORKSPACE}
ENTRYPOINT ["/entrypoint/entrypoint.sh"]
