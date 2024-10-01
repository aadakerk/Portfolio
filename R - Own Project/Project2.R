library(XML)
library(methods)
library(tidyverse)
library(rvest)
library(maps)
library(mapdata) 
library(stringr)
library(sf)


# Firstly making a list of all necessary results (the past 10)
urls <- c("https://results.jukola.com/tulokset/fi/j2022_ju/ju/kilpailijat/",
          "https://results.jukola.com/tulokset/fi/j2021_ju/ju/kilpailijat/",
          "https://results.jukola.com/tulokset/fi/j2019_ju/ju/kilpailijat/",
          "https://results.jukola.com/tulokset/fi/j2018_ju/ju/kilpailijat/",
          "https://results.jukola.com/tulokset/fi/j2017_ju/ju/kilpailijat/",
          "https://results.jukola.com/tulokset/fi/j2016_ju/ju/kilpailijat/",
          "https://results.jukola.com/tulokset/fi/j2015_ju/ju/kilpailijat/",
          "https://results.jukola.com/tulokset/fi/j2014_ju/ju/kilpailijat/",
          "https://results.jukola.com/tulokset/fi/j2013_ju/ju/kilpailijat/",
          "https://results.jukola.com/tulokset/fi/j2012_ju/ju/kilpailijat/") %>%
  as.list()

# Initializing loop variables
results <- tibble()
temp  <- list()

# A loop that reads in each of the tables in the urls-list, renames to translate,
# obtains the countries of the flags on the website, and then binds the columns
# together. Finally, the top 10 teams of each year are combined into a single 
# data frame.

for(i in 1:length(urls)) {
  temp <- read_html(urls[[i]]) %>%
    html_elements("table") %>%
    pluck(3) %>%
    html_table() %>%
    select(-c(Maa, Nro)) %>%
    rename(team = Joukkue) %>%
    slice(1:10)
  
  flag <- read_html(urls[[i]]) %>%
    html_elements(".lippu img") %>%
    html_attr("title") %>%
    as_tibble() %>%
    rename(country_abb = value) %>%
    slice(1:10)
  
  temp <- bind_cols(temp, flag)

  results <- bind_rows(results, temp)
}

# Fixing one naming issue and removing the number out of the team in case a
# second team from a club has places in the top 10. This is done because
# the location and club is the same.

results <- results %>%
  mutate(team = case_when(
  team == "Södertälje Nykvarn Orient" ~ "Södertälje Nykvarn Orienter",
  str_detect(team, "[1-9]") ~ str_remove(team, "\\s[1-9]"),
  .default = team
))


# See all the possible teams for coordinates
unique(results$team)

