create table neighbourlist_6585_match(MEMBER integer, NEIGHBOUR integer, MATCH double);
insert into neighbourlist_6585_match

select dbaf.userlist.USER_ID as MEMBER, neighbourlist_id.USER_ID as NEIGHBOUR, MATCH
from dba.dt3, neighbourlist_id,dbaf.userlist
where dbaf.userlist.USER = dba.dt3.USER and neighbourlist_id.USER = dba.dt3.NEIGHBOUR