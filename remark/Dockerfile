FROM alpine:3.9

ARG VERSION="6.0.4"
ARG WORKSPACE="/github/workspace"
ARG VCS_REF
ARG BUILD_DATE

ARG REMARK_PLUGINS="""\
remark-preset-lint-consistent@2.0.2 \
remark-preset-lint-markdown-style-guide@2.1.2 \
remark-preset-lint-recommended@3.0.2 \
remark-validate-links@8.0.0 \
remark-lint-no-dead-urls@0.4.1 \
remark-lint-no-url-trailing-slash@3.0.1 \
remark-lint-write-good@1.0.5 \
remark-lint-checkbox-character-style@1.0.2 \
remark-lint-final-newline@1.0.2 \
remark-lint-list-item-bullet-indent@1.0.2 \
remark-lint-list-item-indent@1.0.3 \
remark-lint-no-auto-link-without-protocol@1.0.2 \
remark-lint-no-blockquote-without-marker@2.0.2 \
remark-lint-no-literal-urls@1.0.2 \
remark-lint-ordered-list-marker-style@1.0.2 \
remark-lint-hard-break-spaces@1.0.3 \
remark-lint-no-duplicate-definitions@1.0.3 \
remark-lint-no-heading-content-indent@1.0.2 \
remark-lint-no-inline-padding@1.0.3 \
remark-lint-no-shortcut-reference-image@1.0.2 \
remark-lint-no-shortcut-reference-link@1.0.3 \
remark-lint-no-undefined-references@1.0.3 \
remark-lint-no-unused-definitions@1.0.4 \
remark-lint-file-extension@1.0.2 \
remark-lint-no-file-name-mixed-case@1.0.2 \
remark-lint-no-file-name-articles@1.0.2 \
remark-lint-no-file-name-irregular-characters@1.0.2 \
remark-lint-no-file-name-consecutive-dashes@1.0.2 \
remark-lint-no-file-name-outer-dashes@1.0.3 \
remark-lint-no-consecutive-blank-lines@1.0.2 \
remark-lint-maximum-line-length@1.2.0 \
remark-lint-no-shell-dollars@1.0.2 \
remark-lint-heading-style@1.0.2 \
remark-lint-heading-increment@1.0.2 \
remark-lint-no-duplicate-headings@1.0.2 \
remark-lint-no-multiple-toplevel-headings@1.0.2 \
remark-lint-maximum-heading-length@1.0.2 \
remark-lint-no-heading-punctuation@1.0.2 \
remark-lint-blockquote-indentation@1.0.2 \
remark-lint-unordered-list-marker-style@1.0.2 \
remark-lint-ordered-list-marker-value@1.0.2 \
remark-lint-list-item-content-indent@1.0.2 \
remark-lint-list-item-spacing@1.1.2 \
remark-lint-code-block-style@1.0.2 \
remark-lint-fenced-code-flag@1.0.2 \
remark-lint-fenced-code-marker@1.0.2 \
remark-lint-rule-style@1.0.2 \
remark-lint-no-table-indentation@1.0.3 \
remark-lint-table-pipes@1.0.2 \
remark-lint-table-pipe-alignment@1.0.2 \
remark-lint-table-cell-padding@1.0.3 \
remark-lint-final-definition@1.0.2 \
remark-lint-definition-case@1.0.3 \
remark-lint-definition-spacing@1.0.3 \
remark-lint-link-title-style@1.0.3 \
remark-lint-strong-marker@1.0.2 \
remark-lint-emphasis-marker@1.0.2 \
remark-lint-no-emphasis-as-heading@1.0.2 \
remark-lint-no-dead-urls@0.4.1 \
remark-validate-links@8.0.0 \
remark-lint-no-url-trailing-slash@3.0.1 \
"""

LABEL \
      # https://github.com/opencontainers/image-spec/blob/master/annotations.md
      "org.opencontainers.image.created"="${BUILD_DATE}" \
      "org.opencontainers.image.authors"="Stephen Moloney <stephen@stephenmoloney.com>" \
      "org.opencontainers.image.homepage"="https://github.com/stephenmoloney/ci-actions/tree/master/remark" \
      "org.opencontainers.image.documentation"="https://github.com/stephenmoloney/ci-actions/tree/master/remark/README.md" \
      "org.opencontainers.image.source"="https://github.com/stephenmoloney/ci-actions" \
      "org.opencontainers.image.version"="ci-actions at ${VCS_REF} and remark version ${VERSION}" \
      "org.opencontainers.image.revision"="${VCS_REF}" \
      "org.opencontainers.image.title"="ci-actions-remark" \
      "org.opencontainers.image.description"="remark in a docker container for linting markdown"

RUN \
    apk add --no-cache \
      bash='4.4.19-r1' \
      nodejs-current='11.3.0-r0' \
      npm='10.14.2-r0'

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN \
    npm install -g --loglevel=error \
      remark@10.0.1 \
      remark-cli@6.0.1 \
      remark-lint@"${VERSION}" \
      ${REMARK_PLUGINS} && \
    apk del npm

COPY *.sh /entrypoint/
RUN \
    chmod +x /entrypoint/*.sh

WORKDIR ${WORKSPACE}
ENTRYPOINT ["/entrypoint/entrypoint.sh"]
