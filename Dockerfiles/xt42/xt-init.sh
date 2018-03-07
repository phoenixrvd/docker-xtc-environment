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
${WEB_ROOT}/lic \
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

echo "DROP DATABASE IF EXISTS ${MYSQL_DATABASE};" > ${SQL_FILE_NAME}
echo "CREATE DATABASE ${MYSQL_DATABASE};" >> ${SQL_FILE_NAME};
echo "GRANT ALL ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" >> ${SQL_FILE_NAME};

mysql -uroot -p${MYSQL_ROOT_PASSWORD} -h${MYSQL_HOSTNAME} < ${SQL_FILE_NAME};

# Import DB data if exists
DUMP_PATH=${WEB_ROOT}/${MYSQL_DUMPFILE}
if [ -f ${DUMP_PATH} ]; then
    echo "UPDATE xt_mail_templates SET email_from='${DEVEL_MAIL}';" > ${SQL_FILE_NAME}
    echo "UPDATE xt_mail_templates SET email_reply='${DEVEL_MAIL}';" >> ${SQL_FILE_NAME};
    echo "UPDATE xt_mail_templates SET email_forward='${DEVEL_MAIL}';" >> ${SQL_FILE_NAME};
    echo "UPDATE xt_orders SET customers_email_address='${DEVEL_MAIL}';" >> ${SQL_FILE_NAME};
    echo "UPDATE xt_customers SET customers_email_address = '${DEVEL_MAIL}';" >> ${SQL_FILE_NAME};
    echo "UPDATE xt_stores SET shop_domain = 'localhost:8042', shop_ssl_domain = 'localhost:8042', shop_http = 'http://localhost:8042', shop_https = 'https://localhost:8042', shop_ssl = 'no_ssl', shop_status = 1, admin_ssl = 0 WHERE shop_id = 1;" >> ${SQL_FILE_NAME};
    mysql -u${MYSQL_USER} -p${MYSQL_PASSWORD} -h${MYSQL_HOSTNAME} ${MYSQL_DATABASE} < ${DUMP_PATH};
    mysql -u${MYSQL_USER} -p${MYSQL_PASSWORD} -h${MYSQL_HOSTNAME} ${MYSQL_DATABASE} < ${SQL_FILE_NAME};
fi