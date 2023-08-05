library(dplyr)
library(ggplot2)
library(lubridate)

crime_data <- read.csv("https://raw.githubusercontent.com/info201a-su23/exploratory-analysis-p02/main/Crime_Data_from_2020_to_Present.csv", fill = TRUE)
crime_type_summary <- crime_data %>%
  group_by(Crm.Cd.Desc) %>%
  summarise(total_incidents = n(), .groups = "drop") %>%
  arrange(desc(total_incidents))

top_10 <- crime_type_summary %>%
  top_n(10, wt = total_incidents) %>%
  arrange(desc(total_incidents))

chart_3 <- ggplot(top_10) +
  geom_col(mapping = aes(x = Crm.Cd.Desc, y = total_incidents), fill = "Blue") +
  labs(title = "Crime Indicdents by Types", y = "Total Incidents",
       x = "Crime Type") +
  coord_flip() # switch the orientation of the x- and y-axes
