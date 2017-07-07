### PRIME ###
prime<- function(){
  num<- readline(prompt = cat("Enter a number to check if it is prime or not", "\n"))
  num<- as.numeric(num)
  loopVar<- num/2
  count<-0
  for(i in c(2:loopVar)){
    if(num%%i==0){
      count= count+1
      break
    }
  }
  if(count>0){
    print("NOT A PRIME")
  }
  else{
    print("PRIME")
  }
}