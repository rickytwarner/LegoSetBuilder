"
This script will generate a list of the parts needed in order to build a 
particular lego set.
"




set_list <- function(set_name)
{
  
  #Libraries
  library(tidyverse)
  
  # Set directory
  setwd('/home/ricky/Documents/ToGithub/A) Ideas/Legos/PBC')
  
  # Load datasets
  colors <- read_csv("./colors.csv")
  inventories <- read_csv("./inventories.csv")
  inventory_parts <- read_csv("./inventory_parts.csv")
  inventory_sets <- read_csv("./inventory_sets.csv")
  part_categories <- read_csv("./part_categories.csv")
  parts <- read_csv("./parts.csv")
  sets <- read_csv("./sets.csv")
  themes <- read_csv("./themes.csv")
  
  export.v1 <- sets %>%
    filter(name == set_name) %>%
    left_join(inventories, by = "set_num") %>%
    select(set_num, name, id, num_parts)
    
  filter_value = export.v1$id
  
  export.v2 <- inventory_parts %>%
    filter(inventory_id == filter_value) %>%
    left_join(colors,  by = c("color_id" = "id")) %>%
    select(inventory_id, part_num, quantity, is_spare, name)
  
  export.v3 <- export.v2 %>%
    left_join(parts, by = "part_num") %>%
    mutate(part_color = name.x) %>%
    mutate(part_name = name.y) %>%
    mutate(buy_url = paste("https://www.bricklink.com/v2/search.page?q=", part_num, "#T=A", sep="")) %>%
    select(part_name, part_color, quantity, buy_url)
  
  write_csv(export.v3, paste("./", set_name, ".csv", sep=""))
}

set_list("Weetabix Promotional House 1")