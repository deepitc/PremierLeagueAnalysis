# Application

# Installing Packages
library(tidyr)
library(dplyr)
library(ggplot2)
library(rqdatatable)

# Loading Data
#11-12
RegularSeason11_12 <- read.csv("RegularSeason11_12.csv")
SquadGoalkeeping11_12 <- read.csv("SquadGoalkeeping11_12.csv")
SquadPlayingTime11_12 <- read.csv("SquadPlayingTime11_12.csv")
Squadshooting11_12 <- read.csv("Squadshooting11_12.csv")
SquadStandardStats11_12 <- read.csv("SquadStandardStats11_12.csv")

#15-16
RegularSeason15_16 <- read.csv("RegularSeason15_16.csv")
SquadGoalkeeping15_16 <- read.csv("SquadGoalkeeping15_16.csv")
SquadPlayingTime15_16 <- read.csv("SquadPlayingTime15_16.csv")
Squadshooting15_16 <- read.csv("Squadshooting15_16.csv")
SquadStandardStats15_16 <- read.csv("SquadStandardStats15_16.csv")

#21-22
RegularSeason21_22 <- read.csv("RegularSeason21_22.csv")
SquadGoalkeeping21_22 <- read.csv("SquadGoalkeeping21_22.csv")
SquadPlayingTime21_22 <- read.csv("SquadPlayingTime21_22.csv")
Squadshooting21_22 <- read.csv("Squadshooting21_22.csv")
SquadStandardStats21_22 <- read.csv("SquadStandardStats21_22.csv")

# Merging Data set


mp <- natural_join(RegularSeason11_12, SquadGoalkeeping11_12, by = "Squad", jointype="FULL")


#11-12
AllStats11_12 <- RegularSeason11_12 %>%
  natural_join(SquadGoalkeeping11_12, by = "Squad", jointype="FULL") %>%
  natural_join(SquadPlayingTime11_12, by = "Squad", jointype="FULL") %>%
  natural_join(Squadshooting11_12, by = "Squad", jointype="FULL") %>%
  natural_join(SquadStandardStats11_12, by = "Squad", jointype="FULL")

AllStats11_12 <- AllStats11_12[, colSums(is.na(AllStats11_12))<nrow(AllStats11_12)]
AllStats11_12 <- AllStats11_12[-1,]

AllStats11_12$Year <- c("11/12")

#15-16
AllStats15_16 <- RegularSeason15_16 %>%
  natural_join(SquadGoalkeeping15_16, by = "Squad",jointype="FULL") %>%
  natural_join(SquadPlayingTime15_16, by = "Squad", jointype="FULL") %>%
  natural_join(Squadshooting15_16, by = "Squad", jointype="FULL") %>%
  natural_join(SquadStandardStats15_16, by = "Squad", jointype="FULL")

  AllStats15_16 <- AllStats15_16[, colSums(is.na(AllStats15_16))<nrow(AllStats15_16)]
  AllStats15_16 <- AllStats15_16[-1,]
  AllStats15_16$Year <- c("15/16")

#21-22
AllStats21_22 <- RegularSeason21_22 %>%
  natural_join(SquadGoalkeeping21_22, by = "Squad", jointype="FULL") %>%
  natural_join(SquadPlayingTime21_22, by = "Squad", jointype="FULL") %>%
  natural_join(Squadshooting21_22, by = "Squad", jointype="FULL") %>%
  natural_join(SquadStandardStats21_22, by = "Squad", jointype="FULL")

AllStats21_22 <- AllStats21_22[, colSums(is.na(AllStats21_22))<nrow(AllStats21_22)]
AllStats21_22$Year <- c("21/22")


# Final Data

Final_Data <-  AllStats21_22 %>%
  natural_join(AllStats15_16, by = c("Year","Squad"), jointype="FULL") %>%
  natural_join(AllStats11_12, by = c("Year","Squad"), jointype="FULL") 



