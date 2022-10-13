library(raster)
library(sp)
library(spData)
library(tidyverse)
library(sf)
library(ncdf4)

data(world)  #load 'world' data from spData package
filter(world, continent != "Antarctica") #remove Antarctica
new_world <- as(world, "Spatial") #convert to sp

download.file("https://crudata.uea.ac.uk/cru/data/temperature/absolute.nc","crudata.nc") #download temperature data
tmean=raster("crudata.nc") 
#plot(tmean) #optional plot to look at data

names(tmean) #see the current name of the data layer
names(tmean)<- "tmean" #update the data layer to ‘tmean’ 

#calculate max temp
maxtemp <-raster::extract(tmean, new_world, fun=max, na.rm=T, small=T, sp=T) #Extract values from a Raster object at the locations of spatial vector data 
tmax_country<-st_as_sf(maxtemp) #convert back to sf

ggplot(tmax_country, aes(fill=tmean)) + 
  geom_sf() +
  scale_fill_viridis_c(name="Annual\nMaximum\nTemperature (C)") +
  theme(legend.position = 'bottom')

hottest_continents <- tmax_country %>%
  group_by(continent) %>%
  arrange(.by_group = TRUE) %>%
  select(name_long, continent, tmean) %>%
  st_set_geometry(NULL) %>%
  arrange(desc(tmean))

hottest_continents



maxtemp <- raster::extract(tmean, new_world, fun = max, na.rm=T, small=T, sp=T)

#convert to sf
tmax_country <- st_as_sf(maxtemp)

#plot results
ggplot(tmax_country, aes(fill= "tmax")) + 
  geom_sf() +
  scale_fill_viridis_c(name="Annual\nMaximum\nTemperature (C)") +
  theme(legend.position = 'bottom')

hottest_continents <- tmax_country %>%
  group_by(continent) %>%
  top_n(1, tmax) %>%
  select(name_long, continent, tmax) %>%
  st_set_geometry(NULL) %>%
  arrange(desc(tmax))

hottest_continents
