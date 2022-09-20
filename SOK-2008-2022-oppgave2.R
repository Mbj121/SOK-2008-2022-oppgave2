# HELP SCRIPT FILE  Utfording 2.3 - SOK-2008

library(readr)
library(ggplot2)    
library(tidyverse)  

#Leser data fra github
union<- read_csv("https://uit-sok-2008-h22.github.io/Assets/union_unempl.csv") #This loads the data with information about the variables of interest
View(union) 

union$country <- gsub("United Kingdom", "UK", union$country)
View(union) 

names(union)[names(union) == "country"] <- "region"
View(union) 

#Her lastes det inn map_data
mapdata <- map_data("world")
view(mapdata)

mapdata <- left_join(mapdata, union, by= "region")
view(mapdata)

mapdata1 <- mapdata %>% filter(!is.na(mapdata$unempl))
view(mapdata1)

#Lager et plot for arbeidsledighet
map1 <- ggplot(mapdata1, aes(x = long, y = lat, group = group)) + 
  geom_polygon(aes(fill = unempl), col = "black") +
  scale_fill_gradient(name = "Arbeidsledighet i Prosent", low = "green", high = "red", na.value = "grey50") +
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        rect = element_blank())
map1



#Lager plot for Fagforeningsdensitet
map2 <- ggplot(mapdata1, aes(x = long, y = lat, group = group)) +
  geom_polygon(aes(fill = density), col = "black") +
  scale_fill_gradient(name = "Fagforeningsdensitet i Prosent", low = "red", high = "green", na.value = "grey50") +
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        rect = element_blank())
map2



#Lager variablen "Excess_coverage"
mapdata1$excess_coverage<-mapdata1$coverage - mapdata1$density

#Lager plot for "Excess_coverage"
map3 <- ggplot(mapdata1, aes(x = long, y = lat, group = group)) +
  geom_polygon(aes(fill = excess_coverage), col = "black") +
  scale_fill_gradient(name = "Excess Coverage", low = "red", high = "green", na.value = "grey50") +
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        rect = element_blank())
map3



#Lager plot for "Koordinering av lønnfastsettelse"
map4 <- ggplot(mapdata1, aes(x = long, y = lat, group = group)) +
  geom_polygon(aes(fill = coord), col = "black") +
  scale_fill_brewer(name= "Koordinering av lønnfastsettelse", palette = "Set1") +
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        rect = element_blank())
map4
