

hepc1 <- read.delim(file = "~/Desktop/hepc1_DE_List.tsv", as.is = TRUE, sep = "\t", header = TRUE)
hepc3 <- read.delim(file = "~/Desktop/hepc3_DE_List.tsv", as.is = TRUE, sep = "\t", header = TRUE)

imm_thromb <- read.delim(file = "~/Desktop/imm_thromb.tsv", as.is = TRUE, sep = "\t", header = TRUE)
sjog_synd <- read.delim(file = "~/Desktop/sjrog_syn.tsv", as.is = TRUE, sep = "\t", header = TRUE)

uniq_hepc1 <- unique(hepc1$genes)
uniq_hepc3 <- unique(hepc3$genes)
uniq_imm <- unique(imm_thromb$Gene)
uniq_sjog <- unique(sjog_synd$Gene)


write.table(uniq_hepc1, file = "~/Desktop/unique_hepc1_genes.tsv", append = FALSE, sep = "\t", row.names = FALSE, col.names = TRUE, quote = FALSE)
write.table(uniq_hepc3, file = "~/Desktop/unique_hepc3_genes.tsv", append = FALSE, sep = "\t", row.names = FALSE, col.names = TRUE, quote = FALSE)
write.table(uniq_imm, file = "~/Desktop/unique_imm_thromb_genes.tsv", append = FALSE, sep = "\t", row.names = FALSE, col.names = TRUE, quote = FALSE)
write.table(uniq_sjog, file = "~/Desktop/unique_sjog_synd_genes.tsv", append = FALSE, sep = "\t", row.names = FALSE, col.names = TRUE, quote = FALSE)

