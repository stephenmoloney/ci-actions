FROM alpine:3.9

ARG VERSION="1.16.4"
ARG WORKSPACE="/github/workspace"
ARG VCS_REF
ARG BUILD_DATE

LABEL \
      # https://github.com/opencontainers/image-spec/blob/master/annotations.md
      "org.opencontainers.image.created"="${BUILD_DATE}" \
      "org.opencontainers.image.authors"="Stephen Moloney <stephen@stephenmoloney.com>" \
      "org.opencontainers.image.homepage"="https://github.com/stephenmoloney/ci-actions/tree/master/prettier" \
      "org.opencontainers.image.documentation"="https://github.com/stephenmoloney/ci-actions/tree/master/prettier/README.md" \
      "org.opencontainers.image.source"="https://github.com/stephenmoloney/ci-actions" \
      "org.opencontainers.image.version"="ci-actions at ${VCS_REF} and prettier version ${VERSION}" \
      "org.opencontainers.image.revision"="${VCS_REF}" \
      "org.opencontainers.image.title"="ci-actions-prettier" \
      "org.opencontainers.image.description"="Prettier in a docker container for linting and formatting various files types"

RUN \
    apk add --no-cache \
      bash='4.4.19-r1' \
      nodejs-current='11.3.0-r0' \
      npm='10.14.2-r0'

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN \
    npm install -g prettier@"${VERSION}" && \
    apk del npm

COPY *.sh /entrypoint/
RUN \
    chmod +x /entrypoint/*.sh

WORKDIR ${WORKSPACE}
ENTRYPOINT ["/entrypoint/entrypoint.sh"]
