FROM alpine:3.9

ARG VERSION="latest"
ARG HELM_VERSION="2.12.3"
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
      " \
      "org.opencontainers.image.revision"="${VCS_REF}" \
      "org.opencontainers.image.title"="ci-actions-bundle" \
      "org.opencontainers.image.description"="An image bundled with helm lint, capabilities"

RUN \
    apk add --no-cache bash='4.4.19-r1' ca-certificates='20190108-r0'

COPY *.sh /entrypoint/
COPY --from=smoloney/ci-actions-helm:2.12.3 /linux-amd64/LICENSE /licenses/helm/
COPY --from=smoloney/ci-actions-helm:2.12.3 /usr/local/bin/helm /usr/local/bin/helm

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN \
    chmod +x \
      /entrypoint/*.sh \
      /usr/local/bin/helm && \
    helm init --client-only && \
    apk del ca-certificates

WORKDIR ${WORKSPACE}
ENTRYPOINT ["/entrypoint/entrypoint.sh"]
