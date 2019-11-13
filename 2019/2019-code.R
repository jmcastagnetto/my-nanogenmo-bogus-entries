library(magrittr)

# -- read the description file
con <- file(here::here("2019", "desc.txt"), "r", blocking = FALSE)
txtdat <- readLines(con) %>%
  stringr::str_replace_all("[^\\w\\s]", " ") %>%
  stringr::str_squish() %>%
  stringr::str_trim()
close(con)

# -- clean the text a bit and split into words each entry
txtdat_clean <- txtdat %>%
  stringr::str_split(pattern = " ") %>%
  unlist() %>%
  tolower() %>%
  stringr::str_replace_all("[0-9_]+", " ") %>%
  stringr::str_squish() %>%
  stringr::str_trim() %>%
  sort()

# -- convert to a tibble and summarise
df <- tibble::tibble(
  term = txtdat_clean
) %>%
  dplyr::filter(term != "") %>%
  dplyr::group_by(term) %>%
  dplyr::tally() %>%
  dplyr::arrange(desc(n))


# -- generate the "novel"
set.seed(201911) # make it reproducible
par = c()
parlen <- 200 # set 200 words per paragraph
for (i in 1:250) {
  tmp <- df %>%
    dplyr::sample_n(
      size = parlen,
      replace = TRUE,
      weight = n
    ) %>%
    dplyr::pull(term)
  commas <- sample(1:length(tmp), size = 10)
  # add commas
  for(p in commas) {
    tmp <- append(tmp, ", ", p)
  }
  # and semicolons
  semicolons <- sample(1:length(tmp), size = 7)
  for(p in semicolons) {
    tmp <- append(tmp, ", ", p)
  }
  # and some periods here ane there
  periods <- sample(1:length(tmp), size = 4)
  for(p in periods) {
    tmp <- append(tmp, ", ", p)
  }
  par[i] <- paste(tmp, sep = "", collapse = " ") %>%
    stringr::str_replace_all(" (,|;|\\.) ", "\\1 ") %>%
    stringr::str_to_sentence() %>% # capitaliza at least the first sentence char
    stringr::str_wrap(width = 72, indent = 4) %>%  # lines <= 72 chars
    paste0(".") # end paragraph with a period
}

# -- save our Magnum Opus for 2019
con <- file(here::here("2019", "nanogenmo-novel.txt"), "w")
writeLines(text = "[Entry for NaNoGenMo 2019]\n[Main repo: https://github.com/jmcastagnetto/my-nanogenmo-bogus-entries]\n\n", con = con)
writeLines(text = "On the importance of being structured", con = con)
writeLines(text = "=====================================\n", con = con)
writeLines(text = par, con = con, sep = "\n\n")
close(con)




