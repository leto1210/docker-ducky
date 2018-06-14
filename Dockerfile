FROM php:7-apache
MAINTAINER leto1210

# Packages
RUN apt-get update && \
    apt-get install wget cron apt-utils -y

# Install s6-overlay
# (https://github.com/just-containers/s6-overlay)
#
ENV S6_OVERLAY_VER 1.21.4.0
RUN wget -qO- https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VER}/s6-overlay-amd64.tar.gz | tar xz -C /

# Install cheky
# (https://github.com/Blount/LBCAlerte/)
ENV CHEKY_VER 3.8.1

ADD https://github.com/Blount/Cheky/archive/${CHEKY_VER}.tar.gz /tmp
RUN cd /tmp && \
    tar xzf ${CHEKY_VER}.tar.gz && \
    rm -fr /var/www/html && \
    mv Cheky-${CHEKY_VER} /var/www/html && \
    rm -f ${CHEKY_VER}.tar.gz

RUN chown -R www-data:www-data /var/www/html
RUN echo "*/5 * * * * root /usr/bin/php /var/www/html/check.php" > /etc/cron.d/lbc

# Copy all the rootfs dir into the container
# COPY rootfs /

# Set s6-overlay as entrypoint
ENTRYPOINT ["/init"]

ENV CONTAINER_VERSION 20180614
