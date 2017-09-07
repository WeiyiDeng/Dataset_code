--w: use cmd to export newbandlist4061.csv from table small_bands_names4061, remember to select rowid instead of BAND_IDs !!

--cmd input: 
E:\Trans\Transfer from old Toshiba\SQLite>sqlite3 dbaf.db
sqlite> .headers on
sqlite> .mode csv
sqlite> .output newbandlist4061try.csv
sqlite> select rowid, ARTIST from newbandlist4061;
Error: no such table: newbandlist4061
sqlite> select rowid, ARTIST from small_bands_names4061;
sqlite> .output stdout