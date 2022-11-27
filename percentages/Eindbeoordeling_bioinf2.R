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

for(row in rownames(df_new)) {
  each_row <- df_new[row,]
  for(i in each_row[3:length(each_row)]) {
    print(i)
    #ifelse(i < 50, df_new$Opmerking <- "Onvoldoende", "Voldoende")
    ifelse(i < 50, print("Onvoldoende"), print("Voldoende"))
  }
}
