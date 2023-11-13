


#' The Latvian SAA
#'
#' @param app_name
#' @param no_folk_songs
#' @param languages
#'
#' @return
#' @export
#'
#' @examples
SAAlatvian <- function(app_name = "SAAlatvian",
                       no_folk_songs = 10L,
                       languages = c("lv", "en")) {

  language <- match.arg(languages)

  SAA::SAA_standalone(
    app_name = app_name,
    num_items = list(long_tones = 6L, arrhythmic = 0L, rhythmic = 10L),
    #skip_setup = 'except_microphone',
    #default_range = list(bottom_range = 48, top_range = 72),
    append_trial_block_before = latvian_folk_songs_block(no_folk_songs, language),
    languages = "lv",
    get_p_id = TRUE,
    SNR_test = FALSE
  )
}



latvian_folk_songs_block <- function(no_folk_songs, language = "lv") {

  latvian_folksong_item_bank <- latvian_folksong_item_bank %>%
    tibble::as_tibble() %>%
    dplyr::slice_sample(n = no_folk_songs) %>%
    itembankr::set_item_bank_class()

  musicassessr::rhythmic_melody_trials(
    item_bank = latvian_folksong_item_bank,
    presampled = TRUE,
    page_text = "Spied zemāk, lai dzirdētu melodiju. Dziedi melodiju un ritmu. Spied Stop, kad esi beidzis.",
    page_title = "Dziedi melodiju un ritmus!",
    instruction_text = "Tagad tu dzirdēsi dažas melodijas ar ritmiem. Lūdzu, mēģini un dziedi melodijas ar konkrēto ritmu.") %>%
      musicassessr::wrap_musicassessr_timeline(language = "lv") %>%
      list()
}
