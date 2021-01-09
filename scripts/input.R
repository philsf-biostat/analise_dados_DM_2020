library(readxl)
library(data.table)

dados <- data.table(read_excel("dataset/basedados_DM_2020.xlsx"))

# novas variáveis ---------------------------------------------------------

# EVD = diferença entre EVD pós e pré
dados$EVD <- dados$`EVD PÓS` - dados$`EVD PRÉ`

# Lado acometido é o lado dominante?
dados[, DOMINANTE := `LADO ACOMETIDO` == `LADO DOMINANTE`]

# data cleaning -----------------------------------------------------------

# RETORNO como booleana
dados$RETORNO <- dados$RETORNO == "SIM"

# colunas numéricas e categóricas
num.vars <- c("EVD PRÉ", "EVD PÓS", "DOMINANTE", "IDADE", "EVD", "TEMPO ARTROSE", "RETORNO")
cat.vars <- setdiff(names(dados), num.vars)

# cols categóricas como factor
dados[, c(cat.vars) := lapply(.SD, factor), .SDcols = cat.vars]