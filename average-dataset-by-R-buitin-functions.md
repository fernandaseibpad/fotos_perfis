Different ways and time required to calculate mean of a dataset with R
buit-in functions
================

Let \(x_i = (x_{i1}, x_{i2}, ..., x_{id}), 1 \leq i \leq n = 150\)
(nrow(iris)), \(1 \leq d \leq 4\) (ncol(iris)) be each object of the
iris dataset. The mean of the dataset is defined as

\[ \frac{\sum_{i = 1}^n x_i}{n} = \frac{\sum_{i = 1}^n(x_{i1}, x_{i2}, x_{i3}, x_{i4})}{n} \]

``` r
mean.by.column = function(X){
    v.mean = c()
    for (i in 1:ncol(X)){
        v.mean[i] = mean(X[, i])
    }
    names(v.mean) = names(X)
    v.mean
}
```

``` r
mean.by.sum.nrow = function(X){
    v.mean = c()
    for (i in 1:ncol(X)){
        v.mean[i] = sum(X[, i])/nrow(X)
    }
    names(v.mean) = names(X)
    v.mean
}
```

## Time required to compute each function

### Using the rbenchmark package

``` r
library(rbenchmark)
```

``` r
time_required = function(X){
    out = list()
    time = benchmark("colMeans" = {
            out$colmeans = colMeans(X)
          },
          "colSums/nrow" = {
            out$colsums = colSums(X)/nrow(X)
          },
          "apply" = {
            out$apply = apply(X, 2, mean)
          },
          "mean.by.column" = {
            out$mean1 = mean.by.column(X)
          },
          "mean.by.sum.nrow" = {
            out$mean2 = mean.by.sum.nrow(X)
          },
          replications = 1000,
          columns = c("test", "replications", "elapsed",
                      "relative", "user.self", "sys.self"))
    out$time = time[order(time$elapsed), ]
    out
}    
```

### Mean of the iris dataset

``` r
result = time_required(iris[, -5])

knitr::kable(result$time)
```

|   | test             | replications | elapsed | relative | user.self | sys.self |
| :- | :--------------- | -----------: | ------: | -------: | --------: | -------: |
| 2 | colSums/nrow     |         1000 |    0.05 |      1.0 |      0.03 |        0 |
| 5 | mean.by.sum.nrow |         1000 |    0.05 |      1.0 |      0.05 |        0 |
| 4 | mean.by.column   |         1000 |    0.06 |      1.2 |      0.06 |        0 |
| 1 | colMeans         |         1000 |    0.08 |      1.6 |      0.08 |        0 |
| 3 | apply            |         1000 |    0.11 |      2.2 |      0.11 |        0 |

### Mean of the wine dataset

``` r
wine.uci = read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data", header = FALSE)
```

``` r
knitr::kable(time_required(wine.uci[, -1])$time)
```

|   | test             | replications | elapsed | relative | user.self | sys.self |
| :- | :--------------- | -----------: | ------: | -------: | --------: | -------: |
| 2 | colSums/nrow     |         1000 |    0.09 |    1.000 |      0.10 |     0.00 |
| 1 | colMeans         |         1000 |    0.11 |    1.222 |      0.11 |     0.00 |
| 5 | mean.by.sum.nrow |         1000 |    0.14 |    1.556 |      0.14 |     0.00 |
| 4 | mean.by.column   |         1000 |    0.16 |    1.778 |      0.16 |     0.00 |
| 3 | apply            |         1000 |    0.22 |    2.444 |      0.20 |     0.02 |

### Mean of the breast cancer dataset

``` r
breast.cancer.uci = read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer-wisconsin/wdbc.data", header = FALSE)
```

``` r
knitr::kable(time_required(breast.cancer.uci[,-2])$time)
```

|   | test             | replications | elapsed | relative | user.self | sys.self |
| :- | :--------------- | -----------: | ------: | -------: | --------: | -------: |
| 2 | colSums/nrow     |         1000 |    0.22 |    1.000 |      0.22 |        0 |
| 1 | colMeans         |         1000 |    0.25 |    1.136 |      0.25 |        0 |
| 5 | mean.by.sum.nrow |         1000 |    0.36 |    1.636 |      0.36 |        0 |
| 4 | mean.by.column   |         1000 |    0.37 |    1.682 |      0.38 |        0 |
| 3 | apply            |         1000 |    0.67 |    3.045 |      0.67 |        0 |

## Considerations:

  - The function **mean.by.column** that calculates the mean of each
    column inside a *for* was faster than using the **apply** function.
  - The functions **mean.by.sum.nrow** and **colSums/nrow** were faster
    than the **colMeans** function.
