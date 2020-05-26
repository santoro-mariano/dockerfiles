FROM ubuntu

# Install needed tools
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y git build-essential autoconf libtool pkg-config cmake mono-devel

WORKDIR /grpc_rpi

# Download Raspberry Pi toolchain
RUN git clone --progress --verbose https://github.com/raspberrypi/tools.git --depth=1 pitools

# Download GRPC source code
RUN git clone --progress --verbose -b v1.28.1 https://github.com/grpc/grpc grpc_src
RUN cd grpc_src && git submodule update --init && cd ..

# Build and Install GRPC
RUN mkdir grpc && cd grpc
RUN cmake -DCMAKE_BUILD_TYPE=Release -DgRPC_INSTALL=ON -DgRPC_BUILD_TESTS=OFF -DgRPC_SSL_PROVIDER=package ../grpc_src
RUN make -j4 install

# Copy RPi toolchain cmake file
COPY toolchain.cmake .

ENV BUILD_FOLDER /grpc_rpi/build

WORKDIR ${BUILD_FOLDER}

CMD ["cmake", "../grpc_src", "-DCMAKE_TOOLCHAIN_FILE=../toolchain.cmake", "-DCMAKE_BUILD_TYPE=Release", "-Dprotobuf_BUILD_TESTS=Off", "-DgRPC_INSTALL=Off", "-DCMAKE_CROSSCOMPILING=1", "-DRUN_HAVE_POSIX_REGEX=0"]