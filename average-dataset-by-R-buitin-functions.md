<h1 style="color:slateblue;font-family:courier;">Different ways and time required to calculate mean of a dataset with R buit-in functions</h1>

<h2 style="color:slateblue;font-family:courier;">Let $x_i = (x_{i1}, x_{i2}, ..., x_{id}), 1 \leq i \leq n = 150$ (nrow(iris)), $1 \leq d \leq 4$ (ncol(iris)) be each object of the iris dataset. The mean of the dataset is defined as  </h2>

$$ \frac{\sum_{i = 1}^n x_i}{n} = \frac{\sum_{i = 1}^n(x_{i1}, x_{i2}, x_{i3}, x_{i4})}{n} $$


```R
mean.by.column = function(X){
    v.mean = c()
    for (i in 1:ncol(X)){
        v.mean[i] = mean(X[, i])
    }
    names(v.mean) = names(X)
    v.mean
}
```


```R
mean.by.sum.nrow = function(X){
    v.mean = c()
    for (i in 1:ncol(X)){
        v.mean[i] = sum(X[, i])/nrow(X)
    }
    names(v.mean) = names(X)
    v.mean
}
```

<h2 style="color:slateblue;font-family:courier;">Time required to compute each function</h2>

<h3 style="color:slateblue;font-family:courier;">Using the rbenchmark package</h3>


```R
#install.packages("rbenchmark")
library(rbenchmark)
```


```R
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


```R
result = time_required(iris[, -5])
result$time
```


<table>
<thead><tr><th></th><th scope=col>test</th><th scope=col>replications</th><th scope=col>elapsed</th><th scope=col>relative</th><th scope=col>user.self</th><th scope=col>sys.self</th></tr></thead>
<tbody>
	<tr><th scope=row>4</th><td>mean.by.column  </td><td>1000            </td><td>0.11            </td><td>1.000           </td><td>0.11            </td><td>0.00            </td></tr>
	<tr><th scope=row>5</th><td>mean.by.sum.nrow</td><td>1000            </td><td>0.14            </td><td>1.273           </td><td>0.14            </td><td>0.00            </td></tr>
	<tr><th scope=row>3</th><td>apply           </td><td>1000            </td><td>0.22            </td><td>2.000           </td><td>0.21            </td><td>0.01            </td></tr>
	<tr><th scope=row>2</th><td>colSums/nrow    </td><td>1000            </td><td>0.25            </td><td>2.273           </td><td>0.25            </td><td>0.00            </td></tr>
	<tr><th scope=row>1</th><td>colMeans        </td><td>1000            </td><td>0.29            </td><td>2.636           </td><td>0.29            </td><td>0.00            </td></tr>
</tbody>
</table>




```R
wine.uci = read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data", header = FALSE)
```


```R
time_required(wine.uci[, -1])$time
```


<table>
<thead><tr><th></th><th scope=col>test</th><th scope=col>replications</th><th scope=col>elapsed</th><th scope=col>relative</th><th scope=col>user.self</th><th scope=col>sys.self</th></tr></thead>
<tbody>
	<tr><th scope=row>2</th><td>colSums/nrow    </td><td>1000            </td><td>0.28            </td><td>1.000           </td><td>0.28            </td><td>0.00            </td></tr>
	<tr><th scope=row>5</th><td>mean.by.sum.nrow</td><td>1000            </td><td>0.29            </td><td>1.036           </td><td>0.30            </td><td>0.00            </td></tr>
	<tr><th scope=row>4</th><td>mean.by.column  </td><td>1000            </td><td>0.38            </td><td>1.357           </td><td>0.38            </td><td>0.00            </td></tr>
	<tr><th scope=row>1</th><td>colMeans        </td><td>1000            </td><td>0.41            </td><td>1.464           </td><td>0.41            </td><td>0.00            </td></tr>
	<tr><th scope=row>3</th><td>apply           </td><td>1000            </td><td>0.53            </td><td>1.893           </td><td>0.52            </td><td>0.01            </td></tr>
</tbody>
</table>




```R
breast.cancer.uci = read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer-wisconsin/wdbc.data",
              header = FALSE)
```


```R
time_required(breast.cancer.uci[,-2])$time
```


<table>
<thead><tr><th></th><th scope=col>test</th><th scope=col>replications</th><th scope=col>elapsed</th><th scope=col>relative</th><th scope=col>user.self</th><th scope=col>sys.self</th></tr></thead>
<tbody>
	<tr><th scope=row>2</th><td>colSums/nrow    </td><td>1000            </td><td>0.57            </td><td>1.000           </td><td>0.56            </td><td>0.00            </td></tr>
	<tr><th scope=row>5</th><td>mean.by.sum.nrow</td><td>1000            </td><td>0.73            </td><td>1.281           </td><td>0.72            </td><td>0.00            </td></tr>
	<tr><th scope=row>1</th><td>colMeans        </td><td>1000            </td><td>0.75            </td><td>1.316           </td><td>0.69            </td><td>0.05            </td></tr>
	<tr><th scope=row>4</th><td>mean.by.column  </td><td>1000            </td><td>1.01            </td><td>1.772           </td><td>0.99            </td><td>0.00            </td></tr>
	<tr><th scope=row>3</th><td>apply           </td><td>1000            </td><td>1.25            </td><td>2.193           </td><td>1.20            </td><td>0.01            </td></tr>
</tbody>
</table>



<h2 style="color:slateblue;font-family:courier;">Considerations:</h2>

<ul style="font-size:20px;font-family:courier;">
  <li>The function <b>mean.by.column</b> that calculates the mean of each column inside a <i>for</i> was faster than using the <b>apply</b> function.</li>
    <li>The functions <b>mean.by.sum.nrow</b> and <b>colSums/nrow</b> were faster than the <b>colMeans</b> function.</li>
</ul> 