# Adding coordinates for the teams - coordinates of their hometowns
results <- results %>%
  mutate(latitude = case_when(
    team == "Stora Tuna OK" ~ 60.48487093957406,
    team == "IFK Göteborg" ~ 57.71159714701995, 
    team == "Helsingin Suunnistajat" ~ 60.16066087186057, 
    team == "Tampereen Pyrintö" ~ 61.4992405097864, 
    team == "OK Ravinen" ~ 59.30881068301218, 
    team == "Nydalens SK" ~ 59.95018335617318, 
    team == "Ikaalisten Nouseva-Voima" ~ 61.76831762203492, 
    team == "Malungs OK Skogsmårdarna" ~ 60.68673858108102, 
    team == "IL Tyrving" ~ 59.89213856297911, 
    team == "OK Linne" ~ 59.85897868868074, 
    team == "Kalevan Rasti" ~ 62.630657208864406, 
    team == "Koovee" ~ 61.4992405097864, 
    team == "Paimion Rasti" ~ 60.45612358666101, 
    team == "Turun Metsänkävijät" ~ 60.450106701295674, 
    team == "Halden SK" ~ 59.13311444272696, 
    team == "Södertälje Nykvarn Orienter" ~ 59.1979526797573, 
    team == "Hiidenkiertäjät" ~ 60.25328294473806, 
    team == "Frol IL" ~ 63.74741176932758, 
    team == "IFK Lidingö SOK" ~ 59.32769166167278, 
    team == "MS Parma" ~ 60.67806825069021, 
    team == "Kristiansand OK" ~ 58.16111571862012, 
    team == "IFK Moras OK" ~ 61.0047284833382, 
    team == "OK Denseln" ~ 58.58082437425917, 
    team == "Vaajakosken Terä" ~ 62.247962262825645, 
    team == "Järla Orientering" ~ 59.30855346077046, 
    team == "Ärla IF" ~ 59.27831869004443, 
    team == "Göteborg Majorna OK" ~ 57.71159714701995, 
    team == "OK Tisaren" ~ 59.06827796887995, 
    team == "OK Hällen" ~ 58.80982847120004, 
    team == "Vehkalahden Veikot" ~ 60.57463316356604, 
    team == "Delta" ~ 60.38948692990222, 
    team == "Hiisirasti" ~ 61.12014932378076, 
    team == "Angelniemen Ankkuri" ~ 60.29742594603356, 
  )) %>%
  mutate(longitude = case_when(
    team == "Stora Tuna OK" ~ 15.43670983223993,
    team == "IFK Göteborg" ~ 11.98877348630408, 
    team == "Helsingin Suunnistajat" ~ 24.93712997476031, 
    team == "Tampereen Pyrintö" ~ 23.79264561933755, 
    team == "OK Ravinen" ~ 18.173364889147447, 
    team == "Nydalens SK" ~ 10.76765201553873, 
    team == "Ikaalisten Nouseva-Voima" ~ 23.075792778776457, 
    team == "Malungs OK Skogsmårdarna" ~ 13.722579206840631, 
    team == "IL Tyrving" ~ 10.528597472101444, 
    team == "OK Linne" ~ 17.637267347052134, 
    team == "Kalevan Rasti" ~ 29.792526800861832, 
    team == "Koovee" ~ 23.79264561933755, 
    team == "Paimion Rasti" ~ 22.690173245419313, 
    team == "Turun Metsänkävijät" ~ 22.258758950043028, 
    team == "Halden SK" ~ 11.387108964454017, 
    team == "Södertälje Nykvarn Orienter" ~ 17.62430088550167, 
    team == "Hiidenkiertäjät" ~ 24.072122202914027, 
    team == "Frol IL" ~ 11.294022171514037, 
    team == "IFK Lidingö SOK" ~ 18.081129903552956, 
    team == "MS Parma" ~ 21.988028188353052, 
    team == "Kristiansand OK" ~ 8.017786374467358, 
    team == "IFK Moras OK" ~ 14.53471328569012, 
    team == "OK Denseln" ~ 15.915603538910515, 
    team == "Vaajakosken Terä" ~ 25.87277743754405, 
    team == "Järla Orientering" ~ 18.154599604618912, 
    team == "Ärla IF" ~ 16.68612554536641, 
    team == "Göteborg Majorna OK" ~ 11.98877348630408, 
    team == "OK Tisaren" ~ 15.107575711184065, 
    team == "OK Hällen" ~ 16.80294349759907, 
    team == "Vehkalahden Veikot" ~ 27.14296031007528, 
    team == "Delta" ~ 24.20546699705805, 
    team == "Hiisirasti" ~ 22.31177766139188, 
    team == "Angelniemen Ankkuri" ~ 22.908487326323883, 
  ))

# Seeing the countries for the map and for full country names
unique(results$country_abb)
# [1] "FIN" "NOR" "SWE"

# Adding the full country names
results <- results %>%
  mutate(country = case_when(
    country_abb == "FIN" ~ "Finland",
    country_abb == "SWE" ~ "Sweden",
    country_abb == "NOR" ~ "Norway")) 

# Finally creating the map. Because all the countries are in the Nordics, 
# making a map only of the Nordic countries using the maps and mapdata
# packages. Additionally, left joining  temp with nordics to get 
# the placements per country. Removing Svalbard and other small islands because
# there are no teams from there with coordinates

temp <- results %>%
  mutate(country = case_when(
    country_abb == "FIN" ~ "Finland",
    country_abb == "SWE" ~ "Sweden",
    country_abb == "NOR" ~ "Norway")) %>%
  group_by(country) %>%
  summarise(per_country = n())   

nordics <- map_data("world", region = c("Finland", "Sweden", "Norway")) %>%
  rename(country = "region") %>%
  filter((long > 2 & long < 33) & (lat > 55 & lat < 72)) %>%
  left_join(temp, by = "country")

# Final mapping with country as the number of placements and points as teams
ggplot() +
  geom_polygon(nordics, 
               mapping = aes(long, lat, group = group, fill = per_country)) +
  geom_path(nordics,
            mapping = aes(long, lat, group = group), color = "white") +
  geom_point(results, mapping = aes(longitude, latitude, color = team), 
             alpha = 0.45, size = 2.3, show.legend = FALSE) +
  scale_fill_gradient(low = "lightgrey", high = "grey") +
  theme_minimal() +
  labs(x = "Longitude",
       y = "Latitude",
       fill = "# in top10",
       title = "Top 10 Teams in Jukola by location")

# Graph for the specifc clubs since the map fails to show them,
# removing any with under three placements 
top_clubs <- results %>%
  group_by(team) %>%
  summarise(count = n()) %>%
  filter(count > 3) %>%
  arrange(count)

ggplot(top_clubs) +
  geom_col(aes(x = reorder(team, count), y = count, fill = team), show.legend = FALSE) +
  coord_flip() +
  labs(x = "Team name",
       y = "Number of Placements",
       title = "Top teams in Jukola") +
  theme_minimal()



  