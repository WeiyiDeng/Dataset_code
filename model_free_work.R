setwd("E:/Trans/Transfer from old Toshiba/SQLite")

library("ggplot2")
# http://www.cookbook-r.com/Graphs/Plotting_distributions_(ggplot2)/#histogram-and-density-plots-with-multiple-groups

count_adopt <- read.csv("count_2nd_half_adoptions.csv",header = FALSE)
discrete_innov <- read.csv("discrete_innov_short.csv",header = FALSE)

adopts <- cbind(count_adopt,discrete_innov)
adopts <- data.frame(adopts)
colnames(adopts) <- c("count_adoptions", "innov_level")

adopts$innov_level <- factor(adopts$innov_level)

levels(adopts$innov_level)[levels(adopts$innov_level)=="1"] <- "low"
levels(adopts$innov_level)[levels(adopts$innov_level)=="2"] <- "medium"
levels(adopts$innov_level)[levels(adopts$innov_level)=="3"] <- "high"

ggplot(adopts, aes(x=count_adoptions, fill=innov_level)) +
  geom_histogram(binwidth=1, position="dodge")

ggplot(adopts, aes(x=count_adoptions, fill=innov_level)) +
  geom_histogram(binwidth=.5, alpha=.5, position="identity")

##
reduced <- adopts[adopts$count_adoptions<=100,]

ggplot(reduced, aes(x=count_adoptions, fill=innov_level)) +
  geom_histogram(binwidth=.5, alpha=.5, position="identity")

ggplot(reduced, aes(x=count_adoptions, fill=innov_level)) +
  geom_histogram(binwidth=1, position="dodge")

ggplot(reduced, aes(x=count_adoptions, fill=innov_level)) +
  geom_histogram(binwidth=1)