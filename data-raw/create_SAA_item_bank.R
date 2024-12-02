
library(tidyverse)

latvian_filtered_item_bank <- SAA::Berkowitz_item_bank_subset %>%
  as_tibble() %>%
  filter(rhythmic_difficulty_percentile <= 10) %>%
  itembankr::set_item_bank_class()


use_data(latvian_filtered_item_bank)

document()

