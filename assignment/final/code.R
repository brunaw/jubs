#-----------------------------------------------------------------------
# perl, c and R
# Bruna Wundervald, May 2019
#-----------------------------------------------------------------------
library(tidyverse)
library(ggridges)
setwd("assignment/")

# Using perl in R-------------------------------------------------------
# extracting chords data for perl
songs <- chorrrds::get_songs("muse")
chords <- chorrrds::get_chords(songs$url)

# saving it! 
write.table(chords, "chords.txt")
chords <- read.table("chords.txt")

# dimensions of our data 
dim(chords) # 3577 rows and 3 columns
glimpse(chords)

# saving only the unique chords found
chords_unique <- chords %>% 
  pull(chord) %>% 
  unique() 

# calculating the results for each chord using perl function
regex <- chords_unique %>% 
  stringr::str_remove_all(., pattern = "\\(|\\)") %>% 
  map(~{
    arg <- .x
    cmd <- paste("perl", "regex.pl", arg)
    system(cmd, intern = TRUE)
  }) 

# obtaining the formatted results
results <- regex  %>% map(~{
  stringr::str_split_fixed(.x, n = 12, pattern = "") %>% c()
}) %>% 
  setNames(1:126) %>% 
  bind_rows() %>% 
  t() %>% 
  as.data.frame() %>% 
  setNames(
    c("minor", "dimi", "augm", "sus",
      "seventh", "seventh_M", "sixth", 
      "fourth", "fifth_aug", "fifth_dim", 
      "ninth", "bass")
  ) %>% 
  mutate_if(is.factor, as.character) %>% 
  mutate_if(is.character, as.numeric) %>% 
  mutate(chord = chords_unique) %>% 
  full_join(chords, by = ('chord' = 'chord'))

glimpse(results) # 3577 rows and 15 columns now

# creating a plot to visualize the densities of the extracted variables
df <- results %>% 
  select(-chord, -key) %>% 
  group_by(music) %>% 
  summarise_all(mean) %>% 
  tidyr::gather(group, vars, minor, seventh, sus,
                seventh_M, sixth, fifth_dim, fifth_aug, 
                fourth, ninth, bass, dimi, augm) %>% 
  mutate(group = as.factor(group))
  

df$group <- forcats::lvls_revalue(
  df$group,
  c("Augmented", "Bass", "Diminished", 
    "Augm. Fifth", "Dimi. Fifth", 
    "Fourth", "Minor", "Ninth", "Seventh",
    "Major Seventh", "Sixth", "Sus"))

# visualizing it!
df %>% 
ggplot(aes(vars, group, fill = group)) +
  geom_density_ridges(alpha = 0.6) +
  scale_fill_cyclical(values =  "darksalmon") +
  guides(fill = FALSE) +
  xlim(0, 1) +
  labs(x = "Densities", y = "Extracted variables") +
  theme_bw(14)

#-----------------------------------------------------------------------
# Using c in R ---------------------------------------------------------
# loading credentials to use with API
source("credentials.R")

# obtaining lyrics from Muse songs with the Vagalume API
songs <- "muse" %>% 
  purrr::map_dfr(vagalumeR::songNames)

# formatted results for lyrics
lyrics <-  songs %>% 
  dplyr::pull(song.id) %>% 
  purrr::map(vagalumeR::lyrics, 
             artist = "muse",
             type = "id", 
             key = vg) %>%
  purrr::map_dfr(data.frame) %>% 
  dplyr::select(-song) %>% 
  dplyr::right_join(songs %>% 
                      dplyr::select(song, song.id), by = "song.id")

dim(lyrics) # 143 rows and 8 columns
# saving it!
write.table(lyrics, "lyrics.txt")

# saving lyrics separately to use with c
purrr::map2(
  .x = lyrics$text %>% as.character(),
  .y = lyrics$id,
  .f = 
    ~{
      write.table(.x, 
                  file = paste0("lyrics/file_", .y, ".txt",
                                collapse = ""))
      
    })

# applying c function to each lyric
fs <- list.files("lyrics/")

res <- fs %>% map_chr(~{
  paste(getwd(),"/count ", paste0("lyrics/", .x) ,sep="")}) %>% 
  purrr::map_chr(~{system(.x, intern = TRUE)})

# obtaining formatted results 
df <- data.frame(
  song = lyrics$song,
  n_words = str_extract(res, "[0-9]{1,5}") %>% as.numeric())

# visualizing it!
df %>% 
  ggplot(aes(reorder(song, n_words), n_words)) +
  geom_bar(alpha = 0.6, stat = "identity", fill = "darksalmon") +
  guides(fill = FALSE) +
  coord_flip() +
  labs(x = "Songs", y = "Number of words") +
  theme_bw(10)
#-----------------------------------------------------------------------