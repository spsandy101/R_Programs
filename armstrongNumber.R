### Armstrong Number ###

armstrong<- function(){
  num<- as.numeric(readline(prompt = cat("Enter a number to see if its an ARMSTRONG number or not", "\n")))
  temp=num
  check=0
  remain=0
  while(temp>0){
    remain=temp%%10
    check=check+(remain^3)
    temp=as.integer(temp/10)
  }
  if(num==check){
    print(paste(num, "is an Armstrong Number."), quote = FALSE)
  }
  else{
    print(paste(num, "is not an Armstrong Number."), quote = FALSE)
  }
}