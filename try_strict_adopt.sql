/*
create table user_intro_8320(USER char, WEEK_USER integer);
insert into user_intro_8320(USER, WEEK_USER)

select USER_ID, min(week_ID) as week_user
from bandadoptions
group by USER_ID
*/

--select count(*) from user_intro_8320

/*
create table band_intro_6046(BAND_ID integer, WEEK_BAND integer);
insert into band_intro_6046(BAND_ID, WEEK_BAND)

select BAND_ID, min(week_ID) as week
from bandadoptions
group by BAND_ID
*/

--select count(*) from band_intro_6046

--select count(*) from bandadoptions

/*
create table bandadoptions_joint(USER_ID integer, BAND_ID integer, WEEK_ID integer, WEEK_USER integer, WEEK_BAND integer);
insert into bandadoptions_joint(USER_ID, BAND_ID, WEEK_ID, WEEK_USER, WEEK_BAND)

select bandadoptions.USER_ID, bandadoptions.BAND_ID, bandadoptions.WEEK_ID, WEEK_USER, WEEK_BAND 
from bandadoptions, user_intro_8320, band_intro_6046
where user_intro_8320.USER = bandadoptions.USER_ID and band_intro_6046.BAND_ID = bandadoptions.BAND_ID
*/

/*
create table bandadoptions_strict_adopt(USER_ID integer, BAND_ID integer, WEEK_ID integer, WEEK_USER integer, WEEK_BAND integer);
insert into bandadoptions_strict_adopt(USER_ID, BAND_ID, WEEK_ID, WEEK_USER, WEEK_BAND)

select * from bandadoptions_joint
where WEEK_USER <= WEEK_BAND
*/

select count(*) from bandadoptions_strict_adopt
--select count(distinct USER_ID) from bandadoptions_strict_adopt
--select count(distinct BAND_ID) from bandadoptions_strict_adopt
