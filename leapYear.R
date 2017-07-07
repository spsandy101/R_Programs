
### Leap Year ###
lepYear<- function(){
  year<- as.integer(readline(cat(prompt = "Enter a year to check if it's a leap year", "\n")))
  if(year%%4==0){
    if(year%%100==0){
      if(year%%400==0){
        print(paste(year, "is a leap year."))
      }
      else{
        print(paste(year, "is not a leap year."))
      }
    }
    else{
      print(paste(year, "is a leap year."))
    }
  }
  else{
    print(paste(year, "is not a leap year."))
  }
}