#https://docs.microsof.com/en-us/sql/linux/sql-server-linux-setup-tools?view=sql-server-ver15

sqlcmd -Usa -PSql2019isfast -S10.0.2.9,31433 -Q"SELECT @@version"
