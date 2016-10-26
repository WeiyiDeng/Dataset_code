select *
from (select f.[ID_USER], f.[UTS], (ifnull(f2.UTS,0)-f.UTS) as diff, f.row_num, f.TRACK_DURATION
from trysample f, trysample f2
where f2.row_num=(f.row_num+1)) G
where G.diff < 10000 and G.[diff] > 0 and G.diff/G.[TRACK_DURATION] < 0.0005 



