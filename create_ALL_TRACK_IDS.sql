﻿create table ALL_TRACK_IDS(TRACK_ID char);
insert into ALL_TRACK_IDS

select TRACK_ID from dt7_member_plus_friend_names_fix_sum
union
select TRACK_ID from dt7_member_plus_neighbour_names_fix_sum