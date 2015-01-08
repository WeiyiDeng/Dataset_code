select D.[ID_USER], TRACK_DURATION, M.[ID_ARTIST], ID_FRIEND, SIMILARITY
from duration_22000 D, tb_2 N, tb_4 M
where D.[ID_USER]=N.[ID_USER] and D.[ID_ARTIST]=M.[ID_ARTIST]

select ID_USER from duration_22000 where Topband = 0
except
select ID_USER from duration_22000 where Lovedband = 1
