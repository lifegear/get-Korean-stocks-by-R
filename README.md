# How to use
R samples function for getting chart data using google finance url (https://www.google.com/finance)

# Get data
output <- g.hist2(ticker, "2017-01-01", "2017-05-01") 

In case of KOSDAQ,
ticker can be symbols like "KOSDAQ:035720" for Kakao Composite Index. 
You can check ticker or symbols in finance google site.

# Chart ex)
plot(output$Date, output$Close, type="l")


