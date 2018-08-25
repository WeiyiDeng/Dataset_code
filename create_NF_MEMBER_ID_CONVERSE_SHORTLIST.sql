create table NF_MEMBER_ID_CONVERSE_SHORTLIST(MEMBER char, NM_ID integer, FM_ID integer);
insert into NF_MEMBER_ID_CONVERSE_SHORTLIST

SELECT * FROM (select * from NF_MEMBER_ID_CONVERSE
where NM_ID in (select NEW_UID from test_nm_full_artistID_adopt6046)) as step1
WHERE FM_ID in (select NEW_UID from test_fm_full_artistID_adopt6046) 