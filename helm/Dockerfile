FROM alpine:3.9

ARG VERSION="2.12.3"
ARG WORKSPACE="/github/workspace"
ARG VCS_REF
ARG BUILD_DATE

ENV DOWNLOAD_URL="https://storage.googleapis.com/kubernetes-helm/helm-v${VERSION}"

LABEL \
      # https://github.com/opencontainers/image-spec/blob/master/annotations.md
      "org.opencontainers.image.created"="${BUILD_DATE}" \
      "org.opencontainers.image.authors"="Stephen Moloney <stephen@stephenmoloney.com>" \
      "org.opencontainers.image.homepage"="https://github.com/stephenmoloney/ci-actions/tree/master/helm" \
      "org.opencontainers.image.documentation"="https://github.com/stephenmoloney/ci-actions/tree/master/helm/README.md" \
      "org.opencontainers.image.source"="https://github.com/stephenmoloney/ci-actions" \
      "org.opencontainers.image.version"="ci-actions at ${VCS_REF} and helm client version ${VERSION}" \
      "org.opencontainers.image.revision"="${VCS_REF}" \
      "org.opencontainers.image.title"="ci-actions-helm" \
      "org.opencontainers.image.description"="Helm client binary in a docker container for linting helm templates"

RUN \
    apk add --no-cache bash='4.4.19-r1' curl='7.63.0-r0' dpkg='1.19.2-r0'

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN \
    export os && \
    os="$(uname -s | awk '{print tolower($0)}')" && \
    export arch && \
    arch="$(dpkg --print-architecture | sed -E "s/musl-linux-//")" && \
    curl -sL -o "helm-v${VERSION}-${os}-${arch}.tar.gz" \
      "${DOWNLOAD_URL}-${os}-${arch}.tar.gz" && \
    curl -sL -o "helm-v${VERSION}-${os}-${arch}.tar.gz.sha256" \
      "${DOWNLOAD_URL}-${os}-${arch}.tar.gz.sha256" && \
    export checksum && \
    checksum="$(cat "helm-v${VERSION}-${os}-${arch}.tar.gz.sha256")" && \
    echo "${checksum}  helm-v${VERSION}-${os}-${arch}.tar.gz" | \
      sha256sum -c -w - | \
      grep 'OK' && \
    tar xzfv "helm-v${VERSION}-${os}-${arch}.tar.gz" && \
    cp linux-amd64/helm /usr/local/bin/helm && \
    chmod +x /usr/local/bin/helm && \
    rm "helm-v${VERSION}-${os}-${arch}.tar.gz" && \
    rm "helm-v${VERSION}-${os}-${arch}.tar.gz.sha256" && \
    helm init --client-only && \
    apk del curl dpkg

COPY *.sh /entrypoint/
RUN \
    chmod +x /entrypoint/*.sh

WORKDIR ${WORKSPACE}
ENTRYPOINT ["/entrypoint/entrypoint.sh"]
