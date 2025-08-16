# cloud-builders

This repository contains source code for Docker images that can be later on used as build steps for [Google Cloud Build](https://cloud.google.com/cloud-build/docs/).

## How to use

Google Cloud Build executes a build as a series of build steps. Each build step is run in a Docker container. See the [Cloud Build documentation](https://cloud.google.com/cloud-build/docs/overview) for more details about builds and build steps.

To use one of the Docker images as a build step, you need to download the source code from this repository and build the image.

Build the image with the following command, replacing `image-name` with the name of the image you want to build and `project-id` with the ID of the project where you want to push the image:

```sh
./build.sh image-name project-id
```
