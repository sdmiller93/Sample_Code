# get truncated id in new column

# READ IN COMPREHENSIVE OUTPUT FILE
data <- read.delim("/Volumes/STOLTZY/data/good_hits//evalue/best_evalue_hits.tsv", header = TRUE, sep="\t", as.is = TRUE)

seqid <- 0

data$truncseqid = NA

# PROGRESS BAR
pb <- txtProgressBar(min = 0, max = nrow(data), style = 3)
timestart <- proc.time()

for (i in 1:nrow(data)){

	setTxtProgressBar(pb, i-1)

	seqid <- data[[1]][i]
	tempname <- strsplit(seqid, fixed = TRUE, ".")
	id <- tempname[[1]][1]
	data$truncseqid[i] <- id

}


write.table(data, file = "/Volumes/STOLTZY/data/best_evalue_hits_updated.tsv", sep = "\t", row.names = FALSE)


# PROGRESS BAR
timeend <- proc.time()
totaltime <- timeend-timestart