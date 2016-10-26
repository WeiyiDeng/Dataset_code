set.seed(1)
x1 <- runif(100)
x2 <- runif(100)
e <- rnorm(100,sd = sqrt(10))
cor(x1,x2)

square_x1 <- x1^2
square_x2 <- x2^2
cor(square_x1,x1)
cor(square_x2,x2)

product_x12 <- x1*x2
cor(product_x12,x1)
cor(product_x12,x2)

# or just
R <- cor(X)
R
VIF1 <- t(diag(solve(R)))
VIF1

b <- c(1,2,3,4,5)
dim(b) <- c(1,length(b))
X <- cbind(x1,x2,square_x1,square_x2,product_x12)
y <- X%*%t(b)#s+e

# run regression
mod1 <- lm(y ~ x1+x2+square_x1+square_x2+product_x12)
mod1
summary(mod1)

##
# std1
X_std <- matrix(0,nrow(X),ncol(X))
for (i in 1:ncol(X)){
  X_std[,i] <- (X[,i]-mean(X[,i]))/sd(X[,i])
}

R2 <- cor(X_std)
VIF2 <- t(diag(solve(R2)))
VIF2

mod2 <- lm(y ~ X_std)
mod2
summary(mod2)

##
# std2
std_x1 <- (x1-mean(x1))/sd(x1)
std_x2 <- (x2-mean(x2))/sd(x2)
std_square_x1 <- std_x1^2
std_square_x2 <- std_x2^2
std_product_x12 <- std_x1*std_x2
std_X <- cbind(std_x1,std_x2,std_square_x1,std_square_x2,std_product_x12)

R3 <- cor(std_X)
VIF3 <- t(diag(solve(R3)))
VIF3

mod3 <- lm(y ~ std_X)
mod3
summary(mod3)

##
const <- 5
x <- runif(100)
x <- ((x-mean(x))/sd(x)+1.3/4)*4

y <- const+2*x
mod <- lm(y ~ x)
summary(mod)

std_x <- (x-mean(x))/sd(x)
modstd <- lm(y ~ std_x)
summary(modstd)
