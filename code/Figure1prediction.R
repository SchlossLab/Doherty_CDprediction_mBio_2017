#**Figure 1: Prediction of RESPONSE/REMISSION in treated subjects using all clinical metadata, baseline microbiome alone, and combined**
#	*Question:* Can the microbiome, clinical metadata, or combined models reliably predict response?
#*Goal:* Show clinical metadata isn’t great for prediction and improvement of prediction using microbiome. Show taxa marked as important for prediction are abundant enough to care about
#A. Response ROCs
#B. Response Model Performance vs. reality
#C. Top predictive taxa and abundance based on response	
#D. REMISSION ROCs
#E. REMISSION Model Performance vs. reality
#F. Top predictive taxa and abundance based on remission

#tiff(RelRSPwk6Fig )

#tiff('figures/Figure1.tiff', height=12, width=10, units='in', res=300)

pdf("figures/Figure6_wk0Xwk6pred.pdf", height = 10, width = 12)
layout(matrix(c(1,2,3,4), 2, 2, byrow = TRUE))

#pdf("figures/Week6response.AUC.pdf")
#tiff('figures/RelRSPwk6AUCRF.tiff', height=6, width=12, units='in', res=300)
#pdf('figures/RelRSPwk6AUCRF.DDW.pdf', height=6, width=12)
#layout(matrix(c(1, 2), 1, 2))
par(mar=c(3,3,2,1), mgp=c(2,0.5,0))
plot(c(1,0),c(0,1), type='l', lty=2, xlim=c(1.01,0), ylim=c(-0.01,1.01), xaxs='i', yaxs='i', ylab='Sensitivity', xlab='Specificity', las=1)
plot(otu_relrespWK6_roc, add=T, lwd=2, col='royalblue', lty=1)
plot(md_relrespWK6_roc, add=T, lwd=2, col='grey5', lty=1)
plot(mdotu_relrespWK6_roc, add=T, lwd=2, col='red', lty=1)
#title("Predicting Week 6 Response")
legend('bottomright', c(sprintf('Week 0 OTUs : AUC=%.3f',otu_relrespWK6_roc$auc), sprintf('Week 0 Clinical Data: AUC=%.3f',md_relrespWK6_roc$auc), sprintf('Combined: AUC=%.3f',mdotu_relrespWK6_roc$auc)), lwd=2, col=c('royalblue', 'grey5', 'red'), bty='n', lty=1)
mtext('A', at=1, side=3, line=0.1, font=2, cex=2)
#legend('bottomright', c(sprintf('Week 0 OTUs : AUC=%.3f',otu_relrespWK6_roc$auc), sprintf('Combined: AUC=%.3f',mdotu_relrespWK6_roc$auc)), lwd=2, col=c('royalblue', 'red'), bty='n', lty=1)

cutoff <- coords(roc=mdotu_relrespWK6_roc, x='best', best.method='y', ret=c('threshold'))
mdotu_relrespWK6_spec <- coords(mdotu_relrespWK6_roc, x=cutoff, input='thr', ret='spec')
mdotu_relrespWK6_sens <- coords(mdotu_relrespWK6_roc, x=mdotu_relrespWK6_spec, input='spec', ret='sens')
mdotu_relrespWK6_thr <- coords(mdotu_relrespWK6_roc, x=mdotu_relrespWK6_spec, input='spec', ret='thr')

points(coords(mdotu_relrespWK6_roc, x=cutoff, input='threshold', ret='specificity'),coords(mdotu_relrespWK6_roc, x=cutoff, input='threshold', ret='sensitivity'), col='red', cex=1.5, pch=10)

cutoff <- coords(roc=otu_relrespWK6_roc, x='best', best.method='y', ret=c('threshold'))
otu_relrespWK6_spec <- coords(otu_relrespWK6_roc, x=cutoff, input='thr', ret='spec')
otu_relrespWK6_sens <- coords(otu_relrespWK6_roc, x=otu_relrespWK6_spec, input='spec', ret='sens')
otu_relrespWK6_thr <- coords(otu_relrespWK6_roc, x=otu_relrespWK6_spec, input='spec', ret='thr')
points(coords(otu_relrespWK6_roc, x=cutoff, input='threshold', ret='specificity'),coords(otu_relrespWK6_roc, x=cutoff, input='threshold', ret='sensitivity'), col='royalblue', cex=1.5, pch=10)

