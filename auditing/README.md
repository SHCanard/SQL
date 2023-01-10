# Auditing SQL

- setup_source: Scripts to execute against the SQL instance to audit. This will configure auditing to generate output .sqlaudit files. Also contains script to move logs.
- setup_destination : Scripts to execute against the SQL instance where audits will be stored. This will create import procedures and needed tables. Also contains script to import logs.
- grafana : Queries to configure Grafana dashboards.
