---
-- ETL Freshness (Gauge)
---

declare @OldestDate datetime
SET @OldestDate = (SELECT MIN(EXEC_START_TIME)
	FROM [dbo].[CR_STAT_EXECUTION]  
    WHERE EXEC_NAME = 'ETL'
AND $__timeFilter(EXEC_START_TIME))

declare @NewestDate datetime
SET @NewestDate = (SELECT MAX(EXEC_START_TIME)
	FROM [dbo].[CR_STAT_EXECUTION]  
    WHERE EXEC_NAME = 'ETL'
AND $__timeFilter(EXEC_START_TIME))

SELECT CONVERT (DECIMAL(9,0),COUNT (*)) / CONVERT (DECIMAL(9,0),(DATEDIFF (DAY, @OldestDate, @NewestDate) +1))
FROM [dbo].[CR_STAT_EXECUTION]
WHERE EXEC_NAME = 'ETL'
AND $__timeFilter(EXEC_START_TIME)

---
-- Auditing Completness (Stat)
---
/* ACTIONS_WARNING will mostly report cases when user name is too long and was truncated. */

SELECT $__timeEpoch(EXEC_START_TIME), CONCAT(EXEC_NAME,' ',UPPER(ENVIRONMENT)) AS Value, CONVERT (DECIMAL(9,0),(COALESCE(ACTIONS_SUCCESS,0))) / CONVERT (DECIMAL(9,0),((COALESCE(ACTIONS_SUCCESS ,0) + coalesce(ACTIONS_WARNING ,0) + coalesce(ACTIONS_ERROR ,0))))
FROM [dbo].[CR_STAT_EXECUTION]
WHERE EXEC_NAME LIKE 'Auditing%'
AND   $__timeFilter(EXEC_START_TIME)
ORDER BY
  EXEC_START_TIME DESC
  
---
-- ETL Completness (Graph)
---

SELECT $__timeEpoch(EXEC_START_TIME), EXEC_NAME AS Value, CONVERT (DECIMAL(9,0),(COALESCE(ACTIONS_SUCCESS,0))) / CONVERT (DECIMAL(9,0),((COALESCE(ACTIONS_SUCCESS ,0) + coalesce(ACTIONS_WARNING ,0) + coalesce(ACTIONS_ERROR ,0))))
FROM [dbo].[CR_STAT_EXECUTION]
WHERE EXEC_NAME = 'ETL'
AND   $__timeFilter(EXEC_START_TIME)

---
-- Datalink Completness (Graph)
---
/* ACTIONS_WARNING gets populated when command returned no results, so we'll ignore warnings. */

SELECT $__timeEpoch(EXEC_START_TIME), EXEC_NAME AS Value, CONVERT (DECIMAL(9,0),(COALESCE(ACTIONS_SUCCESS,0))) / CONVERT (DECIMAL(9,0),((COALESCE(ACTIONS_SUCCESS ,0) + coalesce(ACTIONS_ERROR ,0))))
FROM [dbo].[CR_STAT_EXECUTION]
WHERE EXEC_NAME LIKE 'Datalink%'
AND   $__timeFilter(EXEC_START_TIME)

