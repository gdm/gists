#!/bin/bash

rm -rf dumps
mkdir -p dumps

CRED=
# CRED=-u $USER -p$PASSWORD
OPTS="--single-transaction --quick"

#rm "$OUTPUTDIR/*gz" > /dev/null 2>&1

databases=`mysql $CRED -e "SHOW DATABASES;" | tr -d "| " | grep -v Database`

for db in $databases; do
    if [[ "$db" != "information_schema" ]] && [[ "$db" != "performance_schema" ]] && [[ "$db" != "mysql" ]] && [[ "$db" != _* ]] ; then
        echo "Dumping database: $db"
        echo "mysqldump $CRED $OPTS --databases $db > dumps/$db.sql"
        mysqldump $CRED $OPTS --databases $db > dumps/$db.sql
    fi
done

mysql -BNe "select concat('\'',user,'\'@\'',host,'\'') from mysql.user where user != 'root'" | \
while read uh; do mysql -BNe "show grants for $uh" | sed 's/$/;/; s/\\\\/\\/g'; done > dumps/grants.sql