FROM webdevops/php-nginx:7.4
ENV WEB_DOCUMENT_ROOT /app/public
USER application

WORKDIR /app
COPY --chown=application:application . /app
RUN chmod -R 755 /app

COPY .example.env /config/.env
RUN ln -s /config/.env /app/.env
RUN composer install
