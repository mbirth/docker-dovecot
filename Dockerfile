# Based on official Dockerfile: https://github.com/dovecot/docker
FROM alpine:3

LABEL org.opencontainers.image.authors="markus@birth-online.de"

ENV container=docker \
    LC_ALL=C

ARG username=vmail

RUN apk add --no-cache \
  tini \
  dovecot \
  dovecot-gssapi \
  dovecot-ldap \
  dovecot-lmtpd \
  dovecot-mysql \
  dovecot-pgsql \
  dovecot-pop3d \
  dovecot-fts-solr \
  dovecot-sqlite \
  dovecot-submissiond \
  ca-certificates && \
  mkdir /conf && \
  echo "!include_try /conf/*.conf" >> /etc/dovecot/dovecot.conf && \
  mkdir /data && \
  addgroup -g 1000 $username && \
  adduser -h /data -u 1000 -D -G $username $username && \
  chown 1000:1000 /data

COPY local.conf /conf/local.conf

VOLUME ["/conf", "/data"]
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/usr/sbin/dovecot", "-F"]

# LMTP
EXPOSE 24
# SMTP
EXPOSE 25
# POP3
EXPOSE 110
# IMAP
EXPOSE 143
# SMTPS
EXPOSE 465
# Submission
EXPOSE 587
# IMAPS
EXPOSE 993
# POP3S
EXPOSE 995
