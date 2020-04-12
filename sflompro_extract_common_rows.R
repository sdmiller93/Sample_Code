# for NanoLC and sFlomPro data, identify which accession numbers are present 
# in each dataste and extract the abundance values 

# I took the master spreadsheet given to me and just took the sflompro and nanolc
# tabs and, values only, copied into new files - tsv format

# read in both datasets
sflompro <- read.delim(file = "~/Desktop/sFlomPro.tsv", as.is = TRUE, sep = "\t", header = TRUE)
nanolc <- read.delim(file = "~/Desktop/NanoLC.tsv", as.is = TRUE, sep = "\t", header = TRUE)


# get rid of any rows with NA values in the abundance fields
for (i in 1:nrow(sflompro)){
	
	sflomrow <- sflompro[i,]
	
	if (is.na(sflomrow$Abundance.Ratio...F2..128C.....F2..131.) == TRUE){
		next
	}else{
		write.table(sflomrow, file = "~/Desktop/sflom_out.tsv", row.names = FALSE, col.names = FALSE, append = TRUE, sep = "\t")
	}
}

for (i in 1:nrow(nanolc)){
	
	nanorow <- nanolc[i,]
	
	if (is.na(nanorow$Abundance.Ratio...F1..129N.....F1..131.) == TRUE){
		next
	}else{
		write.table(nanorow, file = "~/Desktop/nano_out.tsv", row.names = FALSE, col.names = FALSE, append = TRUE, sep = "\t")
	}
}

# read in the files that contain only rows with valid abundance values
sflom <- read.delim(file = "~/Desktop/sflom_out.tsv", as.is = TRUE, sep = "\t", header = TRUE)
nano <- read.delim(file = "~/Desktop/nano_out.tsv", as.is = TRUE, sep = "\t", header = TRUE)

# identify matching accession numbers
# store accession numbers
sflom_acc <- sflom$Accession  # 6,770
nano_acc <- nano$Accession  # 6,754

# compare both sets of accession numbers, extract ones found in both lists
acc <- intersect(sflom_acc, nano_acc) # 5,974

# for the accession rows that are found in both datasets, move to new output
for (i in 1:length(acc)){
	
	# find the row that matches the ith acc id
	sflomid <- acc[i]
	sflomrow <- sflom[which(sflom$Accession == sflomid),]
	write.table(sflomrow, file = "~/Desktop/sflom_final.tsv", row.names = FALSE, col.names = FALSE, append = TRUE, sep = "\t")
}

message <- ("starting nanolc")
print(message)

# pull associated nanolc abundance values
for (j in 1:length(acc)){
		
	# find the row that matches the ith acc id
	nanoid <- acc[j]
	nanorow <- nano[which(nano$Accession == nanoid),]
	write.table(nanorow, file = "~/Desktop/nano_final.tsv", row.names = FALSE, col.names = FALSE, append = TRUE, sep = "\t")
}








