FROM alpine:latest
RUN apk update
RUN apk upgrade
COPY src/mkroot.sh /tmp/
COPY src/root.cnf /tmp/
