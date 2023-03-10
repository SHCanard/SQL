# Trace flags for SQL Server 2019 CU15+

## -T2467
Enables an alternate parallel work thread allocation policy.
Threads are scheduled more evenly across nodes.

## -T4139
Fix for poor cardinality estimation with ascending keys.
Allows quickstats histogram amendments to provide better cardinality estimates outside of the histogram range.

## -T8121
Fix for system-wide low memory issue.
Addresses an issue that occurs when SQL Server commits memory above the maximum server memory.
