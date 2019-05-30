#!/bin/bash
export PGPASSWORD=$2

psql --host=validation-database.cyjaepzpx1tk.eu-west-2.rds.amazonaws.com --port=5432 --username=$1 --dbname=validationdb -a -f droptables.sql