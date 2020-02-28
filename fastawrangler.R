#!/usr/bin/env Rscript



# This is the FASTAwRangler script to be executed from the command line. 
# The script takes 5 arguments, 2 which are necessary for function
# 1) input fasta file 2) text file with seq IDs to remove or extract with
# or without wildcards * 3) optional TRUE/FALSE to note whether wildcards
# are present in the list of ids 4) optional TRUE/FALSE to to extract 
# sequences (default) or remove the sequences from the fasta file

########################################################################


# this variable can be turned on to print/track any errors in the script
# will turn off when script is ready to be used by others
error_checking = TRUE


# print message when script is invoked to let them know there is a help file
message("This script takes an input fasta file and a list of ids ",
	"with or without wildcards and extracts or removes those ",
	"sequences from the fasta file. For more information type '-h'.")

################## argument/input section ##############################

# all arguments accepted not just ones following this line
args = commandArgs(trailingOnly = TRUE)

if (error_checking) {
message(sprintf("first arg %s", args[1L]))

message(sprintf("second arg %s", args[2L]))

message(sprintf("third arg %s", args[3L]))

message(sprintf("fourth arg %s", args[4L]))

message(sprintf("fifth arg %s", args[5L]))
}

library("seqinr")
################## help message section ################################


# if the first argument passed is '-h' print the help section

if (args[1L] == "-h"){
	
	message("The first argument should be an input file should be a ",
	"fasta file where the sequences headers begin with  a '>' ",
	"character. There should be no spaces within the sequence headers.")
	message("                                    ")
	message("The second argument should be a text file list of sequence",
	" IDs. This file is read in with the header = FALSE, so even if ",
	"your file has a header, it should return no results.")
	message("                                    ")					
	message("The third and fourth arguments are logicals ",
	"(TRUE or FALSE). To set, just type either 'TRUE' or 'FALSE'")
	message("                                    ")	
	message(" The third argument determines whether your input list of ",
	"sequence ids have a wildcard (*) character present. Default = ",
	"FALSE.")
	message("                                    ")	
	message("The fourth argument determines whether you want the output ",
	"to be a fasta file with only the sequences you have listed in your ",
	"second argument input file (TRUE and default), or a fasta file ",
	"with the sequences you have listed in your second input file ",
	"removed from the final fasta.")
	message("                                    ")		
	message("The fifth argument is noting the path and name of the ",
	"desired output file. It is defaulted to out.fasta and will be ",
	"placed in whichever directory you are executing this script from.")
	message("									 ")
	message("Please note that if you want the sequences matching the ",
	"input ID list to be removed from the final fasta, you must enter a",
	"flag for the third argument 'TRUE/FALSE' and then the fourth ",
	" argument = 'FALSE'")
	
	# stop execution of script
	stop()
}

########################################################################
########################## input checks ################################
########################################################################


##################### fasta file input check ###########################

# first argument is to give fasta file input, if no first argument is given, 
# stop code halts process
if (is.na(args[1L])) {
	
	stop("missing input fasta file")
	
} else {
	
	# if fasta file is given as first argument, this sets fasta file to the 
	# first argument passed by user
	fastafilename = args[1L]
	
	# load in fasta file (first argument from user) and check to make sure it 
	# is indeed a fasta file
	# read in fasta file as tab delimited file
	fasta <- read.delim(file = fastafilename, as.is = TRUE, header = FALSE)
	
	# check to make sure first line of fasta file starts with a ">" character
	firstline <- fasta[1,]
	
	# if it does start with ">" then progress, if not error out 
	if (startsWith(firstline, ">") == FALSE){
		stop("Your fasta file does not seem to be a fasta file")
	}
}

################## seq id list check ###################################

# second arg passed by user should be list of seq ids
# check to make sure the user supplied that information
if (is.na(args[2L])){
	
	stop("missing input list of sequence ids")
	
} else {
	# if argument by user is given, then set the id list variable to that
	# argument 
	idlist = args[2L]
}

