FROM ubuntu AS builder

# Install needed tools
ENV DEBIAN_FRONTEND noninteractive
RUN apt update && apt install -y git build-essential autoconf libtool libssl-dev pkg-config cmake

WORKDIR /grpc_rpi

# Download GRPC source code
RUN git clone --progress --verbose -b v1.28.1 https://github.com/grpc/grpc grpc_src
RUN cd grpc_src && git submodule update --init && cd ..

# Download Raspberry Pi toolchain
RUN git clone --progress --verbose https://github.com/raspberrypi/tools.git --depth=1 pitools

# Build and Install GRPC
WORKDIR /grpc_rpi/grpc
RUN cmake ../grpc_src -DCMAKE_BUILD_TYPE=Release -DgRPC_INSTALL=ON -DgRPC_BUILD_TESTS=OFF -DgRPC_SSL_PROVIDER=package
RUN make -j4 install
RUN cp grpc_cpp_plugin /usr/local/bin

# Copy RPi toolchain cmake file
COPY toolchain.cmake /grpc_rpi

# Build GRPC for Raspberry Pi
WORKDIR /grpc_rpi/build
RUN cmake ../grpc_src -DCMAKE_TOOLCHAIN_FILE=../toolchain.cmake \
                      -DCMAKE_BUILD_TYPE=Release \
                      -Dprotobuf_BUILD_TESTS=Off \
                      -DgRPC_INSTALL=Off \
                      -DCMAKE_CROSSCOMPILING=1 \
                      -DRUN_HAVE_POSIX_REGEX=0
RUN make grpc_csharp_ext

#--------------------------------------------------------------------------------------------

# Create final Image
FROM resin/rpi-raspbian

# Update and Upgrade OS
RUN apt update && apt upgrade

# Install mono (Complete mono is needed to work with .Net Standard libraries)
RUN apt install mono-complete

# Copy GRPC native library
COPY --from=builder /grpc_rpi/build/libgrpc_csharp_ext.so.2.28.1 /usr/local/lib
RUN ln -s /usr/local/lib/libgrpc_csharp_ext.so.2.28.1 /usr/local/lib/libgrpc_csharp_ext.x86.so