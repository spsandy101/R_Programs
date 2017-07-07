
### Find FACTORIAL of a number ###

factorial_find<- function(){
  while(1){
    num<- readline(prompt = cat("Enter a number to find factorial or press 'S' to stop the program.", sep = "\n"))
    if(tolower(num)=="s"){
      break
    }else{
      num<- as.numeric(num)
      fact=1
      for(i in 1:num){
        if(num==0){
          break
        }
        fact= fact*i
      }
      print(paste("The factorial of", num, "is", fact,"."))
    }
  }
}

# ## Using Recursion ###
# recur_factorial <- function(n) {
#   if(n <= 1) {
#     return(1)
#   } else { 
#     return(n * recur_factorial(n-1))
#   }
# }