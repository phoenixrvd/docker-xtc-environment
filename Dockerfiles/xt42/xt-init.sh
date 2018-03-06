#!/usr/bin/env bash

WEB_ROOT=/var/www/html

# Set write access
chmod -R 777 ${WEB_ROOT}/cache \
${WEB_ROOT}/templates_c \
${WEB_ROOT}/export \
${WEB_ROOT}/xtLogs \
${WEB_ROOT}/media \
${WEB_ROOT}/plugin_cache \
${WEB_ROOT}/conf \
${WEB_ROOT}/xtWizard \
${WEB_ROOT}/plugins/magnalister \
/tmp

# Simulate Database-Hostname
MYSQL_SERVER_IP=`dig +short mysql`
if [ ! -f /etc/hosts.orig ]; then
   cp /etc/hosts /etc/hosts.orig
fi

if [ -s /etc/hosts.orig ]; then
    cat /etc/hosts.orig > /etc/hosts
    echo ${MYSQL_SERVER_IP} ${MYSQL_HOSTNAME} >> /etc/hosts
fi

# Init empty Database
SQL_FILE_NAME=/tmp/create_db.sql

echo "DROP DATABASE IF EXISTS ${MYSQL_DATABASE};" > $SQL_FILE_NAME
echo "CREATE DATABASE ${MYSQL_DATABASE};" >> $SQL_FILE_NAME;
echo "GRANT ALL ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" >> $SQL_FILE_NAME;

mysql -uroot -p${MYSQL_ROOT_PASSWORD} -h${MYSQL_HOSTNAME} < $SQL_FILE_NAME;

# Import DB data if exists
DUMP_PATH=${WEB_ROOT}/${MYSQL_DUMPFILE}
if [ -f ${DUMP_PATH} ]; then
    mysql -u${MYSQL_USER} -p${MYSQL_PASSWORD} -h${MYSQL_HOSTNAME} < ${DUMP_PATH};
fi