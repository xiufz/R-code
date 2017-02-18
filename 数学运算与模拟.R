#数学运算与模拟

##1.1 数学函数

###四则运算
cumsum(1:3)          ##累加
prod(1:3)            ##连乘
factorial(3)         ##阶乘
cumprod(1:3)         ##累乘
round(pi)            ##四舍五入取整，可指定四舍五入保留的小数位数，默认为零（取整）
ceiling(pi)          ##向上取整
floor(sqrt(3))       ##向下取整

###集合运算
x<-c(1,2,5)
y<-c(2,5,8,9)
union(x,y)           ##并集
intersect(x,y)       ##交集
setdiff(x,y)         ##差集
setdiff(y,x)
setequal(x,y)        ##判断相等
2%in%x               ##是否属于
c(1,5)%in%x          ##向量化判断


###排序
x<-sample(c(3:10),5) ##从3到10之间选取不重复的5的整数
which.min(x)         ##确定最大最小数所在的位置
which.max(x)

sort(x)              ##对x进行排序，默认升序,返回排序后的值，不改变原向量
sort(x,decreasing = T)

order(x)             ##给出排序后的值在原向量中的位置，默认升序
order(x,decreasing = T)
                     ##order可用于给数据框排序，详见数据框
rank(c(5,3,5,4,2,3)) ##g给出向量的排位，如5出现两次，排第五和第六，取均值为5.5

xx<-matrix(sample(10),5);xx
pmin(xx[,1],xx[,2])  ##成对比较（注意多于两个向量比较时似乎有bug）

###排列组合
choose(5,4)          ##C(5,4)
choose(5,4)*factorial(4)##P(5,4)
combn(5,4)           ##5选4的组合情况

###微积分、优化部分

####求函数的零点
fun<-function(x) print(x)*(sin(x)-1) ##print便于观察取点位置
plot(fun,-pi,pi)
abline(h=0)          ##粗略观察
uniroot(fun,c(-1,1)) ##单根，复跟可用polyroot



####最大值最小值
fun<-function(x) x^2-sin(x)
plot(fun,-2,2)     ##预估最小值出现的区间
optimize(fun,c(-1,1)) ##找出最小值‘若要寻找最大值，可添加负号处理
                      ##一维优化用optimize，多维时可用optim()，nlm等函数
optimize(function(x) x^2*(print(x)-1),c(0,10))
                      ##观察取点的位置

####微分与积分
D(expression(sin(x^2)),"x") ##对x进行微分
integrate(function(x) exp(-x^2),-1,1) ##积分
                      ##此外odesolve包可以处理常微分方程，ryacas包可处理符号运算
##1.2 统计部分
                      ##更多分布可参见?distributions
                    
                      ##关于统计函数类型：
                      ##d: density(pdf);p: probability(cdf)
                      ##q: quantile;r: random number
                      ##关于函数分布：
                      ##norm: normal;t: student;f: F;chisq: chi-square
                      ##binom: binomial;exp:exponential;pois: poisson
rnorm(3)*2+1          ##产生3个N(1,4)分布的数
qnorm(c(0.925,0.975)) ##分位数，可向量化输入
                
set.seed(1)           ##设置随机数种子
#应用案例：选举委员会
                      ##20个代表中分别选取人数为3、4、5的三个委员会，
                      ##问A、B在一起的概率

###理论值
total<-choose(20,3)*choose(17,4)*choose(13,5)
together<-choose(18,1)*choose(17,4)*choose(13,5)+choose(16,3)*choose(18,2)*
  choose(13,5)+choose(15,3)*choose(12,4)*choose(18,3)
prob<-together/total;prob

###模拟
set.seed(100)         ##设定模拟随机种子
n<-10000             ##模拟次数
count<-0
for(k in 1:n)
{
  commt<-sample(20) 
  x<-commt[1:3]      ##三个委员会的组成情况
  y<-commt[4:7]
  z<-commt[8:12]
  if(prod(c(1:2)%in%x)==1)  
                     ##通过连乘判断A、B是否在该委员会
  { 
    count<-count+1
    next             ##如果在该委员会，则count+1，且直接进入下一次循环
  }else if(prod(c(1:2)%in%y)==1){
    count<-count+1
    next
  }else if(prod(c(1:2)%in%z)==1){
    count<-count+1
    next
  }
}
smprob<-count/n;smprob


