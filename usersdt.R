# check out week variable
weekcheck <- tbl(db,sql("select week
           from dataset7
           "))

weekout <- collect(weekcheck)
hist(table(weekout))   # UTS -> weeks
table(weekout)  # x axis is the number of weeks with how many observations

## select total number of listenings by each ID
numrows_peruserID <- tbl(db,sql("select ID_USER, count(*)
           from dataset1
           group by ID_USER
           "))

numrows_peruserIDnew <- collect(numrows_peruserID)

# plot historgram total number of listens
qplot(numrows_peruserIDnew$count)

barplot(table(numrows_peruserIDnew$count), main="number of listens per user_id",
        xlab = "number of listens", ylab = "count user_id")

table(numrows_peruserIDnew$count)
