FROM ubuntu:18.04

RUN echo "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic main" > /etc/apt/sources.list.d/clang.list \
    && echo "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-6.0 main" > /etc/apt/sources.list.d/clang6.list \
    && echo "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-7 main" > /etc/apt/sources.list.d/clang7.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6084F3CF814B57C1CF12EFD515CF4D18AF4F7421 \
    && echo "deb http://ppa.launchpad.net/ubuntu-toolchain-r/test/ubuntu bionic main" > /etc/apt/sources.list.d/gcc.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 60C317803A41BA51845E371A1E9377A2BA9EF27F

ADD https://raw.githubusercontent.com/wireshark/wireshark/master/tools/debian-setup.sh /
RUN chmod +x /debian-setup.sh

RUN apt-get update \
    && /debian-setup.sh --install-optional --install-deb-deps --install-test-deps \
        g++-4.9 g++-5 g++-6 g++-7 g++-8 \
        clang-5.0 clang-6.0 clang-7 \
    && rm -rf /var/lib/apt/lists/*
