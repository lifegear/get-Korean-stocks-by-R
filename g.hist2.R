#######################################################
###     Getting historical stock price data from google finance
###     Revised by lifegear@gmail.com, Jun 2017 
###     Ref: http://blog.naver.com/PostView.nhn?blogId=lisist&logNo=220417131329 (Jun 2015 by lisist)
#######################################################

### You need XML package to run this function
library(XML)

g.hist2 <- function(ticker, start_date, end_date){
  
  #ticker set & modify
  ticker_m <- gsub(":","%3A",ticker)
  
  #set locale
  lct<-Sys.getlocale("LC_TIME")
  Sys.setlocale("LC_TIME", "C")
  
  #set date
  start_date = as.Date(start_date)
  end_date = as.Date(end_date)
  
  #format date for calling google finance url
  fmtstr <- "%b+%d%%2C+%Y"  #ex) Jan+01,+2017
  start_date_fmt <- as.character(format(start_date, fmtstr))
  end_date_fmt <- as.character(format(end_date, fmtstr))
  
  #set URL
  url = 'http://www.google.com/finance/historical?q='
  url = paste(url,ticker_m,'&startdate=',start_date_fmt,'&enddate=',end_date_fmt,'&num=200',sep='')
  
  #downloading data from the Google Finance
  output <- as.data.frame(readHTMLTable(url,stringsAsFactors=FALSE)[4])
  
  output[, 1] <- as.Date(output[, 1], format="%b %d, %Y")
  names(output) <- c("Date", "Open","High","Low","Close","Volume")
  
  for (k in 2:6){
    output[, k] <- as.numeric(gsub(",", "", output[, k]))
  }
  
  #### Checking whether all data are retrieved or not ####
  end <- as.Date(output[length(output[, 1]), 1])
  ll <- 200 - length(output[, 1])
  if ((end-ll)<start_date) end <- start_date
  if (end > start_date) {
    output <- rbind(output, g.hist2(ticker,start_date,as.character(end-1)))
  }
  
  return(output)
}

