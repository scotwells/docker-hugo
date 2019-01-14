# start with a debian version for fetching the standard hugo binary
FROM debian:9.6-slim AS fetch-standard
# set the version of Hugo we should install, this makes it configurable from the CLI.
ARG VERSION=0.53
ADD https://github.com/gohugoio/hugo/releases/download/v${VERSION}/hugo_${VERSION}_Linux-64bit.tar.gz /hugo.tar.gz
RUN tar -zxf hugo.tar.gz

# start with a debian image to fetch the extended hugo version
FROM debian:9.6-slim AS fetch-extended
# set the version of Hugo we should install, this makes it configurable from the CLI.
ARG VERSION=0.53
ADD https://github.com/gohugoio/hugo/releases/download/v${VERSION}/hugo_extended_${VERSION}_Linux-64bit.tar.gz /hugo.tar.gz
RUN tar -zxf hugo.tar.gz

# start with a debian image to install the Git binary
FROM debian:9.6-slim AS git-install
# install the git binary
RUN apt-get update && apt-get install -y git

FROM alpine:3.8 as ssl-certs

RUN apk --update add ca-certificates

# use a debian slim image for our production container
FROM debian:9.6-slim

COPY --from=fetch-standard /hugo /bin/hugo
COPY --from=fetch-extended /hugo /bin/hugo-extended
COPY --from=git-install /usr/bin/git /usr/bin/git
COPY --from=ssl-certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
