setwd("E:/Trans/Transfer from old Toshiba/SQLite")

rm(list = ls())

library(survival)

# example used from
# https://www.mathworks.com/help/stats/cox-proportional-hazards-model-with-time-dependent-covariates.html
mydata<- read.csv("labCP.csv")
attach(mydata)

mydata <- mydata[1:13,1:6]

? coxph

# event = 1-Censoring
fit <- coxph(Surv(tStart, tStop, 1-Censoring) ~ Sex + Lab,
             data=mydata)
summary(fit)

detach(mydata)

##------------------------------------------------------------
adoptData<- read.csv("cox_mat_tStart.csv",header = FALSE)
# adoptData<- read.csv("cox_mat.csv",header = FALSE)
# adoptData<- read.csv("cox_mat_lenient.csv",header = FALSE)
# adoptData<- read.csv("cox_mat_strict.csv",header = FALSE)
colnames(adoptData) <- c("memberID", "friendID", "bandID", "weekID", "eventAdopt", "trend", 
                         "memberAdopt", "newbaseline_prob", "Innov_m", "Innov_m2", "Innov_f", "Innov_f2",
                         "Innov_m*Innov_f", "(Innov_m*Innov_f)2", "Explor_m", "Explor_m2", "Explor_f", "Explor_f2",
                         "Explor_m*Explor_f", "(Explor_m*Explor_f)2", "tStart", "tStop")

attach(adoptData)

X <- cbind(trend, memberAdopt, newbaseline_prob, Innov_m, Innov_m2, Innov_f, Innov_f2, `Innov_m*Innov_f`, `(Innov_m*Innov_f)2`,
           Explor_m, Explor_m2, Explor_f, Explor_f2, `Explor_m*Explor_f`, `(Explor_m*Explor_f)2`, memberAdopt*Innov_m, memberAdopt*Innov_m2, 
           memberAdopt*Innov_f, memberAdopt*Innov_f2, memberAdopt*`Innov_m*Innov_f`, memberAdopt*`(Innov_m*Innov_f)2`,
           memberAdopt*Explor_m, memberAdopt*Explor_m2, memberAdopt*Explor_f, memberAdopt*Explor_f2, 
           memberAdopt*`Explor_m*Explor_f`, memberAdopt*`(Explor_m*Explor_f)2`)

N <- X

X2 <- as.matrix(adoptData[,c("trend","newbaseline_prob")])

colnames(X) <- c("trend", "memberAdopt", "newbaseline_prob", "Innov_m", "Innov_m2", "Innov_f", "Innov_f2",
                           "Innov_m*Innov_f", "(Innov_m*Innov_f)2", "Explor_m", "Explor_m2", "Explor_f", "Explor_f2",
                           "Explor_m*Explor_f", "(Explor_m*Explor_f)2","memberAdopt*Innov_m", "memberAdopt*Innov_m2", 
                         "memberAdopt*Innov_f", "memberAdopt*Innov_f2", "memberAdopt*Innov_m*Innov_f", "memberAdopt*(Innov_m*Innov_f)2",
                         "memberAdopt*Explor_m", "memberAdopt*Explor_m2", "memberAdopt*Explor_f", "memberAdopt*Explor_f2", 
                         "memberAdopt*`Explor_m*Explor_f", "memberAdopt*(Explor_m*Explor_f)2")
colnames(X)

colnames(N) <- c("trend", "memberAdopt", "newbaseline_prob", "Innov_m", "Innov_m2", "Innov_f", "Innov_f2",
                 "V8", "V9", "Explor_m", "Explor_m2", "Explor_f", "Explor_f2",
                 "V14", "V15","V16", "V17", 
                 "V18", "V19", "V20", "V21",
                 "V22", "V23", "V24", "V25", 
                 "V26", "V27")
colnames(N)

colnames(X2) <- c("trend","newbaseline_prob")
colnames(X2)

vars_prep <- adoptData[,c("tStart", "tStop", "eventAdopt")]
combined_mat <- cbind(X2,vars_prep)
big_mat <- cbind(N,vars_prep)

