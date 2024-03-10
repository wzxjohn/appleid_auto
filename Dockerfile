FROM webdevops/php-nginx:7.4
ENV WEB_DOCUMENT_ROOT /app/public
RUN cat <<EOF > /opt/docker/etc/nginx/vhost.common.d/10-location-root.conf
location ~* (runtime|application)/{
    return 403;
}
location / {
    if (!-e \$request_filename){
        rewrite  ^(.*)\$  /index.php?s=\$1  last;   break;
    }
}
EOF

WORKDIR /app
COPY --chown=application:application . /app

COPY .example.env /config/.env
RUN ln -s /config/.env /app/.env

RUN composer install && chmod -R 755 /app && chown -R application:application /app
