# combine virushostdb.tsv and PhagesDB_data.tsv 11/4/2019

virushostdb <- read.delim(file = "~/Desktop/virushostdb.tsv", as.is = TRUE, sep = "\t", header = TRUE)

phagedb <- read.delim(file = "~/Desktop/PhagesDB_Data.tsv", as.is = TRUE, sep = "\t", header = TRUE)


pb <- txtProgressBar(min = 0, max = nrow(phagedb), style = 3)
timestart <- proc.time()

counter = 1

for (i in 1:nrow(phagedb)){

	setTxtProgressBar(pb, i-1)

	# store row i of phagedb tsv in tempdata
	tempdata <- phagedb[i,]

	# store specific fields of that phagedb row into specific variables 
	phagedbacc <- tempdata$Accession..
	phagedbname <- tempdata$Phage.Name
	phagedbhost <- tempdata$Host
	phagedbtaxid <- "pending"

	# place phagedb data into appropriate fields of virushostdb tsv
	virushostdb[counter]$virus.tax.id <- phagedbtaxid
	virushostdb$virus.name <- phagedbname
	virushostdb$host.name <- phagedbhost
	virushostdb$refseqid <- phagedbacc
	virushostdb$evidence <- "PhageDB"
	
	counter = counter + 1


	write.table(virushostdb, file="~/Desktop/combinedvirhost_phagedb.tsv", append = TRUE, sep= "\t", row.names = FALSE, col.names = TRUE, quote = FALSE)

}
