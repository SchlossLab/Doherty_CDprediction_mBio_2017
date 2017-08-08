print("RelRSPwk6 by AUC-RF \\nRelative response defined as a decrease in CDAI from Week.6 greater than 29.5%.")
set.seed(32016)
levels(trtd.wk6_data$RelRSPwk6) <- c(0,1)

mdotu_relrespWK6xWK6 <- trtd.wk6_data[trtd.wk6_data$visit=='Week 6', c('RelRSPwk6',"AGE", "SEX", "BAMINO", "BANTIBIO", "BCORT", "BIMM", "BL_BMI", "DDUR", "DDUR10", "DDUR15", "tissinvol", "BRSP_TNF", "BL_FLACT", "BL_FCALP", "BL_CRP", "BL_CRPLEV", "BL_FCALPLEV", "BL_FLACTLEV", "BOWSTRICT", "CDSTOOLM_Week.6", "CDPAINM_Week.6", "CDWELBEM_Week.6", "CDARTRTM_Week.6", "CDARALGM_Week.6", "CDIRITM_Week.6", "CDUVEITM_Week.6", "CDERYTHM_Week.6", "CDPYODEM_Week.6", "CDSTOMAM_Week.6", "CDFISURM_Week.6", "CDFISTUM_Week.6", "CDABSCEM_Week.6", "CDOTFISM_Week.6", "CDFEVERM_Week.6", "CDDRGM_Week.6", "CDAMASSM_Week.6", "CDHCTM_Week.6", "CDWEIGHM_Week.6", "invsimpson", colnames(trtd.wk6_data)[grep('Otu[0123456789]', colnames(trtd.wk6_data))])]
#summary(mdotu_relrespWK6xWK6[,c("RelRSPwk6")])
mdotu_relrespWK6xWK6<-na.omit(mdotu_relrespWK6xWK6)
#summary(mdotu_relrespWK6xWK6[,c("RelRSPwk6")])
otu_relrespWK6xWK6 <- mdotu_relrespWK6xWK6[, c('RelRSPwk6', colnames(mdotu_relrespWK6xWK6)[grep('Otu[0123456789]', colnames(mdotu_relrespWK6xWK6))])]
#summary(otu_relrespWK6xWK6[,c("RelRSPwk6")])
#summary(otu_relrespWK6xWK6[,c("RelRSPwk6")])
otu_relrespWK6xWK6<-na.omit(otu_relrespWK6xWK6)
summary(otu_relrespWK6xWK6[,c("RelRSPwk6")])
set.seed(32016)
otu_relrespWK6xWK6_rf <- AUCRF(RelRSPwk6~., data=otu_relrespWK6xWK6, ranking='MDA', ntree=500, pdel=0.2)
##otu_relrespWK6xWK6_rf # prints list of optimal OTUs
otu_relrespWK6xWK6_probs <- predict(otu_relrespWK6xWK6_rf$RFopt, type='prob')[,2]
otu_relrespWK6xWK6_roc <- roc(otu_relrespWK6xWK6$RelRSPwk6~otu_relrespWK6xWK6_probs)


