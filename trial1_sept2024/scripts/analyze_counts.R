library(dplyr)
library(VennDiagram)
#starting with granges_ML environment

pre41817 <- read.table("/datacommons/ydiaolab/arinze/daichi/counts2/AO43_counts.txt", header = FALSE)
pre41818 <- read.table("/datacommons/ydiaolab/arinze/daichi/counts2/AO44_counts.txt", header = FALSE)
pre41824 <- read.table("/datacommons/ydiaolab/arinze/daichi/counts2/AO45_counts.txt", header = FALSE)

names(pre41817) <- c("counts_pre41817", "gRNA")
names(pre41818) <- c("counts_pre41818", "gRNA")
names(pre41824) <- c("counts_pre41824", "gRNA")

combined_counts <- merge(merge(pre41817, pre41818, by="gRNA", all = TRUE), pre41824, by="gRNA", all = TRUE)
#combined recovered gRNAs is 12,126

head(combined_counts)
rownames(combined_counts) <- combined_counts$gRNA
combined_counts <- combined_counts[,-1]
combined_counts[is.na(combined_counts)] <- 0

venn.diagram(
  x = list(pre41817$gRNA, pre41818$gRNA, pre41824$gRNA),
  category.names = c("pre41817" , "pre41818" , "pre41824"),
  filename = 'non_responsive_venn_diagramm2.png',
  output=TRUE)

#now using seurat environment
library("RColorBrewer")

v <- eulerr::euler(c(pre41817 = 71, pre41818 = 134, pre41824 = 27,
                     "pre41817&pre41818" = 580,
                     "pre41817&pre41824" = 53,
                     "pre41818&pre41824" = 148,
                     "pre41817&pre41818&pre41824" = 11113),
                   shape = "circle")
pdf("Area_responsive_venn_diagram_pre2.pdf")
plot(v, , legend = TRUE)
dev.off()


corr_mat <- cor(combined_counts, method="spearman")
pdf("correlation_between_counts2.pdf")
pheatmap::pheatmap(corr_mat, 
color = colorRampPalette(brewer.pal(n = 7, name = "YlOrRd"))(100),
display_numbers = TRUE)
dev.off()

#91.6% of gRNAs are recovered in all three samples.