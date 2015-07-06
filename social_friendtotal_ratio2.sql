select ID_USER, weeknum, sum(perSong)
from (SELECT friendsample. ID_USER, friendsample. ID_FRIEND, ID_TRACK, weeknum, perSong
FROM (select ID_USER as ID_FRIEND, weeknum, ID_TRACK, count(*) as perSong
from trysample2 
group by ID_USER, weeknum, ID_TRACK) as B, friendsample
WHERE friendsample. ID_FRIEND = B.ID_FRIEND)
group by ID_USER, weeknum