md_relrespWK6xWK6 <- trtd.wk6_data[trtd.wk6_data$visit=='Week 6', c('RelRSPwk6',"AGE", "SEX", "BAMINO", "BANTIBIO", "BCORT", "BIMM", "BL_BMI", "DDUR", "DDUR10", "DDUR15", "tissinvol", "BRSP_TNF", "BL_FLACT", "BL_FCALP", "BL_CRP", "BL_CRPLEV", "BL_FCALPLEV", "BL_FLACTLEV", "BOWSTRICT", "CDSTOOLM_Week.6", "CDPAINM_Week.6", "CDWELBEM_Week.6", "CDARTRTM_Week.6", "CDARALGM_Week.6", "CDIRITM_Week.6", "CDUVEITM_Week.6", "CDERYTHM_Week.6", "CDPYODEM_Week.6", "CDSTOMAM_Week.6", "CDFISURM_Week.6", "CDFISTUM_Week.6", "CDABSCEM_Week.6", "CDOTFISM_Week.6", "CDFEVERM_Week.6", "CDDRGM_Week.6", "CDAMASSM_Week.6", "CDHCTM_Week.6", "CDWEIGHM_Week.6")]
#summary(md_relrespWK6xWK6[,c("RelRSPwk6")])
md_relrespWK6xWK6<-na.omit(md_relrespWK6xWK6)
#summary(md_relrespWK6xWK6[,c("RelRSPwk6")])
set.seed(32016)
md_relrespWK6xWK6_rf <- AUCRF(RelRSPwk6~., data=md_relrespWK6xWK6, ranking='MDA', ntree=500, pdel=0.3)
##md_relrespWK6xWK6_rf # prints list of optimal features
md_relrespWK6xWK6_probs <- predict(md_relrespWK6xWK6_rf$RFopt, type='prob')[,2]
md_relrespWK6xWK6_roc <- roc(md_relrespWK6xWK6$RelRSPwk6~md_relrespWK6xWK6_probs)


mdotu_relrespWK6xWK6 <- trtd.wk6_data[trtd.wk6_data$visit=='Week 6', c('RelRSPwk6',"AGE", "SEX", "BAMINO", "BANTIBIO", "BCORT", "BIMM", "BL_BMI", "DDUR", "DDUR10", "DDUR15", "tissinvol", "BRSP_TNF", "BL_FLACT", "BL_FCALP", "BL_CRP", "BL_CRPLEV", "BL_FCALPLEV", "BL_FLACTLEV", "BOWSTRICT", "CDSTOOLM_Week.6", "CDPAINM_Week.6", "CDWELBEM_Week.6", "CDARTRTM_Week.6", "CDARALGM_Week.6", "CDIRITM_Week.6", "CDUVEITM_Week.6", "CDERYTHM_Week.6", "CDPYODEM_Week.6", "CDSTOMAM_Week.6", "CDFISURM_Week.6", "CDFISTUM_Week.6", "CDABSCEM_Week.6", "CDOTFISM_Week.6", "CDFEVERM_Week.6", "CDDRGM_Week.6", "CDAMASSM_Week.6", "CDHCTM_Week.6", "CDWEIGHM_Week.6", "invsimpson", colnames(trtd.wk6_data)[grep('Otu[0123456789]', colnames(trtd.wk6_data))])]
#summary(mdotu_relrespWK6xWK6[,c("RelRSPwk6")])
mdotu_relrespWK6xWK6<-na.omit(mdotu_relrespWK6xWK6)
#summary(mdotu_relrespWK6xWK6[,c("RelRSPwk6")])
set.seed(32016)
mdotu_relrespWK6xWK6_rf <- AUCRF(RelRSPwk6~., data=mdotu_relrespWK6xWK6, ranking='MDA', ntree=500, pdel=0.2)
#mdotu_relrespWK6xWK6_rf # prints list of optimal features
mdotu_relrespWK6xWK6_probs <- predict(mdotu_relrespWK6xWK6_rf$RFopt, type='prob')[,2]
mdotu_relrespWK6xWK6_roc <- roc(mdotu_relrespWK6xWK6$RelRSPwk6~mdotu_relrespWK6xWK6_probs)



#pdf('data/figures/RSPwk6aucrf.#pdf', height=6, width=8)
### Plot ROC curves
layout(matrix(c(1,2), nrow=1))
par(mar=c(3,3,2,1), mgp=c(2,0.5,0))
plot(c(1,0),c(0,1), type='l', lty=2, xlim=c(1.01,0), ylim=c(-0.01,1.01), xaxs='i', yaxs='i', ylab='Sensitivity', xlab='Specificity', las=1)
#plot(otu_relrespWK6xWK6_roc, add=T, lwd=2, col='royalblue', lty=1)
plot(md_relrespWK6xWK6_roc, add=T, lwd=2, col='grey5', lty=1)
#plot(mdotu_relrespWK6xWK6_roc, add=T, lwd=2, col='red', lty=1)
title("Predicting Week 6 Response using Week 0 Clinical Data")
legend('bottomright', sprintf('Clinical Data: AUC=%.3f',md_relrespWK6xWK6_roc$auc), lwd=2, col='grey5', bty='n', lty=1)
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
#dev.off()

