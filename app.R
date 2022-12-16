# Application

# Installing Packages
library(tidyr)
library(dplyr)
library(ggplot2)
library(rqdatatable)
library(lme4)

# Loading Data
#11-12
RegularSeason11_12 <- read.csv("RegularSeason11_12.csv")
SquadGoalkeeping11_12 <- read.csv("SquadGoalkeeping11_12.csv")
SquadPlayingTime11_12 <- read.csv("SquadPlayingTime11_12.csv")
Squadshooting11_12 <- read.csv("Squadshooting11_12.csv")
SquadStandardStats11_12 <- read.csv("SquadStandardStats11_12.csv")

SquadStandardStats11_12$Age <- SquadStandardStats11_12$Poss

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

AllStats11_12 <- AllStats11_12 %>%
  select(Year, Age, Ast, Attendance, CrdR, CrdY, CS, CS., D, GF, W, L, Pts.MP, Pts, Gls, Ast, Squad)

#15-16
AllStats15_16 <- RegularSeason15_16 %>%
  natural_join(SquadGoalkeeping15_16, by = "Squad",jointype="FULL") %>%
  natural_join(SquadPlayingTime15_16, by = "Squad", jointype="FULL") %>%
  natural_join(Squadshooting15_16, by = "Squad", jointype="FULL") %>%
  natural_join(SquadStandardStats15_16, by = "Squad", jointype="FULL")

AllStats15_16 <- AllStats15_16[, colSums(is.na(AllStats15_16))<nrow(AllStats15_16)]
AllStats15_16 <- AllStats15_16[-1,]
AllStats15_16$Year <- c("15/16")

AllStats15_16 <- AllStats15_16 %>%
  select(Year, Age, Ast, Attendance, CrdR, CrdY, CS, CS., D, GF, W, L, Pts.MP, Pts, Gls, Ast, Squad)

#21-22
AllStats21_22 <- RegularSeason21_22 %>%
  natural_join(SquadGoalkeeping21_22, by = "Squad", jointype="FULL") %>%
  natural_join(SquadPlayingTime21_22, by = "Squad", jointype="FULL") %>%
  natural_join(Squadshooting21_22, by = "Squad", jointype="FULL") %>%
  natural_join(SquadStandardStats21_22, by = "Squad", jointype="FULL")

AllStats21_22 <- AllStats21_22[, colSums(is.na(AllStats21_22))<nrow(AllStats21_22)]
AllStats21_22$Year <- c("21/22")

AllStats21_22 <- AllStats21_22 %>%
  select(Year, Age, Ast, Attendance, CrdR, CrdY, CS, CS., D, GF, W, L, Pts.MP, Pts, Gls, Ast, Squad)

# Final Data

Final_Data <-  AllStats21_22 %>%
  natural_join(AllStats15_16, by = c("Year","Squad"), jointype="FULL") %>%
  natural_join(AllStats11_12, by = c("Year","Squad"), jointype="FULL") 


Final_Data <- Final_Data[, colSums(is.na(Final_Data))<nrow(Final_Data)]
Final_Data <- Final_Data %>% replace(is.na(.), 0)

Final_Data <- Final_Data %>%
  select(Year, Age, Ast, Attendance, CrdR, CrdY, CS, CS., D, GF, W, L, Pts.MP, Pts, Gls, Ast, Squad)


## Data Normalization 11/12

AllStats11_12_norm <- AllStats11_12

# First, we will identify the numeric columns in the dataset
numeric_columns <- sapply(AllStats11_12_norm, is.numeric)

# Next, we will create a new data frame that contains only the numeric columns
numeric_data <- AllStats11_12_norm[, numeric_columns]

# We will then normalize the numeric data by subtracting the minimum value of each column from each value
# and dividing by the range (maximum value - minimum value) of each column
normalized_numeric_data <- apply(numeric_data, 2, function(x) {
  (x - min(x)) / (max(x) - min(x))
})

# Finally, we will replace the original numeric columns in the dataset with the normalized values
AllStats11_12_norm[, numeric_columns] <- normalized_numeric_data

# First, we will identify the numeric columns in the dataset
numeric_columns <- sapply(AllStats11_12_norm, is.numeric)

# Next, we will create a new data frame that contains only the numeric columns
numeric_data <- AllStats11_12_norm[, numeric_columns]

# Finally, we will replace the original data frame with the new one containing only numeric columns
AllStats11_12_norm <- numeric_data

# Identifying Norm Rows
AllStats11_12_norm$Squad <- AllStats11_12$Squad


