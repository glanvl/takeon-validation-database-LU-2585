#!/bin/bash

log="output-log.txt"

if [ "$#" -ne 2 ]; then
   echo "Illegal number of parameters. Usage: load_data.sh <username> <password>"
    exit
else
    export PGPASSWORD=$2
fi
echo "Dropping existing tables..."
psql --host=validation-database.cyjaepzpx1tk.eu-west-2.rds.amazonaws.com --port=5432 --username=$1 --dbname=validationdb -a -f droptables.sql
echo "Creating Tables..."
psql --host=validation-database.cyjaepzpx1tk.eu-west-2.rds.amazonaws.com --port=5432 --username=$1 --dbname=validationdb -a -f tables.sql >> $log
echo "Generating dummy contributor data..."
python generateContributors.py >> $log
echo "Generating dummy response data..."
psql --host=validation-database.cyjaepzpx1tk.eu-west-2.rds.amazonaws.com --port=5432 --username=$1 --dbname=validationdb -a -f generateResponses.sql >> $log
echo "Generating validation data..."
python generateValidationData.py >> $log
echo "Script finished"