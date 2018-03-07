#!/usr/bin/env bash

WEB_ROOT=/var/www/html
MYSQL_SERVER_IP=`dig +short mysql`
DUMP_PATH=${WEB_ROOT}/${MYSQL_DUMPFILE}
mysqldump -u${MYSQL_USER} -p${MYSQL_PASSWORD} -h${MYSQL_SERVER_IP} ${MYSQL_DATABASE} > ${DUMP_PATH};