#pdf('data/figures/RSPwk6abunds.#pdf', height=6, width=8)
plot(1, type='n', xlim=c(0.5,2.5), ylim=c(0,1), ylab='', xlab='', xaxt='n', cex.axis=1.2)
stripchart(at=1, md_relrespWK6xWK6_probs[md_relrespWK6xWK6$'RelRSPwk6'==0], vertical=T, method='jitter', jitter=0.4, pch=21, bg='orange', add=T, cex=1.5)
stripchart(at=2, md_relrespWK6xWK6_probs[md_relrespWK6xWK6$'RelRSPwk6'==1], vertical=T, method='jitter', jitter=0.4, pch=21, bg='royalblue', add=T, cex=1.5)
mtext(side=2, text='Probability of Response', line=2.2, cex=0.8)
axis(1, at=c(1,2), labels=c('No', 'Yes'), cex.axis=1.2)
cutoff <- coords(roc=md_relrespWK6xWK6_roc, x='best', best.method='y', ret=c('threshold')) #gives best point on curve for cutoff
#dev.off()


md_relrespWK6xWK6_rf # prints list of optimal features


#pdf('data/figures/RSPwk6aucrf.#pdf', height=6, width=8)
### Plot ROC curves
layout(matrix(c(1,2), nrow=1))
par(mar=c(3,3,2,1), mgp=c(2,0.5,0))
plot(c(1,0),c(0,1), type='l', lty=2, xlim=c(1.01,0), ylim=c(-0.01,1.01), xaxs='i', yaxs='i', ylab='Sensitivity', xlab='Specificity', las=1)
plot(otu_relrespWK6xWK6_roc, add=T, lwd=2, col='royalblue', lty=1)
plot(md_relrespWK6xWK6_roc, add=T, lwd=2, col='grey5', lty=1)
plot(mdotu_relrespWK6xWK6_roc, add=T, lwd=2, col='red', lty=1)
title("RESPONSEwk6")
legend('bottomright', c(sprintf('OTUs : AUC=%.3f',otu_relrespWK6xWK6_roc$auc),sprintf('Clinical Data: AUC=%.3f',md_relrespWK6xWK6_roc$auc),sprintf('Combined: AUC=%.3f',mdotu_relrespWK6xWK6_roc$auc)), lwd=2, col=c('royalblue','grey5', 'red'), bty='n', lty=1)
#dev.off()

#pdf('data/figures/RSPwk6abunds.#pdf', height=6, width=8)
plot(1, type='n', xlim=c(0.5,2.5), ylim=c(0,1), ylab='', xlab='', xaxt='n', cex.axis=1.2)
stripchart(at=1, mdotu_relrespWK6xWK6_probs[mdotu_relrespWK6xWK6$'RelRSPwk6'==0], vertical=T, method='jitter', jitter=0.4, pch=21, bg='orange', add=T, cex=1.5)
stripchart(at=2, mdotu_relrespWK6xWK6_probs[mdotu_relrespWK6xWK6$'RelRSPwk6'==1], vertical=T, method='jitter', jitter=0.4, pch=21, bg='royalblue', add=T, cex=1.5)
mtext(side=2, text='Probability of Response', line=2.2, cex=0.8)
axis(1, at=c(1,2), labels=c('No', 'Yes'), cex.axis=1.2)
cutoff <- coords(roc=mdotu_relrespWK6xWK6_roc, x='best', best.method='y', ret=c('threshold')) #gives best point on curve for cutoff
#dev.off()

