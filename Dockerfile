FROM alpine:3.7

RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/testing' | tee -a /etc/apk/repositories

RUN apk --no-cache add \
	curl \
	make \
	unzip \
	fontforge \
	py-fonttools \
	bash

RUN mkdir -p /ricty/fonts
WORKDIR /ricty

COPY ./files/Makefile .

VOLUME /ricty

ENTRYPOINT ["make"]
CMD ["-j"]
