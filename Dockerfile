FROM webdevops/php-nginx:7.4
ENV WEB_DOCUMENT_ROOT /app/public

WORKDIR /app
COPY --chown=application:application . /app

COPY .example.env /config/.env
RUN ln -s /config/.env /app/.env

RUN composer install && chmod -R 755 /app && chown -R application:application /app
