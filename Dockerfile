ARG TAG=38
FROM registry.fedoraproject.org/fedora:${TAG}

RUN \ 
dnf -y update && \
dnf -y install git cmake zlib-devel zlib-static llvm-devel re2c bison gcc-c++ && \
dnf clean all

RUN useradd -m -G wheel -u 1001 user
RUN echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER user
WORKDIR /home/user

RUN git clone https://github.com/lfortran/lfortran
WORKDIR lfortran
RUN cmake -B build -DWITH_LLVM=on -DLFORTRAN_BUILD_ALL=yes
RUN cmake --build build
