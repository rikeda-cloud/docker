FROM alpine:latest

RUN apk update && \
	apk upgrade && \
	apk add bash && \
	apk add mariadb && \
	apk add mariadb-client

ENTRYPOINT bash
