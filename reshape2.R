
###   pkgs <- c('reshape2', 'plyr', 'ggplot2', 'dplyr', 'data.table', 'Lahman')
###   install.packages(pkgs)
###   update.packages(ask = TRUE)


## 1.
pew<- read.delim(
  file = "http://stat405.had.co.nz/data/pew.txt",
  header = TRUE,
  stringsAsFactors = FALSE,
  check.names = FALSE
)
head(pew)
dim(pew)
str(pew)
names(pew)

install.packages("reshape2")
library(reshape2)

pew_tidy<- melt(
  data=pew,
  id="religion",
  variable.name = "income",
  value.name = "frquency"
)
head(pew_tidy)
str(pew_tidy)

tb<- read.csv("tb.csv", header = TRUE, stringsAsFactors = FALSE)
head(tb)
names(tb)
dim(tb)
colnames(tb)


## 2.
# set column `new_sp` to NULL and clean up column names
tb$new_sp = NULL
names(tb) <- gsub("new_sp_", "", names(tb))

# Use na.rm = TRUE to remove missing observations
tb_tidy <- melt(
  data = tb,
  id = c("iso2", "year"),
  variable.name = "gender_age",
  value.name = "cases",
  na.rm = TRUE
)

# split gender_age into gender and age group
library(plyr)
tb_tidy <- mutate(tb_tidy,
                  gender = sub("^([m|f])(.*)$", "\\1", gender_age),
                  age = sub("^([m|f])(.*)$", "\\2", gender_age),
                  gender_age = NULL
)
tb_tidy <- tb_tidy[c('iso2', 'year', 'gender', 'age', 'cases')]