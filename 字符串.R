#字符串、输入与输出、文件目录等

##字符串函数

###grep
grep("Pole",c("Equator","North Pole","South Pole"))
        ##grep(a,b)用于查找b中含a字符串的元素出现的位置

grepl("P.le",c("Equator","North Pole","South Pole"))
        ##可以使用正则表达式，"."代表任意一个字符。
        ##正则表示的具体用法见下面“正则表达式”

###substr
substr("Equator",3,5)
        ##提取给定起始位置的字符串

###strsplit
strsplit(date()," ")
        ##按给定分隔符分开原字符串，结果返回列表

###regexpr, gregexpr
regexpr("uat","Equator")
        ##regular experession,支持正则表达式，查找子字符串出现的位置
regexpr("u.t","Equator")

gregexpr("iss","Mississippi")
        ##多处查找

###sprintf
d<-8
s<-sprintf("The square of %d is %d",d,d^2);s
        ##类似于C语言中的printf
        ##%d:整形输出；%f:浮点输出，默认六位小数；%g:浮点数出，自动调整小数位数

###sub, gsub
sub("BCD","bcd","ABCDE")
        ##仅替换第一次出现的字符串
gsub("B","b","BoB")
        ##全部替换(gross)

###nchar()
nchar("This is a Character!")
##计算长度，中文字每字一个长度

nzchar("A fast way to find out if strings are non-empty")

###paste
figname<-paste("fig",1:5,".pdf",sep = "");figname
##粘贴，默认空格分开，sep可以选择分隔符

##正则表达式
        ##"."代表任意一个字符；"[str]"表示含有字母"s,t,r"的字符串
        ##"\\":表转意，如"\\."表示点号本身
        ##当不必要用正则意，而需要用本意是，可选用命令"fixed=TRUE"
###case study: 检查文件后缀名
testsuffix<-function(filename,suffix)
{
  sp<-strsplit(filename,".",fixed = T)
  lensp<-length(sp[[1]])
  return(sp[[1]][lensp]==suffix)
}
testsuffix("abc.pdf","pdf")

##输入

###scan()
        ##只能读取同种类型的数据，如数值型或字符型向量
setwd("C:/Users/Administrator/Documents")
scan("rnum.txt")##从磁盘中读取文件
scan("rtext.txt",what = character())
        ##字符串需要用what=character()指明，其他还可以有logical(),integer()等
        ##也可直接用what=""表示任何同种类型的向量输入
scan("",quiet = T)
        ##从屏幕读取数值型向量，以空行结束;quiet=T表示不显示已读取数目
scan(what = "",sep = "\n")
        ##从屏幕读取字符串向量,以换行符作为分隔符

###readline()/readLines()
        ##readline()单行整行读取;readLines()多行整行提取(注意大写)
str<-readline();str
readline("Please enter a word:")##提示语
readLines("rtext.txt")

###read.table/read.csv
tbl<-read.table("rtbl.txt",header = T);tbl
class(tbl)
        ##read.table用于读取纯文本表格，默认空白分隔（如制表符、空格符）
        ##为分隔符，也可以用sep=指定；表格元素不必整齐排列
        ##read.csv用于读取逗号分隔的csv文件

###文件连接
contbl<-file("rtbl.txt","r")
        ##"r"表示read，后面"w"的表示write环境下的链接
        ##contbl表示处于连接可访问的文件
readLines(contbl,n=1)
        ##每次访问一行，多次执行时依次访问后面的行
seek(con = contbl,where = 0)
        ##观察连接文件读取到的位置，where表示从0开始(注意不是从1开始)
close(contbl)
        ##关闭contbl文件
##输出

###paste
paste("The words you input are:",readline())
        ##粘贴法输出

###cat
cat("The words you input are:",readline(),"\n")
        ##concatenate and print
        ##默认空格分隔；需要用换行符结束，否则下一次会输出在同一行上
        ##可用sep=调整分隔符

###write.table
write.table(tbl,file = "rtbl_write.txt",sep = "\t",row.names = F)
        ##写成txt文本格式,制表符分隔，且不要行名；也可以不要列名。
write.csv(tbl,file = "rtbl_write.csv",row.names = F)
        ##写成csv格式

###save
save(tbl,file = "tbl_save.Rdata")
        ##保存工作空间中的文件

##文件目录
getwd()
        ##获取当前工作目录
setwd(getwd())
        ##设置当前工作目录，注意需要使用反斜杠表示下一级目录
dir()
        ##当前工作目录下的文件夹、文件树，dir(directory)列出指定文件
        ##目录下的文件目录树
        ##当设置recursive=T时显示当前工作目录下的所有文件
file.info("MATLAB")
        ##查询文件、目录信息，包括创建、修改时间、大小、是否为文件夹等等
