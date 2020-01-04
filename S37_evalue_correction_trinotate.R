# READ IN TRINOTATE FILE MADE FROM TRINOTATE_SEARCH.R
trinotate <- read.delim("~/Desktop/suppl_trinotate_out.tsv", as.is = TRUE, header = TRUE)

out <- read.delim("~/Desktop/template.tsv", as.is = TRUE, header = TRUE)

max_evalue <- 0.00005

pb <- txtProgressBar(min = 0, max = nrow(trinotate), style = 3)
timestart <- proc.time()

curr_row = 0

for (i in 2:nrow(trinotate)){

		setTxtProgressBar(pb, i-1)
		
		if (trinotate$evalue[i] < max_evalue){
				data <- trinotate[i,] 
				out[curr_row,] = data
		} else {
				next
		}
	curr_row = curr_row + 1
}

write.table(out, file = "~/Desktop/good_evalue_trinotate.tsv", sep = "\t", row.names = FALSE, col.names = TRUE, quote = FALSE)

timeend <- proc.time()
totaltime <- timeend-timestart
