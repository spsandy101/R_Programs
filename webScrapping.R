#### Microsoft NASDAQ Example ####

library(XML)
library(httr)
library(xlsx)
library(data.table)

#Iteration vectors
dateindex=c(0:7)
optionChainPages=c(0:5)
greekPages=c(0:8)


#Function for Getting the option chain data and Writing to excel file
for (dateindex in c(0:7)) {
    for (page in c(0:5)) {
        
        #Define the URL
        optionChain= paste("http://www.nasdaq.com/symbol/goog/option-chain?dateindex=",dateindex,"&page=",page)
        
        #Get table data
        option_Chain_Table= readHTMLTable(optionChain, which = 6)
        
        #Write data into csv file
        write.csv(option_Chain_Table, paste("C:/Users/sparta/Desktop/R/Microsoft/optionchain/option_Chain_Table_",dateindex,".csv"), append = T)
        
        #Remove null values
        na.omit(paste("C:/Users/sparta/Desktop/R/Microsoft/optionchain/option_Chain_Table_",dateindex,".csv"))
    }

#Function for Getting the greek data and Writing to excel file
    for (page in c(0:8)) {
        #Define the URLs
        greeks= paste("http://www.nasdaq.com/symbol/goog/option-chain/greeks?dateindex=",dateindex,"&page=",page)
        
        #Get table data
        greeks_Table= readHTMLTable(greeks, which = 6)
        
        #Write data into csv files
        write.csv(greeks_Table, "C:/Users/sparta/Desktop/R/Microsoft/greek/greeks_Table_",dateindex,".csv")
        write.table(greeks_Table, file ="C:/Users/sparta/Desktop/R/Microsoft/greek/greeks_Table_",dateindex,".csv", append = T )
        #Remove null values
        na.omit(paste("C:/Users/sparta/Desktop/R/Microsoft/greek/greeks_Table_",dateindex,".csv"))
    }
}
