#!/bin/bash

mkdir /run/php
/usr/sbin/php-fpm7.0 -R
nginx -c /etc/nginx/nginx.conf
