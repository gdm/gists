#!/bin/bash -xe
# for 

PASS=$(perl -e 'print map{("a".."z","A".."Z",0..9)[int(rand(62))]}(1..16)');

sed -i "s/^password =.*$/password = ${PASS}/" /etc/mysql/debian.cnf
sed -i "s/^user     =.*$/user     = debian-sys-maint/" /etc/mysql/debian.cnf


mysql -e "GRANT ALL ON *.* TO 'debian-sys-maint'@'localhost' IDENTIFIED BY '${PASS}' WITH GRANT OPTION;"


# Tested with Debian + mariadb (EasyEngine v3.7.4)
# Release:        8.7
# Codename:       jessie
# 


## other comment:
# How to fix password (may be broken after some time/upgrade)
# SET PASSWORD FOR 'debian-sys-maint'@'localhost' = PASSWORD('plain-text-password from /etc/mysql/debian.cnf');
