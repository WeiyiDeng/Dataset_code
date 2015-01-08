select ID_USER, count(distinct ID_TRACK)
from duration_22000
Group by ID_USER;
