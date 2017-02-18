##2016-12-9
###R基础操作

# '#'注释
#选中代码后按ctrl+enter执行
#ctrl+alt+R全部运行，更多快捷方式见help

##帮助文件
help("lm")#打开帮助文档，查看lm中包含的数值、变量等等，相当于?lm
??lm#本地帮助文件查找关键词
??"normal distribution"#查询一个词
help(package="AER")#查看对应包中的函数
library(AER)
lm##直接查看函数代码
args(lm)#查询函数的arguments
example(lm)##函数示例

getwd()#获取当前的 working directory
setwd("D:/办公学习/计算机/R/R语言实战")#set the working diretory
#使用绝对路径；使用'正'斜杠/，在R中\代表转义。

data()#查看当前所有可用数据集
example(Nile)#示例：运行名为Nile的数据集
ls()#查看当前工作空间对象
save.image("example.Rdata")#保存工作空间
rm(fit)#删去名为fit的对象
load("example.Rdata")#重新加载example.Rdata
#source("filename")#运行名为filename的R文件
install.packages("vcd")#安装名为vcd的安装包
installed.packages()#查看现有已安装的包
update.packages()#更新安装包
library("car")#调用除7个基本安装包以外的包
cat("\f")#clear console,=ctrl+L
rm(list = ls())#清除当前工作空间

#-----------------数据导入导出----------------#
#excel数据转为csv数据后导入
csvdta<-read.csv("examcsv.csv")#字符串都带双引号；读取csv数据用read.csv
class(csvdta)#观察csvdta的数据类型
dim(csvdta)#观察数据框或矩阵的维数(观测数x变量数)，相当于matlab中的size()
names(csvdta)#观察数据框中变量的名字
str(csvdta)#进一步观察数据框中的结构构成
head(csvdta)#观察数据框前面的数据
tail(csvdta)#观察数据框尾部的数据
with(
  csvdta,a13<<-a12+a11#定义一个新变量用于合并
)
csvdta_new<-cbind(csvdta,a13)#按列合并，同理,rbing()为按行合并
head(csvdta_new)#观察合并后的数据框
save(csvdta,file = "examcsv.Rdata")#将csvdta存在名为examcsv.Rdata的文件中
save.image("chp1&2image.Rdata")#将当前image全部存在chp1&2image的文件中;
#Rdata文件下次可直接用load加载,可使用相对路径