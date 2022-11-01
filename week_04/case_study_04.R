#GEO511 case study 4 script
#Kaitlyn Biehler
#Farthest airport from New York City
#objective: What is the full name (not the three letter code) of 
#the destination airport farthest from any of the NYC airports in the flights table?
#Save the name as a character value farthest_airport
#Tasks
#Join two datasets using a common column
#join flights and airports datasets 
#load libraries
library(tidyverse)
library(nycflights13)
#View(flights)
#View(airports)
#flights has dest, a 3-letter code and contains distance information
#airports has faa, which matches dest
#airports also has name, the usual name of the airport
#arrange by distance, descending
flightbydistance <- arrange(flights, desc(distance))
#View(flightbydistance)
#largest distance is 4983, flight is JFK to HNL
#join
flightbydistance_airports <-
left_join(flightbydistance, airports, c("dest" = "faa"))%>%
slice_head(n=1) 
View(flightbydistance_airports)
#Honolulu Intl = HNL
farthest_airport <- select(flightbydistance_airports, name) %>%
  as.character()
#others used slice, new to me
#as.character also new
View(farthest_airport)
#Answer a question that requires understanding how multiple tables are related
#Save your script as a .R or .Rmd in your course repository