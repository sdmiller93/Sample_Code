## THIS SCRIPT COMBINES THE EDGER NORMALIZED COUNTS WITH THE BLASTP, RAW, COUNT TABLE

# READ IN THE BLAST OUTPUT TABLE THAT CONTAINS THE RAW COUNTS
blast_out <- read.delim("/Volumes/STOLTZY/data/count_blast_table.tsv", as.is = TRUE, header = TRUE)

# READ IN THE NORMALIZED COUNT TABLE
counts <- read.delim("/Volumes/STOLTZY/data/edgeR/edgeR_output/edgeR_normcounts.tsv", as.is = TRUE, header = TRUE)

# READ IN THE MSTRG IDS BY WHICH THE FOR LOOP WILL RUN FROM
seq_ids <- read.table("/Volumes/STOLTZY/data/mstrg_ids.tsv", header = TRUE, sep = "\t", as.is = TRUE)

# WRITE NEW COLUMNS THAT NORMALIZED COUNTS WILL BE PLACED INTO
blast_out$keel_tt_normalized <- NA
blast_out$keel_uu_normalized <- NA
blast_out$keel_ww_normalized <- NA

blast_out$mantle_tt_normalized <- NA
blast_out$mantle_uu_normalized <- NA
blast_out$mantle_ww_normalized <- NA

blast_out$nuchal_tt_normalized <- NA
blast_out$nuchal_uu_normalized <- NA
blast_out$nuchal_ww_normalized <- NA

# PROGRESS BAR
pb <- txtProgressBar(min = 0, max = nrow(seq_ids), style = 3)
timestart <- proc.time()

for (i in 1:nrow(seq_ids)){

	setTxtProgressBar(pb, i-1)

	# STORE SEQ ID TO MATCH WITH COUNTS SEQ IDS
	seq <- seq_ids[i,1]

	# MATCH MSTRG ID IN BLAST OUT FILE TO MSTRG ID BEING HELD IN SEQ
	blast_seq_row <- blast_out$mstrg_id == seq

	# MATCH MSTRG ID IN COUNTS FILE
	temp_data <- counts[counts$GeneID == seq,]
	

	# ENTER NORMALIZED COUNTS INTO PROPER ROWS/COLS
	blast_out$keel_tt_normalized[blast_seq_row] <- temp_data$keel_tt
	blast_out$keel_uu_normalized[blast_seq_row] <- temp_data$keel_uu
	blast_out$keel_ww_normalized[blast_seq_row] <- temp_data$keel_ww

	blast_out$mantle_tt_normalized[blast_seq_row] <- temp_data$mantle_tt
	blast_out$mantle_uu_normalized[blast_seq_row] <- temp_data$mantle_uu
	blast_out$mantle_ww_normalized[blast_seq_row] <- temp_data$mantle_ww

	blast_out$nuchal_tt_normalized[blast_seq_row] <- temp_data$nuchal_tt
	blast_out$nuchal_uu_normalized[blast_seq_row] <- temp_data$nuchal_uu
	blast_out$nuchal_ww_normalized[blast_seq_row] <- temp_data$nuchal_ww


} # for (i in 1:length(seq_ids)):



write.table(blast_out,file = "/Volumes/STOLTZY/data/blastp_allcounts.tsv", sep = "\t")


# PROGRESS BAR
timeend <- proc.time()
totaltime <- timeend-timestart







