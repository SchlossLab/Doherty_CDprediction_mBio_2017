#figure layout
tiff(file='figures/RSPwk6aucrf.tiff', height=4, width=9, units='in', res=300)


layout(matrix(c(2, 1), nrow=1))
par(mar=c(3,3.5,2,1), mgp=c(2,0.5,0), oma=c(0,1.5,0,0))


#pdf('data/figures/RSPwk6aucrf.#pdf', height=6, width=8)
### Plot REMISSION ROC curves

plot(c(1,0),c(0,1), type='l', lty=2, xlim=c(1.01,0), ylim=c(-0.01,1.01), xaxs='i', yaxs='i', ylab='Sensitivity', xlab='Specificity', las=1)
plot(otu_remWK6xWK6_roc, add=T, lwd=2, col='royalblue', lty=1)
plot(md_remWK6xWK6_roc, add=T, lwd=2, col='grey5', lty=1)
plot(mdotu_remWK6xWK6_roc, add=T, lwd=2, col='red', lty=1)
#title("Predicting Week 6 Remission using Week 6 Clinical Data")
legend('bottomright', c(sprintf('OTUs : AUC=%.3f',otu_remWK6xWK6_roc$auc),sprintf('Clinical Data: AUC=%.3f',md_remWK6xWK6_roc$auc),sprintf('Combined: AUC=%.3f',mdotu_remWK6xWK6_roc$auc)), lwd=2, col=c('royalblue','grey5', 'red'), bty='n', lty=1, title="Remission Week 6")
title
mtext('B', at=1.1, side=3, line=0.1, font=2, cex=2)

cutoff <- coords(roc=mdotu_remWK6xWK6_roc, x='best', best.method='y', ret=c('threshold'))
mdotu_remWK6xWK6_spec <- coords(mdotu_remWK6xWK6_roc, x=cutoff, input='thr', ret='spec')
mdotu_remWK6xWK6_sens <- coords(mdotu_remWK6xWK6_roc, x=mdotu_remWK6xWK6_spec, input='spec', ret='sens')
mdotu_remWK6xWK6_thr <- coords(mdotu_remWK6xWK6_roc, x=mdotu_remWK6xWK6_spec, input='spec', ret='thr')

points(coords(mdotu_remWK6xWK6_roc, x=cutoff, input='threshold', ret='specificity'),coords(mdotu_remWK6xWK6_roc, x=cutoff, input='threshold', ret='sensitivity'), col='red', cex=1.5, pch=10)

cutoff <- coords(roc=otu_remWK6xWK6_roc, x='best', best.method='y', ret=c('threshold'))
otu_remWK6xWK6_spec <- coords(otu_remWK6xWK6_roc, x=cutoff, input='thr', ret='spec')
otu_remWK6xWK6_sens <- coords(otu_remWK6xWK6_roc, x=otu_remWK6xWK6_spec, input='spec', ret='sens')
otu_remWK6xWK6_thr <- coords(otu_remWK6xWK6_roc, x=otu_remWK6xWK6_spec, input='spec', ret='thr')
points(coords(otu_remWK6xWK6_roc, x=cutoff, input='threshold', ret='specificity'),coords(otu_remWK6xWK6_roc, x=cutoff, input='threshold', ret='sensitivity'), col='royalblue', cex=1.5, pch=10)

cutoff <- coords(roc=md_remWK6xWK6_roc, x='best', best.method='y', ret=c('threshold'))
md_remWK6xWK6_spec <- coords(md_remWK6xWK6_roc, x=cutoff, input='thr', ret='spec')
md_remWK6xWK6_sens <- coords(md_remWK6xWK6_roc, x=md_remWK6xWK6_spec, input='spec', ret='sens')
md_remWK6xWK6_thr <- coords(md_remWK6xWK6_roc, x=md_remWK6xWK6_spec, input='spec', ret='thr')

points(coords(md_remWK6xWK6_roc, x=cutoff, input='threshold', ret='specificity'),coords(md_remWK6xWK6_roc, x=cutoff, input='threshold', ret='sensitivity'), col='black', cex=1.5, pch=10)
#dev.off()

#pdf('data/figures/RSPwk6abunds.#pdf', height=6, width=8)
#plot(4, type='n', xlim=c(0.5,2.5), ylim=c(0,1), ylab='', xlab='', xaxt='n', cex.axis=1.2)
#title('Remission Status Compared to OTU Model')
#stripchart(at=1, otu_remWK6xWK6_probs[otu_remWK6xWK6$'REMISSwk6'==0], vertical=T, method='jitter', jitter=0.4, pch=21, bg='orange', add=T, cex=1.5)
#stripchart(at=2, otu_remWK6xWK6_probs[otu_remWK6xWK6$'REMISSwk6'==1], vertical=T, method='jitter', jitter=0.4, pch=21, bg='royalblue', add=T, cex=1.5)
#mtext(side=2, text='Probability of Response', line=2.2, cex=0.8)
#axis(1, at=c(1,2), labels=c('No', 'Yes'), cex.axis=1.2)
#cutoff <- coords(roc=otu_remWK6xWK6_roc, x='best', best.method='y', ret=c('threshold')) #gives best point on curve for cutoff
#abline(h=cutoff, lty=2)
#legend("top", lty=2, sprintf('Model Threshold'), title="Remission Week 6")
#mtext('D', at=0.5, side=3, line=0.1, font=2, cex=2)

