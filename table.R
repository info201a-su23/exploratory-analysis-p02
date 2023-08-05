library(dplyr)
library(data.table)
df_crime <- read.csv("https://raw.githubusercontent.com/info201a-su23/exploratory-analysis-p02/main/Crime_Data_from_2020_to_Present.csv", fill = TRUE)

sex_info <- df_crime %>% group_by(Vict.Sex) %>% summarise(Count = n())

gender_summary_table <- data.table(
  unknown_gender = sex_info$Count[1],
  female_vict = sex_info$Count[2]
)

age_info <- df_crime %>%
  filter(!is.na(Vict.Age)) %>%
  group_by(Vict.Age) %>%
  summarise(Total = n())

breaks <- seq(min(age_info$Vict.Age), max(age_info$Vict.Age), by = 10)
age_groups <- cut(df_crime$Vict.Age,
                  breaks = breaks,
                  labels = c("0-10", "10-20", "20-30", "30-40", "40-50", "50-60", "60-70", "70-80", "80-90", "90-100", "100-110", "110-120"), include.lowest = TRUE, right = FALSE)

age_summary_df <- data.frame(table(age_groups))

area_info <- df_crime %>% group_by(AREA.NAME) %>% summarise(Count = n())

area_summary_table <- data.table(area_info)
