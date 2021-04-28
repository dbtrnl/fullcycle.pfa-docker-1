FROM mysql:8

ENV MYSQL_ROOT_PASSWORD mysql
ENV LANG=C.UTF-8

COPY ./db-setup.sql /docker-entrypoint-initdb.d/