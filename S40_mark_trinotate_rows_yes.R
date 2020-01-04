de <- read.delim(file = "~/Desktop/new_updated_de_blast.tsv", as.is = TRUE, sep = "\t", header = TRUE)
counts <- read.delim(file = "~/Desktop/new_updated_counts_blast.tsv", as.is = TRUE, sep = "\t", header = TRUE)
trinotate <- read.delim(file = "~/Desktop/good_evalue_trinotate.tsv", as.is = TRUE, sep = "\t", header = TRUE)

for (i in 1:nrow(trinotate)){
	id <- trinotate$qseqid[i]
	row <- which(de$trinity_id == id)
	
	if (sum(row)>0){
		print(id)
	}
}