mod1 <- coxph(Surv(tStart, tStop, eventAdopt) ~ newbaseline_prob,
              data=adoptData)
summary(mod1)
mod1$loglik

mod12 <- coxph(Surv(tStart, tStop, eventAdopt) ~ .- tStart - tStop - eventAdopt,
              data=combined_mat)
summary(mod12)

detach(adoptData)

# mod <- coxph(Surv(tStart, tStop, eventAdopt) ~  .- memberID- friendID- bandID- weekID- eventAdopt- tStart- tStop -trend,
#              data=adoptData)
mod2 <- coxph(Surv(tStart, tStop, eventAdopt) ~  .- memberID- friendID- bandID- weekID- eventAdopt- tStart- tStop,
             data=adoptData)
summary(mod2)

mod2$loglik
ll_r <- mod2$loglik[2]

mod3 <- coxph(Surv(tStart, tStop, eventAdopt) ~ X,
              data=adoptData)
summary(mod3)
mod3$loglik
ll_ur <- mod3$loglik[2]

mod4 <- coxph(Surv(tStart, tStop, eventAdopt) ~ .- tStart - tStop - eventAdopt,
              data=big_mat)
summary(mod4)
mod4$loglik
ll_ur <- mod4$loglik[2]

likelihood_ratio_test <- -2*(ll_r-ll_ur)
LR_test_result <- 1-pchisq(likelihood_ratio_test,12)
LR_test_result

#------------------------ try out parametric & non-parametric --------------------------
# prepare X matrix with time invariant variables 
X_invar <- X[adoptData$eventAdopt==1,c(2,4:15)]
dim(X_invar)
sum(X_invar[,2])

time <- adoptData$tStop[adoptData$eventAdopt==1]
event <- adoptData$eventAdopt[adoptData$eventAdopt==1]

summary(time)
summary(event)
summary(X_invar)

# Kaplan-Meier non-parametric analysis
kmsurvival <- survfit(Surv(time,event) ~ 1)
summary(kmsurvival)
plot(kmsurvival, xlab="Time", ylab="Survival Probability")

# Nelson-Aalen non-parametric analysis
nasurvival <- survfit(coxph(Surv(time,event)~1), type="aalen")
summary(nasurvival)
plot(nasurvival, xlab="Time", ylab="Survival Probability")

## Exponential, Weibull, and log-logistic parametric model coefficients
# Opposite signs from Stata results, Weibull results differ; same as SAS
exponential <- survreg(Surv(time,event) ~ X_invar, dist="exponential")
summary(exponential)

weibull <- survreg(Surv(time,event) ~ X_invar, dist="weibull")
summary(weibull)

loglogistic <- survreg(Surv(time,event) ~ X_invar, dist="loglogistic")
summary(loglogistic)

? survfit.coxph
? survfit.object
                 
survfit(mod1, newdata=data.frame(newbaseline_prob=0.3))
plot(survfit(mod1, newdata=data.frame(newbaseline_prob=0.3)), ylab="Survival", conf.int=F)
lines(survfit(mod1, newdata=data.frame(newbaseline_prob=0.6)), ylab="Survival", conf.int=F)

x <- survfit(fit, newdata = mydata)
mytry <- summary(x)$table
mytry
mytry[,"*rmean"]                                  # prediction for each obs ?

predict(mod1,newdata=list(tStart = 1, tStop = 2, eventAdopt = 1, newbaseline_prob=1), type ="expected")

predict(mod12,newdata=list(tStart = 1, tStop = 2, eventAdopt = 1, newbaseline_prob=1, trend = 1), type ="expected")

cumu_hazard <- predict(mod1,newdata=list(tStart = 1, tStop = 2, eventAdopt = 1, newbaseline_prob=mean(X[,3])), type ="expected")
surv <- exp(-cumu_hazard)

