create table neighbourlist_6585(MEMBER integer, NEIGHBOUR integer);
insert into neighbourlist_6585

select dbaf.userlist.USER_ID as MEMBER, neighbourlist_id.USER_ID as NEIGHBOUR
from dba.dt3, neighbourlist_id,dbaf.userlist
where dbaf.userlist.USER = dba.dt3.USER and neighbourlist_id.USER = dba.dt3.NEIGHBOUR