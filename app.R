# Application

# Installing Packages
library(tidyr)
library(dplyr)
library(ggplot2)

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

#11-12
AllStats11_12 <- RegularSeason11_12 %>%
  full_join(SquadGoalkeeping11_12, by = "Squad") %>%
  full_join(SquadPlayingTime11_12, by = "Squad") %>%
  full_join(Squadshooting11_12, by = "Squad") %>%
  full_join(SquadStandardStats11_12, by = "Squad") %>%
  select(-X..x, -Starts.x, -Min.x, -X..y, -MP.x.x, -Min.y, -Min.y, -Min.,
         -Starts.y, -Mn.Start, -Mn.Sub, -X..., -X..x.x, -Pl.x.x, -Gls.x, -SoT, -SoT, -SoT.,-SoT.90,
         -G.SoT, -X..y.y, -Age.y, -Starts, -Min)

AllStats11_12 <- AllStats11_12[-21,]
AllStats11_12$Year <- c("11/12")

#15-16
AllStats15_16 <- RegularSeason15_16 %>%
  full_join(SquadGoalkeeping15_16, by = "Squad") %>%
  full_join(SquadPlayingTime15_16, by = "Squad") %>%
  full_join(Squadshooting15_16, by = "Squad") %>%
  full_join(SquadStandardStats15_16, by = "Squad") %>%
  select (-X..x, -MP.y, -Starts.x, -Min.x, -X90s.x, -X..y, -X90s.y, G.SoT.x, -X..x.x, 
          -X90s.x.x, -G.SoT.y,-X..y.y, -Min.y, - X90s.y.y)

AllStats15_16 <- AllStats15_16[-21,]
AllStats15_16$Year <- c("15/16")

#21-22
AllStats21_22 <- RegularSeason21_22 %>%
  full_join(SquadGoalkeeping21_22, by = "Squad") %>%
  full_join(SquadPlayingTime21_22, by = "Squad") %>%
  full_join(Squadshooting21_22, by = "Squad") %>%
  full_join(SquadStandardStats21_22, by = "Squad") %>%
  select(-X..x, -X90s.x, -X..y, -Mn.MP, -Min., -X90s.y, -Starts, -X..x.x, -X..y.y)

AllStats21_22$Year <- c("21/22")


# Final Data

f1 <- full_join(x = AllStats11_12, y = AllStats15_16, by = "Squad")



