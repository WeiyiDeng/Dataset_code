create table bandweeks4061_lenient_adopt(USER_ID integer, week_ID integer, COUNTmod integer, BAND_ID integer, WEEK_USER integer, WEEK_BAND integer);
insert into bandweeks4061_lenient_adopt(USER_ID, week_ID, COUNTmod, BAND_ID, WEEK_USER, WEEK_BAND)

select * from bandweeks4061_joint
where WEEK_USER <= WEEK_BAND or WEEK_USER+52 <= WEEK_ID