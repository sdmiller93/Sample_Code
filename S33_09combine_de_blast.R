## ADD BLAST INFORMATION TO THE COMBINED DE OUTPUT TABLE

# READ IN COMBINED DE OUTPUT TABLE
de <- read.delim(file = "/Volumes/STOLTZY/data/de_combined_with_trinids.tsv", as.is = TRUE, sep = "\t", header = TRUE)

# READ IN BLAST OUTPUT 
blast <- read.delim(file = "/Volumes/STOLTZY/data/besthitperseq_mstrg_ids.tsv", as.is = TRUE, sep = "\t", header = TRUE)

# ADD NEW COLUMNS TO DE FILE
de$query_seq_id <- NA
de$query_length <- NA
de$subj_acc <- NA
de$subj_length <- NA
de$evalue <- NA
de$subj_title <- NA
de$align_length <- NA
de$query_covg <- NA
de$perc_pos_score_match <- NA
de$truncseqid <- NA
de$mstrg_id <- NA

# PROGRESS BAR
pb <- txtProgressBar(min = 0, max = nrow(de), style = 3)
timestart <- proc.time()

for (i in 1:nrow(de)){

	setTxtProgressBar(pb, i-1)

	# STORE SEQ ID TO MATCH WITH COUNTS SEQ IDS
	seq <- de[i,19]

	# MATCH MSTRG ID IN BLAST OUT FILE TO MSTRG ID BEING HELD IN SEQ
	# blast_seq_row <- blast[blast$mstrg_id == ,]
	blast_seq_row <- blast[which(blast$truncseqid == seq),]

	if (length(which(blast$truncseqid == seq)) == 0) {
		next
	}

	if (length(which(blast$mstrg_id == seq)) > 1) {
		print(paste(seq, "has more than one match in blast dataframe.", sep = " ")); next
	}

	

	# ENTER BLAST DATA INTO APPROPRIATE COLUMNS IN THE CORRECT ROW
	
	de$query_seq_id[i] <- blast_seq_row$query_seq_id
	de$query_length[i] <- blast_seq_row$query_length
	de$subj_acc[i] <- blast_seq_row$subj_acc
	de$subj_length[i] <- blast_seq_row$subj_length
	de$evalue[i] <- blast_seq_row$evalue
	de$subj_title[i] <- blast_seq_row$subj_title
	de$align_length[i] <- blast_seq_row$align_length
	de$query_covg[i] <- blast_seq_row$query_covg
	de$perc_pos_score_match[i] <- blast_seq_row$perc_pos_score_match
	de$truncseqid[i] <- blast_seq_row$truncseqid
	de$mstrg_id[i] <- blast_seq_row$mstrg_id

} # for (i in 1:length(seq_ids)):

write.table(de,file = "/Volumes/STOLTZY/de_blast_out.tsv", row.names = FALSE, col.names = TRUE, append = TRUE, sep = "\t")


# PROGRESS BAR
timeend <- proc.time()
totaltime <- timeend-timestart



