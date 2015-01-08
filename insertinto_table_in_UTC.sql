insert into Time(UTC)
SELECT datetime(UTS, 'unixepoch')
FROM dataset1

