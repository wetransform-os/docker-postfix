FROM debian:stable
MAINTAINER Simon Templer <simon@templer.cc>

# Set noninteractive mode for apt-get
ENV DEBIAN_FRONTEND noninteractive

# Update
RUN apt-get update

# Start editing
# Install package here for cache
#
# XXX postfix installation fails due to automatically created myhostname setting
RUN apt-get -y install postfix; \
    postconf -e myhostname=localhost && \
    apt-get -y install rsyslog supervisor sasl2-bin opendkim opendkim-tools

# XXX again installing postfix is probably not required
RUN postconf -h myhostname && \
    apt-get -y install postfix

# Add files
ADD assets/install.sh /opt/install.sh

# Run
CMD /opt/install.sh;/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
