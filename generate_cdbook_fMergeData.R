Data <- fMergeData
cols <- names(Data)
values <- sapply(cols, function(x) {
	cls <- class(Data[[x]])
	if(cls == "integer") 		  	
		paste(cls, min(Data[x]), "to", max(Data[x]), sep = " : ")				
	else if(cls == "factor")
		paste(unique(Data[[x]]), sep = " : ")
	else  if(cls == "numeric")
		paste(cls, min(Data[x]), max(Data[x]), sep = " : ")

	})
write.table(values, "codebook.csv", row.name = FALSE, sep = ",")
