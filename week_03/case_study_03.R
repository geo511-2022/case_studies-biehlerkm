#GEO511 Case study 3
#Wealth over time
#load libraries
library(ggplot2)
library(gapminder)
library(dplyr)
#take a look at the data
#View(gapminder)
#variables are country, continent, year, lifeExp, pop, gpdPercap
#make a copy of the data
mygapminder <- gapminder 
#view your dataset
#View(mygapminder)
#use filter to remove Kuwait
noKuwait <- filter(mygapminder, country != "Kuwait")
#Check the data
#View(noKuwait)
#create the first row of plots
plot_1 <- ggplot(noKuwait, aes(x = lifeExp, y = gdpPercap, color = continent))+
  geom_point(aes(size = pop/100000))+
  facet_wrap(~year,nrow=1)+
  scale_y_continuous(trans = "sqrt")+
  theme_bw()+
  labs(title = "Wealth and life expectancy through time",
       x = "Life Expectancy",
       y = "GDP per capita",
       size = "Population (100k)",
       color = "Continent"
  )
plot_1
ggsave("CS3_plot1.png", plot_1)
#
#prepare data for second plot
#create a new dataset
copynoKuwait <- noKuwait
ConYearGroup <- group_by(copynoKuwait, continent, year)
gapminder_continent <- 
  summarise(ConYearGroup, gdpPercapweighted = weighted.mean(x = gdpPercap, w = pop),
            pop = sum(as.numeric(pop)))
#create the second row of plots
plot_2 <- ggplot(noKuwait, mapping=aes(x = year, y = gdpPercap, color = continent,
                                       size = pop/100000))+
  geom_line(mapping=aes(group=country, size = 0.3))+
  geom_point(aes(size = pop/100000))+
  geom_line(gapminder_continent, mapping=aes(x = year, y = gdpPercapweighted), 
            color = "black", size = 0.5)+
  geom_point(data = gapminder_continent, mapping=aes(x = year, y = gdpPercapweighted,
                                  size = pop/100000), color = "black") +
  scale_size_continuous(trans = "sqrt")+
  facet_wrap(~continent, nrow = 1)+
  theme_bw()+
  labs(
       x = "Year",
       y = "GDP per capita",
       size = "Population (100k)",
  )
plot_2
ggsave("CS3_plot2.png", plot_2, width = 15, units = "in")
