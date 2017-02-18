#1. 调试
    ##基本原则：由易到难；随时观察；模块化编程

##stopufnot, print/cat等
x<-3
stopifnot(x<2)
    ##如果非真，则停止运行
    ##调用print/cat函数观察输出的结果

##debug()/browser
    ##debug(fun)使函数fun进入调试状态，当下一次调用debug函数时进行调试
    ##调试时输入n表示next，执行下一条语句；c表示countinue表示执行下一段语句
    ##如执行完后续函数体部分、后续循环部分等。若要观察变量n，可用print(n)
    ##Q： quit
resum<-function(n)
{
  if(n==1) return(n) else return(n+resum(n-1))
}
debug(resum)
resum(5)

s<-0
for(k in 1:5) 
{
  browser() 
  ##brower()函数可以放在任意位置，当执行完函数或循环体时退出  
  s<-s+k
  browser(s>3)s
  ##当满足一定条件时调试，等价于if(s>3) browser()
} 

##setBreakpoint()
    ##setBreakpoint("filename",linenumber)
    ##设置断点，无需对源程序进行修改；指定源序文件和开始设置断点的行数
    ##需要先用source()调用源程序（调用即执行，所以最好是函数文件）
    ##以debug_test.R为例
source("debug_test.R")
setBreakpoint("debug_test.R",3)
debug_test()
    ##每按一次enter,执行前面browser[d]的语句
    ##当遇到错误时跳出,或者用Q退出

###也可以用Rstudio里面的debug

#2. 内存与运行

    ##基本原则
    ##预先分配空间、向量化运算、减少向量赋值、慎用c(r)bind函数
    ##内存与计算时间不可兼得

##case 1:向量化运算与循环比较
    ##问题：现有两个装有颜色不同的小球的袋子，袋子1中10蓝8红，袋子2中6蓝6红
    ##问：从袋1中取一个球到袋2中，再从袋2中取一个球出来，求该球时蓝球的概率


ball1<-function(nreps)
{
  count<-0 ##去除蓝球的次数
  for(k in 1:nreps)
  {
    nb1<-10##袋1中蓝球个数
    n1<-18##袋1中 球总个数
    nb2<-6##袋2中原来蓝球的个数
    n2<-13##袋2中放入新球后的总个数
    if(runif(1)<=nb1/n1) nb2<-nb2+1
    ##计算概率的方法，若if成立，则取出的记为蓝球，nb2加1
    if(runif(1)<=nb2/n2) count<-count+1
  }
  return(count/nreps)
}

ball2<-function(nreps)
{
  count<-0
  nb1<-10##袋1中蓝球个数
  n1<-18##袋1中 球总个数
  nb2<-6##袋2中原来蓝球的个数
  n2<-13##袋2中放入新球后的总个数
  u<-matrix(runif(2*nreps),nrow = nreps)
    ##一次性产生2*nreps个数,第一列第一个袋子，第二列第二个袋子
  mean(u[,1]<=nb1/n1&u[,2]<=(nb2+1)/n2|u[,1]>nb1/n1&u[,2]<=nb2/n2)
    ##运用逻辑运算实现向量化
}

system.time(
  ball1(100000)
)
system.time(
  ball2(100000)
)

##使用Rprof()计算运行时间
Rprof()
    ##启动监视器
invisible(ball1(1000000))
    ##抑制结果显示，包含调用的函数、各函数运行时间等
Rprof(NULL)
    ##关闭监视器
summaryRprof()
    ##监视报告

Rprof()
invisible(ball2(1000000))
Rprof(NULL)
summaryRprof()

##字节码编译
    ##可用字节码编译加快编译时间
library(compiler)
cpball1<-cmpfun(ball1)
system.time(
  cpball1(1000000)
)   ##加快了计算时间，但仍然无法与向量化计算相比