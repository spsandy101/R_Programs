
####DPLYR####

library(dplyr)

head(mtcars)
colnames(mtcars)
rownames(mtcars)
colnames(mtcars)[1]="Miles_Per_Gallon"

##RENAME
mtcars= rename(mtcars, mpg=Miles_Per_Gallon, cylinders=cyl,
               displacement=disp, horsepower=hp)
colnames(mtcars)

## Subsetting rows- FILTER
mt_over20=filter(mtcars, mpg>20, cylinders==6)
head(mt_over20)

#AND operator
mt_over20_6cyl=filter(mtcars, mpg>20, cylinders==6)
head(mt_over20_6cyl)

#OR operator
mt_over20_or_6cyl= filter(mtcars, mpg>20 | cylinders==6)
head(mt_over20_or_6cyl)

## Sorting the rows- ARRANGE
mt_mpg_sort= arrange(mtcars, cylinders, desc(mpg))
mt_mpg_sort

## Selecting columns - SELECT
carbdf= select(mtcars, carb, mpg)
head(carbdf)

## Make new variables - MUTATE
mtcars=mutate(mtcars, new_mpg=mpg^2, new_cylinder=cylinders^2)
head(mtcars)

## Remove a column
mtcars$new_cylinder=NULL

##Add new columns and keep some specific columns - TRANSMUTATE
#Subsetting and generating new variable
 mt_mut= transmute(mtcars,
                   mpg2=mpg^2,
                   cyl2=cylinders^2,
                   disp2=displacement^2,
                   over20_mpg= mpg>20,
                   mpg2_over140=new_mpg>140,
                   gear,
                   carb)
head(mt_mut)

# Summarise data
summarise(mtcars,
          mean_cyl=mean(cylinders),
          max_cyl=max(cylinders),
          q25_cyl=quantile(cylinders, probs = 0.25))

#Calculate summaries Grouped by a certain criteria
plot(summarise(group_by(mtcars, cylinders, gear),
          mean_mpg=mean(mpg),
          men_disp=mean(displacement)))


####  dplyr SQL ####

library(Lahman)

head(Batting)

bdat= Batting%>%
  filter(HR>=50 & SO<80)%>%
  select(playerID, HR, yearID)%>%
  arrange(desc(HR))

head(bdat)

bdat=Batting%>%
  group_by(playerID)%>%
  summarise(THR=sum(HR, na.rm=TRUE))%>%
  arrange(desc(THR))

head(bdat1)

bdat=Batting%>%
  group_by(playerID)%>%
  summarize(avg_season_hits=round(mean(H, na.rm=TRUE), 2))%>%
  arrange(desc(avg_season_hits))
head(bdat)

bdat= Batting%>%
  group_by(playerID)%>%
  summarize(max_career_HR= max(HR), min_career_SO= min(SO))%>%
  arrange(desc(max_career_HR))
head(bdat)

bdat=Batting%>%
  group_by(playerID)%>%
  summarize(number_of_records=n())
bdat

bdat=Batting%>%
  filter(AB >= 400)%>%
  group_by(playerID)%>%
  summarize(min_career_so=min(SO,na.rm=TRUE))%>%
  filter(min_career_so<20)%>%
  arrange(desc(min_career_so))
bdat

bdat=Batting%>%
  filter(AB>=400)%>%
  mutate(battingAverage=round(H/AB,3))%>%
  select(playerID, battingAverage, yearID)%>%
  arrange(desc(battingAverage))
head(bdat)

bdat=Batting%>%
  group_by(playerID)%>%
  summarize(career_H=sum(H, na.rm=TRUE), career_AB=sum(AB, na.rm=TRUE))%>%
  filter(career_AB>1000)%>%
  mutate(career_batting_avg=round(career_H/career_AB, 3))%>%
  select(playerID, career_batting_avg)%>%
  arrange(desc(career_batting_avg))
head(bdat)

### INNER JOINS ###
bdat=inner_join(Batting, Master, by=c("playerID"))%>%
  filter(playerID=="ruthba01" | playerID=="aaronha01")
## Another way
bdat=Batting%>%
  filter(playerID=="ruthba01" | playerID=="aaronha01")

bdat=inner_join(bdat, Master, by=c("playerID"))

head(bdat)

bdat=Batting%>%
  select(playerID, teamID, yearID, HR)

bdat=inner_join(bdat, Master, by=c("playerID"))%>%
  select(FirstName=nameFirst, LastName= nameLast, teamID, yearID, HR)%>%
  arrange(desc(HR))

head(bdat)

bdat=Batting%>%
  filter(playerID=="ruthba01")%>%
  select(playerID, teamID, yearID, HR)

bdat=inner_join(bdat, Teams, by=c("teamID", "yearID"))%>%
  select(playerID, name, yearID, HR=HR.x)%>%
  arrange(desc(HR))

bdat

## Joining three tables
bdat=Batting%>%
  filter(playerID=="ruthba01")%>%
  select(playerID, teamID, yearID, HR)

bdat=inner_join(bdat, Master, by=c("playerID"))%>%
  select(nameFirst, nameLast, teamID, yearID, HR)

bdat=inner_join(bdat, Teams, by=c("teamID", "yearID"))%>%
  select(nameFirst, nameLast, name, yearID, HR=HR.x)

bdat

bdat=Batting%>%
  group_by(playerID)%>%
  summarize(career_HR=sum(HR, na.rm=TRUE))

bdat= inner_join(bdat, Master, by=c("playerID"))%>%
  select(nameFirst, nameLast, career_HR)

bdat


bdat=inner_join(Batting, Master, by=c("playerID"))%>%
  group_by(playerID)%>%
  summarize(FirstName= nameFirst[1], LastName= nameLast[1], career_HR=sum(HR, na.rm=TRUE))%>%
  select(FirstName, LastName, career_HR)
bdat