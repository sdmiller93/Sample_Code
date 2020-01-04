## THIS SCRIPT IS TO COMBINE THE BLAST BEST HITS WITH THE RAW ABUNDANCE COUNTS OUTPUT. 

# READ IN THE BLAST OUTPUT 
blast_out <- read.delim("/Volumes/STOLTZY/data/besthitperseq_mstrg_ids.tsv", as.is = TRUE, header = TRUE)

# READ IN THE COUNTS OUTPUT
keel <- read.delim(file = "/Volumes/STOLTZY/data/counts/keel_raw_counts.tsv", header = TRUE, sep = "\t")
mantle <- read.delim(file = "/Volumes/STOLTZY/data/counts/mantle_raw_counts.tsv", header = TRUE, sep = "\t")
nuchal <- read.delim(file = "/Volumes/STOLTZY/data/counts/nuchal_raw_counts.tsv", header = TRUE, sep = "\t")

# READ IN THE MSTRG IDs & MAKE THEM ONLY CALL UNIQUE ONES ***should be the same (and it is)
seq_ids <- read.table("/Volumes/STOLTZY/data/mstrg_ids.tsv", header = TRUE, sep = "\t", as.is = TRUE)
seq_ids <- unique(seq_ids)


# WRITE THE NEW COLUMNS BUT PLACE NA PLACEHOLDERS THERE UNTIL WE GET THE DATA TO TXFR INTO IN FOR LOOP
blast_out$keel_tt_raw <- NA
blast_out$keel_uu_raw <- NA
blast_out$keel_ww_raw <- NA

blast_out$mantle_tt_raw <- NA
blast_out$mantle_uu_raw <- NA
blast_out$mantle_ww_raw <- NA

blast_out$nuchal_tt_raw <- NA
blast_out$nuchal_uu_raw <- NA
blast_out$nuchal_ww_raw <- NA

# PROGRESS BAR
pb <- txtProgressBar(min = 0, max = nrow(seq_ids), style = 3)
timestart <- proc.time()


for (i in 1:nrow(seq_ids)){

	setTxtProgressBar(pb, i-1)

	# STORE SEQ ID TO MATCH WITH COUNTS SEQ IDS
	seq <- seq_ids[i,1]

	# FIND ROWS THAT MATCH BLASTOUT SEQ ID TO COUNT FILES ID
	
	#Because there may be multiple rows that have that match seq, 
	#we want to keep track of all the  rows.  
	# this will allow us to update all the rows at once as opposed to needing a for-loop
	# this is a series of TRUE and FALSE, where true is a row with an id that matches seq
	blast_seq_row <- blast_out$mstrg_id == seq
	
	#for these lines, we know that there is only one row for each sequence
	# we pull out the full row so that we can access the specific expression data easily
	# MATCH BASED ON TT ID, PREIVOUSLY CONFIRMED THAT ROWS CONTAIN SAME ID ACROSS INDIVIDUALS
	keel_temp_data <- keel[keel$tt_id == seq,]
	mantle_temp_data <- mantle[mantle$tt_id == seq,]
	nuchal_temp_data <- nuchal[nuchal$tt_id == seq,]

	# In the following lines
	# we will fill in the expression data into each row of blast-out
	# that matches the current sequence that we are working on
	blast_out$keel_tt_raw[blast_seq_row] <- keel_temp_data$keel_tt
	blast_out$keel_uu_raw[blast_seq_row] <- keel_temp_data$keel_uu
	blast_out$keel_ww_raw[blast_seq_row] <- keel_temp_data$keel_ww

	blast_out$mantle_tt_raw[blast_seq_row] <- mantle_temp_data$mantle_tt
	blast_out$mantle_uu_raw[blast_seq_row] <- mantle_temp_data$mantle_uu
	blast_out$mantle_ww_raw[blast_seq_row] <- mantle_temp_data$mantle_ww

	blast_out$nuchal_tt_raw[blast_seq_row] <- nuchal_temp_data$nuchal_tt 
	blast_out$nuchal_uu_raw[blast_seq_row] <- nuchal_temp_data$nuchal_uu
	blast_out$nuchal_ww_raw[blast_seq_row] <- nuchal_temp_data$nuchal_ww


} # for (i in 1:length(seq_ids)):

write.table(blast_out,file = "/Volumes/STOLTZY/data/count_blast_table.tsv", sep = "\t")

timeend <- proc.time()
totaltime <- timeend-timestart

