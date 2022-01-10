# load in heatmap dataframes: has subj_title descriptors -- simplified, and edgeR normalized counts

library(gplots)
library(RColorBrewer)

data <- read.delim(file = "~/Desktop/collagen_heatmap.tsv", as.is = TRUE, sep = "\t", header = TRUE)

rnames <- data[order(data$display_title),3]
mat_data <- data.matrix(data[,4:ncol(data)])
rownames(mat_data) <- rnames
my_palette<-colorRampPalette(c("blue", "yellow"))(n=1000)


heatmap.2(mat_data, col=my_palette, key.title = "edgeR logCPM", Rowv = FALSE, Colv=FALSE, margins=c(8,15), trace="none", scale = "none", dendrogram="none", cexRow=0.4,cexCol=1.0)


quartz.save("~/Desktop/collaagen_edgeRlogCPM_scalerow_heatmap.pdf", type="pdf")
