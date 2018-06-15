create table test_ftrack(new_id char, TRACK_ID char);
insert into test_ftrack

select rowid as new_id, TRACK_ID from ftrack_ids