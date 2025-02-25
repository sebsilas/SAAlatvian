
library(tidyverse)

latvian_filtered_item_bank <- Berkowitz::Berkowitz_item_bank_subset %>%
  as_tibble() %>%
  filter(rhythmic_difficulty_percentile <= 10) %>%
  rowwise() %>%
  mutate(total_duration = sum(itembankr::str_mel_to_vector(durations), na.rm = TRUE),
         min_duration = min(itembankr::str_mel_to_vector(durations), na.rm = TRUE),
         max_duration = max(itembankr::str_mel_to_vector(durations), na.rm = TRUE),
         durations = paste0(if(min_duration < .40) itembankr::str_mel_to_vector(durations) * .40/min_duration else durations, collapse = ",")
  ) %>%
  ungroup() %>%
  filter(total_duration < 6,
         N < 13) %>%
  # Scale melodies with min duration < .40 to be higher
  itembankr::set_item_bank_class()



use_data(latvian_filtered_item_bank, overwrite = TRUE)

document()


