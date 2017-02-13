#**Figure 2: Lefse data supporting the abundance/importance data in the predictive models**
#Abundance strip charts of differential taxa based on A) response and B) remission.

tiff(file='figures/Figure2LEfSe.tiff', height=8, width=9, units='in', res=300)

layout(matrix(c(2,1)))
par(mar=c(4, 12, 2, 1))


nao.screen.trtd<-nao.screen_data[nao.screen_data$TRTGRINDMAN!="Placebo_Placebo",]
nao.screen.trtd<-nao.screen.trtd[nao.screen.trtd$TRTGRINDMAN!="Placebo_Treated",]




Lsum<-read.table("../data/Jan400.screening.all.na.omit.cmd.byTRTGR_REMISSwk6.trtdYN.lefse_summary", header=T, na.strings=c("NA", "NULL"), sep="\t", fill=T)
Lsum<-na.omit(Lsum)
Lsumtax<-merge(tax, Lsum, by='OTU')

Lsumtax_otus <- as.character(Lsumtax$OTU)

Lsumtax_otus <- Lsumtax_otus[1:10]
Lsumtax_tax<- as.character(Lsumtax$Label) 
Lsumtax_tax <- Lsumtax_tax[1:10]
trtdWK6.remitters<-nao.screen.trtd[nao.screen.trtd$REMISSwk6=='Yes',]

trtdWK6.rem.Lsumtax <-subset(trtdWK6.remitters, select=Lsumtax_otus)
trtdWK6.NONremitters<-nao.screen.trtd[nao.screen.trtd$REMISSwk6=='No',]
trtdWK6.NONrem.Lsumtax <-subset(trtdWK6.NONremitters, select=Lsumtax_otus)


No_abunds <- trtdWK6.NONrem.Lsumtax/10000 + 1e-4

Yes_abunds <- trtdWK6.rem.Lsumtax/10000 + 1e-4

plot(1, type="n", ylim=c(0,length(Lsumtax_otus)*3), xlim=c(1e-4,1), log="x", ylab="", xlab="Relative Abundance (%)", xaxt="n", yaxt="n")
index <- 1
for(i in Lsumtax_otus){
	stripchart(at=index+0.7, jitter(No_abunds[,i], amount=1e-5), pch=21, bg="red", method="jitter", jitter=0.2, add=T, cex=1, lwd=0.5)
	stripchart(at=index-0.7, jitter(Yes_abunds[,i], amount=1e-5), pch=21, bg="royalblue1", method="jitter", jitter=0.2, add=T, cex=1, lwd=0.5)
	segments(median(No_abunds[,i]),index+0.9,median(No_abunds[,i]),index+.3, lwd=4)
	segments(median(Yes_abunds[,i]),index-0.9,median(Yes_abunds[,i]),index-0.3, lwd=4)
	index <- index + 3
}
axis(2, at=seq(1,index-3,3), labels=Lsumtax_tax, las=1, line=-0.5, tick=F, cex.axis=0.8)
axis(1, at=c(1e-4, 1e-3, 1e-2, 1e-1, 1), label=c("0", "0.1", "1", "10", "100"))
legend("topright", legend=c("No", "Yes", "Median"), pch=c(21, 21, 21), pt.bg=c("red", "royalblue1", "black"), cex=1, title='Remission Week 6')
#title("Differential OTUs by LEfSe Remission Week 6")
mtext('B', at=1e-5, side=3, line=0.1, font=2, cex=2)

par(mar=c(4, 12, 2, 1))
Lsum<-read.table("../data/Jan400.screening.all.na.omit.cmd.byTRTGR_RelRSPwk6.trtdYN.lefse_summary", header=T, na.strings=c("NA", "NULL"), sep="\t", fill=T)
Lsum<-na.omit(Lsum)
Lsumtax<-merge(tax, Lsum, by='OTU')

Lsumtax_otus <- as.character(Lsumtax$OTU)
Lsumtax_otus <- Lsumtax_otus[1:10]
Lsumtax_tax<- as.character(Lsumtax$Label) 
Lsumtax_tax <- Lsumtax_tax[1:10]
No_abunds <- nao.screen.trtd[nao.screen.trtd$RelRSPwk6=='No', Lsumtax_otus]/10000 + 1e-4
Yes_abunds <- nao.screen.trtd[nao.screen.trtd$RelRSPwk6=="Yes", Lsumtax_otus]/10000 + 1e-4

plot(1, type="n", ylim=c(0,length(Lsumtax_otus)*3), xlim=c(1e-4,1), log="x", ylab="", xlab="Relative Abundance (%)", xaxt="n", yaxt="n")
index <- 1
for(i in Lsumtax_otus){
	stripchart(at=index+0.7, jitter(No_abunds[,i], amount=1e-5), pch=21, bg="red", method="jitter", jitter=0.2, add=T, cex=1, lwd=0.5)
	stripchart(at=index-0.7, jitter(Yes_abunds[,i], amount=1e-5), pch=21, bg="royalblue1", method="jitter", jitter=0.2, add=T, cex=1, lwd=0.5)
	segments(median(No_abunds[,i]),index+0.9,median(No_abunds[,i]),index+.3, lwd=4)
	segments(median(Yes_abunds[,i]),index-0.9,median(Yes_abunds[,i]),index-0.3, lwd=4)
	index <- index + 3
}
axis(2, at=seq(1,index-3,3), labels=Lsumtax_tax, las=1, line=-0.5, tick=F, cex.axis=0.8)
axis(1, at=c(1e-4, 1e-3, 1e-2, 1e-1, 1), label=c("0", "0.1", "1", "10", "100"))
legend("topright", legend=c("No", "Yes", "Median"), pch=c(21, 21, 21), pt.bg=c("red", "royalblue1", "black"), cex=1, title="Response Week 6")
#title("Differential OTUs by LEfSe Response Week 6")
mtext('A', at=1e-5, side=3, line=.1, font=2, cex=2)

dev.off()


