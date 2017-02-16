#绘图

##数据准备
setwd( "D:/Work and Study/Software and Programming/R/R in Action")#设置当前工作文件夹
dose<-c(20,25,30,35,40,45,50)#创建示例数据
drugA<-c(16,20,27,35,40,47,60)
drugB<-c(15,18,25,31,37,40,42)

#1.1 图形参数设置

par()#获取当前图形全局参数,72个
opar<-par(no.readonly = T)#获取可修改的图形参数66个，用于恢复默认设置
par(font.lab=3,col.lab=rgb(0,0,1),cex.lab=0.9,pin=c(5,7),mai=c(1,0.5,1,0.5))
  #用来控制全局参数，然后用par(opar)来恢复
  #font:控制字体，1常2粗3斜4粗斜
  #col,cex分别控制颜色和字体大小，详见下面plot
  #lab为坐标轴标签，可以用于二级组合设置的还有axis(刻度标签)，main/sub(主副标题)
  #pin:picture inch,成对数字用向量表示；mai:margin inch,顺序为下左上右。
plot(dose,drugA,type = "b",pch=16,cex=0.8,lty=4,lwd=1.2,col="red",
     main="clinlical trials for drug A",sub="based on hypothetical data",
     xlab="dosage",ylab="drug response",ylim=c(15,62),xlim=c(20,50))
  #plot等函数内部参数为局部参数
  #说明：type=p:point(default);l:line;b:both.others see ?plot
  #pch:point character,取值0-25;cex:character example:按默认比例放大缩小
  #lty:line type,取值：1-6；lwd:line width,按默认比例放大缩小
  #col:设置图像颜色，默认黑色，颜色取值如："red",rgb(0.8,0.4,0.3),
  # #FFFFFF,hsv(0.5,0.8,0.1)等,也可以通过1到8来调用
  #lim用于控制范围,用向量表示；
  #另外一种设置坐标轴范围的方式为：plot(c(xmin,xmax),c(ymin,ymax),type="n")
plot(dose,drugB,type="b",ann=F)
title(main="clinlical trials for drug B",sub="based on hypothetical data",
      xlab="dosage",ylab="drug response")
  #可以使用title控制main,sub,lab的性质，如col,font,cex等
  #plot为高级绘图指令，没有特殊声明时另起一幅图
  #但可以用add=T来添加到当前图像上，也可以用lines()/points()等低级指令绘图
  #后两者继承了plot()的绝大多数绘图指令

#3.2 添加文本，自定义坐标轴和图例

x<-c(1:10)
y<-x
z<-10/x#产生绘图数据
  #R里面的向量和矩阵四则运算指数组元素，元素长度不同时循环运算。
par(opar)#恢复默认设置
plot(x,y,type = "b",pch=22,lty=6,col="blue",yaxt="n",xaxt="n",ann = F)
  #type: 控制绘图类型，默认点图，l--line;b:both;n:none.
  #yaxt/xaxt:axis tick,y轴/x轴上的刻度线和刻度标签，
  #取值为n时表示不绘制刻度、刻度标签。
  #ann:annotate,表示x、y轴自带的显示x,y变量的标签，取值为F表示不显示标签
lines(x,z,type="b",pch=25,lty=2,col="red")#在原图上添加点直线
axis(1,at=x,tck=0.01,cex.axis=0.7)
lab<-rep("",10)#产生10个空位，用于清空标签
axis(2,at=y,tck=0.01,labels=lab,las=1,cex.axis=0.7,col.axis="blue",
     col.ticks = "blue")
