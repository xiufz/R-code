##R 语言编程结构 2017-1-6
#####目录
##控制语句
###循环语句: for, while, repeat
###判断语句：if-else
##算数、关系与逻辑符

##控制语句

###循环语句: for, while, repeat
                          ##标量循环
for(k in c(3,2,4,1))
  print(k)                 
                           ##向量循环  
c1<-sample(10,5)
c2<-seq(1,10,length=5)    ##定义两个列向量，也可以为非向量元素
for(j in c("c1","c2"))      
{
  z<-get(j)               ##get函数：将j对指向的内容赋值给z
  print(sum(z))           ##或使用lapply函数
}                         
                         ## while语句
k<-1
while(TRUE)
{
 k<-k+2
 if(k>10)
 {
   print(k)
   break               ##直接跳出循环；此外还可用next跳过本层循环中剩余语句
 }                     ##直接进入下一次循环
}

j<-1
s<-1
repeat               ##repeat循环（无条件执行）
{
  s<-s*j
  j<-j+1
  if(s>1000)
  {
    print(c(j,s))
    break
  }
}

### if-else
s<-1
if(s>=0) print("Positive") else print("Negative")  ##单条语句单行格式

s<-1
if(s>=0) {print("Positive"); print(s+1)}else 
  print("Negative")      ##多条语句时需要用{}，并且
                         ##else必须紧邻在}之后。此外，一行若执行多条语句，用分号隔开

x<-2
y<-if(x==2) x else x+1   ##直接赋值
z<-ifelse(x==2,x,x+1)    ##紧凑格式

##算数、关系与逻辑符

10%/%3     ##整数除法
10%%3      ##模运算

x<-c(T,T,F)
y<-c(F,T,T)
sum(x)    ##逻辑值可直接做算术运算
x|y       ##向量或
x&y       ##向量与
(1>=2)||(1<=1) ##标量或
(1>=2)&&(1<=1) ##标量与
!2<=1     ##逻辑非，注意运算优先级


