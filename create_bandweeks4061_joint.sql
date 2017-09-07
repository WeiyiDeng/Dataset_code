create table bandweeks4061_joint(USER_ID integer, week_ID integer, COUNT_mod integer, BAND_ID integer, WEEK_USER integer, WEEK_BAND integer);
insert into bandweeks4061_joint(USER_ID, week_ID, COUNT_mod, BAND_ID, WEEK_USER, WEEK_BAND)

select bandweeks4061_userID.USER_ID, bandweeks4061_userID.week_ID, COUNT_mod, bandweeks4061_userID.BAND_ID, WEEK_USER, WEEK_BAND 
from bandweeks4061_userID, user_intro_8320_from_dt7, band_intro_6046_from_dt7
where user_intro_8320_from_dt7.USER_ID = bandweeks4061_userID.USER_ID and band_intro_6046_from_dt7.BAND_ID = bandweeks4061_userID.BAND_ID
order by bandweeks4061_userID.USER_ID