cutoff <- coords(roc=md_relrespWK6_roc, x='best', best.method='y', ret=c('threshold'))
md_relrespWK6_spec <- coords(md_relrespWK6_roc, x=cutoff, input='thr', ret='spec')
md_relrespWK6_sens <- coords(md_relrespWK6_roc, x=md_relrespWK6_spec, input='spec', ret='sens')
md_relrespWK6_thr <- coords(md_relrespWK6_roc, x=md_relrespWK6_spec, input='spec', ret='thr')

points(coords(md_relrespWK6_roc, x=cutoff, input='threshold', ret='specificity'),coords(md_relrespWK6_roc, x=cutoff, input='threshold', ret='sensitivity'), col='black', cex=1.5, pch=10)

#pdf('data/figures/RSPwk6abunds.#pdf', height=6, width=8)
#plot(1, type='n', xlim=c(0.5,2.5), ylim=c(0,1), ylab='', xlab='Response Week 6', xaxt='n', cex.axis=1.2)
#title('Response Status Compared to Combined Model')
# set.seed(32016)
# stripchart(at=1, mdotu_relrespWK6_probs[mdotu_relrespWK6$'RelRSPwk6'==0], vertical=T, method='jitter', jitter=0.4, pch=21, bg='orange', add=T, cex=1.5)
# stripchart(at=2, mdotu_relrespWK6_probs[mdotu_relrespWK6$'RelRSPwk6'==1], vertical=T, method='jitter', jitter=0.4, pch=21, bg='royalblue', add=T, cex=1.5)
# mtext(side=2, text='Probability of Response', line=2.2, cex=0.8)
# axis(1, at=c(1,2), labels=c('No', 'Yes'), cex.axis=1.2)
# cutoff <- coords(roc=mdotu_relrespWK6_roc, x='best', best.method='y', ret=c('threshold')) #gives best point on curve for cutoff
# abline(h=cutoff, lty=2)
# legend("top", lty=2, sprintf('Model Threshold'))

#mtext('B', at=0.5, side=3, line=0.1, font=2, cex=2)
#dev.off()

tax<-read.table("../data/Jan400.simple.taxonomy.txt", header=T, sep='\t')


#Abundance stripchart or most predictive otus
oturf_otus  <- as.character(ordered(otu_relrespWK6_rf$Xopt))
oturf_otus <- oturf_otus[1:10]
#oturf_otus
no_abunds <- otu_relrespWK6[otu_relrespWK6$RelRSPwk6=='0', oturf_otus]/10000 + 1e-5
no_abunds <-na.omit(no_abunds)
yes_abunds <- otu_relrespWK6[otu_relrespWK6$RelRSPwk6=='1', oturf_otus]/10000 + 1e-5
yes_abunds<- na.omit(yes_abunds)

#pdf('figures/oturelRSPwk6AUCRFabunds.DDW.pdf', height=6, width=12)
#layout(1)
par(mar=c(4, 12, 2, 1))
plot(1, type="n", ylim=c(0,length(oturf_otus )*2), xlim=c(1e-5,3), log="x", ylab="", xlab="Week 0 Relative Abundance (%)", xaxt="n", yaxt="n")
#title('Abundance of Top OTUs from Microbiome Model')
set.seed(32016)
index <- 1
for(i in oturf_otus ){
	stripchart(at=index-0.35, jitter(yes_abunds[,i], amount=1e-6), pch=21, bg=alpha("royalblue1", alpha=0.5), method="jitter", jitter=0.2, add=T, cex=1, lwd=0.5)
	stripchart(at=index+0.35, jitter(no_abunds[,i], amount=1e-6), pch=21, bg=alpha("orange", alpha=0.5), method="jitter", jitter=0.2, add=T, cex=1, lwd=0.5)
	segments(median(yes_abunds[,i]),index-0.7,median(yes_abunds[,i]),index-0.1, lwd=6, col = "black", lty = "solid")
	segments(median(no_abunds[,i]),index+0.7,median(no_abunds[,i]),index+0.1, lwd=6, col = "black", lty = "solid")
	segments(median(yes_abunds[,i]),index-0.7,median(yes_abunds[,i]),index-0.1, lwd=3, col = "red", lty = "solid")
	segments(median(no_abunds[,i]),index+0.7,median(no_abunds[,i]),index+0.1, lwd=3, col = "red", lty = "solid")
	index <- index + 2
}
#oturf_otus
rf_tax<-data.frame(oturf_otus)
colnames(rf_tax) <- c('OTU')

oturf_tax<-merge(rf_tax, tax, by='OTU')

lab <- levels(oturf_tax$tax)
oturf_tax$Classification <- gsub("(OTU\\d+)", "(\\1)", oturf_tax$Classification)

oturf_tax<-oturf_tax[match(rf_tax$OTU, oturf_tax$OTU),]
oturf_name<-as.character(oturf_tax$tax)
oturf_numb<-oturf_tax$Classification