### Plot response ROC curves
plot(c(1,0),c(0,1), type='l', lty=2, xlim=c(1.01,0), ylim=c(-0.01,1.01), xaxs='i', yaxs='i', ylab='Sensitivity', xlab='Specificity', las=1)
plot(otu_relrespWK6xWK6_roc, add=T, lwd=2, col='royalblue', lty=1)
plot(md_relrespWK6xWK6_roc, add=T, lwd=2, col='grey5', lty=1)
plot(mdotu_relrespWK6xWK6_roc, add=T, lwd=2, col='red', lty=1)
#title("Predicting Week 6 Response \\n using Week 6 Clinical Data")
legend('bottomright', c(sprintf('OTUs : AUC=%.3f',otu_relrespWK6xWK6_roc$auc),sprintf('Clinical Data: AUC=%.3f',md_relrespWK6xWK6_roc$auc),sprintf('Combined: AUC=%.3f',mdotu_relrespWK6xWK6_roc$auc)), lwd=2, col=c('royalblue','grey5', 'red'), bty='n', lty=1, title="Response Week 6")
mtext('A', at=1.1, side=3, line=0.1, font=2, cex=2)

cutoff <- coords(roc=mdotu_relrespWK6xWK6_roc, x='best', best.method='y', ret=c('threshold'))
mdotu_relrespWK6xWK6_spec <- coords(mdotu_relrespWK6xWK6_roc, x=cutoff, input='thr', ret='spec')
mdotu_relrespWK6xWK6_sens <- coords(mdotu_relrespWK6xWK6_roc, x=mdotu_relrespWK6xWK6_spec, input='spec', ret='sens')
mdotu_relrespWK6xWK6_thr <- coords(mdotu_relrespWK6xWK6_roc, x=mdotu_relrespWK6xWK6_spec, input='spec', ret='thr')

points(coords(mdotu_relrespWK6xWK6_roc, x=cutoff, input='threshold', ret='specificity'),coords(mdotu_relrespWK6xWK6_roc, x=cutoff, input='threshold', ret='sensitivity'), col='red', cex=1.5, pch=10)

cutoff <- coords(roc=otu_relrespWK6xWK6_roc, x='best', best.method='y', ret=c('threshold'))
otu_relrespWK6xWK6_spec <- coords(otu_relrespWK6xWK6_roc, x=cutoff, input='thr', ret='spec')
otu_relrespWK6xWK6_sens <- coords(otu_relrespWK6xWK6_roc, x=otu_relrespWK6xWK6_spec, input='spec', ret='sens')
otu_relrespWK6xWK6_thr <- coords(otu_relrespWK6xWK6_roc, x=otu_relrespWK6xWK6_spec, input='spec', ret='thr')
points(coords(otu_relrespWK6xWK6_roc, x=cutoff, input='threshold', ret='specificity'),coords(otu_relrespWK6xWK6_roc, x=cutoff, input='threshold', ret='sensitivity'), col='royalblue', cex=1.5, pch=10)

cutoff <- coords(roc=md_relrespWK6xWK6_roc, x='best', best.method='y', ret=c('threshold'))
md_relrespWK6xWK6_spec <- coords(md_relrespWK6xWK6_roc, x=cutoff, input='thr', ret='spec')
md_relrespWK6xWK6_sens <- coords(md_relrespWK6xWK6_roc, x=md_relrespWK6xWK6_spec, input='spec', ret='sens')
md_relrespWK6xWK6_thr <- coords(md_relrespWK6xWK6_roc, x=md_relrespWK6xWK6_spec, input='spec', ret='thr')

points(coords(md_relrespWK6xWK6_roc, x=cutoff, input='threshold', ret='specificity'),coords(md_relrespWK6xWK6_roc, x=cutoff, input='threshold', ret='sensitivity'), col='black', cex=1.5, pch=10)



#plot model results response wk6 by wk6
#plot(2, type='n', xlim=c(0.5,2.5), ylim=c(0,1), ylab='', xlab='', xaxt='n', cex.axis=1.2)
#title('Response Status \\n Compared to OTU Model')
#stripchart(at=1, otu_relrespWK6xWK6_probs[otu_relrespWK6xWK6$'RelRSPwk6'==0], vertical=T, method='jitter', jitter=0.4, pch=21, bg='orange', add=T, cex=1.5)
#stripchart(at=2, otu_relrespWK6xWK6_probs[otu_relrespWK6xWK6$'RelRSPwk6'==1], vertical=T, method='jitter', jitter=0.4, pch=21, bg='royalblue', add=T, cex=1.5)
#mtext(side=2, text='Probability of Response', line=2.2, cex=0.8)
#axis(1, at=c(1,2), labels=c('No', 'Yes'), cex.axis=1.2)
#cutoff <- coords(roc=otu_relrespWK6xWK6_roc, x='best', best.method='y', ret=c('threshold')) #gives best point on curve for cutoff
#abline(h=cutoff, lty=2)
#legend("top", lty=2, sprintf('Model Threshold'), title="Response Week 6")
#mtext('B', at=0.5, side=3, line=0.1, font=2, cex=2)
#dev.off()


dev.off()

