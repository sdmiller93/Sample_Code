#!/usr/bin/env Rscript

## LAST UPDATED: 2021-04-12
## Author: Sierra D. Miller (sierra.miller@nist.gov)
## This script will take a mounted ftp dir and scrape the fastq file names for
## input into the GIAB Data Registry 

## use the following line to capture arguments passed in bash command entry
## = true: These arguments are captured before the standard R command line 
## processing takes place. This means that they are the unmodified values.

message("This script will take an ftp dir url and scrape the file names that match the extension specified")
message("")
message("For info: Rscript file_scrape.R -h")
message("Remember to include trailing '/' in ftp URL and output dirs.")


########################################################################
## SETUP
########################################################################
## this variable can be turned on to print/track any errors in the script
## will turn off when script is ready to be used by others
error_checking = TRUE
args = commandArgs(trailingOnly = TRUE)


if (error_checking) {
  
  message(sprintf("first arg %s", args[1L]))

  message(sprintf("second arg %s", args[2L]))

  message(sprintf("third arg %s", args[3L]))

}

########################################################################
##### HELP MESSAGE
########################################################################
## if the first argument passed is '-h' print the help section
## I find this helpful especially when I need to pass several things
## as arguments, to print what is required as arguments and the syntax
## for execution

if (args[1L] == "-h") {
	
	message("Usage: Rscript file_scrape.R arg1 arg2 arg3")
	message("NOTE: All arguments must be supplied.")
	message("")
	message("Arguments:")
	message("arg1 = ftp url address")
	message("arg2 = output dir")
	message("arg3 = extension of files that are to be listed - ex: .fastq, .md5")
	
	## stop execution of script
	stop()
	
}

########################################################################
## PACKAGES
########################################################################
require("RCurl")
require("stringr")
require("readr")
require("tidyverse")

########################################################################
##### SCRIPT WORKHORSE
########################################################################

## associate variables
ftp_dir <- args[1L] # ftp_dir <- "ftp://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/data/AshkenazimTrio/HG002_NA24385_son/PacBio_CCS_10kb/"
output <- args[2L] # output <- "~/Desktop/"
extension <- args[3L] # extension <- ".fastq"

if (error_checking){ message("variable assignment completed")}

## get ftp dir root for output name
ftp_dir_root <- gsub("/", "_", ftp_dir) 

## list all files in ftp dir
files <- getURL(ftp_dir,verbose=TRUE,ftp.use.epsv=TRUE,
       dirlistonly = TRUE)

if (error_checking){ message("url accepted")}

## get file names only and store in df
files_df <- data.frame(files) %>%
  mutate(file_names = strsplit(as.character(files), "\n")) %>%
  unnest(file_names)

if (error_checking){ message("listed files")}
                     
## get file names of specified extension
filtered_files <- files_df %>%
  filter(endsWith(files_df$file_names, extension))

## add paths to the file names
final_files <- data.frame(paste0(ftp_dir, filtered_files$file_names))
  
if (error_checking){ message("files in df format")}


## write out list of files
outfile <- paste0(output, ftp_dir_root, extension, "_file_names.csv")

message("writing out file")

write_csv(final_files, file = outfile)
