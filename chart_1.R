library(ggplot2)
library(dplyr)
library(lubridate)
crime_data <- read.csv("https://raw.githubusercontent.com/info201a-su23/exploratory-analysis-p02/main/Crime_Data_from_2020_to_Present.csv", fill = TRUE)

crime_data$Date_Rptd <- as.Date(crime_data$Date.Rptd, format = "%m/%d/%Y")
crime_counts <- crime_data %>% group_by(Date_Rptd) %>% summarise(Count = n())

trend_plot <- ggplot(crime_counts) +
  geom_point(mapping = aes(x = Date_Rptd, y = Count)) +
  geom_smooth(mapping = aes(x = Date_Rptd, y = Count)) +
  labs(
    title = "Trends of Crinunal Cases Happening Around Years",
    x = "By Year",
    y = "Criminal Cases Count",
  )

crime_data$Month <- month(crime_data$Date_Rptd)
crime_counts_month <- crime_data %>%
  group_by(Month) %>%
  summarise(Count = n())

month_arr <- c("Jan", "Feb", "Mar", "Apr", "May",
               "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
crime_counts_month$Month <- month_arr
crime_counts_month$Month <- factor(crime_counts_month$Month, levels = month_arr)

month_plot <- ggplot(crime_counts_month, aes(x = Month, y = Count)) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(
    title = "Trends of Crinunal Cases Happening Around Months",
    x = "By Month",
    y = "Average Criminal Cases Count",
  )

crime_data$TIME.OCC <- as.POSIXct(strptime(crime_data$TIME.OCC,
                                           format = "%H%M"))
crime_data$Hour <- hour(crime_data$TIME.OCC)

table_data_time <- crime_data %>%
  mutate(year = format(as.Date(Date.Rptd, format = "%m/%d/%Y %I:%M:%S %p"),
                       "%Y")) %>%
  group_by(year, Date.Rptd) %>%
  summarise(total_incidents = n(), .groups = "drop")

total_days <- nrow(table_data_time)

hourly_data <- crime_data %>%
  group_by(Hour) %>%
  summarise(Count = n()) %>%
  mutate(hourly = Count/total_days)

filtered_hourly_data <- hourly_data %>%
  filter(Hour >= 10)

time_trend <- ggplot(filtered_hourly_data, aes(x = Hour, y = hourly)) +
  geom_line() +
  labs(
    title = "Trends of Crinunal Cases Happening Around Hours",
    x = "By Hour",
    y = "Avergae Criminal Cases Count",
  )
