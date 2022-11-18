# Auditing SQL

- setup_source: Scripts to execute against the SQL instance to audit. This will configure auditing to generate output .sqlaudit files.
- setup_destination : Scripts to execute against the SQL instance where audits will be stored. This will create import procedures and needed tables.
- import : Scripts to import .sqlaudit files into the destination DB.
- grafana : Queries to configure Grafana dashboards.
