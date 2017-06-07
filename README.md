# Introduction
R samples function for getting chart data using google finance url (https://www.google.com/finance)

# Setup
download source R file and
first of all, you need to install "xml" library
<pre>
> install.packages("xml")
> library(xml)
> source("g.hist2.R")
</pre>

# Get data
<pre>
> output <- g.hist2(ticker, "2017-01-01", "2017-05-01") 
</pre>

In case of KOSDAQ,
ticker can be symbols like "KOSDAQ:035720" for Kakao Composite Index. 
You can check ticker or symbols in finance google site.

# Chart ex)
<pre>
> plot(output$Date, output$Close, type="l")
</pre>

