FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && \
    apt-get -y install clang cmake python3 python3-dev python3-distutils \
    xorg-dev libglu1-mesa-dev \
    xvfb \
    mesa-utils \
&& rm -rf /var/lib/apt/lists/*

COPY . /MaterialX/

ENV DISPLAY=:0
ENV MESA_GL_VERSION_OVERRIDE=4.0FC
ENV MESA_GLSL_VERSION_OVERRIDE=400

WORKDIR /MaterialX/build

RUN cmake -DMATERIALX_BUILD_PYTHON=ON -DMATERIALX_BUILD_VIEWER=ON -DMATERIALX_TEST_RENDER=ON -DMATERIALX_WARNINGS_AS_ERRORS=OFF -DMATERIALX_PYTHON_VERSION=3 .. && cmake --build . --target install --config .