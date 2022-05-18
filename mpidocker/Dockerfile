FROM docker.io/nvidia/cuda:11.2.0-cudnn8-devel-ubuntu20.04

ENV DEBIAN_FRONTEND noninteractive
ARG MPICH_VERSION=3.1.4

RUN env TZ=Europe/Zurich DEBIAN_FRONTEND=noninteractive apt-get update \
    && env TZ=Europe/Zurich DEBIAN_FRONTEND=noninteractive apt-get -y --fix-missing upgrade


WORKDIR /mpidocker
COPY ./mpidocker .

RUN apt-get update 
RUN apt-get install -y apt-utils
RUN apt-get install -y ssh wget build-essential

# MPICH
RUN cd /tmp \
  && wget -q http://www.mpich.org/static/downloads/${MPICH_VERSION}/mpich-${MPICH_VERSION}.tar.gz \
  && tar -xf mpich-${MPICH_VERSION}.tar.gz \
  && cd mpich-${MPICH_VERSION} \
  && ./configure --disable-fortran --enable-fast=all,O3 --prefix=/usr \
  && echo "Using $(cat /proc/cpuinfo | grep 'model name' | wc -l) processes to build" \
  && make -j$(cat /proc/cpuinfo | grep 'model name' | wc -l) \
  && make install \
  && ldconfig \
  && cd .. \
  && rm -Rf mpich-${MPICH_VERSION}{,.tar.gz}

# DOTNET SDK
RUN cd /tmp \
  && wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
  && dpkg -i packages-microsoft-prod.deb \
  && rm packages-microsoft-prod.deb \
  && apt-get update \
  && apt-get install -y dotnet-sdk-6.0

# MSolve App
RUN cd /mpidocker/MSolveApp/Msolve.One.MPI \
 && dotnet build \
 && chmod ../../runTest.sh