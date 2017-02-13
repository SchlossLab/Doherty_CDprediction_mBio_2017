#**Table 1: Diversity differences based on clinical metadata of chort at baseline**


colnames(CDAI) <- c('Clinical Variable', 'Summary', 'Species Richness (Alpha-diversity)', 'Community Structure (beta-diversity)')
tbl1<-rbind(CDAI, Stool)
colnames(tbl1) <- c('Clinical Variable', 'Summary', 'Species Richness\n(alpha-diversity)', 'Community Structure\n(beta-diversity)')

cohortdiv<-c("CRP", "FCALP", "FLACT", "BMI", "weight", "AGE", "SEX", "BCORT", "DDUR", "tissinvol")

for (i in cohortdiv){
	tbl1<-rbind(tbl1, get(i))
}

tiff("tables/table1_cohortdiversity.tiff", width = 11, height = 4, units='in', res=300)
grid.table(tbl1)
dev.off()

pdf("tables/table1_cohortdiversity.pdf", width = 11, height = 4)
grid.table(tbl1)
dev.off()
