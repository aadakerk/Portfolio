# Are the leading causes of death in the US misrepresented by media? 

# Step 1: Downloading necessary packages
library(tidyverse)
library(fs)

# Step 2: Importing and formatting data for each table
# I have chosen to represent the leading causes with the average percentage
# of that cause during the time of the data in the table.

# Google 
google <- read_csv("Project_1/Google-trends.csv") %>%
  rename(year = Words) %>%
  pivot_longer(c("alzheimer's":"terrorism"), names_to = "cause", 
               values_to = "cases") %>%
  filter(year == "Average") %>%
  select(-year) %>%
  rename(mean_google = cases)


# CDC
cdc <- read_tsv("Project_1/CDC.txt") %>% 
  pivot_longer(c(`1999`:`2016`), names_to = "year", values_to = "cases") %>%
    group_by(cause) %>%
    summarise(mean_cdc = mean(cases)) %>%
  filter(str_detect(cause, "\\_all") | !str_detect(cause, "\\_"))

# New York Times
nyt_file <- dir_ls(path = "Project_1/NYT")

# Initializing input variable and then loop for a list of the files
nyt_contents <- list()
for(i in seq_along(nyt_file)) {
  nyt_contents[[i]] <- read_csv(nyt_file[[i]]) %>% select(-"ID") %>%
    pivot_wider(names_from = Words, values_from = count)
}

# Initializing input and then tibble of the NYT csv files and merging
nyt <- tibble(nyt_contents[[1]])
for(i in seq_along(nyt_contents)) {
  nyt <- full_join(nyt_contents[[i]], nyt)
}

# Other tibbles have proportion of each instead of counts so modifying NYT
i <- 1
while(i <= nrow(nyt)) {
  
  # Get the sum of each row except the first column
  row_sum <- sum(nyt[i, -1], na.rm = TRUE)
  
  # Change values to be the proportion
  j <-  2
  while(j <= ncol(nyt)) {
    nyt[i, j] <- nyt[i, j] / row_sum
    j <-  j + 1
  }
  
  i <- i + 1
  
}

# Matching NYT format to other tables
nyt <- nyt %>%
  pivot_longer(c(`heart disease`:`drug overdose`), 
               names_to = "cause", values_to = "cases") %>%
  group_by(cause) %>%
  summarise(mean_nyt = mean(cases))

# Defining names to match categories in all tables

google["cause"][google["cause"] == "alzheimer's"] <- "alzheimer"
google["cause"][google["cause"] == "heart"] <- "heart disease"
google["cause"][google["cause"] == "heart"] <- "alzheimer"
google["cause"][google["cause"] == "car accidents"] <- "accident"
google["cause"][google["cause"] == "pneumonia"] <- "respiratory infection"


cdc["cause"][cdc["cause"] == "cancer_all"] <- "cancer"
cdc["cause"][cdc["cause"] == "homicide_all"] <- "homicide"
cdc["cause"][cdc["cause"] == "heart"] <- "heart disease"
cdc["cause"][cdc["cause"] == "influpneu"] <- "respiratory infection"
cdc["cause"][cdc["cause"] == "kidney"] <- "kidney disease"
cdc["cause"][cdc["cause"] == "loresp"] <- "respiratory disease"


nyt["cause"][nyt["cause"] == "alzheimer's disease"] <- "alzheimer"
nyt["cause"][nyt["cause"] == "car accident"] <- "accident"
nyt["cause"][nyt["cause"] == "car crash"] <- "accident"
nyt["cause"][nyt["cause"] == "pileup"] <- "accident"
nyt["cause"][nyt["cause"] == "unintentional injuries"] <- "accident"
nyt["cause"][nyt["cause"] == "malignant neoplasms"] <- "cancer"
nyt["cause"][nyt["cause"] == "heart failure"] <- "heart disease"
nyt["cause"][nyt["cause"] == "knife attack"] <- "homicide"
nyt["cause"][nyt["cause"] == "gun violence"] <- "homicide"
nyt["cause"][nyt["cause"] == "knifing"] <- "homicide"
nyt["cause"][nyt["cause"] == "lynching"] <- "homicide"
nyt["cause"][nyt["cause"] == "manslaughter"] <- "homicide"
nyt["cause"][nyt["cause"] == "murder"] <- "homicide"
nyt["cause"][nyt["cause"] == "shootings"] <- "homicide"
nyt["cause"][nyt["cause"] == "assassination"] <- "homicide"
nyt["cause"][nyt["cause"] == "self-harm"] <- "suicide"
nyt["cause"][nyt["cause"] == "drug overdose"] <- "overdose"
nyt["cause"][nyt["cause"] == "flu"] <- "respiratory infection"
nyt["cause"][nyt["cause"] == "influpneu"] <- "respiratory infection"
nyt["cause"][nyt["cause"] == "pneumonia"] <- "respiratory infection"
nyt["cause"][nyt["cause"] == "bronchitis"] <- "respiratory infection"
nyt["cause"][nyt["cause"] == "Influenza"] <- "respiratory infection"
nyt["cause"][nyt["cause"] == "asthma"] <- "respiratory disease"
nyt["cause"][nyt["cause"] == "emphysema"] <- "respiratory disease"
nyt["cause"][nyt["cause"] == "cardiovascular disease"] <- "heart disease"
nyt["cause"][nyt["cause"] == "nephritis"] <- "kidney disease"
nyt["cause"][nyt["cause"] == "nephrosis"] <- "kidney disease"
nyt["cause"][nyt["cause"] == "nephrotic syndrome"] <- "kidney disease"
nyt["cause"][nyt["cause"] == "terrorist"] <- "terrorism"
nyt["cause"][nyt["cause"] == "terror attack"] <- "terrorism"

nyt <- nyt %>%
  group_by(cause) %>%
  summarise(mean_nyt = sum(mean_nyt)) %>%
  filter(!cause == "cerebrovascular diseases")

# Joining tables on "cause"

table <- nyt %>%
  full_join(google, by = "cause") %>%
  full_join(cdc, by = "cause")


# Mapping the plot

ggplot(table) +
  geom_col(mapping = aes(mean_google, cause), fill = "forestgreen", 
           position = "dodge") +
  geom_col(mapping = aes(mean_cdc, cause), fill = "orange",
           position = "dodge") +
  geom_col(mapping = aes(mean_nyt, cause), fill = "blue") + 
  scale_fill_manual(values = c("forestgreen", "orange", "blue"), 
                    labels = c("Google", "CDC", "NYT"),
                    name = "Source") +
  labs(x = "Cause of Death",
       y = "Percentage of Total Deaths by Cause",
       caption = "Blue = NYT, Green = Google, Orange = CDC") 

# As we can see in the graph, the orange represents CDC or the most reliable
# source while green and blue represent Google and New York Times. It seems that 
# terrorism is regarded as highly deathly by NYT while the most common cause
# of death according to CDC is heart disease. This is not highlighted by the 
# media as well. Therefore, I would say that the leading causes of death in
# the US are misrepresented by the media. Furthermore, it is important to note
# that the NYT had many different categories for single categories in other sources.
# This leads to higher values (blue) by the NYT.
