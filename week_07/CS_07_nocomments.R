#case study 7
#Getting Help!

#load required libraries
library(tidyverse)
library(sf)
library(spData)
library(ggplot2)

#use data from sp world
data(world)

ggplot(world,aes(x=gdpPercap, y=continent, color=continent))+
   geom_density(alpha=0.5,color=F)
########
#creating the reprex
#copy the code you ran above (that didn't work) before you run the next step

#library(reprex)
#reprex(venue = "gh")

#this is what you get
# library(tidyverse)
# library(sf)
# #> Linking to GEOS 3.10.2, GDAL 3.4.2, PROJ 8.2.1; sf_use_s2() is TRUE
# library(spData)
# library(ggplot2)
# 
# #use data from sp world
# data(world)
# 
# ggplot(world,aes(x=gdpPercap, y=continent, color=continent))+
#   geom_density(alpha=0.5,color=F)
# #> Warning: Removed 17 rows containing non-finite values (stat_density).