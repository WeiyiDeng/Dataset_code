﻿create table dt7_member_plus_friend_neighbour_names_fix_weeks_artist6046ID_union_week_listens(NEW_BAND_ID char, WEEK_ID integer, TOTAL_WEEK_LISTENS integer);
insert into dt7_member_plus_friend_neighbour_names_fix_weeks_artist6046ID_union_week_listens

select NEW_ID as NEW_BAND_ID, WEEK_ID, TOTAL_WEEK_LISTENS
from dt7_member_plus_friend_neighbour_names_fix_weeks_artist6046_union_week_listens, artist_new_old_id_6046
where NEW_AID = ARTIST