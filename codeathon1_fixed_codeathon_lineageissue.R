install.packages("RColorBrewer")
data <- read.csv("~/Desktop/heatmp/counts.csv")
rnames<-data[,1]
mat_data<-data.matrix(data[,2:ncol(data)])
rownames(matdata)<- rnames
rownames(mat_data)<- rnames
my_palette<-colorRampPalette(c("red","yellow","green"))(n=299)
png("~/Desktop/heatmaptrial1.png"), width = 5*300, height = 5*300, res=300, pointsize=8)
png("~/Desktop/heatmaptrial1.png"), width = 5*300, height = 5*300, res=300, pointsize=8)
png("~/Desktop/heatmaptrial1.png", width = 5*300, height = 5*300, res=300, pointsize=8)
png
heatmap.2(mat_data, cellnote=mat_data, main="Correlation", notecol="black",density.info="none", trace="none",margins=c(12,9), col=my_palette, dendrogram="row", Colv="NA")
install.packages("heatmap.2")
data <- read.delim("/Volumes/STOLTZY/data/all_output.tsv", as.is = TRUE)
data <- read.delim("~/Desktop/Bacterial_Taxonomy_clean.tsv.tsv", as.is = TRUE)
host <- read.delim("~/Desktop/Bacterial_Taxonomy_clean.tsv", header = FALSE, sep="\t", as.is = TRUE)
head(host)
j = 1
k = 1
temptaxid2 <- host[j,1]
templin2 <- host[j,2]
temptaxid2
templin2
match2 <- which(db$hosttaxid == temptaxid2)
db <- read.delim("~/Desktop/gscombinedphagesdb.tsv", header = TRUE, as.is = TRUE, sep = "\t")
head(db)
match2 <- which(db$hosttaxid == temptaxid2)
match2
newmatch <- match2[k]
newmatchid <- host[newmatch,1]
newmatchlin <- host[newmatch,2]
newmatch
newmatchid
newmatchlin
newmatch <- match2[k]
newmatchid <- host[newmatch,1]
newmatchlin <- host[newmatch,2]
db$hostlineage[] <- newmatchlin
newmatchlin
newmatchlin[1]
newmatchid
db$hostlineage[newmatchid] <- newmatchlin
match2
head(db)
match2
db$hostlineage <- NA
head(db)
db$hostlineage[13] <- newmatchlin
match2
newmatch
newmatchid
db$Phage.Name
host[newmatch,1]
host[newmatch,]
db$hostlineage[newmatch] <- newmatchlin
db$hostlineage[newmatchid] <- newmatchlin
for (j in 1:nrow(host)){
temptaxid2 <- host[j,1]
templin2 <- host[j,2]
match2 <- which(db$hosttaxid == temptaxid2)
if (length(match2) > 1){
for (k in 1:length(match2)){
newmatch <- match2[k]
newmatchid <- host[newmatch,1]
newmatchlin <- host[newmatch,2]
db$hostlineage[newmatch] <- newmatchlin
}
}else{
db$hostlineage[match2] <- templin2
}
} #for (j in 1:nrow(host)){
head(db)
?data.table
library(data.table)
?data.table
savehistory("~/Desktop/fixed_codeathon_lineageissue.Rhistory")
