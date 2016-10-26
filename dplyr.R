library("dplyr")
library("ggplot2")
? dplyr

library("RSQLite")

db <- src_sqlite("db_mod.db")          # link with database db_mod
db_tb1 <- tbl(db, "dataset1")          # link with table dataset1
db_tb2 <- tbl(db, "dataset2")
db_tb4 <- tbl(db, "dataset4")
db_tb7 <- tbl(db, "dataset7")
# db_tb1 <- tbl(db, "simple")

#db_tb2 %>%
#  select(ID_USER, ID_FRIEND)%>%
#  arrange(desc(ID_USER))

tbl(db,sql("select count(*) from dataset1"))         # count num of rows

c <- tbl(db,sql("select dataset1.ID_USER, Topband, AGE, ID_FRIEND 
           from dataset1, dataset2
           where dataset1.ID_USER = dataset2.ID_USER
           order by AGE
           "))

a <- tbl(db,sql("select dataset1.ID_USER, Topband, AGE, ID_FRIEND 
           from dataset1, dataset2
           where dataset1.ID_USER = dataset2.ID_USER
           and AGE = 30    
           "))

a
# or cat <- as.data.frame(a)
glimpse(c)
B <- data.frame(a)
barplot(table(B$Topband))
# M <- data.frame(c, n = -1)
M <- collect(c)
barplot(table(M$AGE))


#--------------------------------------------
## ggplot trials

#load data
str(mpg)
data("mpg")
summary(mpg)
head(mpg)

qplot(displ, hwy, data = mpg, col = drv)         # color according to variable drv     

qplot(displ, hwy, data = mpg, col = drv, 
      geom = c("point", "smooth"), method = "lm")       # add smooth line

qplot(hwy, data = mpg, fill = drv)                    # make histogram

qplot(hwy, data = mpg, binwidth = 2, facets = .~drv)

qplot(displ, hwy, data = mpg, col = drv, facets = drv~.)  

# geom = "density"
# shape = drv

## ggplot by adding layers
# xlab(), ylab(), ggtitle(), & labs()

# cut continuous variable into categories
cutpoints <- quantile(mpg$cty, seq(0,1,length=5))         
mpg$city_new <- cut(mpg$cty, cutpoints)

g <- ggplot(mpg, aes(displ,hwy))
g + geom_point() + facet_wrap(city_new ~ drv, nrow=4, ncol = 3) + geom_smooth(method = "lm") + labs(title = "ggplot trial")

# + facet_grid(.~fl)

