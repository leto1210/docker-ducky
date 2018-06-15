FROM php:7-apache
MAINTAINER leto1210

# Packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install wget cron -y && \
    apt-get autoremove -y
    
# Install s6-overlay
ENV S6_OVERLAY_VER 1.21.4.0
RUN wget -qO- https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VER}/s6-overlay-amd64.tar.gz | tar xz -C /
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VER}/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C /

# Install cheky (formerly LBCAlerte)
ENV CHEKY_VER 3.8.1
ADD https://github.com/Blount/Cheky/archive/${CHEKY_VER}.tar.gz /tmp
RUN cd /tmp && \
    tar xzf ${CHEKY_VER}.tar.gz && \
    rm -fr /var/www/html && \
    mv Cheky-${CHEKY_VER} /var/www/html && \
    rm -f ${CHEKY_VER}.tar.gz
RUN chmod -R 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

RUN echo "*/5 * * * * root /usr/bin/php /var/www/html/check.php" > /etc/cron.d/lbc

# Setup Apache whith php 7
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf 

# Reduce  container size
RUN apt-get remove wget -y && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

# Copy all the rootfs dir into the container
# COPY rootfs /

# Set s6-overlay as entrypoint
# ENTRYPOINT ["/init"]

#Start Cron & Apache
CMD cron && apache2ctl -k graceful -D FOREGROUND

EXPOSE 80

ENV CONTAINER_VERSION 20180615
