#!/bin/bash
if [ "$#" -eq 0 ]; then
    echo "Usage: load_data.sh <username> <password>"
    exit
elif [ "$#" -ne 2 ]; then
   echo "Illegal number of parameters. Usage: load_data.sh <username> <password>"
    exit
else
    export PGPASSWORD=$2
fi
psql --host=validation-database.cyjaepzpx1tk.eu-west-2.rds.amazonaws.com --port=5432 --username=$1 --dbname=validationdb -a -f tables.sql

python generateContributors.py

psql --host=validation-database.cyjaepzpx1tk.eu-west-2.rds.amazonaws.com --port=5432 --username=$1 --dbname=validationdb -a -f generateResponses.sql

python generateValidationData.py