mdotu_relrespWK6xWK6_rf # prints list of optimal features
otu_relrespWK6xWK6_rf
md_relrespWK6xWK6_rf

print("REMISSwk6 by AUC-RF")
set.seed(32016)
levels(trtd.wk6_data$REMISSwk6) <- c(0,1)
mdotu_remWK6xWK6 <- trtd.wk6_data[trtd.wk6_data$visit=='Week 6', c('REMISSwk6',"AGE", "SEX", "BAMINO", "BANTIBIO", "BCORT", "BIMM", "BL_BMI", "DDUR", "DDUR10", "DDUR15", "tissinvol", "BRSP_TNF", "BL_FLACT", "BL_FCALP", "BL_CRP", "BL_CRPLEV", "BL_FCALPLEV", "BL_FLACTLEV", "BOWSTRICT", "CDSTOOLM_Week.6", "CDPAINM_Week.6", "CDWELBEM_Week.6", "CDARTRTM_Week.6", "CDARALGM_Week.6", "CDIRITM_Week.6", "CDUVEITM_Week.6", "CDERYTHM_Week.6", "CDPYODEM_Week.6", "CDSTOMAM_Week.6", "CDFISURM_Week.6", "CDFISTUM_Week.6", "CDABSCEM_Week.6", "CDOTFISM_Week.6", "CDFEVERM_Week.6", "CDDRGM_Week.6", "CDAMASSM_Week.6", "CDHCTM_Week.6", "CDWEIGHM_Week.6", "invsimpson", colnames(trtd.wk6_data)[grep('Otu[0123456789]', colnames(trtd.wk6_data))])]
#summary(mdotu_remWK6xWK6[,c("REMISSwk6")])
mdotu_remWK6xWK6<-na.omit(mdotu_remWK6xWK6)
#summary(mdotu_remWK6xWK6[,c("REMISSwk6")])
otu_remWK6xWK6 <- mdotu_remWK6xWK6[, c('REMISSwk6', colnames(mdotu_remWK6xWK6)[grep('Otu[0123456789]', colnames(mdotu_remWK6xWK6))])]
#summary(otu_remWK6xWK6[,c("REMISSwk6")])
#summary(otu_remWK6xWK6[,c("REMISSwk6")])
otu_remWK6xWK6<-na.omit(otu_remWK6xWK6)

#summary(otu_remWK6xWK6[,c("REMISSwk6")])
set.seed(32016)
otu_remWK6xWK6_rf <- AUCRF(REMISSwk6~., data=otu_remWK6xWK6, ranking='MDA', ntree=500, pdel=0.2)
#otu_remWK6xWK6_rf # prints list of optimal OTUs
otu_remWK6xWK6_probs <- predict(otu_remWK6xWK6_rf$RFopt, type='prob')[,2]
otu_remWK6xWK6_roc <- roc(otu_remWK6xWK6$REMISSwk6~otu_remWK6xWK6_probs)


