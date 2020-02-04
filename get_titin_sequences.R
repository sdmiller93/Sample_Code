# GET SEQUENCE OF ALL TITIN SUPERTRANSCRIPTS

counts <- read.delim(file = "~/Desktop/2020_January/initial_data/S42_final_counts.tsv", as.is = TRUE, sep = "\t", header = TRUE)
titin <- "titin"

pb <- txtProgressBar(min = 0, max = nrow(counts), style = 3)
timestart <- proc.time()

for (i in 1:nrow(counts)){ 

	setTxtProgressBar(pb, i-1)
	titin_hits <- counts[which(grepl(titin, counts$subj_title)),]


}

timeend <- proc.time()
totaltime <- timeend-timestart


library("seqinr")

fasta <- read.fasta(file = "~/Desktop/2020_January/initial_data/S4B_ww_supertranscripts_no_rrna_010919.fasta", seqtype = "AA",as.string = TRUE, set.attributes = FALSE)


uniqueids <- unique(titin_hits$truncseqid)
titin_fasta <- fasta[names(fasta) %in% titin_hits$truncseqid]


write.fasta(titin_fasta, uniqueids, "~/Desktop/titin_fasta.fasta", open = "w", nbchar = 1000000, as.string = FALSE)

