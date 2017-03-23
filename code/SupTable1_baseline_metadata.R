#**Supplemental Table 1: Summary of clinical metadata of chort at baseline**

tiff(file='tables/SupTable1_baseline_metadata.tiff', height=4, width=6, units='in', res=300)

	
colnames(N.cohort) <- c('Clinical Variable', 'Treated', 'Placebo', 'Total')
cohort.table<-rbind(N.cohort, AGE.cohort) 

x<-c("SEX.cohort", "RACE.cohort", "BCORT.cohort", "BL_BMI.cohort", "DDUR.cohort", "cdail_wk0.cohort", "BOWSTRICT.cohort", "tissinvol.cohort")

for (i in x){
	cohort.table<-rbind(cohort.table, get(i))
}

grid.table(cohort.table)

dev.off()

pdf(file='tables/SupTable1_baseline_metadata.pdf', height=6, width=8)
grid.table(cohort.table)
dev.off()