md_remWK6xWK6 <- trtd.wk6_data[trtd.wk6_data$visit=='Week 6', c('REMISSwk6',"AGE", "SEX", "BAMINO", "BANTIBIO", "BCORT", "BIMM", "BL_BMI", "DDUR", "DDUR10", "DDUR15", "tissinvol", "BRSP_TNF", "BL_FLACT", "BL_FCALP", "BL_CRP", "BL_CRPLEV", "BL_FCALPLEV", "BL_FLACTLEV", "BOWSTRICT", "CDSTOOLM_Week.6", "CDPAINM_Week.6", "CDWELBEM_Week.6", "CDARTRTM_Week.6", "CDARALGM_Week.6", "CDIRITM_Week.6", "CDUVEITM_Week.6", "CDERYTHM_Week.6", "CDPYODEM_Week.6", "CDSTOMAM_Week.6", "CDFISURM_Week.6", "CDFISTUM_Week.6", "CDABSCEM_Week.6", "CDOTFISM_Week.6", "CDFEVERM_Week.6", "CDDRGM_Week.6", "CDAMASSM_Week.6", "CDHCTM_Week.6", "CDWEIGHM_Week.6")]
#summary(md_remWK6xWK6[,c("REMISSwk6")])
md_remWK6xWK6<-na.omit(md_remWK6xWK6)
#summary(md_remWK6xWK6[,c("REMISSwk6")])
set.seed(32016)
md_remWK6xWK6_rf <- AUCRF(REMISSwk6~., data=md_remWK6xWK6, ranking='MDA', ntree=500, pdel=0.3)
#md_remWK6xWK6_rf # prints list of optimal features
md_remWK6xWK6_probs <- predict(md_remWK6xWK6_rf$RFopt, type='prob')[,2]
md_remWK6xWK6_roc <- roc(md_remWK6xWK6$REMISSwk6~md_remWK6xWK6_probs)


mdotu_remWK6xWK6 <- trtd.wk6_data[trtd.wk6_data$visit=='Week 6', c('REMISSwk6', "AGE", "SEX", "BAMINO", "BANTIBIO", "BCORT", "BIMM", "BL_BMI", "DDUR", "DDUR10", "DDUR15", "tissinvol", "BRSP_TNF", "BL_FLACT", "BL_FCALP", "BL_CRP", "BL_CRPLEV", "BL_FCALPLEV", "BL_FLACTLEV", "BOWSTRICT", "CDSTOOLM_Week.6", "CDPAINM_Week.6", "CDWELBEM_Week.6", "CDARTRTM_Week.6", "CDARALGM_Week.6", "CDIRITM_Week.6", "CDUVEITM_Week.6", "CDERYTHM_Week.6", "CDPYODEM_Week.6", "CDSTOMAM_Week.6", "CDFISURM_Week.6", "CDFISTUM_Week.6", "CDABSCEM_Week.6", "CDOTFISM_Week.6", "CDFEVERM_Week.6", "CDDRGM_Week.6", "CDAMASSM_Week.6", "CDHCTM_Week.6", "CDWEIGHM_Week.6", 'invsimpson', colnames(trtd.wk6_data)[grep('Otu[0123456789]', colnames(trtd.wk6_data))])]
#summary(mdotu_remWK6xWK6[,c("REMISSwk6")])
mdotu_remWK6xWK6<-na.omit(mdotu_remWK6xWK6)
#summary(mdotu_remWK6xWK6[,c("REMISSwk6")])
set.seed(32016)
mdotu_remWK6xWK6_rf <- AUCRF(REMISSwk6~., data=mdotu_remWK6xWK6, ranking='MDA', ntree=500, pdel=0.2)
#mdotu_remWK6xWK6_rf # prints list of optimal features
mdotu_remWK6xWK6_probs <- predict(mdotu_remWK6xWK6_rf$RFopt, type='prob')[,2]
mdotu_remWK6xWK6_roc <- roc(mdotu_remWK6xWK6$REMISSwk6~mdotu_remWK6xWK6_probs)


