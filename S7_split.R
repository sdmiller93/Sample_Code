# script to split fasta file into chunks of desired size

setwd("/Volumes/STOLTZY/split")
chunksize  = 40
filename = "longestorfspep.fasta"
txt <- read.csv("/Volumes/STOLTZY/longest_orfspep.csv", header = FALSE, check.names = FALSE) 
numfiles = ceiling(nrow(txt)/chunksize)
for (i in 1:numfiles){
	begin = (i-1)*chunksize + 1
	end =  i*chunksize
	temp = txt[begin:end,]
	splitname = strsplit(filename, fixed = TRUE, ".")
	tempname = paste(splitname[[1]][1], i,".fasta", sep = "")
	write.table(temp, tempname, row.names = FALSE, col.names = FALSE, quote = FALSE)
}
