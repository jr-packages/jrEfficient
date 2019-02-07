## ----echo=FALSE----------------------------
library(tufte)
knitr::opts_chunk$set(results = "SHOW", echo = TRUE)

## ----echo=TRUE-----------------------------
library("bench")

## ----practical1, cache=TRUE, echo = TRUE----
N = 1e5
m = as.data.frame(matrix(runif(N), ncol=1000))
write.csv(m, file="example.csv", row.names=FALSE)

## ----cache=TRUE, echo = TRUE---------------
dd = read.csv("example.csv")

## ----cache=TRUE, echo = TRUE---------------
system.time(read.csv("example.csv"))

## ----cache=TRUE,results='hide', tidy=FALSE, echo = TRUE----
read.csv(file="example.csv",
         colClasses=rep("numeric", 1000))

## ----cache=TRUE, results="hide", echo = TRUE----
saveRDS(m, file="example.RData")
readRDS(file="example.RData")

## ----eval=FALSE, echo = TRUE---------------
#  install.packages("readr")

## ---- echo = TRUE, eval= FALSE-------------
#  library("readr")

## ----  eval=FALSE, tidy=TRUE---------------
#  ## 1. Using RData files is the fastest -
#  ## although you have to read the data in first.
#  ## Set colClasses also produces an good speed-up.
#  
#  ##2. Setting colClasses R is no longer checking your data types.
#  ## If your data is changing - for example it's coming from the web
#  ## or a database, this may be problem.
#  
#  ##3. The results do depend on the number of columns, as this code demonstrates
#  N = c(1, 10, 100, 1000, 1000, 10000)
#  l = numeric(5)
#  for(i in seq_along(N)){
#    m = as.data.frame(matrix(runif(N[6]), ncol=N[i]))
#    write.csv(m, file="example.csv", row.names=FALSE)
#    cc = rep("numeric", N[i])
#    l[i] = system.time(
#      read.csv("example.csv", colClasses=cc))[3]
#  }
#  l
#  
#  ## Notice that when we have a large number of columns,
#  ## we get a slow down in reading in data set (even though
#  ## we have specified the column classes). The reason for
#  ## this slow down is that we are creating a data frame
#  ## and each column has to be initialised with a particular class.

## ---- echo = TRUE--------------------------
##For fast computers
#d_m = matrix(1:1000000, ncol=1000)
##Slower computers
d_m = matrix(1:10000, ncol=100)
dim(d_m)

## ---- echo = TRUE--------------------------
d_df = as.data.frame(d_m)
colnames(d_df) = paste0("c", 1:ncol(d_df))

## ----results='hide', tidy=FALSE, echo = TRUE----
mark(d_m[1,], d_df[1,], d_m[,1], d_df[,1],
     relative = TRUE, 
     check = FALSE)

## ----  tidy=TRUE---------------------------
## Two things are going on here
## 1. The very large difference when selecting columns and rows (in data frames)
## is because the data is stored in column major-order. Although the matrix is also stored in column major-order, because everything is the same type, we can efficiently select values.

##2. Matrices are also more memory efficient:
m = matrix(runif(1e4), ncol=1e4)
d = data.frame(m)
object.size(m)
object.size(d)

## ----results='hide', echo = TRUE-----------
d_df$c10
d_df[,10]
d_df[,"c10"]
d_df[,colnames(d_df) == "c10"]

## ---- eval=FALSE---------------------------
#  mark(d_df$c10,
#       d_df[,10],
#       d_df[,"c10"],
#       d_df[,colnames(d_df) == "c10"],
#       iterations = 10000,
#       relative = TRUE)
#  
#  m = matrix(1:100000000, ncol=10000)
#  dim(m)
#  
#  mark(m[,1], m[1,],
#       iterations = 10000,
#       relative = TRUE)

## ----echo=FALSE----------------------------
n = 1

## ----tidy=FALSE, echo = TRUE---------------
a = NULL
for(i in 1:n)
  a = c(a, 2 * pi * sin(i))

## ----cache=TRUE, tidy=FALSE, echo = TRUE----
n = 1e6
## Example 1
I = 0
for(i in 1:n) {
  10
  I = I + 1
}
## Example 2
I = 0
for(i in 1:n){
  ((((((((((10))))))))))
  I = I + 1
}
## Example 3
I = 0
for(i in 1:n){
  ##This is a comment
  ##But it is still parsed
  ##So takes time
  ##But not a lot
  ##So don't worry!
  10
  I = I + 1
}

## ----results='hide', echo = TRUE-----------
library("parallel")
detectCores()

## ----eval=FALSE, echo = TRUE---------------
#  library("jrEfficient")
#  vignette("solutions1", package="jrEfficient")

