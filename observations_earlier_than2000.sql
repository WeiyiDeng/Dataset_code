SELECT count(*)
From (SELECT UTC, strftime('%s', UTC) - strftime('%s','2000-01-01 00:00:00') as sec
From Time) G
where G.[sec] <0;
