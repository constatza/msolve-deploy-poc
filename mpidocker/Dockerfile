FROM docker.io/nvidia/cuda:11.2.0-cudnn8-devel-ubuntu20.04
# ENV DEBIAN_FRONTEND noninteractive

WORKDIR /mpidocker
COPY ./mpidocker .

RUN apt-get update 
RUN apt-get install -y apt-utils
RUN apt-get install -y ssh wget build-essential
# RUN apt-get install -y software-properties-common

# MPICH
RUN wget -q http://www.mpich.org/static/downloads/3.1.4/mpich-3.1.4.tar.gz \
    && tar xf mpich-3.1.4.tar.gz \
    && cd mpich-3.1.4 \
    && ./configure --disable-fortran --enable-fast=all,O3 --prefix=/usr \
    && make -j$(nproc) \
    && make install \
    && ldconfig \
    && cd .. \
    && rm -rf mpich-3.1.4 \
    && rm mpich-3.1.4.tar.gz

# CUDA
# RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-keyring_1.0-1_all.deb
# RUN dpkg -i cuda-keyring_1.0-1_all.deb

# RUN add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"
# RUN apt-get update
# RUN apt-get -y install cuda

# DOTNET SDK
RUN wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN rm packages-microsoft-prod.deb
RUN apt-get update 
RUN apt-get install -y apt-transport-https
RUN apt-get update
RUN apt-get install -y dotnet-sdk-6.0

# MSolve App
WORKDIR /mpidocker/MSolveApp/Msolve.One.MPI
RUN dotnet build

WORKDIR /mpidocker
RUN chmod +x runTest.sh