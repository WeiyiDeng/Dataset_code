create table test_fm_nm_artist_adopt_week_baseline(ARTIST char, WEEK_ID integer, week_adopts integer);
insert into test_fm_nm_artist_adopt_week_baseline

select ARTIST, WEEK_ID, count(*) as week_adopts
from test_fm_nm_artist_adopt
group by ARTIST, WEEK_ID
--w: notice here can not group by NEW_AID as the NEW_AIDs have not been unified for both friend and neighbour data, you get two different NEW_AIDs for one ARTIST !! 