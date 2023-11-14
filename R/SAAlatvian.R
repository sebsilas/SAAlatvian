


#' The Latvian SAA
#'
#' @param app_name
#' @param no_folk_songs
#' @param no_items
#' @param languages
#'
#' @return
#' @export
#'
#' @examples
SAAlatvian <- function(app_name = "SAAlatvian",
                       no_folk_songs = 10L,
                       num_items = list(long_tones = 6L, arrhythmic = 0L, rhythmic = 10L),
                       languages = c("lv", "en")) {

  language <- match.arg(languages)

  SAA::SAA_standalone(
    app_name = app_name,
    examples = 2L,
    num_items = num_items,
    append_trial_block_after = latvian_folk_songs_block(no_folk_songs, language),
    languages = "lv",
    get_p_id = TRUE,
    SNR_test = FALSE,
    final_results = FALSE,
    gold_msi = FALSE,
    demographics = FALSE
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
