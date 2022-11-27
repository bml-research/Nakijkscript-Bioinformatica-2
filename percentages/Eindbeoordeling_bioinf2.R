library(xlsx)
library(openxlsx)
library(gtools)
library(stringr)

setwd("/Users/markuiz/PycharmProjects/Eigen projectjes/Nakijken_Bioinformatica/Eindbeoordeling/input")
read_path <- "/Users/markuiz/PycharmProjects/Eigen projectjes/Nakijken_Bioinformatica/Eindbeoordeling/input/"
save_path <- "/Users/markuiz/PycharmProjects/Eigen projectjes/Nakijken_Bioinformatica/Eindbeoordeling/output/"

files_to_read <- mixedsort(list.files(
  path = read_path, 
  pattern = ".xlsx"))
df_percentages <- list()
for(f in files_to_read) {
  lespercentages <- read.xlsx(f, 1)
  df_percentages[[f]] <- data.frame(lespercentages)
  df_percentages[[f]]$Les <- as.numeric(str_extract(f, "\\d+"))
  #colnames(df_punten[[f]]) <- c("Studentnummer", "Naam", "Percentage", "Les")
}

merged_df <- Reduce(function(...) merge(..., by = "Studentnummer", all = T), 
                    df_percentages)
df_new <- merged_df[, c(1:2, seq(3, ncol(merged_df), 3))]
colnames(df_new) <- c("Studentnummer", "Naam", paste0("Les ", 
                                                      rep(seq_along(files_to_read))))
df_new$mean <- rowMeans(df_new[3:length(df_new)])
df_new$Beoordeling <- ifelse(apply(df_new[3:8], 1, function(x) any(x < 50)) == T,
                             "Onvoldoende", "Voldoende")

