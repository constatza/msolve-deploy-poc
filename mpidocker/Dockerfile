FROM ubuntu:18.04
WORKDIR /mpidocker
COPY ./mpidocker .

RUN apt-get update
RUN apt-get install -y ssh wget build-essential

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
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
RUN apt-get update
RUN apt-get install cuda-10-0

# DOTNET SDK
RUN wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN rm packages-microsoft-prod.deb
RUN apt-get update 
RUN apt-get install -y apt-transport-https
RUN apt-get update
RUN apt-get install -y dotnet-sdk-5.0

# MSolve App
WORKDIR /mpidocker/MSolveApp/Msolve.One.MPI
RUN dotnet build -c Release

WORKDIR /mpidocker
RUN chmod +x runTest.sh
# docker run --rm -it mpi-test ./runTest.sh 4
# mpirun -np 2 dotnet /mpidocker/MSolveApp/Msolve.One.MPI/Msolve.One.MPI/bin/Release/net5.0/Msolve.One.MPI.dll