#!/bin/bash

echo "This script export data to new database"

USERNAME=postgres
PASSWORD=postgres
DATABASE=hawle
HOST=127.0.0.1
PORT=5432
thisFileName=dbDataExport.sh

ERROR_MESSAGE="Usage: $thisFileName--newUsername={newUsername} --newPassword={newPassword} --newDatabase={newDatabase} --newHost={newHost} --newPort={newPort}"

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
else
    username="${USERNAME// }"
    password="${PASSWORD// }"
    database="${DATABASE// }"
    host="${HOST// }"
    port="${PORT// }"
fi

export PGPASSWORD="$password"

search_dir=.
for entry in "$search_dir"/*
do
  fileName=${entry#"$search_dir/"}
  fileName=${fileName%".csv"}
  echo "$fileName"
  if [ "$fileName" = "$thisFileName" ] || [ "$fileName" = "dbSchemaExport.sh" ]; then
     echo "skipped $fileName"
  else
    psql -h "$host" -p "$port" -U "$username" -d "$database" -c "\copy $fileName FROM '$fileName.csv' DELIMITER ',' CSV HEADER;"
  fi
done

if [ $? -ne 0 ]; then
    echo "DB data import failed!"
else
    echo "DB data import successful!"
fi

exit $?