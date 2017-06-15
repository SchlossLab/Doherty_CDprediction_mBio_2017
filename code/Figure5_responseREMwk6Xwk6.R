pdf("figures/Figure5_wk6Xwk6.pdf", height = 8, width = 7)

layout(matrix(c(1,2), 2,1, byrow = T))
par(mar=c(3,3.5,2,1), mgp=c(2,0.5,0), oma=c(0,1.5,0,0))

### Plot REMISSION ROC curves

plot(c(1,0),c(0,1), type='l', lty=2, xlim=c(1.01,0), ylim=c(-0.01,1.01), xaxs='i', yaxs='i', ylab='Sensitivity', xlab='Specificity', las=1)
plot(otu_remWK6xWK6_roc, add=T, lwd=2, col='royalblue', lty=1)
plot(otu_relrespWK6xWK6_roc, add=T, lwd=2, col='red', lty=1)
legend('bottomright', c(sprintf('Remission : AUC=%.3f',otu_remWK6xWK6_roc$auc),sprintf('Response : AUC=%.3f',otu_relrespWK6xWK6_roc$auc)), lwd=2, col=c('royalblue','red'), bty='n', lty=1)
mtext('A', at=1, side=3, line=0.1, font=2, cex=2)

cutoff <- coords(roc=otu_relrespWK6xWK6_roc, x='best', best.method='y', ret=c('threshold'))
otu_relrespWK6xWK6_spec <- coords(otu_relrespWK6xWK6_roc, x=cutoff, input='thr', ret='spec')
otu_relrespWK6xWK6_sens <- coords(otu_relrespWK6xWK6_roc, x=otu_relrespWK6xWK6_spec, input='spec', ret='sens')
otu_relrespWK6xWK6_thr <- coords(otu_relrespWK6xWK6_roc, x=otu_relrespWK6xWK6_spec, input='spec', ret='thr')
points(coords(otu_relrespWK6xWK6_roc, x=cutoff, input='threshold', ret='specificity'),coords(otu_relrespWK6xWK6_roc, x=cutoff, input='threshold', ret='sensitivity'), col='red', cex=1.5, pch=10)

cutoff <- coords(roc=otu_remWK6xWK6_roc, x='best', best.method='y', ret=c('threshold'))
otu_remWK6xWK6_spec <- coords(otu_remWK6xWK6_roc, x=cutoff, input='thr', ret='spec')
otu_remWK6xWK6_sens <- coords(otu_remWK6xWK6_roc, x=otu_remWK6xWK6_spec, input='spec', ret='sens')
otu_remWK6xWK6_thr <- coords(otu_remWK6xWK6_roc, x=otu_remWK6xWK6_spec, input='spec', ret='thr')
points(coords(otu_remWK6xWK6_roc, x=cutoff, input='threshold', ret='specificity'),coords(otu_remWK6xWK6_roc, x=cutoff, input='threshold', ret='sensitivity'), col='royalblue', cex=1.5, pch=10)

tax<-read.table("../data/Jan400.simple.taxonomy.txt", header=T, sep='\t')

oturf_otus  <- as.character(otu_remWK6xWK6_rf$Xopt)
no_abunds <- otu_remWK6xWK6[otu_remWK6xWK6$REMISSwk6=='0', oturf_otus]/10000 + 1e-5
no_abunds <-na.omit(no_abunds)
yes_abunds <- otu_remWK6xWK6[otu_remWK6xWK6$REMISSwk6=='1', oturf_otus]/10000 + 1e-5
yes_abunds<- na.omit(yes_abunds)

par(mar=c(3, 14.5, 2, 1))
plot(1, type="n", ylim=c(0,length(oturf_otus )*2), xlim=c(1e-5,1.5), log="x", ylab="", xlab="Week 6 Relative Abundance (%)", xaxt="n", yaxt="n")
set.seed(32016)
index <- 1
for(i in oturf_otus ){
	stripchart(at=index-0.35, jitter(yes_abunds[,i], amount=1e-6), pch=21, bg=alpha("royalblue1", alpha=0.25), method="jitter", jitter=0.2, add=T, cex=1, lwd=0.5)
	stripchart(at=index+0.35, jitter(no_abunds[,i], amount=1e-6), pch=21, bg=alpha("orange", alpha=0.25), method="jitter", jitter=0.2, add=T, cex=1, lwd=0.5)
	segments(median(yes_abunds[,i]),index-0.7,median(yes_abunds[,i]),index-0.1, lwd=6, col = "black", lty = "solid")
	segments(median(no_abunds[,i]),index+0.7,median(no_abunds[,i]),index+0.1, lwd=6, col = "black", lty = "solid")
	index <- index + 2
}
rf_tax<-data.frame(oturf_otus)
colnames(rf_tax) <- c('OTU')

oturf_tax<-merge(rf_tax, tax, by='OTU')
oturf_tax<-oturf_tax[match(rf_tax$OTU, oturf_tax$OTU),]
oturf_tax<-oturf_tax$Label
oturf_tax <- gsub("_", " ", oturf_tax)
axis(2, at=seq(1,index-2,2), labels=oturf_tax, font = 3, las=1, line=0, tick=F, cex.axis=1)
axis(1, at=c(1e-5, 1e-4, 1e-3, 1e-2, 1e-1, 1e0), label=c("0", "0.01", "0.1", "1", "10", "100"))
legend('right', legend=c("Week 6 Active CD", "Week 6 Remission"), pch=c(21, 21), pt.bg=c("orange","royalblue1"), cex=1)
mtext('B', at=5e-9, side=3, line=0.1, font=2, cex=2)

dev.off()

