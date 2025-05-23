# Plot heatmap for correlation PTR-abundance

library(ggplot2)
library(dplyr)
library(ggcorrplot)
library(reshape2)
library(corrplot)


input <- function(inputfile) {
data <- inputfile#"../analysis-out/2-CorrelationPTR-Abundance/ptr-abundance-corr-groups.csv"
dfff <<- read.csv(data)
}

run <- function() {}

output <- function(outputfile) {
out_plot <- outputfile#"Fig2A.png"

order_species <- c("Klebsiella pneumoniae",
                   "Escherichia coli",
                   "Enterococcus faecalis",
                   "Staphylococcus epidermidis",
                   "Enterobacter cloacae",
                   "Enterobacter hormaechei",
                   "Klebsiella oxytoca",
                   "Enterococcus faecium",
                   "Bifidobacterium longum",
                   "Klebsiella quasipneumoniae",
                   "Klebsiella variicola",
                   "Klebsiella michiganensis",
                   "Klebsiella aerogenes",
                   "Citrobacter freundii",
                   "Veillonella parvula",
                   "Clostridium perfringens",
                   "Enterobacter roggenkampii",
                   "Enterobacter asburiae",
                   "Enterobacter sp. CRENT-193",
                   "Klebsiella sp. M5al",
                   "Enterobacter sp. DKU_NT_01",
                   "Enterobacter sp. HK169",
                   "Citrobacter Unclassified")

rownames(dfff) <- dfff$species
dfff <- dfff[order_species,]

df_corr <- select(dfff,"spearmanr_antibiotics", "spearmanr_control")

plot.data <- as.matrix(df_corr)
#rownames(plot.data) <- df$species
colnames(plot.data) <- c("Antibiotics Cohort", "Control Cohort")
plot.data <- t(plot.data)

p.value <- select(dfff, "pval_antibiotics", "pval_control")
p.value <- as.matrix(p.value)
p.value <- t(p.value)
#plot.data$stars <- cut(plot.data$p.value, breaks=c(-Inf, 0.001, 0.01, 0.05, Inf), label=c("***", "**", "*", ""))  # Create column of significance labels

png(height=1200, width=1200, pointsize=25, file=out_plot)
write.csv(plot.data, paste(outputfile, "csv", sep="."))
corrplot(plot.data, is.corr=FALSE, p.mat= p.value, sig.level = .05, tl.col = "black", cl.lim=c(-1,1), col=colorRampPalette(c("red","white", "blue"))(200), cl.ratio=0.1, cl.length = 5)
dev.off()
}
