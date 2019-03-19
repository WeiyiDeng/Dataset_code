create table dt_5_tags(TAG char, COUNTS int);
insert into dt_5_tags

select TAG1, sum(COUNTS) from dt5
group by TAG1
union all
select TAG2, sum(COUNT2) from dt5
group by TAG2
union all
select TAG3, sum(COUNT3) from dt5
group by TAG3
union all
select TAG4, sum(COUNT4) from dt5
group by TAG4
union all
select TAG5, sum(COUNT5) from dt5
group by TAG5
union all
select TAG6, sum(COUNT6) from dt5
group by TAG6
union all
select TAG7, sum(COUNT7) from dt5
group by TAG7
union all
select TAG8, sum(COUNT8) from dt5
group by TAG8
union all
select TAG9, sum(COUNT9) from dt5
group by TAG9
union all
select TAG10, sum(COUNT10) from dt5
group by TAG10
union all
select TAG11, sum(COUNT11) from dt5
group by TAG11
union all
select TAG12, sum(COUNT12) from dt5
group by TAG12
union all
select TAG13, sum(COUNT13) from dt5
group by TAG13
union all
select TAG14, sum(COUNT14) from dt5
group by TAG14
union all
select TAG15, sum(COUNT15) from dt5
group by TAG15
union all
select TAG16, sum(COUNT16) from dt5
group by TAG16
union all
select TAG17, sum(COUNT17) from dt5
group by TAG17
union all
select TAG18, sum(COUNT18) from dt5
group by TAG18
union all
select TAG19, sum(COUNT19) from dt5
group by TAG19
union all
select TAG20, sum(COUNT20) from dt5
group by TAG20