#pdf('data/figures/RSPwk6aucrf.#pdf', height=6, width=8)
### Plot ROC curves
layout(matrix(c(1,2), nrow=1))
par(mar=c(3,3,2,1), mgp=c(2,0.5,0))
plot(c(1,0),c(0,1), type='l', lty=2, xlim=c(1.01,0), ylim=c(-0.01,1.01), xaxs='i', yaxs='i', ylab='Sensitivity', xlab='Specificity', las=1)
#plot(otu_remWK6xWK6_roc, add=T, lwd=2, col='royalblue', lty=1)
plot(md_remWK6xWK6_roc, add=T, lwd=2, col='grey5', lty=1)
#plot(mdotu_remWK6xWK6_roc, add=T, lwd=2, col='red', lty=1)
title("Predicting Week 6 Remission using Week 6 Clinical Data")
legend('bottomright', sprintf('Clinical Data: AUC=%.3f',md_remWK6xWK6_roc$auc), lwd=2, col='grey5', bty='n', lty=1)

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
plot(1, type='n', xlim=c(0.5,2.5), ylim=c(0,1), ylab='', xlab='', xaxt='n', cex.axis=1.2)
stripchart(at=1, md_remWK6xWK6_probs[md_remWK6xWK6$'REMISSwk6'==0], vertical=T, method='jitter', jitter=0.4, pch=21, bg='orange', add=T, cex=1.5)
stripchart(at=2, md_remWK6xWK6_probs[md_remWK6xWK6$'REMISSwk6'==1], vertical=T, method='jitter', jitter=0.4, pch=21, bg='royalblue', add=T, cex=1.5)
mtext(side=2, text='Probability of Response', line=2.2, cex=0.8)
axis(1, at=c(1,2), labels=c('No', 'Yes'), cex.axis=1.2)
cutoff <- coords(roc=md_remWK6xWK6_roc, x='best', best.method='y', ret=c('threshold')) #gives best point on curve for cutoff
#dev.off()

md_remWK6xWK6_rf # prints list of optimal features


#pdf('data/figures/RSPwk6aucrf.#pdf', height=6, width=8)
### Plot ROC curves
layout(matrix(c(1,2), nrow=1))
par(mar=c(3,3,2,1), mgp=c(2,0.5,0))
plot(c(1,0),c(0,1), type='l', lty=2, xlim=c(1.01,0), ylim=c(-0.01,1.01), xaxs='i', yaxs='i', ylab='Sensitivity', xlab='Specificity', las=1)
plot(otu_remWK6xWK6_roc, add=T, lwd=2, col='royalblue', lty=1)
plot(md_remWK6xWK6_roc, add=T, lwd=2, col='grey5', lty=1)
plot(mdotu_remWK6xWK6_roc, add=T, lwd=2, col='red', lty=1)
title("Predicting Week 6 Remission using Week 6 Clinical Data")
legend('bottomright', c(sprintf('OTUs : AUC=%.3f',otu_remWK6xWK6_roc$auc),sprintf('Clinical Data: AUC=%.3f',md_remWK6xWK6_roc$auc),sprintf('Combined: AUC=%.3f',mdotu_remWK6xWK6_roc$auc)), lwd=2, col=c('royalblue','grey5', 'red'), bty='n', lty=1)
#dev.off()

#pdf('data/figures/RSPwk6abunds.#pdf', height=6, width=8)
plot(1, type='n', xlim=c(0.5,2.5), ylim=c(0,1), ylab='', xlab='', xaxt='n', cex.axis=1.2)
stripchart(at=1, mdotu_remWK6xWK6_probs[mdotu_remWK6xWK6$'REMISSwk6'==0], vertical=T, method='jitter', jitter=0.4, pch=21, bg='orange', add=T, cex=1.5)
stripchart(at=2, mdotu_remWK6xWK6_probs[mdotu_remWK6xWK6$'REMISSwk6'==1], vertical=T, method='jitter', jitter=0.4, pch=21, bg='royalblue', add=T, cex=1.5)
mtext(side=2, text='Probability of Response', line=2.2, cex=0.8)
axis(1, at=c(1,2), labels=c('No', 'Yes'), cex.axis=1.2)
cutoff <- coords(roc=mdotu_remWK6xWK6_roc, x='best', best.method='y', ret=c('threshold')) #gives best point on curve for cutoff
#dev.off()

mdotu_remWK6xWK6_rf # prints list of optimal features
otu_remWK6xWK6_rf
md_remWK6xWK6_rf

WK6xWK6rocsP <- roc.test(otu_relrespWK6xWK6_roc, otu_remWK6xWK6_roc)
WK6xWK6rocsPval <- signif(WK6xWK6rocsP$p.value, digits=2)