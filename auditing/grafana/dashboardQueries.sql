---
-- Successful logins gauge (%)
---

SELECT (SELECT CONVERT(decimal(9,2),COUNT(*))
FROM [DB_Audit].[dbo].[SQLAUDIT_LOGIN]
WHERE succeeded = 'true'
AND server_principal_name != ''
AND $__timeFilter([event_time])) / (SELECT CONVERT(decimal(9,2),COUNT(*))
FROM [DB_Audit].[dbo].[SQLAUDIT_LOGIN]
WHERE server_principal_name != ''
AND $__timeFilter([event_time])) * 100

---
-- Failed logins table
---

SELECT [event_time]
      ,[succeeded]
      ,[server_principal_name]
      ,[server_instance_name]
      ,[statement]
      ,[client_ip]
      ,[application_name]
  FROM [DB_Audit].[dbo].[SQLAUDIT_LOGIN]
  WHERE succeeded = 'false'
  AND server_principal_name != ''
  AND $__timeFilter([event_time])

---
-- Last successful connexions heatmap
---

SELECT
  $__timeEpoch([event_time]),
  [sequence_number] as value,
  [server_principal_name] as metric
FROM
  [DB_Audit].[dbo].[SQLAUDIT_LOGIN]
WHERE
  $__timeFilter([event_time])
  AND server_principal_name != ''
  AND succeeded = 'true'
ORDER BY
  [event_time] DESC
  
---
-- Create queries gauge
---
  
SELECT COUNT(*)
  FROM [DB_Audit].[dbo].[SQLAUDIT_QUERY]
  WHERE [statement] LIKE 'CREATE%'
  AND database_name = 'DB'
  AND server_principal_name != 'sa'
  AND $__timeFilter([event_time])

---
-- Create queries table
---

  SELECT event_time
    ,server_principal_name
    ,SCHEMA_NAME
    ,object_name
    ,statement
  FROM [DB_Audit].[dbo].[SQLAUDIT_QUERY]
  WHERE [statement] LIKE 'CREATE%'
  AND database_name = 'DB'
  AND server_principal_name != 'sa'
  AND $__timeFilter([event_time])
  
  ---
