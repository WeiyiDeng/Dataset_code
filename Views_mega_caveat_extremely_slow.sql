create view Mega as
select tb_type.ID_USER, UTS, AGE,
       tb_type.ID_ARTIST, ID_FRIEND, ID_SIM, SIMILARITY
from tb_type, tb_2, tb_4
where tb_type.ID_USER = tb_2.ID_USER and tb_type.ID_ARTIST = tb_4.ID_ARTIST;

select ID_USER from Mega
Where AGE = 35;

drop view Mega;


