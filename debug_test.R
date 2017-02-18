##Test for debug: setBreakpoint()
debug_test<-function()
{
  x<-runif(100)
  lst<-list()
  for(k in 1:length(x))
  {
    count<-k%%4+1
    lst[[count]]<-c(lst[[count]],x[k])  
  }
}