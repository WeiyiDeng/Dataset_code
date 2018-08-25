create table MEMBER_NAMES(MEMBER char);
insert into MEMBER_NAMES

select distinct USER as MEMBER from dt2
where USER in (SELECT USER FROM dt3)