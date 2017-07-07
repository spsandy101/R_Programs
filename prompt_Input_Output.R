
### Create array from user input ###

createArray<- function(){
  a<- c()  #Initialize input holding vector
  n<- readline(prompt = "EANTER an ARRAY ENTRY OR ENTER 'S' to STOP") #Read Input
  while(1){ #Loop to check the input
    if(tolower(n)=="s"){
      break
    }else{
      a<- c(a, as.integer(n)) #Add the input to the vector
    }
    n<- readline() #Recursive input prompt
  }
  return(a)
}

var<- createArray() #Call the function