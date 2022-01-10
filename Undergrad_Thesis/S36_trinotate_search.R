library("seqinr")

# LOAD WW SUPERTRANSCRIPT FILE
st <- read.fasta("~/Desktop/ww_supertranscripts_no_rrna_010919.fa")

# LOAD LONGEST ORF FILE
orf <- read.delim("~/Desktop/seq_ids.tsv", as.is = TRUE, header = TRUE)

# LOAD TRINOTATE BLASTX FILE
trinotate <- read.delim("~/Desktop/blastx.tsv", as.is = TRUE, header = TRUE)

# LOAD TABLE TO BE WRITTEN TO
# write.table("qseqid\tsseqid\tpident\tlength\tmismatch\tgapopen\tqstart\tqend\tsstart\tsend\tevalue\tbitscore", file = "~/Desktop/trinotate_hits_missing_blastplus_annot.tsv", sep = "\t", row.names = FALSE, col.names = FALSE, quote = FALSE)

st_seq <- 0
curr_row = 1

# PROGRESS BAR
pb <- txtProgressBar(min = 0, max = length(st), style = 3)
timestart <- proc.time()

for (i in 2:length(st)){ # making new df issues so I run this script with i = 2 (i = 1 was translated thus not needed here) and paste that result into the 
# row and then read it back in with the out <- when this script is initialized. the as.is function also helps this issue but doesn't solve it. 
	
	#setTxtProgressBar(pb, i-1)
	
	st_seq <- getName(st[i])
	# FIND MATCH FOR SEQ ID, IF NO MATCH THEN WRITE ID TO FILE
	no_translate_hits <- orf == st_seq

	if (sum(no_translate_hits)==0){
		temp_data <- trinotate[trinotate$qseqid == st_seq,]

			if (nrow(temp_data)>0){
				hits <- order(temp_data$evalue, decreasing = FALSE)
				best_hit <- temp_data[hits[1],]
				out[curr_row,]=best_hit
				curr_row = curr_row + 1
			} else {
				next
			}
				
	} else {
		next
	}						

}

write.table(out, file = "~/Desktop/suppl_trinotate_out.tsv", append = TRUE, sep = "\t", row.names = FALSE, col.names = TRUE, quote = FALSE)

# PROGRESS BAR
timeend <- proc.time()
totaltime <- timeend-timestart

