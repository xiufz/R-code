# 函数

##1.1函数的编写
               ##找出一个向量中奇数的个数##
odd<-function(x,narm=T) 
               ##默认制定narm的值为T
{
  x<-round(x)  ##round x into "integer"(numeric indeed)
  k<-sum(x%%2,na.rm=narm)
  return(k)    ##用return返回需要输出的对象，可以使任意对象；当不用return时，
               ##函数自动返回最后一个表达式的值;当执行完return()跳过后续程序；
}              ##当需要返回多个对象时，可用列表输出
               ##当函数没有命名时为匿名函数，如：plot(function(x) sin(2*x),0,2*pi)
x<-c(pi,2,3,1,1.5,NA)
odd(x)         ##当不指定narm的值时，narm默认为T

##1.2 观察函数的形参和函数体
args(odd)      ##直接观察（部分）形参
formals(odd)   ##同上
formalArgs(odd)
body(odd)      ##观察函数体
page(odd)      ##打开函数代码
edit(odd)      ##编辑函数

##1.3 函数作为一种对象

###函数与绘图
sin2<-function(x) sin(2*x)
               ##先自定义一个函数
funs<-c(sin,cos,sin2)
class(funs)    ##构建一个函数列表！
plot(c(0,2*pi),c(-1,1),col="white")
               ##预先绘制一幅空白图
for(k in 1:length(funs))
{
  fun<-funs[[k]] ##注意此处用的是列表的调用方法
  plot(fun,0,2*pi,col=k,add=T)
               ##plot的直接函数绘图方法，后面0,2*pi指定横轴范围，add=T指定
               ##是否添加当前图上
}

###函数的直接赋值
body(sin2)<-quote(sin(3*x))
               ##用quote将sin(3*x)作为函数表达式赋给sin2的函数体
sin2(pi/6)

##2.1 环境和变量作用域
               ##说明：
               ##函数内部变量为局部变量，外部变量为全局变量。在函数体中，若变量
               ##没有输出，则用完即废，不再存在函数外层环境中。编制函数时，遵循
               ##先内后外的原则，即先调用内层的局部变量，当内层没有局部变量时调
               ##用外层定义的全局变量。
               ##函数作为一个对象，在函数内部仍然可以再定义子函数！

###case 1:全局变量在函数内部调用 
rm(list=ls())
w<-10          ##定义全局变量
fun1<-function(y) w+y #直接调用全局变量w
fun1(2)

###case 2:全局变量与局部变量发生冲突时
d<-5           ##外部定义一个全局变量
fun2<-function(y)
{
  d<-8         ##d在此处是一个局部变量，但相对于函数fun3来说是全局变量
  fun3<-function() d*(w+y)
  print(environment(fun3))  ##观察函数fun3的环境（局部or全局）
  list1<-list(ls())         ##观察内层中对象
  return(list(list1,fun3()))
}
fun2(10)       ##理论值160，而不是100
print(environment(fun2))
ls()           ##观察外层中的对象

###case 3:调用的形参为已经定义的实际参数
rm(list=ls())
fun<-function(x,fun1)
{
  print(environment(fun1))  ##此处fun1事先定义,实际为全局变量
  fun1(x)       
}
fun1<-function(x) sin(2*x)
fun(pi/4,fun1)

##2.2 关于ls()函数
              ##ls()在没有指定环境时列出当前环境中的局（全）部变量，当指定环境时列出
              ##指定环境中的局（全）部变量
rm(list = ls())
d<-1
fun<-function()
{
  y<-1
  cat("当前局部变量：",ls(),"\n") ##打印当前环境中的变量，注意使用print函数
  cat("上一层变量(全局)变量：",ls(envir = parent.frame(n=1)),"\n")
              ##parent.frame(n=1)用于返回上一级的环境，n用于指定返回级数。
}
fun()

##2.3 全局变量的修改
              ##当局部变量与全局变量值相同时两者共用一个内存地址，否则为
              ##局部变量新指定一个位置


###case 1:使用超赋值符赋值
rm(list = ls())
d<-1
x<-2
fun<-function(z)
{
  x<-x+1      ##普通赋值符赋值只在当前环境中有效
  d<<-d+1     ##超赋值符可向上搜寻变量，直到搜寻到第一个同名变量时赋值
  z<<-z+1     ##若上级环境中没有同名变量，则在全局变量中新创建同名变量
}
z             ##未调用函数时当前环境中没有变量z
fun(3)
x             ##x=2
d             ##d=1+1
z             ##z=3+1

###case 2:使用assign赋值
rm(list = ls())
fun<-function(x)
{
  assign("x",2*x,pos = .GlobalEnv)
              ##直接指定赋值环境
  z<-x+1
}
z<-2
fun(z)
x
z

##2.4 闭包
             ##闭包包含了函数的参数、函数体以及调用的环境！
rm(list = ls())
f<-function()
{
  x<-0
  ff<-function()
  {
   x<<-x+1  ##只比ff()函数高一层，赋值给f1,f2时被打包成不同的闭包
    cat("当前局部变量：",x,"\n") 
  }
  return(ff)
}
f1<-f()      ##返回对象为函数，存储在不同的内存位置，形成不同的环境
f2<-f()
f1()         ##观察f1()形成的闭包
environment(f1)
environment(f2)

f1()
f1()
f2()
f2()
assign("x",10,pos = environment(f1))
            ##对指定函数环境中的变量直接赋值
get("x",envir = environment(f1))
            ##观察赋值后变量的assign("x",10,pos = environment(f1))
f1()

##2.5 递归
            ##递归允许函数在内部调用本身,类似于数学归纳法
###case 1: 1+2+3+...+n
resum<-function(n)
{
  if(n==1) return(n) else return(n+resum(n-1))
}

###case 2: 求向量中的最大值
remax<-function(x)
{
  if(length(x)==1) return(x) else{
    return(max(x[1],x[2:length(x)]))
  }
}

###case :快速排序(quicksort)
            ##原理：先任取向量x中的一个数y，将x分为两个子向量，一个全部大于y
            ##另一个子向量所有元素小于y。一直重复该步骤直到所有子向量长度为1
qs<-function(x,count=0)
{
  if(length(x)<=1) return(x)
            ##当向量x长度小于等于1时终止递归，并返回x
  pivot<-x[1]##取第一个数作为分隔数
  rest<-x[-1]
  sv1<-rest[rest<pivot];print(sv1)
  sv2<-rest[rest>=pivot];print(sv2)
  sv1<-qs(sv1)##递归部分
  sv2<-qs(sv2)
  return(c(sv1,pivot,sv2))
            ##将子向量重新组合
}
x<-c(5,4,12,13,3,8,18)
qs(x)

##2.6 二元运算符
            ##%str%定义二元运算符，返回相同类型的值
"%symdiff%"<-function(x,y)
{
  xdy<-setdiff(x,y)
  ydx<-setdiff(y,x)
  return(union(xdy,ydx))
}           ##定义对称差集,因为含有特殊符号，所以必须带冒号。
x<-c(1,2,5)
y<-c(2,5,8,9)
x%symdiff%y





