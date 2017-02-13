#**Figure 3:  Abundance of frequently predictive OTUs in responders and remitters**
	
tiff(file='figures/Figure3freqOTUabund.tiff', height=4, width=8, units='in', res=300)

layout(1)
par(mar=c(4, 12, 2, 1))


tax<-read.table("../data/Jan400.simple.taxonomy.txt", header=T, sep='\t')


#Abundance stripchart or most predictive otus
oturf_otus  <- as.character(freqOTUs_list)
no_abunds <- otu_relrespWK22[otu_relrespWK22$RelRSPwk22=='0', oturf_otus]/10000 + 1e-5
no_abunds <-na.omit(no_abunds)
yes_abunds <- otu_relrespWK22[otu_relrespWK22$RelRSPwk22=='1', oturf_otus]/10000 + 1e-5
yes_abunds<- na.omit(yes_abunds)

plot(1, type="n", ylim=c(0,length(oturf_otus )*2), xlim=c(1e-5,3), log="x", ylab="", xlab="Relative Abundance (%)", xaxt="n", yaxt="n")
index <- 1
for(i in oturf_otus ){
	stripchart(at=index-0.35, jitter(yes_abunds[,i], amount=1e-5), pch=21, bg="royalblue1", method="jitter", jitter=0.2, add=T, cex=1, lwd=0.5)
	stripchart(at=index+0.35, jitter(no_abunds[,i], amount=1e-5), pch=21, bg="orange", method="jitter", jitter=0.2, add=T, cex=1, lwd=0.5)
	segments(mean(yes_abunds[,i]),index-0.7,mean(yes_abunds[,i]),index, lwd=3)
	segments(mean(no_abunds[,i]),index+0.7,mean(no_abunds[,i]),index, lwd=3)
	segments(median(yes_abunds[,i]),index-0.7,median(yes_abunds[,i]),index, lwd=3, col = "red")
	segments(median(no_abunds[,i]),index+0.7,median(no_abunds[,i]),index, lwd=3, col = "red")
	index <- index + 2
}
#oturf_otus<-as.factor(otu_relrespWK22_rf$Xopt)
axis(2, at=seq(1,index-2,2), labels=tax[tax$OTU %in% oturf_otus, 'Label'][as.factor(oturf_otus)], las=1, line=-0.5, tick=F, cex.axis=0.8)
axis(1, at=c(1e-5, 1e-4, 1e-3, 1e-2, 1e-1), label=c("0", "0.01", "0.1", "1", "10"))
legend('topright', legend=c("No", "Yes", "Median", "Mean"), pch=c(21, 21, 21, 21), pt.bg=c("orange","royalblue1", "red", "black"), cex=0.7)

dev.off()
