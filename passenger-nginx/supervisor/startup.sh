#!/bin/bash

/usr/local/bin/supervisord -c /supervisor.conf
/opt/nginx/sbin/nginx -g "daemon off;"
