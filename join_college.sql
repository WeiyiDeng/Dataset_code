--select sID, cName, enrollment
--from Apply join College using (cName)

--select Apply.sID, College.cName, sum(enrollment)
--from College, Apply
--where College.cName = Apply.cName
--group by sID

select sID, cName, sum(enrollment)
from Apply join College using (cName)
group by sID
