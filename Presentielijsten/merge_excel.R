library(openxlsx)

path <- "/Users/markuiz/PycharmProjects/Eigen projectjes/Merge_Excel_files/"


filenames_list <- list.files(path= path, full.names=TRUE)

All <- lapply(filenames_list,function(filename){
  print(paste("Merging",filename,sep = " "))
  read.xlsx(filename)
})

df <- do.call(rbind.data.frame, All)
write.xlsx(df, paste0(path, "merged-files.xlsx"))
