

setwd('/Users/sebsilas/SAAlatvian/data-raw')

#debug(itembankr::create_item_bank)

itembankr::create_item_bank(
  name = "latvian_folk_songs",
  input = "files_phrases",
  output = "item",
  midi_file_dir = "latvian_folk_songs"
)


load('latvian_folk_songs_item.rda')

latvian_folksong_item_bank <- item_bank

use_data(latvian_folksong_item_bank, overwrite = TRUE)
