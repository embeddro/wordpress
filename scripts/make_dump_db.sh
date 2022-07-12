#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR"
source ../.env
cd ../sql
docker exec mysql_server sh -c "exec mysqldump --all-databases -uroot -p${DB_ROOT_PSWD}" > all-dump.sql  
tar -cvzf -  all-dump.sql  | gpg -c --batch --passphrase "${MYSQL_DUMP_PASSWORD}" > dump.tar.gz.gpg
rm -f all-dump.sql
