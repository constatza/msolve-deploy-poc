FROM ubuntu:20.04
ENV DEBIAN_FRONTEND noninteractive

WORKDIR /mpidocker
COPY ./mpidocker .

RUN apt-get update 
RUN apt-get install -y apt-utils
RUN apt-get install -y ssh wget build-essential
RUN apt-get install -y software-properties-common

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
# RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
# RUN mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
# RUN apt-key adv --no-tty --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub

RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-keyring_1.0-1_all.deb
RUN sudo dpkg -i cuda-keyring_1.0-1_all.deb

RUN add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"
RUN apt-get update
RUN apt-get -y install cuda

# MONO
# RUN apt install gnupg ca-certificates
# RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF         
# RUN echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" |  tee /etc/apt/sources.list.d/mono-official-stable.list 
# RUN apt update
# RUN apt install -y mono-devel

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