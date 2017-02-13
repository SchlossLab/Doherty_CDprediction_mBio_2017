#**Supplemental Table 1: Summary of clinical metadata of chort at baseline**

tiff(file='tables/SupTable1_baseline_metadata.tiff', height=4, width=6, units='in', res=300)

	
colnames(AGE.cohort) <- c('Clinical Variable', 'Treated', 'Placebo', 'Total')
cohort.table<-rbind(AGE.cohort, SEX.cohort) 

x<-c("RACE.cohort", "BCORT.cohort", "BL_BMI.cohort", "DDUR.cohort", "cdail_wk0.cohort", "BOWSTRICT.cohort", "tissinvol.cohort")

for (i in x){
	cohort.table<-rbind(cohort.table, get(i))
}

grid.table(cohort.table)

dev.off()

pdf(file='tables/SupTable1_baseline_metadata.pdf', height=4, width=6)
grid.table(cohort.table)
dev.off()