## Data Normalization 15/16

AllStats15_16_norm <- AllStats15_16

# First, we will identify the numeric columns in the dataset
numeric_columns <- sapply(AllStats15_16_norm, is.numeric)

# Next, we will create a new data frame that contains only the numeric columns
numeric_data <- AllStats15_16_norm[, numeric_columns]

# We will then normalize the numeric data by subtracting the minimum value of each column from each value
# and dividing by the range (maximum value - minimum value) of each column
normalized_numeric_data15_16 <- apply(numeric_data, 2, function(x) {
  (x - min(x)) / (max(x) - min(x))
})

# Finally, we will replace the original numeric columns in the dataset with the normalized values
AllStats15_16_norm[, numeric_columns] <- normalized_numeric_data15_16

# Finally, we will replace the original numeric columns in the dataset with the normalized values
AllStats15_16_norm[, numeric_columns] <- normalized_numeric_data15_16

# First, we will identify the numeric columns in the dataset
numeric_columns <- sapply(AllStats15_16_norm, is.numeric)

# Next, we will create a new data frame that contains only the numeric columns
numeric_data <- AllStats15_16_norm[, numeric_columns]

# Finally, we will replace the original data frame with the new one containing only numeric columns
AllStats15_16_norm <- numeric_data

# Identifying Norm Rows
AllStats15_16_norm$Squad <- AllStats15_16$Squad


## Data Normalization 21/22
AllStats21_22_norm <- AllStats21_22

# First, we will identify the numeric columns in the dataset
numeric_columns <- sapply(AllStats21_22_norm, is.numeric)

# Next, we will create a new data frame that contains only the numeric columns
numeric_data <- AllStats21_22_norm[, numeric_columns]

# We will then normalize the numeric data by subtracting the minimum value of each column from each value
# and dividing by the range (maximum value - minimum value) of each column
normalized_numeric_data21_22 <- apply(numeric_data, 2, function(x) {
  (x - min(x)) / (max(x) - min(x))
})

# Finally, we will replace the original numeric columns in the dataset with the normalized values
AllStats21_22_norm[, numeric_columns] <- normalized_numeric_data21_22

# Finally, we will replace the original numeric columns in the dataset with the normalized values
AllStats21_22_norm[, numeric_columns] <- normalized_numeric_data21_22

# First, we will identify the numeric columns in the dataset
numeric_columns <- sapply(AllStats21_22_norm, is.numeric)

# Next, we will create a new data frame that contains only the numeric columns
numeric_data <- AllStats21_22_norm[, numeric_columns]

# Finally, we will replace the original data frame with the new one containing only numeric columns
AllStats21_22_norm <- numeric_data

# Identifying Norm Rows
AllStats21_22_norm$Squad <- AllStats21_22$Squad


ui <- fluidPage(
  
  # Add a title to the page
  titlePanel("Soccer Data Analysis"),
  
  # Add a main panel for displaying the results
  mainPanel(
    column(1,),
    column(10, plotOutput(outputId = "plot"),
           paste("It appears that in general, the performance of teams in the Premier 
            League tends to improve when their attendance increases. However, 
            there are some exceptions to this trend. One possible explanation 
            for these discrepancies could be the impact of playing games behind 
            closed doors in the 2021 season. Due to the COVID-19 pandemic, many 
            games were played without any spectators, which may have removed the
            usual home advantage that teams typically experience when playing in
            front of their own fans. This could have resulted in some teams 
            performing differently than expected based on their attendance numbers."),
           br(),br(),
           verbatimTextOutput(outputId = "regression_results")),
    column(1,)
    
  )
  
)


## Mixed-Effects Models For Linear Regression

server <- function(input, output) {
  
  df_Final_Attendance <- data.frame(x = Final_Data$Attendance, y = Final_Data$W, w = Final_Data$Squad)
  
  Attendance_model <- lmer(y ~ x + (1|x), data = df_Final_Attendance)
  
  output$plot <- renderPlot({ 
    ggplot(data = df_Final_Attendance, aes(x = x, y = y, color = w)) +
      geom_count() +
      geom_smooth(method = "lm", se = FALSE) +
      labs(x = "Attendance", y = "Wins")
  })
  
  # Fit mixed effects model
  model <- reactive({
    lm(y ~ x, data = df_Final_Attendance)
  })
  
  # Display regression results
  output$regression_results <- renderText({
    paste("Fixed effects:", model())})
  
}

# Create Shiny app
shinyApp(ui = ui, server = server)
