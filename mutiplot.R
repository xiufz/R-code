#说明：矩阵数据绘图，用于一次性绘多条曲线
##输入：
###x,y:必须是（列）向量或者矩阵，x每一列表示自变量范围
###y每一列表示因变量取值范围，x和y的列数的最大值表示要绘制的曲线条数
###当x与y列数不等时，取两者列数最大者并循环补齐。
###col:颜色，循环取色。
###add:选择是否要添加到当前图层上，默认开启一幅新图层
###ann:坐标轴标签，默认不添加标签

mutiplot<-function(x,y,type="l",col="black",add=F,ann=F)
{
  xlim<-c(min(x),max(x))
  ylim<-c(min(y),max(y))
  if(add) lines(xlim,ylim,type="n") else 
  plot(xlim,ylim,type="n",ann=ann)
            ##判断是否添加到当前图层上
  if(is.vector(x)) ncx<-1 else ncx<-ncol(x)
        ##判断是否是向量，是向量则要选择单维的绘制方式
  ncy<-ncol(y)
  ncmax<-max(ncx,ncy)
  lencol<-length(col)
  for(k in 1:ncmax)
  {
    colorder<-(k-1)%%lencol+1##循环取值
    xorder<-(k-1)%%ncx+1
    yorder<-(k-1)%%ncy+1
    if(is.vector(x)) lines(x,y[,yorder],type=type,col=col[colorder]) else
    lines(x[,xorder],y[,yorder],type=type,col=col[colorder])
        ##根据维度来选择不同的绘制方式
  }
}