library(dplyr)
library(leaflet)

data <- read.csv("Crime_Data_from_2020_to_Present.csv")

grid_cell_size <- 0.005
crime_data$CellRow <- floor(crime_data$LAT / grid_cell_size)
crime_data$CellCol <- floor(crime_data$LON / grid_cell_size)

data <- crime_data %>% group_by(CellRow, CellCol) %>%
  summarise(LAT = mean(LAT), LON = mean(LON), Count = n())

color_range <- colorFactor(
  palette = c("grey", "blue"),
  domain = data$Count
)

map <- leaflet() %>%
  addProviderTiles("Stamen.Toner") %>%
  setView(lng = -118.2879, lat = 34.0141, zoom = 12) %>%
  addRectangles(
    lat1 = data$LAT,
    lng1 = data$LON,
    lat2 = data$LAT + 0.005,
    lng2 = data$LON + 0.005,
    stroke = TRUE,
    popup = paste0("Total Crime in this Area: ", data$Count),
    color = color_range(data$Count)
  )

html_code = "<p>Total Crime by Area in LA</p>"

map <- addControl(map,
                  html = html_code, position = "topright")