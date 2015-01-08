insert into Yearmon	 
select strftime('%Y-%m', UTC)
from Time
-- Note: create table "Yearmon" with char variable "month"



