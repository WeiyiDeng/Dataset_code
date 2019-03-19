create table dt_5_tags2(TAG char, COUNTS int);
insert into dt_5_tags2

select TAG1, count(*) from dt5
group by TAG1
union all
select TAG2, count(*) from dt5
group by TAG2
union all
select TAG3, count(*) from dt5
group by TAG3
union all
select TAG4, count(*) from dt5
group by TAG4
union all
select TAG5, count(*) from dt5
group by TAG5
union all
select TAG6, count(*) from dt5
group by TAG6
union all
select TAG7, count(*) from dt5
group by TAG7
union all
select TAG8, count(*) from dt5
group by TAG8
union all
select TAG9, count(*) from dt5
group by TAG9
union all
select TAG10, count(*) from dt5
group by TAG10
union all
select TAG11, count(*) from dt5
group by TAG11
union all
select TAG12, count(*) from dt5
group by TAG12
union all
select TAG13, count(*) from dt5
group by TAG13
union all
select TAG14, count(*) from dt5
group by TAG14
union all
select TAG15, count(*) from dt5
group by TAG15
union all
select TAG16, count(*) from dt5
group by TAG16
union all
select TAG17, count(*) from dt5
group by TAG17
union all
select TAG18, count(*) from dt5
group by TAG18
union all
select TAG19, count(*) from dt5
group by TAG19
union all
select TAG20, count(*) from dt5
group by TAG20