oturf_name <- gsub("_", " ", oturf_name)
formatted <- lapply(1:nrow(oturf_tax), function(i) bquote(paste(italic(.(oturf_name[i])), " ", .(oturf_numb[i]), sep=" ")))


axis(2, at=seq(1,index-2,2), labels=do.call(expression, formatted), las=1, line=0, tick=F, cex.axis=1)
axis(1, at=c(1e-5, 1e-4, 1e-3, 1e-2, 1e-1, 1e0), label=c("0", "0.01", "0.1", "1", "10", "100"))
legend('bottomright', legend=c("Week 6 Nonresponder", "Week 6 Responder"), pch=c(21, 21), pt.bg=c("orange","royalblue1"), cex=1)
mtext('B', at=1e-8, side=3, line=0.1, font=2, cex=2)
#dev.off()

#Remission
#pdf('figures/REMISSwk6AUCRF.pdf', height=6, width=12)
#layout(matrix(c(1, 2), 1, 2))
par(mar=c(3,3,2,1), mgp=c(2,0.5,0))
plot(c(1,0),c(0,1), type='l', lty=2, xlim=c(1.01,0), ylim=c(-0.01,1.01), xaxs='i', yaxs='i', ylab='Sensitivity', xlab='Specificity', las=1)
plot(otu_remWK6_roc, add=T, lwd=2, col='royalblue', lty=1)
plot(md_remWK6_roc, add=T, lwd=2, col='grey5', lty=1)
plot(mdotu_remWK6_roc, add=T, lwd=2, col='red', lty=1)
#title("Predicting Week 6 Remission")
legend('bottomright', c(sprintf('Week 0 OTUs : AUC=%.3f', otu_remWK6_roc$auc), sprintf('Week 0 Clinical Data: AUC=%.3f',md_remWK6_roc$auc),sprintf('Combined: AUC=%.3f',mdotu_remWK6_roc$auc)), lwd=2, col=c('royalblue', "grey5", 'red'), bty='n', lty=1)
mtext('C', at=1, side=3, line=0.1, font=2, cex=2)

cutoff <- coords(roc=mdotu_remWK6_roc, x='best', best.method='y', ret=c('threshold'))
mdotu_remWK6_spec <- coords(mdotu_remWK6_roc, x=cutoff, input='thr', ret='spec')
mdotu_remWK6_sens <- coords(mdotu_remWK6_roc, x=mdotu_remWK6_spec, input='spec', ret='sens')
mdotu_remWK6_thr <- coords(mdotu_remWK6_roc, x=mdotu_remWK6_spec, input='spec', ret='thr')

points(coords(mdotu_remWK6_roc, x=cutoff, input='threshold', ret='specificity'),coords(mdotu_remWK6_roc, x=cutoff, input='threshold', ret='sensitivity'), col='red', cex=1.5, pch=10)

cutoff <- coords(roc=otu_remWK6_roc, x='best', best.method='y', ret=c('threshold'))
otu_remWK6_spec <- coords(otu_remWK6_roc, x=cutoff, input='thr', ret='spec')
otu_remWK6_sens <- coords(otu_remWK6_roc, x=otu_remWK6_spec, input='spec', ret='sens')
otu_remWK6_thr <- coords(otu_remWK6_roc, x=otu_remWK6_spec, input='spec', ret='thr')
points(coords(otu_remWK6_roc, x=cutoff, input='threshold', ret='specificity'),coords(otu_remWK6_roc, x=cutoff, input='threshold', ret='sensitivity'), col='royalblue', cex=1.5, pch=10)

cutoff <- coords(roc=md_remWK6_roc, x='best', best.method='y', ret=c('threshold'))
md_remWK6_spec <- coords(md_remWK6_roc, x=cutoff, input='thr', ret='spec')
md_remWK6_sens <- coords(md_remWK6_roc, x=md_remWK6_spec, input='spec', ret='sens')
md_remWK6_thr <- coords(md_remWK6_roc, x=md_remWK6_spec, input='spec', ret='thr')

points(coords(md_remWK6_roc, x=cutoff, input='threshold', ret='specificity'),coords(md_remWK6_roc, x=cutoff, input='threshold', ret='sensitivity'), col='black', cex=1.5, pch=10)
#dev.off()

