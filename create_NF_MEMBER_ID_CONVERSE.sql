create table NF_MEMBER_ID_CONVERSE(MEMBER char, NM_ID integer, FM_ID integer);
insert into NF_MEMBER_ID_CONVERSE

select MEMBER, dba.test_nlist.new_id as NM_ID, test_flist.new_id as FM_ID
from dba.MEMBER_NAMES, dba.test_nlist, test_flist
where dba.test_nlist.USERS = MEMBER and test_flist.USERS = MEMBER