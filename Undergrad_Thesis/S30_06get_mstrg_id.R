# READ IN STRINGTIE MERGE TSV
stringtie_merge <- read.delim("/Volumes/STOLTZY/data/edgeR/stringtie/stringtie_merge.tsv", as.is = TRUE, header = FALSE)

# READ IN THE BLAST OUTPUT 
blast_out <- read.delim("/Volumes/STOLTZY/data/best_hit_per_seq.tsv", as.is = TRUE, header=TRUE)

# ADD MSTRG COLUMN TO BLAST_OUT FILE 
blast_out$mstrg_id <- NA

# GET LIST OF SEQ IDS
seq_ids <- read.table("/Volumes/STOLTZY/data/seq_ids.tsv", header = FALSE, sep = "\t", as.is = TRUE)

# PROGRESS BAR
pb <- txtProgressBar(min = 0, max = nrow(seq_ids), style = 3)
timestart <- proc.time()

for (i in 1:nrow(seq_ids)){
	
	setTxtProgressBar(pb, i-1)
	
	seq <- seq_ids[i,1]

	
	# ONLY NEED TO GO THROUGH EVERY OTHER ROW OF THE STRINGTIE MERGE COLUMN A & IGNORE THE FIRST TWO ROWS select via [1,9] FIRST ROW, 9TH COLUMN
	# MATCH SEQ ID IN EVALUE FRAME
	hit_seq_row <- blast_out$truncseqid == seq

	# IF NO MATCH, THEN SKIP AND MOVE TO NEXT ID ON THE LIST
	if (sum(hit_seq_row) == 0){
		next
	}

	# MATCH SEQ TO STRINGTIE MERGE SEQ ID (COL A) AND STORE THAT ROW INFO IN VARIABLE
	string_id_row <- stringtie_merge[,1]== seq
	temp_string_row <- stringtie_merge[string_id_row,]

	# SPLIT THE MSTRG STRING IN COLUMN I TO GET THE MSTRG.XXX.X PORTION ONLY
	split_name <- strsplit(temp_string_row[1,9], fixed= TRUE, " ")
	temp_split <- split_name[[1]][4]
	temp_name <- strsplit(temp_split, fixed = TRUE, ";")
	temp_name <- temp_name[[1]][1]
	

	# ADD MSTRG ID TO THE MSTRG_ID COL OF THE BLAST_OUT
	blast_out$mstrg_id[hit_seq_row] <- temp_name

	
}

# ADD THE MSTRG NAME TO THE BLAST OUT FILE 
write.table(blast_out, file = "~/Desktop/besthitperseq_mstrg_ids.tsv", append=TRUE, row.names=FALSE, quote=FALSE, sep="\t")

# PROGRESS BAR
timeend <- proc.time()
totaltime <- timeend-timestart