# READ IN BEST E VALUE OUTPUT FILE THAT HAS TRUNCATED ID NAME IN NEW COLUMN
data <- read.delim("/Volumes/STOLTZY/data/best_evalue_hits_updated.tsv", header = TRUE, sep="\t", as.is = TRUE)

# READ IN SEQ ID LIST
seq_ids <- read.table("/Volumes/STOLTZY/data/seq_ids.tsv", header = FALSE, sep = "\t", as.is = TRUE)

datanew <- data[!is.na(data$truncseqid),]

# WRITE TABLE 
write.table("query_seq_id\tquery_length\tsubj_acc\tsubj_length\tevalue\tsubj_title\talign_length\tquery_covg_per_subj\tperc_pos_score_match\ttruncseqid", file = "/Volumes/STOLTZY/best_hit_per_seq.tsv", sep ="\t",row.names = FALSE, col.names = FALSE, quote = FALSE)

hit <- 0

# PROGRESS BAR
pb <- txtProgressBar(min = 0, max = nrow(list_of_seqids), style = 3)
timestart <- proc.time()

list_of_seqids <- unique(seq_ids)

for (i in 1:nrow(list_of_seqids)){

	setTxtProgressBar(pb, i-1)

	# STORE SEQUENCE THAT WILL MATCH HITS QUERY ID
	seq <- list_of_seqids[i,1]

	# FIND ROWS THAT MATCH QUERY SEQ ID TO SEQ ID FROM UNIQUE ID LIST
	data_row <- datanew$truncseqid == seq

	if (sum(data_row)==0){
		next
	}	

	temp_data <- datanew[data_row,]
		
	# ORDER THE ROWS BASED ON THE ONE WITH THE BEST EVALUE
	best_evalue_hit <- order(temp_data$evalue, decreasing = FALSE)[1]

	hit <- temp_data[best_evalue_hit,]

	write.table(hit, file="/Volumes/STOLTZY/data/best_hit_per_seq.tsv", append = TRUE, sep= "\t", row.names = FALSE, col.names = FALSE, quote = FALSE)


}

# PROGRESS BAR
timeend <- proc.time()
totaltime <- timeend-timestart
