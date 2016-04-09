# compute s^2 by hand
x <- c(1.20, 1.50, 1.68, 1.89, 0.95, 1.49, 1.58, 1.55, 0.50, 1.09)
x_bar <- mean(x)
1/(length(x)-1)*sum((x-x_bar)^2)
var(x)