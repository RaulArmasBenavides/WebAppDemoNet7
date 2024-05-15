#start SQL Server, start the script to create the DB and import the data, start the app
#/opt/mssql/bin/sqlserver & /usr/src/app/import-data.sh
/usr/src/app/restore-db.sh & /opt/mssql/bin/sqlserver