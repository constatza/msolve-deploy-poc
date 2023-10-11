FROM docker.io/nvidia/cuda:12.2.0-devel-ubuntu22.04

# TODO: decide which variable is actually ENV or just ARG
ENV DEBIAN_FRONTEND=noninteractive \
    TZ='Europe/Zurich'

ARG MPICH_VERSION=3.1.4

# !!! Important !!!
# For Ubuntu 22.04> you can install .NET SDK either from: 
# the Ubuntu repo OR the Microsoft repo. 
# Don't mix!
# Here we install from Ubuntu 
RUN apt-get update  && \
    apt-get -y --fix-missing upgrade && \
    apt-get -y install apt-utils wget build-essential dotnet-sdk-6.0 ssh

WORKDIR /mpidocker
COPY . .



# === MPICH ===
WORKDIR /tmp
RUN wget -q "http://www.mpich.org/static/downloads/${MPICH_VERSION}/mpich-${MPICH_VERSION}.tar.gz" && \
    tar -xf "mpich-${MPICH_VERSION}.tar.gz"  && \ 
    cd "mpich-${MPICH_VERSION}" && \
    ./configure --disable-fortran --enable-fast=all,O3 --prefix=/usr && \
    NUM_PROCESSES=$(cat /proc/cpuinfo | grep 'model name' | wc -l) && \
    echo "Using ${NUM_PROCESSES} processes to build" && \
    make -j"${NUM_PROCESSES}"  && \
    make install && \
    ldconfig && \
    cd .. && \
    rm -rf ../"mpich-${MPICH_VERSION}"{,.tar.gz} 


# === MSolve App ===
RUN apt-get -y remove wget && \
    apt-get -y autoremove && \
    cd /mpidocker/MSolveApp/Msolve.One.MPI && \
    dotnet build && \
    chmod +x ../../runTest.sh
