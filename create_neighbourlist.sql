create table neighbourlist(USER text);
insert into neighbourlist

select distinct USER from neighbours_full_listen_bands 
order by USER