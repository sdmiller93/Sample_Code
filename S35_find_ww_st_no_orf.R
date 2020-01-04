library("seqinr")

# LOAD WW SUPERTRANSCRIPT FILE
st <- read.fasta("~/Desktop/ww_supertranscripts_no_rrna_010919.fa")

# LOAD LONGEST ORF FILE
orf <- read.delim("~/Desktop/seq_ids.tsv", as.is = TRUE, header = TRUE)

st_seq <- 0


for (i in 1:length(st)){
	
	st_seq <- getName(st[i])

	# FIND MATCH FOR SEQ ID, IF NO MATCH THEN WRITE ID TO FILE
	hits <- orf$seq_ids == st_seq

	if (sum(hits)==0){
		write.table(st_seq, file = "~/Desktop/seqs_no_orf.tsv", append = TRUE, sep = "\t", row.names = FALSE, col.names = FALSE, quote = FALSE)
	}
}