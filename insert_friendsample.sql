delete from friendsample;

insert into friendsample(ID_USER, ID_FRIEND)
SELECT ID_USER, ID_FRIEND
FROM dataset2
where ID_USER in (select ID_USER from trysample) and ID_FRIEND in (select ID_USER from trysample)






