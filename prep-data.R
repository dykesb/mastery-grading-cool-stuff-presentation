library(googlesheets4)

# Prevent need for Google credentials with public sheet
gs4_deauth()

# URL from Google Sheet 
# This is a public sheet (not recommended for actual grades)
# You can use private sheets: https://googlesheets4.tidyverse.org/articles/articles/auth.html
class_rubric <- read_sheet("https://docs.google.com/spreadsheets/d/1gKdp4ZokPxJVo4LDv5Vb2gU8ctm4D4kJWk2UiglHRtw/edit#gid=0")

library(tidyverse)
library(rmarkdown)
# Want to update using parameterized Rmd files and purrr:walk()
for(i in class_rubric$student){
  df <- class_rubric %>% filter(student == i)
  
  save(df, file="df.Rdata")
  
  render(here::here("rubric-template.Rmd"),
         output_file = glue::glue("{df$student}_rubric.docx"),
         output_dir = here::here("rubrics"))
}
