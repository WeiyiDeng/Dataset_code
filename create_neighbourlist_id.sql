create table neighbourlist_id(USER_ID integer, USER text);
insert into neighbourlist_id

select (rowid+8320) as neighbourlist_id, USER from neighbourlist