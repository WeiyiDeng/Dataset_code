﻿CREATE TABLE [BAND_dt5_ordered] (
  [BAND_ID] INTEGER,
  [TRACK_ID] CHAR, 
  [TAG1] TEXT, 
  [COUNT1] INTEGER, 
  [TAG2] TEXT, 
  [COUNT2] INTEGER, 
  [TAG3] TEXT, 
  [COUNT3] INTEGER, 
  [TAG4] TEXT, 
  [COUNT4] INTEGER, 
  [TAG5] TEXT, 
  [COUNT5] INTEGER, 
  [TAG6] TEXT, 
  [COUNT6] INTEGER, 
  [TAG7] TEXT, 
  [COUNT7] INTEGER, 
  [TAG8] TEXT, 
  [COUNT8] INTEGER, 
  [TAG9] TEXT, 
  [COUNT9] INTEGER, 
  [TAG10] TEXT, 
  [COUNT10] INTEGER, 
  [TAG11] TEXT, 
  [COUNT11] INTEGER, 
  [TAG12] TEXT, 
  [COUNT12] INTEGER, 
  [TAG13] TEXT, 
  [COUNT13] INTEGER, 
  [TAG14] TEXT, 
  [COUNT14] INTEGER, 
  [TAG15] TEXT, 
  [COUNT15] INTEGER, 
  [TAG16] TEXT, 
  [COUNT16] INTEGER, 
  [TAG17] TEXT, 
  [COUNT17] INTEGER, 
  [TAG18] TEXT, 
  [COUNT18] INTEGER, 
  [TAG19] TEXT, 
  [COUNT19] INTEGER, 
  [TAG20] TEXT, 
  [COUNT20] INTEGER);
insert into BAND_dt5_ordered
select * from BAND_dt5
order by BAND_ID asc