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

#transform to the albers equal area projection:
albers="+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs"

#change crs to albers
world_albers <-st_transform(world, albers)

#filter the world dataset to include only name_long=="Canada"
Canada <- filter(world_albers, name_long=="Canada")

#plot(Canada)

#buffer canada to 10km (10000m)
#units??
buf_Canada<- st_buffer(Canada, 10000)
data("us_states")
#change crs to albers
us_albers <- st_transform(us_states, albers)

#plot(us_states)

NY_state <- filter(us_albers, NAME == "New York")
#plot(NY_state)

#create a border object
#not working beyond this point
border <- st_intersection(buf_Canada, NY_state)

#plot
ggplot() +
  geom_sf(data = NY_state)+
  geom_sf(data = border, fill = "red") +
  labs(title = "New York Land within 10km")

#calculate area of the polygon
area_border <- st_area(border)
#print(area_border)
new_area_border <- set_units(area_border, km^2)
