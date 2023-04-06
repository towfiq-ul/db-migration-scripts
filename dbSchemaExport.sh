#!/bin/bash

echo "This script export schema to new database"


USERNAME=postgres
PASSWORD=postgres
DATABASE=hawle
HOST=127.0.0.1
PORT=5432
OLD_DATABASE=hawle_db_schema

ERROR_MESSAGE="Usage: db_schema_export.sh --newUsername={newUsername} --newPassword={newPassword} --newDatabase={newDatabase} --newHost={newHost} --newPort={newPort} --oldDatabase={oldDatabase}"

if [[ -z "${USERNAME// }" ]]
then
    echo "--newUsername parameter is invalid or unspecified!"
    echo "$ERROR_MESSAGE"
    exit 1
elif [[ -z "${PASSWORD// }" ]]
then
    echo "--newPassword parameter is invalid or unspecified!"
    echo "$ERROR_MESSAGE"
    exit 1

elif [[ -z "${DATABASE// }" ]]
then
    echo "--newDatabase parameter is invalid or unspecified!"
    echo "$ERROR_MESSAGE"
    exit 1

elif [[ -z "${HOST// }" ]]
then
    echo "--newHost parameter is invalid or unspecified!"
    echo "$ERROR_MESSAGE"
    exit 1

elif [[ -z "${PORT// }" ]]
then
    echo "--newPort parameter is invalid or unspecified!"
    echo "$ERROR_MESSAGE"
    exit 1
elif [[ -z "${OLD_DATABASE// }" ]]
then
    echo "--oldDatabase parameter is invalid or unspecified!"
    echo "$ERROR_MESSAGE"
    exit 1
else
    username="${USERNAME// }"
    password="${PASSWORD// }"
    database="${DATABASE// }"
    host="${HOST// }"
    port="${PORT// }"
    oldDatabase="${OLD_DATABASE// }"
fi

export PGPASSWORD="$password"

psql -h "$host" -p "$port" -U "$username" -d "$database" -s < "../$oldDatabase" ;

if [ $? -ne 0 ]; then
    echo "DB schema export failed!"
else
    echo "DB schema export successful!"
fi

exit $?