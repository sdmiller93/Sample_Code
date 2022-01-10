# code that takes in a list of fasta files that are chunked into NCBI appropriate size
# and sends the to NCBI for analysis


# determine the fasta files in the current folder

#Folder listed here should only contain fasta files, because I am lazy
# I recommend this file structure
# ../Date and within Date have this code.
# ../Date/fastafiles/

foldername = "fastafiles"

fastafiles <- list.files(path = foldername, full.names = TRUE)
numfiles = length(fastafiles)

pb <- txtProgressBar(min = 0, max = numfiles, style = 3)

timestart <- proc.time()

for (i in 1:numfiles) {
	setTxtProgressBar(pb, i-1)

	# get the correct output name for the out files
	fastafilesname = fastafiles[i]
	fastanamesplit = strsplit(fastafilesname, fixed = TRUE, "/")
	fastasplit2 = strsplit(fastanamesplit[[1]][2], "pep")
	fastanameholder = fastasplit2[[1]][2]
	splitholder = strsplit(fastanameholder, fixed = TRUE, ".")
	finalnameholder = splitholder[[1]][1]
	tempoutputname = paste("output", fastanameholder, ".tsv", sep = "")

	NCBIcode = paste('./blastp -db nr -query', fastafiles[i], '-outfmt "6 qseqid qlen sacc slen evalue stitle length qcovs ppos" -out', tempoutputname, '-max_target_seqs 10 -remote', sep = " ")
	
	
	system(command = NCBIcode)

	Sys.sleep(20)	# pause for five seconds before sending the next job



}

close(pb)
timeend <- proc.time()
totaltime <- timeend-timestart
print(totaltime)
