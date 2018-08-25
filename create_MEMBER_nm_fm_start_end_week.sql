create table MEMBER_nm_fm_start_end_week(NM_ID integer, FM_ID integer, START_WEEK integer, END_WEEK integer);
insert into MEMBER_nm_fm_start_end_week

select NM_ID, FM_ID, START_WEEK, END_WEEK
from NF_MEMBER_ID_CONVERSE_SHORTLIST, nm_start_end_week
where NEW_UID = NM_ID