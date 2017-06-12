FROM ubuntu:16.04

RUN sed -i.bak 's@archive.ubuntu.com/ubuntu@ftp.jaist.ac.jp/pub/Linux/ubuntu@' /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
    curl \
    fontforge \
    fonttools \
    make \
    python-fontforge \
    unzip \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /ricty/fonts
WORKDIR /ricty

COPY ./files/Makefile .

VOLUME /ricty

ENTRYPOINT ["make"]
CMD ["-j"]