axis(4,at=z,labels=round(z,2),tck=-0.01,las=1,cex.axis=0.5,col.axis="red",
     col.ticks = "red",pos = 10)
  #side=1/2/3/4,用于限定下左上右(顺时针)四条坐标轴
  #at:用于指定刻度线绘制的位置
  #labels:用于指定刻度线上的标签，缺省时默认为at的值
  #tck:tick,即坐标轴刻度线，以所占图形区域的百分数表示，取值可正可负;
  #同理col.tick表示刻度线颜色
  #正值代表刻度线在绘图区，最大值为1，即表示绘制网格线；
  #负值表示为指向图形区域外，默认为-0.01
  #las:取值0/1/2/3，0代表刻度上的标签平行于该坐标轴；2总是垂直于坐标轴。(其余略)
  #cex.axis/col.axis/font.axis:用于控制坐标轴刻度线标签的大小、颜色、字体
  #pos:position,坐标，表示在何处显示刻度线和标签

#install.packages("Hmisc")#安装Hmisc安装包，用于绘制次要刻度线
library(Hmisc)#加载安装包
minor.tick(nx=3,ny=3,tick.ratio=0.5)
  #nx,ny分别制定x和y主要坐标轴的每对主要刻度线之间次要刻度线(小刻度线)的数目
  #tick.ratio:与原主要刻度线的比例百分数。
legend(x=3,y=10,title="Dependent",legend = c("y","z"),lty = c(6,2),pch=c(22,25),
       col = c("blue","red"),bg="gray90",text.col = "green")
  #x,y:用于指明图例的左边界和上边界，也可用bottomm,top,left ,right,center
  #或他们的组合使用
  #交互式取点方式：可用locator(n),n代表取点个数，返回列表；
  #如：legend(locator(1),...)
  #title:图例的标题
  #legend:图例文字
  #ity,pch,col:用于指明图例说明的对象，与图形中的元素参数设置保持相同
  #bty:box type,设置为n时表示去除边界线
  #bg:background;text.col: color of text
  #更多例子可见example(legend)
abline(v=sqrt(10),h=sqrt(10),lty=3)
  #绘制辅助线，vertical and horizontal
  #其他参数：a,b表示y=a+b*x，也可以用向量c(a,b)表示。
  #abline()是低级绘图指令，需要在plot等图基础之上绘图
  #abline()可直接对线性回归的模型画图，如abline(lm(y~x))
text(x=3.5,y=3.3,pos=4,"intersection",family="serif")
text(x=c(7,7),y=c(7,1.2),pos=c(4,3),c(expression(y==x),expression(z==1/x)))
mtext("Double Functions",side = 3,line = -4,outer = T)
  #x,y:指定文本信息的位置，也可使用locator(1)交互式指定
  #pos:1下2左3上4右，指定文本信息相对于坐标的位置,如pos=4表示text在(x,y)右边
  #family:取值serif,mono,sans,用于控制字体，更多字体见par()
  #expression:用于输入数学公式，更多数学公式可见?plotmath or demo(plotmath).
  #mtext用于在在边轴边框上添加文本信息，side选边，line移动位置，可正可负，
  #outer选定内外

#3.3 函数绘图
fun<-function(x) exp(-x)*sin(x)
plot(fun,-pi,pi)
  #先定义函数，再直接用函数名绘图，后面-pi,pi指定x轴范围
curve(exp(-x)*cos(x),-pi,pi,col=2,add = T)
  #或者直接用curve()绘图，无需先定义函数，add=T表示添加到当前绘图框上
  #当绘图取点需要更加精细时，可用"n="来控制取点数，默认取101个点
legend(1,-4,c(expression(f(x)==e^{-x}*sin(x)),expression(f(x)==e^{-x}*cos(x))),
       lty = c(1,1),col = c(1,2))
  #{}表示一个式子为一个整体

#3.4 绘制三维图
g <- expand.grid(x = 1:10, y = 5:15, gr = 1:2)
  #将x,y,gr网格化,形成一个列表
  #gr用于分组
g$z <- log((g$x^g$gr + g$y^2) * g$gr)
  #计算z值，存入列表
wireframe(z ~ x * y, data = g, groups = gr,
          scales = list(arrows = FALSE),
          drape = TRUE, colorkey = TRUE,
          screen = list(z = 30, x = -60))
  ##绘制曲面图
