#!/bin/bash

rm -rf /var/run/nginx-cache/*
rm -rf /home/shop_production/htdocs/var/cache/*

rm -rf /cache/catalog-cache/*
rm -rf /cache/shop-cache/*
rm -rf /cache/nginx-cache/*

# clean redis
redis-cli flushall

# clean memcached
echo -e "flush_all\nquit\n" | nc localhost 11211