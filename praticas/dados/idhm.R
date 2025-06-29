library(abjData)
dados_filtrados <- abjData::pnud_min |> 
  dplyr::filter(ano == max(ano), uf_sigla == "SP") 

readr::write_csv(dados_filtrados, "praticas/dados/idhm_sp_2010.csv")  
