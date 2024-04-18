


#' The Latvian SAA
#'
#' @param app_name
#' @param no_folk_songs
#' @param no_items
#' @param languages
#' @param musicassessr_aws
#'
#' @return
#' @export
#'
#' @examples
SAAlatvian <- function(app_name = "SAAlatvian",
                       no_folk_songs = 10L,
                       num_items = list(
                         long_tones = 0L,
                         # long_tones = 6L,
                         arrhythmic = 0L,
                         rhythmic = 1L
                         #rhythmic = 10L
                         ),
                       languages = c("lv", "en")) {

  language <- match.arg(languages)

  songs <- latvian_folk_songs_block(no_folk_songs, language)

  before <-   psychTestR::one_button_page(
    shiny::tags$div(
      shiny::tags$script("var upload_to_s3 = true; console.log('Turning S3 mode on');"),
      shiny::tags$p("Turpināsim.")
    )
  )


  SAA::SAA_standalone(
    app_name = app_name,
    examples = 2L,
    num_items = num_items,
    append_trial_block_before = before,
    append_trial_block_after = songs,
    languages = "lv",
    get_p_id = TRUE,
    SNR_test = FALSE,
    final_results = FALSE,
    gold_msi = FALSE,
    demographics = FALSE,
    absolute_url = "https://musicassessr.com/saa-latvian-2024/",
    skip_setup = 'except_microphone',
    experiment_id = 1L, # dev
    #experiment_id = 4L, # Latvian SAA
    musicassessr_aws = TRUE,
    use_musicassessr_db = TRUE,
    asynchronous_api_mode = TRUE,
    user_id = 62L, # SAA latvian experiment user
    get_answer_melodic = musicassessr::get_answer_add_trial_and_compute_trial_scores_s3

  )
}



latvian_folk_songs_block <- function(no_folk_songs, language = "lv") {

  latvian_folksong_item_bank <- latvian_folksong_item_bank %>%
    tibble::as_tibble() %>%
    dplyr::slice_sample(n = no_folk_songs) %>%
    itembankr::set_item_bank_class()

  musicassessr::rhythmic_melody_trials(
    asynchronous_api_mode = TRUE,
    item_bank = latvian_folksong_item_bank,
    presampled = TRUE,
    page_text = "Spied zemāk, lai dzirdētu melodiju. Dziedi melodiju un ritmu. Spied Stop, kad esi beidzis.",
    page_title = "Dziedi melodiju un ritmus!",
    instruction_text = "Tagad tu dzirdēsi dažas melodijas ar ritmiem. Lūdzu, mēģini un dziedi melodijas ar konkrēto ritmu.") %>%
      musicassessr::wrap_musicassessr_timeline(language = "lv") %>%
      list()
}