#compared to model
# plot(1, type='n', xlim=c(0.5,2.5), ylim=c(0,1), ylab='', xlab='Remission Week 6', xaxt='n', cex.axis=1.2)
# title('Remission Status Compared to Combined Model')
# set.seed(32016)
# stripchart(at=1, mdotu_remWK6_probs[mdotu_remWK6$REMISSwk6=='0'], vertical=T, method='jitter', jitter=0.4, pch=21, bg='orange', add=T, cex=1.5)
# stripchart(at=2, mdotu_remWK6_probs[mdotu_remWK6$REMISSwk6=='1'], vertical=T, method='jitter', jitter=0.4, pch=21, bg='royalblue', add=T, cex=1.5)
# mtext(side=2, text='Probability of Response', line=2.2, cex=0.8)
# axis(1, at=c(1,2), labels=c('No', 'Yes'), cex.axis=1.2)
# cutoff <- coords(roc=mdotu_remWK6_roc, x='best', best.method='y', ret=c('threshold')) #gives best point on curve for cutoff
# abline(h=cutoff, lty=2)
# legend("top", lty=2, sprintf('Model Threshold'))
#mtext('E', at=0.5, side=3, line=0.1, font=2, cex=2)
#dev.off()

#Abundance stripchart or most predictive otus
tax<-read.table("../data/Jan400.simple.taxonomy.txt", header=T, sep='\t')

oturf_otus  <- as.character(otu_remWK6_rf$Xopt)
oturf_otus <- oturf_otus[1:10]
no_abunds <- otu_remWK6[otu_remWK6$REMISSwk6=='0', oturf_otus]/10000 + 1e-5
no_abunds <-na.omit(no_abunds)
yes_abunds <- otu_remWK6[otu_remWK6$REMISSwk6=='1', oturf_otus]/10000 + 1e-5
yes_abunds<- na.omit(yes_abunds)

#pdf('figures/otuREMwk6AUCRFabunds.pdf', height=8, width=12)
#layout(1)
par(mar=c(4, 14, 2, 1))
plot(1, type="n", ylim=c(0,length(oturf_otus )*2), xlim=c(1e-5,3), log="x", ylab="", xlab="Week 0 Relative Abundance (%)", xaxt="n", yaxt="n", cex=1)
#title('Abundance of Top OTUs from Microbiome Model')
set.seed(32016)
index <- 1
for(i in oturf_otus ){
	stripchart(at=index-0.35, jitter(yes_abunds[,i], amount=1e-6), pch=21, bg=alpha("royalblue1", alpha=0.5), method="jitter", jitter=0.2, add=T, cex=1, lwd=0.5)
	stripchart(at=index+0.35, jitter(no_abunds[,i], amount=1e-6), pch=21, bg=alpha("orange", alpha=0.5), method="jitter", jitter=0.2, add=T, cex=1, lwd=0.5)
	segments(median(yes_abunds[,i]),index-0.7,median(yes_abunds[,i]),index-0.1, lwd=6, col = "black", lty = "solid")
	segments(median(no_abunds[,i]),index+0.7,median(no_abunds[,i]),index+0.1, lwd=6, col = "black", lty = "solid")
	segments(median(yes_abunds[,i]),index-0.7,median(yes_abunds[,i]),index-0.1, lwd=3, col = "red", lty = "solid")
	segments(median(no_abunds[,i]),index+0.7,median(no_abunds[,i]),index+0.1, lwd=3, col = "red", lty = "solid")
	index <- index + 2
}
#oturf_otus
rf_tax<-data.frame(oturf_otus)
colnames(rf_tax) <- c('OTU')

oturf_tax<-merge(rf_tax, tax, by='OTU')

lab <- levels(oturf_tax$tax)
oturf_tax$Classification <- gsub("(OTU\\d+)", "(\\1)", oturf_tax$Classification)

oturf_tax<-oturf_tax[match(rf_tax$OTU, oturf_tax$OTU),]
oturf_name<-as.character(oturf_tax$tax)
oturf_numb<-oturf_tax$Classification

oturf_name <- gsub("_", " ", oturf_name)
formatted <- lapply(1:nrow(oturf_tax), function(i) bquote(paste(italic(.(oturf_name[i])), " ", .(oturf_numb[i]), sep=" ")))

axis(2, at=seq(1,index-2,2), labels=do.call(expression, formatted), las=1, line=0, tick=F, cex.axis=1)
axis(1, at=c(1e-5, 1e-4, 1e-3, 1e-2, 1e-1, 1e0), label=c("0", "0.01", "0.1", "1", "10", "100"))
legend('topright', legend=c("Week 6 Nonremitter", "Week 6 Remitter"), pch=c(21, 21), pt.bg=c("orange","royalblue1"), cex=1)
mtext('D', at=1e-8, side=3, line=0.1, font=2, cex=2)

dev.off()




