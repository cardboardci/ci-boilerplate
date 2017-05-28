# Dockerized librsvg
[![License][license-badge]][license-link]

---

 * [Summary](#summary)
 * [Usage](#usage)
 * [Components](#components)
 * [Build Process](#build-process)
 * [Labels](#labels)
 * [User and Group Mapping](#user-and-group-mapping)

## Summary

A boilerplate project for Docker based on the `jrbeverly/baseimage` image. Compilation is done with `make`.

## Usage

You can clone this repository and copy the contents into the new docker repository.  It will provide a straightfoward build system that provides the ability for unique tagging, a staging registry, internal testing of an image.

## Components

### Metadata Arguments

Metadata build arguments used in the system, the follow the [Label Schema Convention](http://label-schema.org).

| Variable | Value | Description |
| -------- | ----- |------------ |
| BUILD_DATE | see [metadata.variable](build/Makefile.metadata.variable) | The Date/Time the image was built. |
| VERSION | see [metadata.variable](build/Makefile.metadata.variable) | Release identifier for the contents of the image. |
| VCS_REF | see [metadata.variable](build/Makefile.metadata.variable) | Identifier for the version of the source code from which this image was built. |

### Build Arguments

Build arguments used in the system.

| Variable | Value | Description |
| -------- | ------- |------------ |
| USER | see [Makefile](build/Makefile) | Sets the [user](http://www.linfo.org/uid.html) to use when running the image. |

### Volumes

Volumes exposed by the docker container.[^1]

| Volume | Description |
| ------ | ----------- |
| /media/ | The root directory containing files. |

## Build Process

To build the docker image, use the included [`Makefile`](build/Makefile). It is recommended to use the makefile to ensure all build arguments are provided.

```
make VERSION=baseimage build
make VERSION=privileged build
```

You can also build the image manually, as visible in [`Makefile`](build/Makefile).  However this is discouraged as the makefile ensures all build arguments are properly formatted.

| Command | Usage | Description |
| --- | --- | --- |
| build | `make VERSION=<-> build` | Builds the specified version of the image (`versions/-/Makefile.options`). |
| clean | `make clean` | Removes the image and all tags associated with it. |
| debug-% | `make debug-PATH_DOCKER` | Prints the variable. |
| deploy | `make VERSION=<-> deploy` | Push the docker image to the release registry (`REGISTRY`) registry. |
| image | `make image` | Prints the working name of the image.  |
| info | `make info` | Prints a collection of relevant variables. |
| prune | `make prune` | Removes unused images. |
| pull | `make VERSION=<-> pull` | Pulls the working docker image from the staging (`STAGING_REGISTRY`) registry. |
| purge | `make purge` | Removes all images and containers. |
| push | `make VERSION=<-> push` | Pushes the working docker image to the staging (`STAGING_REGISTRY`) registry. |
| test | `make VERSION=<-> test` | Runs the tests for the specified version of the image (`versions/-/Makefile.options`). |
| release | `make VERSION=<-> release` | Tags the working docker image as a release candidate (`IMAGE:TAG`). |

### Adding a new version

When adding a new version of the docker image, you create a directory in the `versions/` directory.

* Create a folder for my version `mkdir myversion`
* Create a `Makefile.options` with the `TAG` of the image (`TAG := mytag`)
* Provide custom build arguments for the image (see [`baseimage/Makefile.options`](versions/baseimage/Makefile.options))

You can set the `PATH_DOCKER` and `PATH_DOCKERFILE` to change the docker build paths used during the build process.  A lightweight `Makefile.options` can point to an existing `Dockerfile` as seen in [`src/`](src/).  This allows you to have two versions that leverage the same `Dockerfile`, or each having their own unique `Dockerfile`.

### Gitlab-CI

Provided in the boilerplate is a copy of `.gitlab-ci.yml`.  The provided build script demonstrates how you can test a two version image, by making use of environment variables in each of the jobs (e.g. `build-baseimage`/`test-baseimage`) to reduce arguments passed to make.  This works ideally for continuous integration oriented images where their are two versions (baseimage/privileged).  For an image with more versions, it might be advisable to make use of branches in git, or a clever and large `.gitlab-ci.yml`.

Gitlab-CI requires the following variables:

| Variable | Description |
| --- | --- |
| `DOCKER_BUILD_USER` | The username of the deploy docker registry. |
| `DOCKER_BUILD_TOKEN` | The password of the deploy docker registry. |

## Testing

Each of the versions of the docker image has an associated script for testing.  The tests are available in `test/`, where they are named in the format `test_<VERSION>.sh`.  The version is the same as the associated image version in the `versions/` directory.

## Labels

The docker image follows the [Label Schema Convention](http://label-schema.org).  The values in the namespace can be accessed by the following command:

```console
docker inspect -f '{{ index .Config.Labels "org.label-schema.LABEL" }}' IMAGE
```

The label namespace `io.jrbeverly` is common among `jrbeverly-docker` images and is a loosely structured set of values.  The values in the namespace can be accessed by the following command:

```console
docker inspect -f '{{ index .Config.Labels "io.jrbeverly.LABEL" }}' IMAGE
```

## User and Group Mapping

All processes within the docker container will be run as the **docker user**, a non-root user.  The **docker user** is created on build with the user id `DUID` and a member of a group with group id `DGID`.  

Any permissions on the host operating system (OS) associated with either the user (`DUID`) or group (`DGID`) will be associated with the docker user.  The values of `DUID` and `DGID` are visible in the [Build Arguments](#build-arguments), and can be accessed by the commands:

```console
docker inspect -f '{{ index .Config.Labels "io.jrbeverly.user" }}' IMAGE
docker inspect -f '{{ index .Config.Labels "io.jrbeverly.group" }}' IMAGE
```

The notation of the build variables is short form for docker user id (`DUID`) and docker group id (`DGID`). 

[^1]: It is necessary to ensure that the **docker user** (`DUID`) has permission to access volumes. (see [User / Group Identifiers](#user-and-group-mapping))