cloud(z ~ x * y, data = g, groups = gr,
      scales = list(arrows = FALSE),
      drape = TRUE, colorkey = TRUE,
      screen = list(z = 30, x = -60))
  ##绘制三维点图

#3.5 图形组合

  #数据准备
x1<-rnorm(1000)#产生1000个正态分布的数
x2<-runif(1000)#产生1000个均匀分布的数
x3<-pnorm(sort(x1))#将正态数排序并计算分布函数
x4<-punif(sort(x2))#将均匀分布数排序并计算分布函数
x5<-dnorm(x1)#产生x1的密度分布函数
  
  ##par
par(mfrow=c(2,2))
hist(x1,main="",yaxt="n",cex.axis=0.5,xlab = "")#绘制直方图并去掉自带标题、坐标轴标题
axis(2,at=c(0,50,100,150,200),labels=c(0,50,100,150,200),tck=0.03,col.axis="red",
     cex.axis=0.5,las=2)#多余刻度自动溢出
hist(x2,main="",yaxt="n",cex.axis=0.5,xlab = "")
axis(2,at=c(0,50,100,150,200),labels=c(0,50,100,150,200),tck=0.03,col.axis="red",
     cex.axis=0.5,las=2)
plot(sort(x1),x3,type = "l",yaxt="n",cex.axis=0.5)#绘制累积分布图
plot(sort(x2),x4,type = "l",yaxt="n",cex.axis=0.5)
par(opar)#恢复原始参数设置
  #mfrow/nfcol：图形按行/列排列，取值为(nrows,ncols)
  #在plot/hist等高级指令中的cex.axis等指令对所有坐标轴适用

  ##layout
layout(matrix(c(1,2,3,3),byrow=T,nrow=2),widths=c(1,1),heights = c(1.2,1))
hist(x1,main="",yaxt="n",cex.axis=0.5,xlab = "")#绘制直方图并去掉自带标题、坐标轴标题
axis(2,at=c(0,50,100,150,200),labels=c(0,50,100,150,200),tck=0.03,col.axis="red",
     cex.axis=0.5,las=2)#多余刻度自动溢出
hist(x2,main="",yaxt="n",cex.axis=0.5,xlab = "")
axis(2,at=c(0,50,100,150,200),labels=c(0,50,100,150,200),tck=0.03,col.axis="red",
     cex.axis=0.5,las=2)
plot(sort(x1),x3,type = "l",cex.axis=0.5,yaxt="n")#绘制累积分布图
axis(2,at=c(0,0.2,0.4,0.6,0.8,1),col.axis = "red",cex.axis=0.5,tck=0.05)
lines(sort(x2),x4,col="red")#用直线绘制x2的累积分布图
  #matrix:指明图形排列的样式，此处意味三四图位排同一幅图
  #widths/heights:指明列/行的相对宽度或高度

  ##fig
par(fig=c(0,0.8,0,1))
plot(x1,x5)
par(fig=c(0.7,1,0,1),new=T)
boxplot(x1,yaxt="n")
axis(4,at=c(-3:3),tck=0,las=2)
abline(h=c(-3:3),lty=3)#画参考线
box(col="white")#白色隐藏边框
  #fig:指明当前图形在图形窗中的相对坐标位置，即fig=c(x1,x2,y1,y2)
  #new:fig默认开启一个新的图形窗，若要在原图上绘制新图，使用new=TRUE

#3.5 图形设别与图形保存
setwd("D:/Work and Study/Software and Programming/R/R in Action/graphs")
pdf("Graph_fig15.pdf",height = 5.43,width = 6.53)
curve(x^2,-1,2)
dev.off()#关闭当前图形设备
  #有则打开，无则新建
  #其他图片类型如：png,jpg类似
  #width/height分别控制宽度和高度
  




