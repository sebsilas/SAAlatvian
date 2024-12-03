
library(tidyverse)

latvian_filtered_item_bank <- SAA::Berkowitz_item_bank_subset %>%
  as_tibble() %>%
  filter(rhythmic_difficulty_percentile <= 10) %>%
  rowwise() %>%
  mutate(total_duration = sum(itembankr::str_mel_to_vector(durations), na.rm = TRUE),
         min_duration = min(itembankr::str_mel_to_vector(durations), na.rm = TRUE),
         max_duration = max(itembankr::str_mel_to_vector(durations), na.rm = TRUE)
  ) %>%
  ungroup() %>%
  filter(total_duration < 6,
         N < 13) %>%
  itembankr::set_item_bank_class()


use_data(latvian_filtered_item_bank, overwrite = TRUE)

document()


