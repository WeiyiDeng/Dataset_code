SELECT S1.ID_USER, S1.weeknum, S1.ID_TRACK, S1.[persong]*1.0/S2.allSong
FROM (select ID_USER, weeknum, ID_TRACK, count(*) as perSong
from trysample2 
group by ID_USER, weeknum, ID_TRACK) as S1,
(select ID_USER, weeknum, count(*) as allSong
from trysample2
group by ID_USER, weeknum) as S2
WHERE S1.ID_USER = S2.ID_USER and S1.weeknum = S2.weeknum and S1.ID_USER in (Select ID_USER from friendsample)



