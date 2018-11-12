FROM debian:stable-slim

# nuget version
ARG NUGET_VERSION

# nuget path
ENV NUGET_PATH=/nuget
ENV NUGET_EXE="mono ${NUGET_PATH}/nuget.exe"

# create directory for nuget
WORKDIR ${NUGET_PATH}

# mono is needed by nuget.exe
RUN apt-get update
RUN apt-get install -y wget mono-devel

# download nuget and set paths
RUN wget https://dist.nuget.org/win-x86-commandline/v${NUGET_VERSION}/nuget.exe
RUN chmod +x ${NUGET_PATH}/nuget.exe