##################### wildcard input check #############################

# are wildcards * used, assume that they are not (wildcard = FALSE)
if (is.na(args[3L])){
	# if no argument given, assume wildcards are not used and treat the
	# id list as one with full sequence ids
	wildcard = FALSE
} else {
	wildcard = args[3L] 
	
}

##################### extract or remove seq check ######################

# if user keepsseqs = TRUE then they want to pull out the seqs for the ids
# that were given, if FALSE, then they want the seqs for the ids removed
# from the input fasta
if (is.na(args[4L])){
	# by default, this program will extract the sequences from the fasta
	# by the ids given
	keepseqs = TRUE	
	
} else {
	keepseqs = args[4L]
	
}

if (error_checking) {message("Starting work: wildcard")}


#################### output file name check ############################

# check to see if user passed an argument for the output file name
if (is.na(args[5L])){
	# if none given, default file name is "out.fasta" in working directory
	outfile = "out.fasta"
} else {
	# otherwise, name the output file what user input
	outfile = args[5L]
}

########################################################################
############### working: wildcard T/F ##################################
########################################################################

# if wildcard = true, go through steps to get all sequence names that
# belong to it
if (wildcard == TRUE){
	
	# read in the list with seqids & * wildcards as tab delimited file
	wildcard_query <- read.delim(file = idlist, sep = "\t", as.is = TRUE, header = FALSE)
		
	# since fasta file was read in as a tab delim file and not fasta file, 
	# need to get the sequence ids in the fasta file without the ">" character
	for (i in 1:nrow(fasta)){
	
		# store the line of the fasta file
		line <- fasta[i,]
		
		# determine if it is a seqid line or seq line
		if (startsWith(line, ">") == TRUE){
			
			# if seqid line, get seqid without the ">" character
			ids <- strsplit(line, fixed = TRUE, ">")
			newid <- ids[[1]][2]
			
			# replace all seqids in the fasta file with the ids without the ">" character
			fasta[i,] <- newid
	
		}
	}


	# get a list of the wildcard ids without the * character		
	for (i in 1:nrow(wildcard_query)){

		# get the first seqid in the list
		id <- wildcard_query[i,]
	
		# remove the wildcard character
		split <- strsplit(id, fixed = TRUE, "*")
		seqid <- split[[1]][1]
			
		# replace list contents with IDs without the "*"
		wildcard_query[i,] <- seqid
			
	}

	# initialize the list of full sequence ids
	names_final <- c()			


	# for each sequence id (without *) find the full sequence ids in the fasta file
	for (j in 1:nrow(wildcard_query)){
		
		id <- wildcard_query[j,]
		names <- (fasta[which(startsWith(fasta[,1], id)), ])
		names_final <- append(names_final, names)
		}

} else {
		
		# if wildcards are not used, then we can read in the input list
		# without much manipulation 

		# read in the list with seqids as tab delimited file
		temp_names_final <- read.delim(file = idlist, sep = "\t", as.is = TRUE, header = FALSE)
		# force data frame structure
		names_final <- temp_names_final$V1
} 

# print first two seq ids 
if (error_checking){message(paste(names_final[1], names_final[2], sep="\n"))} 



########################################################################
################### working: keep/remove seqs ##########################
########################################################################

# if true, use seqinr to extract the sequences by id easily
if (error_checking){ message("Starting work: extracting or removing")}

# load in fasta file via seqinr
	fasta <- read.fasta(file = fastafilename, as.string = FALSE, forceDNAtolower = FALSE)

if (keepseqs == TRUE){
		

	newfasta <- fasta[names(fasta) %in% names_final]

	write.fasta(as.list(newfasta), names_final, outfile, open = "w", nbchar = 1000000)
		
# if false, remove them from the fasta file 
}else{
	
						
	newfasta <- fasta[!(names(fasta) %in% names_final)]

	write.fasta(as.list(newfasta), names_final, outfile, open = "w", nbchar = 1000000)
		
}
