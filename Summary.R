library(dplyr)
library(data.table)
df_crime <- read.csv("Crime_Data_from_2020_to_Present.csv")

crime_summary_table <- data.table(
  crime_Num_Rows = nrow(df_crime),
  crime_Num_Columns = ncol(df_crime),
  Num_Of_Area = length(unique(df_crime$AREA.NAME)),
  Num_Of_Crime_Type = length(unique(df_crime$Crm.Cd)),
  Eldest_Victim_Age = max(df_crime$Vict.Age)
)