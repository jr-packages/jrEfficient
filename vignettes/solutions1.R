## ----echo=FALSE----------------------------------------------------------
results='show';echo=TRUE

## ----setup, include=FALSE, cache=FALSE----------
library(knitr)
opts_knit$set(out.format = "latex")
knit_theme$set(knit_theme$get("greyscale0"))

options(replace.assign=FALSE,width=50)

opts_chunk$set(fig.path='figure/graphics-', 
               cache.path='cache/graphics-', 
               fig.align='center', 
               dev='pdf', fig.width=5, fig.height=5, 
               fig.show='hold', cache=FALSE, par=TRUE)
knit_hooks$set(crop=hook_pdfcrop)

knit_hooks$set(par=function(before, options, envir){
  if (before && options$fig.show!='none') {
    par(mar=c(3,3,2,1),cex.lab=.95,cex.axis=.9,
        mgp=c(2,.7,0),tcl=-.01, las=1)
  }}, crop=hook_pdfcrop)

## ----eval=FALSE, tidy=FALSE---------------------
#  install.packages("drat")

## ----eval=FALSE, tidy=FALSE---------------------
#  drat::addRepo("rcourses")
#  install.packages("nclRefficient", type="source")

## -----------------------------------------------
library("nclRefficient")

## ----echo=TRUE----------------------------------
library("rbenchmark")

## ----cache=TRUE, echo=echo, results=results, eval=echo----
system.time(read.csv("example.csv"))

## ----eval=FALSE---------------------------------
#  install.packages("readr")

## -----------------------------------------------
library("readr")

## ----echo=echo, results=results, eval=FALSE, tidy=TRUE----
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

## -----------------------------------------------
##For fast computers
#d_m = matrix(1:1000000, ncol=1000)
##Slower computers
d_m = matrix(1:10000, ncol=100)
dim(d_m)

## -----------------------------------------------
d_df = as.data.frame(d_m)
colnames(d_df) = paste0("c", 1:ncol(d_df))

## ----results='hide', tidy=FALSE-----------------
benchmark(replications=1000, 
          d_m[1,], d_df[1,], d_m[,1], d_df[,1],
          columns=c("test", "elapsed", "relative"))

## ----echo=echo, results=results, tidy=TRUE------
## Two things are going on here
## 1. The very large difference when selecting columns and rows (in data frames) 
## is because the data is stored in column major-order. Although the matrix is also stored in column major-order, because everything is the same type, we can efficiently select values.

##2. Matrices are also more memory efficient: 
m = matrix(runif(1e4), ncol=1e4)
d = data.frame(m)
object.size(m)
object.size(d)

## ----results='hide'-----------------------------
d_df$c10
d_df[,10]
d_df[,"c10"]
d_df[,colnames(d_df) == "c10"]

## ----echo=FALSE, eval=FALSE---------------------
#  benchmark(replications=10000,
#            d_df$c10, d_df[,10], d_df[,"c10"],d_df[,colnames(d_df) == "c10"],
#            columns=c("test", "elapsed", "relative"))
#  
#  m = matrix(1:100000000, ncol=10000)
#  dim(m)
#  
#  benchmark(replications=10000,
#            m[,1], m[1,], columns=c("test", "elapsed", "relative"))

## ----echo=FALSE---------------------------------
n = 1

## ----tidy=FALSE---------------------------------
a = NULL
for(i in 1:n)
  a = c(a, 2 * pi * sin(i))

## ----results='hide'-----------------------------
library("parallel")
detectCores()

## ----eval=FALSE---------------------------------
#  library("nclRefficient")
#  vignette("solutions1", package="nclRefficient")

