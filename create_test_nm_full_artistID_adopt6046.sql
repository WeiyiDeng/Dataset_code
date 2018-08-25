create table test_nm_full_artistID_adopt6046(NEW_UID char, NEW_AID char, WEEK_ID integer);
insert into test_nm_full_artistID_adopt6046

select *
from test_nm_full_artistID_adopt
where NEW_AID in (select NEW_ID from artist_new_old_id_6046)