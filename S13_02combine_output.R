# COMBINE ALL OUTPUT FROM BLAST INTO ONE FILE
# full_path = file.path("/Volume/STOLTZY/blast_out", output)
# all_output <- do.call("rbind", lapply(output, FUN=function(files){read.delim(files)}))

setwd("/Volumes/STOLTZY/")

output <- list.files("/Volumes/STOLTZY/data/database/blast_out", full.names = TRUE)

filename <- "all_output.tsv"

write.table("query_seq_id\tquery_length\tsubj_acc\tsubj_length\tevalue\tsubj_title\talign_length\tquery_covg_per_subj\tperc_pos_score_match", file = "all_output.tsv", sep ="\t",row.names = FALSE, col.names = FALSE, quote = FALSE)

# PROGRESS BAR
pb <- txtProgressBar(min = 0, max = nrow(output), style = 3)
timestart <- proc.time()

for (i in 1:length(output)){

	setTxtProgressBar(pb, i-1)

	data <- read.delim(output[i])
	write.table(data, file = filename, append = TRUE, sep ="\t", row.names = FALSE, col.names = FALSE, quote = FALSE)

}

# PROGRESS BAR
timeend <- proc.time()
totaltime <- timeend-timestart

# check line counts from terminal not within R
# wc -l ~/Desktop/all_output.tsv 