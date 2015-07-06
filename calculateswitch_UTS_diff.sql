select f.[ID_USER], f.[UTS], (ifnull(f2.UTS,0)-f.UTS) as diff, f.row_num
from trysample f, trysample f2
where f2.row_num=(f.row_num+1)




