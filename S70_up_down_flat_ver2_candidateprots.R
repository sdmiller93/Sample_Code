library(dplyr)

# READ IN DIFF EXP DATAFRAME
de <- read.delim(file = "~/Desktop/cand_prot_UpSetR/de_troponin.tsv", as.is = TRUE, sep = "\t", header = TRUE)

# Make new columns
de$kvm_up <- NA
de$kvm_down <- NA
de$kvm_flat <- NA

de$kvn_up <- NA
de$kvn_down <- NA
de$kvn_flat <- NA

de$mvn_up <- NA
de$mvn_down <- NA
de$mvn_flat <- NA

# I have 3 pairwise comparison de testing keel vs mantle, keel vs nuchal, and mantle vs nuchal

for (i in 1:nrow(de)){ # this is for my keel vs mantle testing values

	if (de$kvm_logFC[i] >= 2){
		de$kvm_up[i] <- "1"
		de$kvm_down[i] <- "0"
		de$kvm_flat[i] <- "0"
	} else if (de$kvm_logFC[i] <= -2){
		de$kvm_up[i] <- "0"
		de$kvm_down[i] <- "1"
		de$kvm_flat[i] <- "0"
	} else if (between(de$kvm_logFC[i], -2, 2)){
		de$kvm_up[i] <- "0"
		de$kvm_down[i] <- "0"
		de$kvm_flat[i] <- "1"
	} else {
		warning(paste("problem with row:",i))
	}
	
	
}

for (i in 1:nrow(de)){ # this is for my keel vs nuchal testing values

	if (de$kvn_logFC[i] >= 2){
		de$kvn_up[i] <- "1"
		de$kvn_down[i] <- "0"
		de$kvn_flat[i] <- "0"
	} else if (de$kvn_logFC[i] <= -2){
		de$kvn_up[i] <- "0"
		de$kvn_down[i] <- "1"
		de$kvn_flat[i] <- "0"
	} else if (between(de$kvn_logFC[i], -2, 2)){
		de$kvn_up[i] <- "0"
		de$kvn_down[i] <- "0"
		de$kvn_flat[i] <- "1"
	} else {
		warning(paste("problem with row:",i))
	}
	
	
}

for (i in 1:nrow(de)){ # this is for my mantle vs nuchal testing values

	if (de$mvn_logFC[i] >= 2){
		de$mvn_up[i] <- "1"
		de$mvn_down[i] <- "0"
		de$mvn_flat[i] <- "0"
	} else if (de$mvn_logFC[i] <= -2){
		de$mvn_up[i] <- "0"
		de$mvn_down[i] <- "1"
		de$mvn_flat[i] <- "0"
	} else if (between(de$mvn_logFC[i], -2, 2)){
		de$mvn_up[i] <- "0"
		de$mvn_down[i] <- "0"
		de$mvn_flat[i] <- "1"
	} else {
		warning(paste("problem with row:",i))
	}
	
	
}
write.table(de, file = "~/Desktop/troponinde_up_down.tsv", append = TRUE, sep = "\t", col.names = TRUE, row.names = FALSE, quote = FALSE)
