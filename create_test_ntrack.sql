create table test_ntrack(new_id char, TRACK_ID char);
insert into test_ntrack

select rowid as new_id, TRACK_ID from ntrack_ids