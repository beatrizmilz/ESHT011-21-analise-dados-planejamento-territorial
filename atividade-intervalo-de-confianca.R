# pacotes
library(tidyverse)
library(janitor)
library(googlesheets4)

dados_brutos <- read_sheet("https://docs.google.com/spreadsheets/d/1Si2E6Oik-DXaaXy8059l2pWzy_mkhMkbn6iBYUwaYlM/edit?usp=sharing")

# leitura do csv exportado do Google Forms
# dados_brutos <- read_csv("respostas_forms.csv")

# limpeza de nomes de colunas
dados <- clean_names(dados_brutos) |> 
  select(-endereco_de_e_mail, -nome) |> 
  mutate(altura_em_metros = as.numeric(altura_em_metros)) 

glimpse(dados)

# Fazer um boxplot para visualizar a distribuição das alturas
dados |> 
ggplot(aes(x = sexo_biologico, y = altura_em_metros)) +
  geom_boxplot() +
  labs(title = "Distribuição das Alturas por Sexo Biológico", x = "Sexo Biológico", y = "Altura (m)") +
  theme_minimal()


# calcular média, desvio padrão, n e IC para cada grupo
ic_altura <- dados |> 
  group_by(sexo_biologico) |> 
  summarise(
    media = mean(altura_em_metros, na.rm = TRUE),
    desvio_padrao = sd(altura_em_metros, na.rm = TRUE),
    tamanho_amostra_n = n(),
    erro_padrao = desvio_padrao / sqrt(tamanho_amostra_n),
    ic_inferior = media - (1.96 * erro_padrao),
    ic_superior = media + (1.96 * erro_padrao)
  )

ic_altura


ggplot(ic_altura,
       aes(x = sexo_biologico, y = media, color = sexo_biologico)) +
  geom_point(show.legend = FALSE) +
  geom_errorbar(aes(ymin = ic_inferior, ymax = ic_superior),
                width = 0.2,
                show.legend = FALSE) +
  labs(title = "Intervalo de Confiança das Alturas por Sexo Biológico", x = "Sexo Biológico", y = "Altura Média (m)") +
  scale_color_brewer(palette = "Set2", direction = -1) +
  theme_minimal()

