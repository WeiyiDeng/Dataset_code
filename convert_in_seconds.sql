SELECT sec/604800 as weeksince00
From (SELECT strftime('%s', UTC) - strftime('%s','2000-01-01 00:00:00') as sec
From Time)

