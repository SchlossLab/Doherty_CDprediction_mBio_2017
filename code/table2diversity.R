#**Table 2: Diversity differenced bases on Response/Remission in treated subjects.**
	
colnames(all.RelRSPwk6) <- c('Status Week', 'Summary', 'Species Richness (Alpha-diversity)', 'Community Structure (beta-diversity)')
table2<-rbind(all.RelRSPwk6, trtd.RelRSPwk6)

divers<-c("plac.RelRSPwk6", "all.REMISSwk6", "trtd.REMISSwk6", "plac.REMISSwk6", "all.RelRSPwk22", "trtd.RelRSPwk22", "plac.RelRSPwk22", "all.REMISSwk22", "trtd.REMISSwk22", "plac.REMISSwk22")

for (i in divers){
	table2<-rbind(table2, get(i))
}

tiff('tables/table2diversity.tiff', height=4, width=10, units='in', res=300)
grid.table(table2)
dev.off()

pdf(file='tables/table2diversity.pdf', height=4, width=10)
grid.table(table2)
dev.off()