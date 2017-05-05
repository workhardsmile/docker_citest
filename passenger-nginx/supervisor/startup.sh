#!/bin/bash

cron
/usr/local/bin/supervisord -c /var/nginx/conf/supervisor.conf
/opt/nginx/sbin/nginx -g "daemon off;"
