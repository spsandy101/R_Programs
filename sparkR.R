### Initialising spark variables
if (nchar(Sys.getenv("SPARK_HOME")) < 1) {
  Sys.setenv(SPARK_HOME = "C:/Users/sparta/AppData/Local/rstudio/spark/Cache/spark-1.6.2-bin-hadoop2.6")
}
library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib")))
sparkR.session(master = "local[*]", sparkConfig = list(spark.driver.memory = "2g"))
sparkR.init(master = "local", spark_config(spark.driver.memory = "2g"))

# Creating sqlContext
sqlContext= sparkRSQL.init(jsc = NULL)


# Creating spark data frames
df= as.DataFrame(sqlContext, faithful)
head(df)
str(df)

#From JSON file
snack=read.json(sqlContext, "C:/Users/sparta/Desktop/R/snack.json")
## Partitioning the data ::
# snack=read.json(sqlContext, "C:/Users/sparta/Desktop/R/snack.json", 8)
head(snack)
str(snack)

# From a mogoDB table

# Read using the spark config
df <- read.df(sqlContext, source = "com.mongodb.spark.sql.DefaultSource")

# Read using the passed in uri config
df1 <- read.df(sqlContext, source = "com.mongodb.spark.sql.DefaultSource", uri = "mongodb://example.com/database.collection1")

### SparkDataFrame operations
# Select only the "eruptions" column
head(select(df, df$eruptions))
# You can also pass in column name as strings
head(select(df, "eruptions"))
# Filter the SparkDataFrame to only retain rows with wait times shorter than 50 mins
head(filter(df, df$waiting < 50))
#count the number of times each waiting time appears
head(summarize(groupBy(df, df$waiting), count = n(df$waiting)))
#sort the output from the aggregation to get the most common waiting times
waiting_counts <- summarize(groupBy(df, df$waiting), count = n(df$waiting))
head(arrange(waiting_counts, desc(waiting_counts$count)))

### Operating on columns
# Convert waiting time from hours to seconds.
# Note that we can assign this to a new column in the same SparkDataFrame
df$waiting_secs <- df$waiting * 60
head(df)













