### FIBONACCI ###

fibonacci<- function(){
  nterms<- as.numeric(readline(cat(prompt = "Enter the number of terms in the Fibonacci sequence", "\n")))
  print(0, 1, quote = FALSE)
  a=0
  b=1
  for(i in 1:nterms){
    c=a+b
    print(c, quote=FALSE)
    a<-b
    b<-c
  }
}