[![](https://images.microbadger.com/badges/version/trainemize/nuget-exe.svg)](https://microbadger.com/images/trainemize/nuget-exe "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/trainemize/nuget-exe.svg)](https://microbadger.com/images/trainemize/nuget-exe "Get your own image badge on microbadger.com")
# Nuget.exe Docker Container

nuget-exe is a docker container based on [debian:stable-slim](https://hub.docker.com/_/debian/), which allows you to use the nuget executable (nuget.exe) as staged build layer.

## Usage

Simply extend the image (you can find it on [dockerhub](https://hub.docker.com/r/trainemize/nuget-exe/)) and use it!

```dockerfile
FROM trainemize/nuget-exe:latest AS nuget-helper
```

### Good to know
 - WORKDIR: `/nuget`
 - Location of nuget.exe: `/nuget/nuget.exe`
 - `${NUGET_EXE}`: can be used instead of `mono /nuget/nuget.exe`

### Example

```dockerfile
FROM trainemize/nuget-exe:latest AS nuget-helper

# Credentials via ARG
ARG NUGET_FEED_NAME
ARG NUGET_USER
ARG NUGET_PW

COPY NuGet.config .
RUN ${NUGET_EXE} source update -ConfigFile ./NuGet.config -Name ${NUGET_FEED_NAME} -username ${NUGET_USER} -StorePasswordInClearText -password ${NUGET_PW}

### Build project
FROM microsoft/dotnet:2.1-sdk AS build-env

COPY --from=nuget-helper /nuget/NuGet.config .
RUN ...
# Build your app here
```

Build command: 
```sh
$ docker build -t myapp --build-arg NUGET_FEED_NAME=my-cool-private-feed-name --build-arg NUGET_USER=foo --build-arg NUGET_PW=bar .
```

## Build image

If you want to build the image yourself, simply execute the build.sh.

 - Param 1: nuget version as semver (e.g. 4.8.1)
 - Param 2: image name (optional, default: `trainemize/dotnet-exe`)

usage: `./build.sh 4.8.1 my/cool-nuget-image`

It will then create to images:
 - `my/cool-nuget-image:4.8.1`
 - `my/cool-nuget-image:latest`