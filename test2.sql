--select count(distinct BAND_ID) from modelbandweeks

--select count(distinct USER_ID) from bandadoptions_strict_adopt

--select count(distinct USER) from fbandslisn

--select count(*) from fbandslisn

--select count(*) from bandadoptions

--select distinct USER_ID from bandadoptions_strict_adopt

--select count(*) from peak_strict

select USER_ID, mod_adoptions_strict.BAND_ID, mod_adoptions_strict.week_mod, introdate.week_mod as bandintro, peak_strict.week_mod as bandpeak
from mod_adoptions_strict, peak_strict, introdate
where mod_adoptions_strict.BAND_ID = peak_strict.BAND_ID and mod_adoptions_strict.BAND_ID = introdate.BAND_ID

/*
select count(*)
from (SELECT *
FROM (select * from friendlist
where MEMBER in (select distinct USER_ID from bandadoptions_strict_adopt)) as M
WHERE FRIEND in (select distinct USER_ID from bandadoptions_strict_adopt))
