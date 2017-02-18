##2016-12-9
###矩阵

##矩阵的创建与寻访
m0<-matrix(nrow=2,ncol=3)#指明矩阵行列数，预先分配储存空间
dim(m0)#观察m0维数
m1<-matrix(1:14,nrow = 2,byrow = T)#创建矩阵，用nrow直接指明行数；
    #byrow指明按行计数,R默认按列排序；T指代TRUE，同理F指代FALSE
m2<-rbind(c(1,2,3,4,3,2,1),c(7,6,5,4,3,2,1))#行合并法创建
m1[2,3]#双下标寻访
m1[2]#单下标寻访，按列计数
m11<-m1[,1];m11#单列留空表示全部寻访,
m12<-m1[1,];m12#自动转换成列向量
m12_t<-m1[1,,drop=F]#提取子矩阵，保持原矩阵格式
diag(3)#创建3阶单位阵
m3<-diag(c(1,2,3));m3#创建以向量c为对角元素的矩阵
a1<-array(1:12,dim=c(2,2,3));a1#创建数组，寻访同矩阵

##矩阵运算
nrow(m2)#行数
ncol(m2)
m2t<-t(m2);m2t#矩阵转置
mm<-m1%*%m2t;mm#矩阵乘积
solve(mm)#矩阵逆
solve(mm,c(1,2))#求解线性方程
eigen(mm)#特征值与特征向量
qr(mm)$rank#qr分解，可观察矩阵秩
colSums(mm)#计算列和，同理rowSums()计算行和
apply(mm,2,var)#apply函数指定在行或列上计算
mmL<-lower.tri(mm,diag = T);mmL#提取矩阵的下上角元素，包括主对角线,返回逻辑值
mm*mmL##返回数值
diag(mm)
sum(diag(mm))#求矩阵迹
x1<-matrix(rnorm(10*100),ncol = 10)
x<-crossprod(x1)#产生一个正定对称矩阵
cholx<-chol(x)#choleskey分解，即正定对称矩阵A=C'C.C为上三角阵
norm(crossprod(cholx)-x)#检验
cholinv<-chol2inv(cholx)#求正定对称矩阵的逆，比solve高效
norm(cholinv-solve(x))

xx<-matrix(sample(10),2);xx
sweep(xx,1,c(2,3),"*") ##批量计算，xx指定对象，1指定计算维度，后面两项制定具体计算


##X'X求逆
xx_1<-solve(crossprod(x))
library(strucchange)
xx_1qr<-solveCrossprod(x)#qr,cholesky,solve三种方法求逆
  #其中：method指定求逆方法，选用“qr”效率最高，选用“chol”精度最高，
  #选用“slove”与slove(crossprod(x,x))效果相同
norm(xx_1qr-xx_1)
library(MASS)
ginv(x)#计算广义逆
library(LoopAnalyst)
make.adjoint(x[1:3,1:3])##计算伴随矩阵,计算量比较大

##reference
#http://www.cnblogs.com/wentingtu/archive/2012/03/30/2425582.html

