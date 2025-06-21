dados_cetesb
library(geobr)
library(tidyverse)

municipios_sp <- read_municipality("SP")

cetesb_sf <- left_join(municipios_sp, dados_cetesb, by = c("code_muni" = "codigo_ibge"))

mapa_cetesb <- cetesb_sf |> 
  ggplot() +
  geom_sf(aes(fill = ictem)) +
  scale_fill_viridis_c(values = c(0, 1), direction = -1) +
  labs(title = "ICTEM Município de São Paulo 2022",
       subtitle = "Indicador de Coleta e Tratabilidade de Esgoto da População Urbana de Município",
       caption = "Fonte: Dados da CETESB",
       fill = "ICTEM") +
  theme_minimal() +
  theme(legend.position = "bottom")

ggsave("mapa_cetesb.png", plot = mapa_cetesb, width = 10, height = 8, dpi = 300)
