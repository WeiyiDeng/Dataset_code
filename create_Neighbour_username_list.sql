create table Neighbour_username_list(Neighbour char);
insert into Neighbour_username_list

SELECT distinct Neighbour FROM dt3
WHERE USER in (select USER from dbaf.userlist
where USER_ID in (select distinct member from dbaf.new_friendlist_8088))