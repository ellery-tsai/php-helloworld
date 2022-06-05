FROM registry.access.redhat.com/ubi8/ubi:8.6

ENV VERSION=0.0.7

RUN yum --disableplugin=subscription-manager -y module enable php:7.3 \
  && yum --disableplugin=subscription-manager -y install httpd php openscap-scanner \
  && yum --disableplugin=subscription-manager clean all

RUN sed -i 's/Listen 80/Listen 8080/' /etc/httpd/conf/httpd.conf \
  && sed -i 's/Options Indexes FollowSymLinks/Options Indexes MultiViews/' /etc/httpd/conf/httpd.conf \
  && sed -i 's/listen.acl_users = apache,nginx/listen.acl_users =/' /etc/php-fpm.d/www.conf \
  && echo "env[APP] = \$APP" >> /etc/php-fpm.d/www.conf \
  && echo "env[VERSION] = \$VERSION" >> /etc/php-fpm.d/www.conf \
  && rm -f /var/www/html/index.html \
  && mkdir /run/php-fpm \
  && chgrp -R 0 /var/log/httpd /var/run/httpd /run/php-fpm \
  && chmod -R g=u /var/log/httpd /var/run/httpd /run/php-fpm

# ADD index.html /var/www/html
ADD index.php /var/www/html

EXPOSE 8080
USER 1001
CMD php-fpm & httpd -D FOREGROUND
