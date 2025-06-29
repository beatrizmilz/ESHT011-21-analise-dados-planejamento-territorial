library(tidyverse)
agua_rede1 <- read_csv2("https://raw.githubusercontent.com/luisfelipebr/mti/master/dados/agua_rede1.csv", locale = readr::locale(encoding="ISO-8859-1")
                   )

agua_rede1 |> 
  janitor::clean_names() |> 
  write_csv2("praticas/dados/agua_rede1.csv")
