FROM mariadb:10.2

COPY config.cnf /etc/mysql/mariadb.conf.d/
ADD init.sql /docker-entrypoint-initdb.d/schema.sql