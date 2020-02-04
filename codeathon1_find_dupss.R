#paste virus tax id and host tax id 
#run intersect on that 


phagedb <- read.delim(file="~/Desktop/PhagesDBknown_virushost_interactionsdb_withdups.tsv", as.is = TRUE, sep = "\t", header = TRUE)

ncbi <- read.delim(file="~/Desktop/ncbi_known_interactionsdb_withdups.tsv", as.is = TRUE, sep = "\t", header = TRUE)


phagevtaxid <- phagedb$virus.tax.id
phagehtaxid <- phagedb$host.tax.id

phageid <- paste(phagevtaxid, phagehtaxid)

ncbivtaxid <- phagedb$virus.tax.id
phagehtaxid <- phagedb$host.tax.id

ncbiid <- paste(ncbivtaxid, phagehtaxid)

overlap <- (intersect(phageid, ncbiid))

unique(rbind(phagedb,ncbi))

ncbi$temp <- paste(ncbi$virus.tax.id,ncbi$host.tax.id)
ncbi_new <- subset(ncbi,!ncbi$temp %in% overlap)
ncbi_new$temp <- NULL
names(phagedb)[3] <- "virus.query.name"
all_db <-  rbind(phagedb,ncbi_new) 
