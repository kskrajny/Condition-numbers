# 1. generates some square matrices from normal distribution
# 2. counts condition numbers of matrices based on different norm
# 3. saves it to csv

# number of matrices
K<-10000

# size of matrix
N<-10

# normal distribution parameters
sd<-10
mean<-0

# containers for conditions
norm2_true_cond <- numeric(0)
norm2_cond <- numeric(0)
normF_cond <- numeric(0)
normO_cond <- numeric(0)
normM_cond <- numeric(0)

# main
for (i in 1:K) {
  A <- matrix( rnorm(N*N, mean, sd), N, N)
  AI <- solve(A)
  norm2_true_cond <- append(norm2_true_cond, kappa(A, exact = TRUE))
  norm2_cond <- append(norm2_cond, norm(A, '2')*norm(AI, '2'))
  normF_cond <- append(normF_cond, norm(A, 'F')*norm(AI, 'F'))
  normO_cond <- append(normO_cond, norm(A, 'O')*norm(AI, 'O'))
  normM_cond <- append(normM_cond, norm(A, 'M')*norm(AI, 'M'))
}

df<-data.frame(norm2_true_cond, norm2_cond, normF_cond, normO_cond, normM_cond)

write.csv(df, paste(getwd(), "/conditions.csv", sep=""), row.names = FALSE)
