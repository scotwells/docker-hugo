# Hugo + Git Docker Image

_This project is an opinionated version of [klakegg/docker-hugo](https://github.com/klakegg/docker-hugo)._

This project provides a Dockerfile capable of building a docker image that can be used to work with both
the standard `hugo` command and the extended `hugo` command. This Dockerfile will also include `git` in
the final image as it can be used by `hugo` when `enableGitInfo` is set to `true`.

## Building a Docker Image

To build a new docker image, use the standard `docker build` command.

```shell
$ docker build -t docker-image-name .
```

You can also pass a version to the build command via a build-arg to build a specific version of Hugo. For example,
you can use the following command to build version `0.50` of the Hugo project.

```shell
$ docker build --build-arg=VERSION=0.50 -t docker-image-name .
```

## Using the Docker Image

There is no entrypoint defined for the container, this provides flexibility as it allows the user to decide what binary
to execute. For example, to build your Hugo using the extended version, use the following command.

```shell
$ docker run --rm -v $PWD:/app --workdir=/app scotwells/hugo:latest hugo-extended
```
