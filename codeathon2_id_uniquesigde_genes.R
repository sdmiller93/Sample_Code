# IDENTIFY THE SIGNIFICANTLY DIFFERENTIALLY EXPRESSED GENES THAT ARE UNIQUE TO EACH DATASET

# READ IN DATA  ***edit the path to file names!!!*****
# hcmvsiNT <- read.delim(file = "~/Desktop/de_geneids_hcmv_siNT_geneids.tsv", as.is = TRUE, sep = "\t", header = TRUE)
# hcmvsiP2Y2 <- read.delim(file = "~/Desktop/de_geneids_geneids.tsv", as.is = TRUE, sep = "\t", header = TRUE)
hepc <- read.delim(file = "~/Desktop/de_geneids/hepc_geneids.tsv", as.is = TRUE, sep = "\t", header = TRUE)
hepe <- read.delim(file = "~/Desktop/de_geneids/hepe_geneids.tsv", as.is = TRUE, sep = "\t", header = TRUE)
rsvwt <- read.delim(file = "~/Desktop/de_geneids/rsvwt_geneids.tsv", as.is = TRUE, sep = "\t", header = TRUE)
rsvmut <- read.delim(file = "~/Desktop/de_geneids/rsvmut_geneids.tsv", as.is = TRUE, sep = "\t", header = TRUE)


# retain only the unique ids per sample

# hcmvsiNT_ed <- unique(hcmvsiNT)
# hcmvsiP2Y2_ed <- unique(hcmvsiP2Y2)
hepc_ed <- unique(hepc)
hepe_ed <- unique(hepe)
rsvwt_ed <- unique(rsvwt)
rsvmut_ed <- unique(rsvmut)

# COMPARE THE TEXT FILES LISTED WITH GENEIDS AND OUTPUT THE UNIQUE STRINGS 
x <- c(hepc_ed, hepe_ed, rsvwt_ed, rsvmut_ed)


unique_ids <- unique(x, incomparables = FALSE)
