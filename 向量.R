##2016-12-9
##向量与矩阵

##向量的创建
c0<-vector(length=2)#预先声明向量长度，同时可以节省计算时间
c0[1]<-1#赋值，必须先给向量c0分配内存空间
c0[2]<-2
c1<-c(1:5,8,9)#创建向量用c()引出；步长为1可用冒号形式；向量默认为列向量
c2<-rep(1,times=7)#rep()表示重复，times用于指明重复次数，可省略，直接rep(1,7)
c2_1<-rep(c(1,2,3),each=2)#每个元素重复2次
c3<-c(0:100)/100*2*pi#创建等步长的向量
c3_1<-seq(0,100,length=100)#创建100个等差数据
c3_2<-seq(c3_1)#将c3_1中的数据“编号”
c3_2<-seq(0,100,by=2)#等步长生成法
c4<-paste("a",1:7,sep = ".")#字符串向量
#向量中的元素类型需保持一致，当出现不一致时按最低要求存储。

length(c3)#观察向量长度
c5<-c(1,2,3,NA,4)#NA为缺失值，但占储存位
length(c5)
mean(c5,na.rm = T)#当有数据有缺失值，计算时需要将其去掉。
c6<-NULL#NULL既不存值也不占位，表示不存在,用于增删存储空间
length(c6)


##向量的寻访
#向量的寻访实际上是对元素位置上逻辑值进行判断
c1[c(1,3,5)]#寻访用方括号，寻访多个元素用向量
c1[-c(1,3,5)]#负号代表删除，但不改变原向量数据
c1[c1>=8]#逻辑值寻访法
subset(c5,c5>=3)#能够自动跳过缺失值
which(c1>=5)#返回满足条件的向量的值所在的位置编号
c1[which(c1>=5)]#检查


##向量的运算
c01<-c0+c1#循环补齐，当向量或矩阵长度不同时（矩阵按列）循环补齐
crossprod(c01)#计算内积,crossprod(x)=x'x.注意，向量以列向量形式储存,=sum(x*x)
t(c1)#转置成行向量（矩阵形式）
t(t(c1))#转置成列向量（矩阵形式)
c01*c01#数组乘，即对应元素直接运算，不足循环补齐
all(c1>=8)#判断向量c1是否全部值>=8
any(c1>=8)#判断向量c1是否存在一个数>=8
diff(c1,2)#向量的2阶差分
sign(c(2,0,-2))#符号函数，用于判断向量值的正负和零
c7<-rnorm(100)
c8<-runif(200)#c7和c8两个向量长度不一样
lapply(list(normal=c7,uniform=c8),mean)
#利用列表，将函数应用于每组数据，不要求每组数据具有相同的结构
names(c1)<-paste("C",1:7,sep ="")#给向量个元素命名
c1["C5"]#根据名称选取元素
unname(c1)#隐藏但不清除名称
names(c1)<-NULL#清除名称

##运算示例-->天气预测模型
set.seed(2)
weather<-runif(720)-0.5#720天天气情况，均匀分布
weather[weather>=0]<-1#大于零部分为晴天，记为1
weather[weather<0]<-0
mean(weather)#计算晴天比例
pred<-function(x,k)
{
  n<-length(x)
  k2<-k/2
  csx<-c(0,cumsum(x))#cumsum:累积运算符
  predi<-vector(length = n-k)#0,1变量向量，用于储存预测值
  for(i in 1:(n-k))#注意1：(n-k)的表示方法，冒号运算顺序高于四则运算
    {
    if(csx[i+k]-csx[i]>=k2) predi[i]<-1 else predi[i]<-0
    }
  return(mean(abs(x[(k+1):n]-predi)))
}
K<-vector(length=30)#一个月的长度
for(j in 1:30)
{
  K[j]<-pred(weather,j)
}
plot(seq(K),K,type = "l",pch=20,ann = F)
title(main = "Weather Prediction", sub = "Uniform Distribution")