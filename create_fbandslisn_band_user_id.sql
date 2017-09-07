--select count(*) from fbandslisn
--12454732

create table fbandslisn_band_user_id(USER char, USER_ID integer, ARTIST char, BAND_ID integer, WEEK_ID integer);
insert into fbandslisn_band_user_id

select fbandslisn.USER, USER_ID, fbandslisn.ARTIST, BAND_ID, WEEK_ID
from fbandslisn, userlist, newbandlist
where fbandslisn.USER = userlist.USER and fbandslisn.ARTIST = newbandlist.ARTIST
--order by USER_ID, BAND_ID