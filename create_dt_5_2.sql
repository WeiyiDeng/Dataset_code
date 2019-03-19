create table dt_5_2(TAG char, wCOUNTS int);
insert into dt_5_2

select TAG, sum(COUNTS) as wCOUNTS from dt_5_tags2
group by TAG
order by wCOUNTS desc
