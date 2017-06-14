#**Table 1: Diversity differences based on clinical metadata of chort at baseline**


colnames(CDAI) <- c('Clinical Variable', 'Summary', 'Species Richness (Alpha-diversity)', 'Community Structure (beta-diversity)')
tbl1<-rbind(CDAI, Stool)

cohortdiv<-c("CRP", "FCALP", "FLACT", "BMI", "weight", "AGE", "SEX", "BCORT", "DDUR", "tissinvol")

for (i in cohortdiv){
	tbl1<-rbind(tbl1, get(i))
}

tbl1 <- data.frame(tbl1)
adiv_p <- as.numeric(as.character(tbl1$Species.Richness..Alpha.diversity.))

tbl1_adiv_adj_p <- p.adjust(adiv_p, method="BH")
tbl1$Species.Richness..Alpha.diversity.<-sprintf("%.3f", round(tbl1_adiv_adj_p,3))

bdiv_p <- as.numeric(as.character(tbl1$Community.Structure..beta.diversity.))

tbl1_bdiv_adj_p <- p.adjust(bdiv_p, method="BH")
tbl1$Community.Structure..beta.diversity.<-sprintf("%.3f", round(tbl1_bdiv_adj_p, 3))

colnames(tbl1) <- c('Clinical Variable', 'Correlation', 'Alpha-Diversity\n(p-value)', 'Beta-Diversity\n(p-value)')

tbl1$Correlation <- gsub("rho", expression("\U03C1"), tbl1$Correlation)
#tbl1

#tbl1 <- tbl1[-c(6:9),]
tbl1 <- as.matrix(tbl1)

png("tables/Supp.table1_cohortdiversity.png", width = 7, height = 4, units='in', res=100)
grid.table(tbl1)
dev.off()

tiff("tables/Supp.table1_cohortdiversity.tiff", width = 7, height = 4, units='in', res=300)
grid.table(tbl1)
dev.off()

#pdf("tables/Supp.table1_cohortdiversity.pdf", width = 8, height = 6)
#grid.table(tbl1)

#dev.off()

#xtbl1 <- xtable(tbl1)
#xtbl1

