##因子与表 2017-1-6
##目录
##因子简介
##因子的常用函数: tapply, split, by, cut
##表（table）的操作


##因子简介
    ##因子相当于一个名义变量，因子的不同值称为因子水平，通过对因子的整合操作可对
    ##同一类因子水平的对象进行操作

x<-c("a","b","d","e","a","e","c")
xf<-factor(x)         ##返回一个因子，包含因子水平
unclass(xf)           ##将因子水平标准化为1,2,3...

##因子的常用函数: tapply, split, by, cut

###tapply(table apply): 按因子水平进行计算
age<-c(10,20,30,40,50,60,70)
labl<-c("C","Y","Y","A","A","O","O") ##确定因子水平
gender<-c("M","M","F","F","F","M","M")
tapply(age,labl,mean)
        ##返回列表
        ##只能对向量进行操作，后面函数不可缺少
tapply(age,list(gender,labl),mean) 
        ##组合因子，必须以列表形式出现；
        ##因子水平中没有对应的元素，则记为NA

###split: 只分类，不进行计算，可用于向量或数据框
set.seed(10)
income<-round(runif(7)*10000)
wlth<-ifelse(income<=1000,"poor",ifelse(income<=5000,"med","rich"))
split(income,wlth)  ##返回列表
split(age,list(wlth,gender))
split(data.frame(age,income,gender),wlth) ##对列表进行分类

###by: tapply升级版，能运算，能处理向量和数据框，且能调用多参数函数
data<-data.frame(age,income,gender)
by(data,gender,function(m) summary(lm(m[,1]~m[,2])))
        ##按性别分类；定义匿名函数可调用多参数

###cut:将元素分别对应到每个数值区间
seqen<-seq(0,1,by=0.1)
z<-runif(10)
y<-cut(z,seqen,labels = F) ##返回z每个值对应的区间号（左开右闭），
                          ##labels=lab,返回设置的标签lab
findInterval(z,seqen) ##结果同上

##表（table）的操作
    ###表中记录每个因子水平下元素出现的频数，可以是二维表，也可以是多维表
    ##因子水平下若没有元素，则记为零
table(gender)
tbl<-table(list(gender=gender,age=age));tbl
table(list(gender=gender,age=age,wealth=wlth))

tbl[1,2]##表可当做一个带标签的矩阵,因而矩阵运算可用到表中
rowSums(tbl) 
tbl[c("F","M"),c("10","20","30")]##提取子表
tbl[-2,]