# colnames(X) <- c("trend", "memberAdopt", "newbaseline_prob", "Innov_m", "Innov_m2", "Innov_f", "Innov_f2",
#                 "Innov_m*Innov_f", "(Innov_m*Innov_f)2", "Explor_m", "Explor_m2", "Explor_f", "Explor_f2",
#                 "Explor_m*Explor_f", "(Explor_m*Explor_f)2","memberAdopt*Innov_m", "memberAdopt*Innov_m2", 
#                 "memberAdopt*Innov_f", "memberAdopt*Innov_f2", "memberAdopt*Innov_m*Innov_f", "memberAdopt*(Innov_m*Innov_f)2",
#                 "memberAdopt*Explor_m", "memberAdopt*Explor_m2", "memberAdopt*Explor_f", "memberAdopt*Explor_f2", 
#                 "memberAdopt*`Explor_m*Explor_f", "memberAdopt*(Explor_m*Explor_f)2")

SI <- 1
# Innovm_score = mean(X[,4])
Innovm_score = 2
Innovf_score = mean(X[,6])
explorm_score = mean(X[,10])
explorf_score = mean(X[,12])

cumu_hazard <- predict(mod4,newdata=list(tStart = 50, tStop = 61, eventAdopt = 1, 
                          trend = mean(X[,1]), memberAdopt= SI, newbaseline_prob= mean(X[,3]), Innov_m = Innovm_score, Innov_m2 = Innovm_score^2, Innov_f= Innovf_score, Innov_f2= Innovf_score^2, V8 = Innovm_score*Innovf_score, V9= Innovm_score^2*Innovf_score^2,
                          Explor_m= explorm_score, Explor_m2=explorm_score^2, Explor_f=explorf_score, Explor_f2=explorf_score^2, V14=explorm_score*explorf_score, V15=explorm_score^2*explorf_score^2, V16 = SI*Innovm_score, V17=SI*Innovm_score^2, 
                          V18 = SI*Innovf_score, V19=SI*Innovf_score^2, V20 = SI*Innovm_score*Innovf_score, V21 = SI*Innovm_score^2*Innovf_score^2,
                          V22 = SI*explorm_score, V23 = SI*explorm_score^2, V24 = SI*explorf_score, V25 = SI*explorf_score^2, 
                          V26 = SI*explorm_score*explorf_score, V27 = SI*explorm_score^2*explorf_score^2), type ="expected")
cumu_hazard
surv <- exp(-cumu_hazard)
surv

cumu_hazard_list <- c()
max(big_mat$tStop)
for (t in 1:max(big_mat$tStop)){
  cumu_hazard <- predict(mod4,newdata=list(tStart = t, tStop = t+1, eventAdopt = 1, 
                                           trend = mean(X[,1]), memberAdopt= SI, newbaseline_prob= mean(X[,3]), Innov_m = Innovm_score, Innov_m2 = Innovm_score^2, Innov_f= Innovf_score, Innov_f2= Innovf_score^2, V8 = Innovm_score*Innovf_score, V9= Innovm_score^2*Innovf_score^2,
                                           Explor_m= explorm_score, Explor_m2=explorm_score^2, Explor_f=explorf_score, Explor_f2=explorf_score^2, V14=explorm_score*explorf_score, V15=explorm_score^2*explorf_score^2, V16 = SI*Innovm_score, V17=SI*Innovm_score^2, 
                                           V18 = SI*Innovf_score, V19=SI*Innovf_score^2, V20 = SI*Innovm_score*Innovf_score, V21 = SI*Innovm_score^2*Innovf_score^2,
                                           V22 = SI*explorm_score, V23 = SI*explorm_score^2, V24 = SI*explorf_score, V25 = SI*explorf_score^2, 
                                           V26 = SI*explorm_score*explorf_score, V27 = SI*explorm_score^2*explorf_score^2), type ="expected")
  cumu_hazard_list <- c(cumu_hazard_list, cumu_hazard)
}

surv_list <- exp(-cumu_hazard_list)

plot(surv_list)
summary(surv_list)

write.csv(cumu_hazard_list, file = "cumu_hazard_list.csv",row.names=FALSE)

# review data to see whether data definition criteria results in systematic structure in the distribution of T 
adopt_T_ind <- which(adoptData$eventAdopt==1)
adopt_T <- adoptData$tStart[adopt_T_ind]
summary(adopt_T)
hist(adopt_T)


