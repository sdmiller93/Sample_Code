# READ IN DATA FRAME THAT CONTAINS THE BLAST HITS FROM ALL DATABASES COMBINED
data <- read.delim("/Volumes/STOLTZY/data/all_output.tsv", as.is = TRUE)

max_evalue <- 0.00005

seq_ids <- read.table("/Volumes/STOLTZY/data/full_seq_ids.tsv", header = FALSE, sep = "\t", as.is = TRUE)

pb <- txtProgressBar(min = 0, max = nrow(seq_ids), style = 3)

timestart <- proc.time()

write.table("query_seq_id\tquery_length\tsubj_acc\tsubj_length\tevalue\tsubj_title\talign_length\tquery_covg_per_subj\tperc_pos_score_match", file = "/Volumes/STOLTZY/data/good_hits/evalue/best_evalue_hits.tsv", sep ="\t",row.names = FALSE, col.names = FALSE, quote = FALSE)

write.table("query_seq_id\tquery_length\tsubj_acc\tsubj_length\tevalue\tsubj_title\talign_length\tquery_covg_per_subj\tperc_pos_score_match", file = "/Volumes/STOLTZY/data/good_hits/covg/best_covg_hits.tsv", sep ="\t",row.names = FALSE, col.names = FALSE, quote = FALSE)

write.table("query_seq_id\tquery_length\tsubj_acc\tsubj_length\tevalue\tsubj_title\talign_length\tquery_covg_per_subj\tperc_pos_score_match", file = "/Volumes/STOLTZY/data/good_hits/e_and_covg/best_eval_covg_hits.tsv", sep ="\t",row.names = FALSE, col.names = FALSE, quote = FALSE)


for (i in 1:nrow(seq_ids)){

	setTxtProgressBar(pb, i-1)

	# STORE SEQUENCE THAT WILL MATCH HITS QUERY ID
	seq <- seq_ids[i,1]

	# FIND ROWS THAT MATCH QUERY SEQ ID TO SEQ ID FROM UNIQUE ID LIST
	temp_data <- data[data$query_seq_id == seq,]

	# THROW OUT THOSE THAT FALL BELOW EVALUE THRESHOLD
	temp_data <- temp_data[temp_data$evalue < max_evalue,]


	# nrow[temp_data] will tell you how many hits you have for that sequence
	# temp_data$evalue will show you the evalues for the rows that match your sequence


	# INITIALIZE total_hits
	total_hits = 0

	# IN CASE OF THERE NOT BEING AT LEAST 10 HITS FOR ANY GIVEN SEQ
	if (nrow(temp_data)<10) {
		total_hits = nrow(temp_data)
	} else {
		total_hits = 10
	}


	# ORDER BY E VALUE, LOWEST EVALUE = BEST
	good_evalue <- order(temp_data$evalue, decreasing = FALSE)[1:total_hits]
	
	# ORDER BY HIGHEST COVERAGE
	good_covg <- order(temp_data$query_covg_per_subj, decreasing = TRUE)[1:total_hits]

	# WRITE THESE DATA TO FILES FOR BACKUP
	write.table(temp_data[good_evalue,], file = "/Volumes/STOLTZY/data/good_hits/evalue/best_evalue_hits.tsv", append = TRUE, sep= "\t", row.names = FALSE, col.names = FALSE, quote = FALSE)
	write.table(temp_data[good_covg,], file = "/Volumes/STOLTZY/data/good_hits/covg/best_covg_hits.tsv", append = TRUE, sep= "\t", row.names = FALSE, col.names = FALSE, quote = FALSE)

	# temp_data[good_covg,] will show you all rows and columns that match sequence and best coverage

	# KEEP THE ROWS THAT ARE FOUND IN BOTH GOOD EVALUE AND GOOD COVG
	good_both <- intersect(good_evalue, good_covg)

	# WRITE THAT TO A FILE FOR BACKUP
	write.table(temp_data[good_both,], file = "/Volumes/STOLTZY/data/good_hits/e_and_covg/best_eval_covg_hits.tsv", append = TRUE, sep= "\t", row.names = FALSE, col.names = FALSE, quote = FALSE)


} # for (i in 1:length(seq_ids)):

timeend <- proc.time()
totaltime <- timeend-timestart