
db <- read.delim(file="~/Desktop/finalPhagesDB_table2.tsv", as.is = TRUE, sep = "\t", header = TRUE)

viral <- read.delim(file="~/Desktop/Viral_Taxonomy_clean.tsv", as.is = TRUE, sep = "\t", header = FALSE)
host <- read.delim(file="~/Desktop/Bacterial_Taxonomy_clean.tsv", as.is = TRUE, sep = "\t", header = FALSE)

for (i in 1:nrow(viral)){

	temptaxid <- viral[i,1]
	templin <- viral[i,2]

	match <- which(db$virustaxid == temptaxid)

	db$viruslineage[match] <- templin


}

for (j in 1:nrow(host)){

	temptaxid2 <- host[j,1]
	templin2 <- host[j,2]

	match2 <- which(db$hosttaxid == temptaxid2)


	if (length(match2) > 1){

		for (k in 1:length(match2)){
		
			newmatch <- match2[k]
			newmatchid <- host[newmatch,1]
			newmatchlin <- host[newmatch,2]

			db$hostlineage[newmatch] <- newmatchlin
			
		
		}

	}else{
		db$hostlineage[match2] <- templin2
}

}

write.table(db, file="~/Desktop/finalPhagesDB.tsv", append = FALSE, sep= "\t", row.names = FALSE, col.names = TRUE, quote = FALSE)
