

library(dplyr)
library(data.table)

merge.easy <- function(df1,df2,columnname){
  df1 <- data.table(df1,key=columnname)
  df2 <- data.table(df2,key=columnname)
  return(unique(merge(df1,df2,all.x=TRUE,by=.EACHI,allow.cartesian=TRUE)))
}

new_db <- merge.easy(old_db1,old_db2,key="SharedColumnName")
