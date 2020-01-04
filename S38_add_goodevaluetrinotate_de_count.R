# this script will match seq IDs from the trinotate file with the de/count files and import that blast row info

# de is new de blast table with blastplus trinotate columns (blastplus rows only marked right now)
# counts = new count table with blastplus/trinotate columns with blastplus rows marked yes
# trinotate = trinotate table that has good evalue hits for every sequence that was NOT translated with transdecoder
de <- read.delim(file = "~/Desktop/new_updated_de_blast.tsv", as.is = TRUE, sep = "\t", header = TRUE)
counts <- read.delim(file = "~/Desktop/new_updated_counts_blast.tsv", as.is = TRUE, sep = "\t", header = TRUE)
trinotate <- read.delim(file = "~/Desktop/good_evalue_trinotate.tsv", as.is = TRUE, sep = "\t", header = TRUE)

yes = "yes"

# de for loop
for (i in 1:nrow(trinotate)){
	id <- trinotate$qseqid[i]

	row <- which(de$trinity_id == id) # will give row # where the trinity id matches -- need to add an if sum = 0 throw warning

	if (length(row) > 1 ){
		warning(paste("multiple de entries exist for trinity id", id))
	}

	# insert the trinotate row (i) into the 'row' of the de table.
	temp_data <- trinotate[i,]
	de$query_seq_id[row] <- temp_data$qseqid
	de$query_length[row] <- temp_data$length
	de$subj_length[row] <- (temp_data$qstart - temp_data$qend)
	de$evalue[row] <- temp_data$evalue
	de$subj_title[row] <- temp_data$prot_org
	de$align_length[row] <- (temp_data$sstart - temp_data$send)
	de$query_covg[row] <- temp_data$bitscore
	de$perc_pos_score_match[row] <- temp_data$pident
	de$trinotate[row] <- yes

}

write.table(de, file = "~/Desktop/de_blastplus_trinotate.tsv", sep = "\t", row.names = FALSE, col.names = TRUE, quote = FALSE)

# counts for loop
for (i in 1:nrow(counts)){
	id <- trinotate$qseqid[i]

	row <- which(counts$trinity_id == id) # will give row # where the trinity id matches -- need to add an if sum = 0 throw warning

	if (length(row) > 1 ){
		warning(paste("multiple counts entries exist for trinity id", id))
	}

	# insert the trinotate row (i) into the 'row' of the de table.
	temp_data <- trinotate[i,]
	counts$query_seq_id[row] <- temp_data$qseqid
	counts$query_length[row] <- temp_data$length
	counts$subj_length[row] <- (temp_data$qstart - temp_data$qend)
	counts$evalue[row] <- temp_data$evalue
	counts$subj_title[row] <- temp_data$prot_org
	counts$align_length[row] <- (temp_data$sstart - temp_data$send)
	counts$query_covg[row] <- temp_data$bitscore
	counts$perc_pos_score_match[row] <- temp_data$pident
	counts$trinotate[row] <- yes

}

write.table(counts, file = "~/Desktop/counts_blastplus_trinotate.tsv", sep = "\t", row.names = FALSE, col.names = TRUE, quote = FALSE)
