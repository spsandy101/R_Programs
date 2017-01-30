
############################
      ### tidyr ###
############################


## Update packages
old.packages()
update.packages(ask = FALSE)

## Install packages
install.packages("devtools")
library(devtools)
install_github("rstudio/EDAWR")
library(EDAWR)

# gather()
new_df<- tidyr::gather(cases, "Year", "n", 2:4)
new_df

# spread()
head(pollution)
new_df<- tidyr::spread(pollution, size, amount)
new_df

# "gather()" -- reverse of "spread()"
new_df<- tidyr::gather(new_df, "size", "amount", 2:3)

## "separate()" vs "unite()"
head(storms)
storms2<- tidyr::separate(storms, date, c("year", "month", "day"), sep="-")
storms2
storms2<-tidyr::unite(storms2, "date", year, month, day, sep="-")
storms2
