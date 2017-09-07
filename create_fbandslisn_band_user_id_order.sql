--select count(*) from fbandslisn
--12454732

create table fbandslisn_band_user_id_order(USER_ID integer, BAND_ID integer, WEEK_ID integer);
insert into fbandslisn_band_user_id_order

select USER_ID, BAND_ID, WEEK_ID
from fbandslisn, userlist, newbandlist
where fbandslisn.USER = userlist.USER and fbandslisn.ARTIST = newbandlist.ARTIST
order by USER_ID, BAND_ID