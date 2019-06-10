FROM alpine:latest
RUN apk add --no-cache openssl
COPY src/mkroot.sh /tmp/
COPY src/root.cnf /tmp/
