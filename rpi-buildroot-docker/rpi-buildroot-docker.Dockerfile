FROM ubuntu:focal

# Install needed tools
ENV DEBIAN_FRONTEND noninteractive
RUN apt update && apt install -y wget patch cpio python unzip rsync bc bzip2 ncurses-dev git make g++

# Download and uncompress buildroot
RUN wget https://buildroot.org/downloads/buildroot-2020.05.tar.gz
RUN mkdir buildroot
RUN tar xvzf buildroot-2020.05.tar.gz
RUN rm buildroot-2020.05.tar.gz

WORKDIR /buildroot-2020.05

# Copy buildroot files
COPY rpi_docker_defconfig configs/
COPY post-build.txt .
RUN cat post-build.txt >> board/raspberrypi/post-build.sh
RUN rm post-build.txt

# Copy raspberry pi files
COPY interfaces board/raspberrypi/
COPY wpa_supplicant.conf board/raspberrypi/
COPY sshd_config board/raspberrypi/

# Prepare buildroot for raspberry pi zero w
ENV FORCE_UNSAFE_CONFIGURE 1
RUN make rpi_docker_defconfig
RUN make

