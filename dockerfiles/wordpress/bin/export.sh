#!/bin/sh -e
#
# exports sql database for backup
#

# re-run script with sudo if we aren't root
if [ "$(id -u)" -ne 0 ] ; then
    sudo "$0"
    exit $?
fi

file=wp-data/data_$(date +"%m_%d_%Y").sql

# shellcheck disable=2016
CMD='exec mysqldump "$MYSQL_DATABASE" -u root -p "$MYSQL_ROOT_PASSWORD"'
docker-compose exec db sh -c "$CMD" > "$file"

# remove password warning from the file
case $(uname) in
    *Darwin*|*BSD*)
        sed -i '.bak' 1,1d "$file"
        ;;
    Linux)
        sed -i 1,1d "$file"
esac
