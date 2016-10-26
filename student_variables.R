# age distribution
age_distri <- tbl(db,sql("select AGE
      from newtable1 
           "))

userage <- collect(age_distri)

table(userage)

barplot(table(userage))

# overall listening to band b prior to week t for the past 52 weeks
weekdat <- tbl(db,sql(" select USER_mod, weekno, Band, BandTotal
from bandtable
order by USER_mod, Band
           "))

weekdata <- collect(weekdat)
# weekdata$weekno <- as.numeric(as.character(weekdata$weekno)) not work ?
# weekdata[, c(2,4)] <- sapply(weekdata[, c(2,4)], as.numeric) not work ?

# matrix can contain only one type of data
week <- as.matrix(weekdata)
weekno <- as.numeric(weekdata$weekno)
BandTotal <- as.numeric(weekdata$BandTotal)

#week[2,3]
#identical(week[2,3],week[3,3])

ele <- c()
ele[1]=0
for (i in 2:300){                                   # change 300 to length(week)
  if (week[i,3]==week[(i-1),3]){
    ele[i]=1
  }
  else{ele[i]=0}
}

count <- c()
for (j in 1:300){                                 # change 300 to length(week)
  if (ele[j] == 0){
    count[j] = 0
  }
  else{
    if ((weekno[j]-weekno[(j-1)])<=52){           # change 52 to any time interval
      count[j]=BandTotal[j-1]
     for (k in 2:300){                            # change 300 to length(week)
        if ((weekno[j]-weekno[j-k])<=52 & ele[j-k+1]==1){        # change 52 to any time interval
        count[j]=count[j]+BandTotal[j-k]
        }
        else break
      }
    }
    else{count[j]=0}
  }
}

# use cbind to combine variable count to the original matrix
write.csv(file="fileName.csv", x=dataframeName)


#count <- c()
#for (j in 1:10){
#  if (ele[j] == 0){
#    count[j] = 0
#  }
#  else{
#    if ((week[j,2]-week[(j-1),2])<=52){
#      count[j]=week[(j-1),4]
#      for (k in 2:10){
#        if ((week[j,2]-week[(j-k),2])<=52 & ele[j-k]==1){
#          count[j]=count[j]+week[(j-k),4]
#        }
#        else break
#      }
#    }
#    else{count[j]=0}
#  }
#}

