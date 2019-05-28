#!/bin/bash
  
psql --host=validation-database.cyjaepzpx1tk.eu-west-2.rds.amazonaws.com --port=5432 --username --password --dbname=validationdb -a -f tables.sql
python generateContributors.py
psql --host=validation-database.cyjaepzpx1tk.eu-west-2.rds.amazonaws.com --port=5432 --username=${var.DB_username} --password --dbname=validationdb -a -f generateResponses.sql
python generateValidationData.py