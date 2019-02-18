FROM alpine:3.9

ARG VERSION="2.12.3"
ARG WORKSPACE="/github/workspace"
ARG VCS_REF
ARG BUILD_DATE

ENV DOWNLOAD_URL="https://storage.googleapis.com/kubernetes-helm/helm-v${VERSION}"

LABEL \
      "com.github.actions.name"="Linting for helm templates" \
      "com.github.actions.description"="Run`helm lint - to lint helm templates" \
      "com.github.actions.icon"="activity" \
      "com.github.actions.color"="blue" \
      "repository"="https://github.com/stephenmoloney/ci-actions" \
      "homepage"="https://github.com/stephenmoloney/ci-actions/tree/master/helm" \
      "maintainer"="Stephen Moloney <stephen@stephenmoloney.com>" \
      "org.label-schema.vcs-ref"="${VCS_REF}" \
      "org.label-schema.vcs-url"="https://github.com/stephenmoloney/ci-actions" \
      "org.label-schema.build-date"="${BUILD_DATE}"

COPY *.sh /entrypoint/

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
    chmod +x /entrypoint/*.sh && \
    apk del curl dpkg && \
    rm -rf /var/cache/apk/*

WORKDIR ${WORKSPACE}
ENTRYPOINT ["/entrypoint/entrypoint.sh"]
