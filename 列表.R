##2016-12-9
###列表

##创建与提取
L<-list(a=100,b="abc",cc=c(1,2,3,4))
L[[1]]
L[["a"]]
L$a#直接提取列表内容，一次仅允许指定一个标签
L[1]#提取原列表的
L[1:2]
length(L)#观察长度


##增删
L$d<-"new" #增
names(L)
L$d<-NULL  #减
names(L)

##拼接与嵌套（递归）
LL<-list(z=paste("z",1:5,sep = ""))
c(L,LL)
L$recursive<-LL
L
##列表与向量
UL<-unlist(L)
UL
class(UL)
names(UL)
UL<-unname(UL)#隐藏向量每个元素的名字（标签）
names(UL)<-NULL#直接将向量标签去除

##列表运算
lapply(L[3], range) #返回列表形式
sapply(L["cc"],range) #simplified lapply，返回矩阵形式
