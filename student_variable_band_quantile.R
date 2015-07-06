bweeklis <- tbl(db,sql("select count(distinct ID_USER)
from dataset7
group by ID_ARTIST, WEEK 
           "))

bweekl <- collect(bweeklis)

table(bweekl)
barplot(table(bweekl))


# quantile of bands listened by number of users in the same time period P1
banduser <- tbl(db,sql("select count(distinct ID_USER)
from wtable
group by ID_ARTIST, P1 
           "))

bandu <- collect(banduser)

quantile(unlist(bandu), c(0.1, 0.2, 0.3, 0.4, 0.8, 0.9, .99))
