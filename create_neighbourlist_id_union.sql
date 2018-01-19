create table neighbourlist_id_union(USER_ID integer, USER text);
insert into neighbourlist_id_union

select * from neighbourlist_id
where USER not in (select USER from dbaf.userlist)
union
select * from dbaf.userlist
where USER in (select USER from neighbourlist)
order by USER