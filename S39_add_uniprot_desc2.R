# enter protein names & accession id, into de/counts table
# this data received by submitting id list (prot_org) from trinotate to uniprot 

de <- read.delim(file = "~/Desktop/de_blastplus_trinotate.tsv", as.is = TRUE, sep = "\t", header = TRUE)
counts <- read.delim(file = "~/Desktop/counts_blastplus_trinotate.tsv", as.is = TRUE, sep = "\t", header = TRUE)
trinotate <- read.delim(file = "~/Desktop/uniprot.tsv", as.is = TRUE, sep = "\t", header = TRUE)


# create a column to store the PROT_ORG information 
de$trinotate_protorg <- NA

for (i in 1:nrow(de)){

	if (is.na(de$trinotate[i]) == FALSE){
		de_id <- de$subj_title[i]

		temp_data <- trinotate[which(de_id == trinotate$prot_org),]

			if (nrow(temp_data)==0){ # length(temp_data) will return 8, the number of columns. 
				stop(paste(de_id, "not found in trinotate description list"))
			}

		de$subj_acc[i] <- temp_data$Entry
		de$subj_title[i] <- temp_data$Protein_names
		de$trinotate_protorg[i] <- temp_data$prot_org

	} else if (is.na(de$trinotate[i]) == TRUE) {
		next
	}
}

write.table(de, file = "~/Desktop/final_de.tsv", sep = "\t", row.names = FALSE, col.names = TRUE, quote = FALSE)

# create a column to store the PROT_ORG information 
counts$trinotate_protorg <- NA

for (i in 1:nrow(counts)){

	if (is.na(counts$trinotate[i]) == FALSE){
		counts_id <- counts$subj_title[i]

		temp_data <- trinotate[which(counts_id == trinotate$prot_org),]

			if (nrow(temp_data)==0){
				stop(paste(counts_id, "not found in trinotate description list"))
			}

		counts$subj_acc[i] <- temp_data$Entry
		counts$subj_title[i] <- temp_data$Protein_names
		counts$trinotate_protorg[i] <- temp_data$prot_org

	} else if (is.na(counts$trinotate[i]) == TRUE){
		next
	}
}

write.table(counts, file = "~/Desktop/final_counts.tsv", sep = "\t", row.names = FALSE, col.names = TRUE, quote = FALSE)
