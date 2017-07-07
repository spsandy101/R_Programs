# Program to find the L.C.M. of two input number
lcm <- function(x, y) {
  # choose the greater number
  if(x > y) {
    greater = x
  } else {
    greater = y
  }
  
  while(TRUE) {
    if((greater %% x == 0) && (greater %% y == 0)) {
      lcm = greater
      break
    }
    greater = greater + 1
  }
  return(lcm)
}

# take input from the user
num1 = as.integer(readline(prompt = "Enter first number: "))
num2 = as.integer(readline(prompt = "Enter second number: "))

print(paste("The L.C.M. of", num1,"and", num2,"is", lcm(num1, num2)))