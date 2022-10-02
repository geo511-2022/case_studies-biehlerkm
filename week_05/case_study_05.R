#GEO511 case study 5
#Beware the Canadians!
#Kaitlyn Biehler
#
#
#Generate a polygon that includes all land in NY 
#that is within 10km of the Canadian border (not including the great lakes)
#then
#Calculate it’s area in km^2. How much land will you need to defend from the Canadians?
#begin
#load libraries
library(spData)
library(sf)
library(tidyverse)
library(units)
#load 'world' data from spData package
data(world)  
# load 'states' boundaries from spData package
data(us_states)
#plot(world[1])  #plot if desired
#plot(us_states[1]) #plot if desired
#world dataset
#transform to the albers equal area projection:
#ok, I don't fully understand what this is doing or why
#where does this go?
data(world) 
albers="+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs"
#filter the world dataset to include only name_long=="Canada"
Canada <- filter(world, name_long=="Canada")
#plot(Canada)
#buffer canada to 10km (10000m)
#units??
buf_Canada<- st_buffer(Canada, 10000)
data("us_states")
#again with the albers thing
albers="+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs"
#plot(us_states)
NY_state <- filter(us_states, NAME == "New York")
#plot(NY_state)
#create a border object
#not working beyond this point
#border <- st_intersection(buf_Canada, NY_state)
#ggplot(border)+
#  geom_sf()
#st_area(border)