# **Supplemental Table 2: Table of taxa that appear frequently in predictive models at different response weeks, use baseline and post-treat time points, also pooled**
#Kopt table frequently occurring OTUs



freqOTUs_listTAX<-tax[tax$OTU %in% row.names(freqOTUs), 'Label'][as.factor(row.names(freqOTUs))]
#freqOTUs_listTAX

freqOTUs$OTUS<-freqOTUs_listTAX
freqOTUstable<-subset(freqOTUs, select=c("OTUS", "Sums"))
row.names(freqOTUstable)<-freqOTUstable$OTUS
freqOTUstable<-freqOTUstable[order(-freqOTUstable$Sums),]

freqOTUstable<-subset(freqOTUstable, select = "Sums")
colnames(freqOTUstable)<-"Occurance\n(out of 24)"

tiff("tables/ST2_freqOTUs.tiff", width = 4, height = 4, units='in', res=300)
grid.table(freqOTUstable)
dev.off()
#freqOTUstable

pdf("tables/ST2_freqOTUs.pdf", width = 4, height = 4)
grid.table(freqOTUstable)
dev.off()