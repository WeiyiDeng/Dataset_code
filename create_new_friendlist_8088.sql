create table new_friendlist_8088 (MEMBER integer, FRIEND integer);
insert into new_friendlist_8088 (MEMBER, FRIEND)

SELECT *
FROM (select * from friendlist
where MEMBER in (select distinct USER_ID from bandadoptions_lenient_adopt)) as M
WHERE FRIEND in (select distinct USER_ID from bandadoptions_lenient_adopt)