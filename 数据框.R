#2016-12-16

setwd("D:/办公学习/计算机/R/R data sets for 5e")
##数据框的创建与寻访
kids<-c("Jack","Jill")
d<-data.frame(kids,ages=c(10,12),stringsAsFactors = F) 
  #stringAsFactors=F，避免字符串变成因子
str(d)#观察结构
d[[1]]#数据框既具有矩阵性质，又具有列表性质,可看成具有相同长度的
      #列表的集合
d$kids
d[,1]  
as.data.frame(matrix(runif(10),ncol=2))#强制转换
load("apple.Rdata")
head(data)#观察数据框前几行观测
tail(data,3)#指定观察后3行观测
dim(data)#n行观测，m列变量

##提取子集
names(data)
data1<-data[1:10,c("state","educ")];data1
  #混合提取生成新数据框，当列提取时可用drop=F防止转换成向量
class(data1)  
logic1<-data1$educ>=15;logic1#返回逻辑值
logic2<-which(data1$state=="NY");logic2#返回对应位置
data1[logic1,]#提取符合要求的值
data1[logic2,]
###subset函数：运用逻辑值提取子集
subset(data1,educ>=15)#subset运算提取子集可以直接去掉里面的NA值
d4<-data.frame(kids=c("Jack","Jill",NA,"John"),states=c("CA","MA","MA",NA))
d4
subset(d4,states!="CA")
navalue<-complete.cases(d4)#判断每一行观测是否存在缺失值
subset(d4,navalue)

##数据框的合并与删除
###横向合并
data2<-data[1:10,"date",drop=F];data2
data1<-cbind(data1,data2);data1#直接合并法
data1$id<-data[1:10,"id"];data1
data3<-data[1:10,c("id","educ","regprc")];data3#data3与data1有交集
merge(data1,data3)#合并相同观测，增添不同列,剔除不同的观测
###纵向合并
rbind(data1,data[11:15,names(data1)])
####删除变量
data1[-4]#用负号直接剔除，但不改变原数据框
data1[-grep("id",names(data1))]#grep()函数用于查找字符串，并返回位置


##数据框的排序
edu_order<-order(data1$educ,data1$id)#order函数（默认升序）
    #返回向量中从小到大每个数出现的位置,多个参数依次为主次参数
data1[edu_order,]#对data1按educ的升序排列

##加载数据框中的变量
attach(data1)#为调取数据方便，用attach全局调用data1中的内容;
            #若有重名数据则会被屏蔽
educ#attach后可直接调用数据
detach(data1)#解除全局调用
with(data1,#局部调用，运算操作用{}包括起来
     {meduc1<-mean(educ)#内部运算，变量值只能在with内部使用；
      meduc2<<-mean(educ)}#增强型赋值，可在with内外使用
)




