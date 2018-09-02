create table test_fm_nm_artist_adopt(USERS char, NEW_UID integer, ARTIST char, NEW_AID integer, WEEK_ID integer);
insert into test_fm_nm_artist_adopt

select * from test_fm_artist_adopt
union
select * from test_nm_artist_adopt