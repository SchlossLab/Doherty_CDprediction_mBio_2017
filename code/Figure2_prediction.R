setwd("submission")
source('../code/R_packages_setup.R')
source('../code/APmd.setup.R')

#**Figure 1: Prediction of RESPONSE/REMISSION in treated subjects using all clinical metadata, baseline microbiome alone, and combined**
#	*Question:* Can the microbiome, clinical metadata, or combined models reliably predict response?
#*Goal:* Show clinical metadata isn’t great for prediction and improvement of prediction using microbiome. Show taxa marked as important for prediction are abundant enough to care about
#A. Response ROCs
#B. Response Model Performance vs. reality
#C. Top predictive taxa and abundance based on response	
#D. REMISSION ROCs
#E. REMISSION Model Performance vs. reality
#F. Top predictive taxa and abundance based on remission
source('../code/readdataAUCRF.R')

print("RESPONSEwk6 by AUC-RF \\nRelative response defined as a decrease in CDAI from Screening greater than 29.5%.")
set.seed(32016)
levels(nao.screen.trtd$RESPONSEwk6) <- c(0,1)
mdotu_RESPONSEWK6 <- nao.screen.trtd[nao.screen.trtd$visit=='Screening', c('RESPONSEwk6',"AGE", "SEX", "BAMINO", "BANTIBIO", "BCORT", "BIMM", "BL_BMI", "DDUR", "DDUR10", "DDUR15", "tissinvol", "BRSP_TNF", "BL_FLACT", "BL_FCALP", "BL_CRP", "BL_CRPLEV", "BL_FCALPLEV", "BL_FLACTLEV", "BOWSTRICT", "CDSTOOLM_Screening", "CDPAINM_Screening", "CDWELBEM_Screening", "CDARTRTM_Screening", "CDARALGM_Screening", "CDIRITM_Screening", "CDUVEITM_Screening", "CDERYTHM_Screening", "CDPYODEM_Screening", "CDSTOMAM_Screening", "CDFISURM_Screening", "CDFISTUM_Screening", "CDABSCEM_Screening", "CDOTFISM_Screening", "CDFEVERM_Screening", "CDDRGM_Screening", "CDAMASSM_Screening", "CDHCTM_Screening", "CDWEIGHM_Screening", "invsimpson", colnames(nao.screen.trtd)[grep('Otu[0123456789]', colnames(nao.screen.trtd))])]
#summary(mdotu_RESPONSEWK6[,c("RESPONSEwk6")])
mdotu_RESPONSEWK6<-na.omit(mdotu_RESPONSEWK6)
#summary(mdotu_RESPONSEWK6[,c("RESPONSEwk6")])
otu_RESPONSEWK6 <- mdotu_RESPONSEWK6[, c('RESPONSEwk6', colnames(mdotu_RESPONSEWK6)[grep('Otu[0123456789]', colnames(mdotu_RESPONSEWK6))])]
#summary(otu_RESPONSEWK6[,c("RESPONSEwk6")])
#summary(otu_RESPONSEWK6[,c("RESPONSEwk6")])
otu_RESPONSEWK6<-na.omit(otu_RESPONSEWK6)
#summary(otu_RESPONSEWK6[,c("RESPONSEwk6")])
set.seed(32016)
otu_RESPONSEWK6_rf <- AUCRF(RESPONSEwk6~., data=otu_RESPONSEWK6, ranking='MDA', ntree=500, pdel=0.2)
##otu_RESPONSEWK6_rf # prints list of optimal OTUs
otu_RESPONSEWK6_probs <- predict(otu_RESPONSEWK6_rf$RFopt, type='prob')[,2]
otu_RESPONSEWK6_roc <- roc(otu_RESPONSEWK6$RESPONSEwk6~otu_RESPONSEWK6_probs)


md_RESPONSEWK6 <- nao.screen.trtd[nao.screen.trtd$visit=='Screening', c('RESPONSEwk6',"AGE", "SEX", "BAMINO", "BANTIBIO", "BCORT", "BIMM", "BL_BMI", "DDUR", "DDUR10", "DDUR15", "tissinvol", "BRSP_TNF", "BL_FLACT", "BL_FCALP", "BL_CRP", "BL_CRPLEV", "BL_FCALPLEV", "BL_FLACTLEV", "BOWSTRICT", "CDSTOOLM_Screening", "CDPAINM_Screening", "CDWELBEM_Screening", "CDARTRTM_Screening", "CDARALGM_Screening", "CDIRITM_Screening", "CDUVEITM_Screening", "CDERYTHM_Screening", "CDPYODEM_Screening", "CDSTOMAM_Screening", "CDFISURM_Screening", "CDFISTUM_Screening", "CDABSCEM_Screening", "CDOTFISM_Screening", "CDFEVERM_Screening", "CDDRGM_Screening", "CDAMASSM_Screening", "CDHCTM_Screening", "CDWEIGHM_Screening")]
#summary(md_RESPONSEWK6[,c("RESPONSEwk6")])
md_RESPONSEWK6<-na.omit(md_RESPONSEWK6)
#summary(md_RESPONSEWK6[,c("RESPONSEwk6")])
set.seed(32016)
md_RESPONSEWK6_rf <- AUCRF(RESPONSEwk6~., data=md_RESPONSEWK6, ranking='MDA', ntree=500, pdel=0.3)
##md_RESPONSEWK6_rf # prints list of optimal features
md_RESPONSEWK6_probs <- predict(md_RESPONSEWK6_rf$RFopt, type='prob')[,2]
md_RESPONSEWK6_roc <- roc(md_RESPONSEWK6$RESPONSEwk6~md_RESPONSEWK6_probs)


mdotu_RESPONSEWK6 <- nao.screen.trtd[nao.screen.trtd$visit=='Screening', c('RESPONSEwk6',"AGE", "SEX", "BAMINO", "BANTIBIO", "BCORT", "BIMM", "BL_BMI", "DDUR", "DDUR10", "DDUR15", "tissinvol", "BRSP_TNF", "BL_FLACT", "BL_FCALP", "BL_CRP", "BL_CRPLEV", "BL_FCALPLEV", "BL_FLACTLEV", "BOWSTRICT", "CDSTOOLM_Screening", "CDPAINM_Screening", "CDWELBEM_Screening", "CDARTRTM_Screening", "CDARALGM_Screening", "CDIRITM_Screening", "CDUVEITM_Screening", "CDERYTHM_Screening", "CDPYODEM_Screening", "CDSTOMAM_Screening", "CDFISURM_Screening", "CDFISTUM_Screening", "CDABSCEM_Screening", "CDOTFISM_Screening", "CDFEVERM_Screening", "CDDRGM_Screening", "CDAMASSM_Screening", "CDHCTM_Screening", "CDWEIGHM_Screening", "invsimpson", colnames(nao.screen.trtd)[grep('Otu[0123456789]', colnames(nao.screen.trtd))])]
#summary(mdotu_RESPONSEWK6[,c("RESPONSEwk6")])
mdotu_RESPONSEWK6<-na.omit(mdotu_RESPONSEWK6)
#summary(mdotu_RESPONSEWK6[,c("RESPONSEwk6")])
set.seed(32016)
mdotu_RESPONSEWK6_rf <- AUCRF(RESPONSEwk6~., data=mdotu_RESPONSEWK6, ranking='MDA', ntree=500, pdel=0.2)
#mdotu_RESPONSEWK6_rf # prints list of optimal features
mdotu_RESPONSEWK6_probs <- predict(mdotu_RESPONSEWK6_rf$RFopt, type='prob')[,2]
mdotu_RESPONSEWK6_roc <- roc(mdotu_RESPONSEWK6$RESPONSEwk6~mdotu_RESPONSEWK6_probs)
mdotu_RESPONSEWK6_rf
otu_RESPONSEWK6_rf
md_RESPONSEWK6_rf

mdotuvmdWK6RESPONSErocsP <- roc.test(mdotu_RESPONSEWK6_roc, md_RESPONSEWK6_roc)
otuvmdWK6RESPONSErocsP <- roc.test(otu_RESPONSEWK6_roc, md_RESPONSEWK6_roc)
mdotuvmdWK6RESPONSErocsPval <- signif(mdotuvmdWK6RESPONSErocsP$p.value, digits=2)
otuvmdWK6RESPONSErocsPval <- signif(otuvmdWK6RESPONSErocsP$p.value, digits=2)

print("REMISSwk6 by AUC-RF")
set.seed(32016)
levels(nao.screen.trtd$REMISSwk6) <- c(0,1)
mdotu_remWK6 <- nao.screen.trtd[nao.screen.trtd$visit=='Screening', c('REMISSwk6',"AGE", "SEX", "BAMINO", "BANTIBIO", "BCORT", "BIMM", "BL_BMI", "DDUR", "DDUR10", "DDUR15", "tissinvol", "BRSP_TNF", "BL_FLACT", "BL_FCALP", "BL_CRP", "BL_CRPLEV", "BL_FCALPLEV", "BL_FLACTLEV", "BOWSTRICT", "CDSTOOLM_Screening", "CDPAINM_Screening", "CDWELBEM_Screening", "CDARTRTM_Screening", "CDARALGM_Screening", "CDIRITM_Screening", "CDUVEITM_Screening", "CDERYTHM_Screening", "CDPYODEM_Screening", "CDSTOMAM_Screening", "CDFISURM_Screening", "CDFISTUM_Screening", "CDABSCEM_Screening", "CDOTFISM_Screening", "CDFEVERM_Screening", "CDDRGM_Screening", "CDAMASSM_Screening", "CDHCTM_Screening", "CDWEIGHM_Screening", "invsimpson", colnames(nao.screen.trtd)[grep('Otu[0123456789]', colnames(nao.screen.trtd))])]

mdotu_remWK6<-na.omit(mdotu_remWK6)

otu_remWK6 <- mdotu_remWK6[, c('REMISSwk6', colnames(mdotu_remWK6)[grep('Otu[0123456789]', colnames(mdotu_remWK6))])]

otu_remWK6<-na.omit(otu_remWK6)

set.seed(32016)
otu_remWK6_rf <- AUCRF(REMISSwk6~., data=otu_remWK6, ranking='MDA', ntree=500, pdel=0.2)
#otu_remWK6_rf # prints list of optimal OTUs
otu_remWK6_probs <- predict(otu_remWK6_rf$RFopt, type='prob')[,2]
otu_remWK6_roc <- roc(otu_remWK6$REMISSwk6~otu_remWK6_probs)


md_remWK6 <- nao.screen.trtd[nao.screen.trtd$visit=='Screening', c('REMISSwk6',"AGE", "SEX", "BAMINO", "BANTIBIO", "BCORT", "BIMM", "BL_BMI", "DDUR", "DDUR10", "DDUR15", "tissinvol", "BRSP_TNF", "BL_FLACT", "BL_FCALP", "BL_CRP", "BL_CRPLEV", "BL_FCALPLEV", "BL_FLACTLEV", "BOWSTRICT", "CDSTOOLM_Screening", "CDPAINM_Screening", "CDWELBEM_Screening", "CDARTRTM_Screening", "CDARALGM_Screening", "CDIRITM_Screening", "CDUVEITM_Screening", "CDERYTHM_Screening", "CDPYODEM_Screening", "CDSTOMAM_Screening", "CDFISURM_Screening", "CDFISTUM_Screening", "CDABSCEM_Screening", "CDOTFISM_Screening", "CDFEVERM_Screening", "CDDRGM_Screening", "CDAMASSM_Screening", "CDHCTM_Screening", "CDWEIGHM_Screening")]
#summary(md_remWK6[,c("REMISSwk6")])
md_remWK6<-na.omit(md_remWK6)
#summary(md_remWK6[,c("REMISSwk6")])
set.seed(32016)
md_remWK6_rf <- AUCRF(REMISSwk6~., data=md_remWK6, ranking='MDA', ntree=500, pdel=0.3)
#md_remWK6_rf # prints list of optimal features
md_remWK6_probs <- predict(md_remWK6_rf$RFopt, type='prob')[,2]
md_remWK6_roc <- roc(md_remWK6$REMISSwk6~md_remWK6_probs)


mdotu_remWK6 <- nao.screen.trtd[nao.screen.trtd$visit=='Screening', c('REMISSwk6', "AGE", "SEX", "BAMINO", "BANTIBIO", "BCORT", "BIMM", "BL_BMI", "DDUR", "DDUR10", "DDUR15", "tissinvol", "BRSP_TNF", "BL_FLACT", "BL_FCALP", "BL_CRP", "BL_CRPLEV", "BL_FCALPLEV", "BL_FLACTLEV", "BOWSTRICT", "CDSTOOLM_Screening", "CDPAINM_Screening", "CDWELBEM_Screening", "CDARTRTM_Screening", "CDARALGM_Screening", "CDIRITM_Screening", "CDUVEITM_Screening", "CDERYTHM_Screening", "CDPYODEM_Screening", "CDSTOMAM_Screening", "CDFISURM_Screening", "CDFISTUM_Screening", "CDABSCEM_Screening", "CDOTFISM_Screening", "CDFEVERM_Screening", "CDDRGM_Screening", "CDAMASSM_Screening", "CDHCTM_Screening", "CDWEIGHM_Screening", 'invsimpson', colnames(nao.screen.trtd)[grep('Otu[0123456789]', colnames(nao.screen.trtd))])]
#summary(mdotu_remWK6[,c("REMISSwk6")])
mdotu_remWK6<-na.omit(mdotu_remWK6)
#summary(mdotu_remWK6[,c("REMISSwk6")])
set.seed(32016)
mdotu_remWK6_rf <- AUCRF(REMISSwk6~., data=mdotu_remWK6, ranking='MDA', ntree=500, pdel=0.2)
#mdotu_remWK6_rf # prints list of optimal features
mdotu_remWK6_probs <- predict(mdotu_remWK6_rf$RFopt, type='prob')[,2]
mdotu_remWK6_roc <- roc(mdotu_remWK6$REMISSwk6~mdotu_remWK6_probs)




otu_RESPONSEWK6xremWK6rocsP <- roc.test(otu_RESPONSEWK6_roc, otu_remWK6_roc)
otu_RESPONSEWK6xremWK6rocsPval <- signif(otu_RESPONSEWK6xremWK6rocsP$p.value, digits=2)

mdotu_RESPONSEWK6xremWK6rocsP <- roc.test(mdotu_RESPONSEWK6_roc, mdotu_remWK6_roc)
mdotu_RESPONSEWK6xremWK6rocsPval <- signif(mdotu_RESPONSEWK6xremWK6rocsP$p.value, digits=2)

mdotuvmdWK6remrocsP <- roc.test(mdotu_remWK6_roc, md_remWK6_roc)
otuvmdWK6remrocsP <- roc.test(otu_remWK6_roc, md_remWK6_roc)
mdotuvmdWK6remrocsPval <- signif(mdotuvmdWK6remrocsP$p.value, digits=2)
otuvmdWK6remrocsPval <- signif(otuvmdWK6remrocsP$p.value, digits=2)
mdotuvotuWK6remrocsP <- roc.test(mdotu_remWK6_roc, otu_remWK6_roc)
mdotuvotuWK6remrocsPval <- signif(mdotuvotuWK6remrocsP$p.value, digits=2)

###################################################

pdf("figures/Figure2_wk0Xwk6pred.pdf", height = 10, width = 12)
layout(matrix(c(3,4,1,2), 2, 2, byrow = TRUE))

par(mar=c(3,3,2,1), mgp=c(2,0.5,0))
plot(c(1,0),c(0,1), type='l', lty=2, xlim=c(1.01,0), ylim=c(-0.01,1.01), xaxs='i', yaxs='i', ylab='Sensitivity', xlab='Specificity', las=1)
plot(otu_RESPONSEWK6_roc, add=T, lwd=2, col='royalblue', lty=1)
plot(md_RESPONSEWK6_roc, add=T, lwd=2, col='grey5', lty=1)
plot(mdotu_RESPONSEWK6_roc, add=T, lwd=2, col='red', lty=1)

legend('bottomright', c(sprintf('Week 0 OTUs : AUC=%.3f',otu_RESPONSEWK6_roc$auc), sprintf('Week 0 Clinical Data: AUC=%.3f',md_RESPONSEWK6_roc$auc), sprintf('Combined: AUC=%.3f',mdotu_RESPONSEWK6_roc$auc)), lwd=2, col=c('royalblue', 'grey5', 'red'), bty='n', lty=1)
mtext('C', at=1.07, side=3, line=0.1, font=2, cex=2)

cutoff <- coords(roc=mdotu_RESPONSEWK6_roc, x='best', best.method='y', ret=c('threshold'))
mdotu_RESPONSEWK6_spec <- coords(mdotu_RESPONSEWK6_roc, x=cutoff, input='thr', ret='spec')
mdotu_RESPONSEWK6_sens <- coords(mdotu_RESPONSEWK6_roc, x=mdotu_RESPONSEWK6_spec, input='spec', ret='sens')
mdotu_RESPONSEWK6_thr <- coords(mdotu_RESPONSEWK6_roc, x=mdotu_RESPONSEWK6_spec, input='spec', ret='thr')

points(coords(mdotu_RESPONSEWK6_roc, x=cutoff, input='threshold', ret='specificity'),coords(mdotu_RESPONSEWK6_roc, x=cutoff, input='threshold', ret='sensitivity'), col='red', cex=1.5, pch=10)

cutoff <- coords(roc=otu_RESPONSEWK6_roc, x='best', best.method='y', ret=c('threshold'))
otu_RESPONSEWK6_spec <- coords(otu_RESPONSEWK6_roc, x=cutoff, input='thr', ret='spec')
otu_RESPONSEWK6_sens <- coords(otu_RESPONSEWK6_roc, x=otu_RESPONSEWK6_spec, input='spec', ret='sens')
otu_RESPONSEWK6_thr <- coords(otu_RESPONSEWK6_roc, x=otu_RESPONSEWK6_spec, input='spec', ret='thr')
points(coords(otu_RESPONSEWK6_roc, x=cutoff, input='threshold', ret='specificity'),coords(otu_RESPONSEWK6_roc, x=cutoff, input='threshold', ret='sensitivity'), col='royalblue', cex=1.5, pch=10)

cutoff <- coords(roc=md_RESPONSEWK6_roc, x='best', best.method='y', ret=c('threshold'))
md_RESPONSEWK6_spec <- coords(md_RESPONSEWK6_roc, x=cutoff, input='thr', ret='spec')
md_RESPONSEWK6_sens <- coords(md_RESPONSEWK6_roc, x=md_RESPONSEWK6_spec, input='spec', ret='sens')
md_RESPONSEWK6_thr <- coords(md_RESPONSEWK6_roc, x=md_RESPONSEWK6_spec, input='spec', ret='thr')

points(coords(md_RESPONSEWK6_roc, x=cutoff, input='threshold', ret='specificity'),coords(md_RESPONSEWK6_roc, x=cutoff, input='threshold', ret='sensitivity'), col='black', cex=1.5, pch=10)

tax<-read.table("../data/Jan400.simple.taxonomy.txt", header=T, sep='\t')


#Abundance stripchart or most predictive otus
oturf_otus  <- as.character(ordered(otu_RESPONSEWK6_rf$Xopt))
oturf_otus <- oturf_otus[1:10]
no_abunds <- otu_RESPONSEWK6[otu_RESPONSEWK6$RESPONSEwk6=='0', oturf_otus]/10000 + 1e-5
no_abunds <-na.omit(no_abunds)
yes_abunds <- otu_RESPONSEWK6[otu_RESPONSEWK6$RESPONSEwk6=='1', oturf_otus]/10000 + 1e-5
yes_abunds<- na.omit(yes_abunds)


par(mar=c(3, 12.2, 2, 1))
plot(1, type="n", ylim=c(0,length(oturf_otus )*2), xlim=c(1e-5,1.5), log="x", ylab="", xlab="Week 0 Relative Abundance (%)", xaxt="n", yaxt="n")
set.seed(32016)
index <- 1
for(i in oturf_otus ){
	stripchart(at=index-0.35, jitter(yes_abunds[,i], amount=1e-6), pch=21, bg=alpha("royalblue1", alpha=0.5), method="jitter", jitter=0.2, add=T, cex=1, lwd=0.5)
	stripchart(at=index+0.35, jitter(no_abunds[,i], amount=1e-6), pch=21, bg=alpha("orange", alpha=0.5), method="jitter", jitter=0.2, add=T, cex=1, lwd=0.5)
	segments(median(yes_abunds[,i]),index-0.7,median(yes_abunds[,i]),index-0.1, lwd=6, col = "black", lty = "solid")
	segments(median(no_abunds[,i]),index+0.7,median(no_abunds[,i]),index+0.1, lwd=6, col = "black", lty = "solid")
	index <- index + 2
}

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
legend(x=0.6e-2, y=10,, legend=c("Week 6 Nonresponder", "Week 6 Responder"), pch=c(21, 21), pt.bg=c("orange","royalblue1"), cex=1)
mtext('D', at=1e-8, side=3, line=0.1, font=2, cex=2)


#Remission
par(mar=c(3,3,2,1), mgp=c(2,0.5,0))
plot(c(1,0),c(0,1), type='l', lty=2, xlim=c(1.01,0), ylim=c(-0.01,1.01), xaxs='i', yaxs='i', ylab='Sensitivity', xlab='Specificity', las=1)
plot(otu_remWK6_roc, add=T, lwd=2, col='royalblue', lty=1)
plot(md_remWK6_roc, add=T, lwd=2, col='grey5', lty=1)
plot(mdotu_remWK6_roc, add=T, lwd=2, col='red', lty=1)
#title("Predicting Week 6 Remission")
legend('bottomright', c(sprintf('Week 0 OTUs : AUC=%.3f', otu_remWK6_roc$auc), sprintf('Week 0 Clinical Data: AUC=%.3f',md_remWK6_roc$auc),sprintf('Combined: AUC=%.3f',mdotu_remWK6_roc$auc)), lwd=2, col=c('royalblue', "grey5", 'red'), bty='n', lty=1)
mtext('A', at=1.07, side=3, line=0.1, font=2, cex=2)

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

#Abundance stripchart or most predictive otus
tax<-read.table("../data/Jan400.simple.taxonomy.txt", header=T, sep='\t')

oturf_otus  <- as.character(otu_remWK6_rf$Xopt)
oturf_otus <- oturf_otus[1:10]
no_abunds <- otu_remWK6[otu_remWK6$REMISSwk6=='0', oturf_otus]/10000 + 1e-5
no_abunds <-na.omit(no_abunds)
yes_abunds <- otu_remWK6[otu_remWK6$REMISSwk6=='1', oturf_otus]/10000 + 1e-5
yes_abunds<- na.omit(yes_abunds)

par(mar=c(3, 12.2, 2, 1))
plot(1, type="n", ylim=c(0,length(oturf_otus )*2), xlim=c(1e-5,1.5), log="x", ylab="", xlab="Week 0 Relative Abundance (%)", xaxt="n", yaxt="n", cex=1)
set.seed(32016)
index <- 1
for(i in oturf_otus ){
	stripchart(at=index-0.35, jitter(yes_abunds[,i], amount=1e-6), pch=21, bg=alpha("royalblue1", alpha=0.5), method="jitter", jitter=0.2, add=T, cex=1, lwd=0.5)
	stripchart(at=index+0.35, jitter(no_abunds[,i], amount=1e-6), pch=21, bg=alpha("orange", alpha=0.5), method="jitter", jitter=0.2, add=T, cex=1, lwd=0.5)
	segments(median(yes_abunds[,i]),index-0.7,median(yes_abunds[,i]),index-0.1, lwd=6, col = "black", lty = "solid")
	segments(median(no_abunds[,i]),index+0.7,median(no_abunds[,i]),index+0.1, lwd=6, col = "black", lty = "solid")
	index <- index + 2
}
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
legend(x=1e-2, y=10, legend=c("Week 6 Active CD", "Week 6 Remission"), pch=c(21, 21), pt.bg=c("orange","royalblue1"), cex=1)
mtext('B', at=1e-8, side=3, line=0.1, font=2, cex=2)

dev.off()

tiff("figures/Figure2_wk0Xwk6pred.tiff", height = 10, width = 12, units = "in", res = 300)
layout(matrix(c(3,4,1,2), 2, 2, byrow = TRUE))

par(mar=c(3,3,2,1), mgp=c(2,0.5,0))
plot(c(1,0),c(0,1), type='l', lty=2, xlim=c(1.01,0), ylim=c(-0.01,1.01), xaxs='i', yaxs='i', ylab='Sensitivity', xlab='Specificity', las=1)
plot(otu_RESPONSEWK6_roc, add=T, lwd=2, col='royalblue', lty=1)
plot(md_RESPONSEWK6_roc, add=T, lwd=2, col='grey5', lty=1)
plot(mdotu_RESPONSEWK6_roc, add=T, lwd=2, col='red', lty=1)

legend('bottomright', c(sprintf('Week 0 OTUs : AUC=%.3f',otu_RESPONSEWK6_roc$auc), sprintf('Week 0 Clinical Data: AUC=%.3f',md_RESPONSEWK6_roc$auc), sprintf('Combined: AUC=%.3f',mdotu_RESPONSEWK6_roc$auc)), lwd=2, col=c('royalblue', 'grey5', 'red'), bty='n', lty=1)
mtext('C', at=1.07, side=3, line=0.1, font=2, cex=2)

cutoff <- coords(roc=mdotu_RESPONSEWK6_roc, x='best', best.method='y', ret=c('threshold'))
mdotu_RESPONSEWK6_spec <- coords(mdotu_RESPONSEWK6_roc, x=cutoff, input='thr', ret='spec')
mdotu_RESPONSEWK6_sens <- coords(mdotu_RESPONSEWK6_roc, x=mdotu_RESPONSEWK6_spec, input='spec', ret='sens')
mdotu_RESPONSEWK6_thr <- coords(mdotu_RESPONSEWK6_roc, x=mdotu_RESPONSEWK6_spec, input='spec', ret='thr')

points(coords(mdotu_RESPONSEWK6_roc, x=cutoff, input='threshold', ret='specificity'),coords(mdotu_RESPONSEWK6_roc, x=cutoff, input='threshold', ret='sensitivity'), col='red', cex=1.5, pch=10)

cutoff <- coords(roc=otu_RESPONSEWK6_roc, x='best', best.method='y', ret=c('threshold'))
otu_RESPONSEWK6_spec <- coords(otu_RESPONSEWK6_roc, x=cutoff, input='thr', ret='spec')
otu_RESPONSEWK6_sens <- coords(otu_RESPONSEWK6_roc, x=otu_RESPONSEWK6_spec, input='spec', ret='sens')
otu_RESPONSEWK6_thr <- coords(otu_RESPONSEWK6_roc, x=otu_RESPONSEWK6_spec, input='spec', ret='thr')
points(coords(otu_RESPONSEWK6_roc, x=cutoff, input='threshold', ret='specificity'),coords(otu_RESPONSEWK6_roc, x=cutoff, input='threshold', ret='sensitivity'), col='royalblue', cex=1.5, pch=10)

cutoff <- coords(roc=md_RESPONSEWK6_roc, x='best', best.method='y', ret=c('threshold'))
md_RESPONSEWK6_spec <- coords(md_RESPONSEWK6_roc, x=cutoff, input='thr', ret='spec')
md_RESPONSEWK6_sens <- coords(md_RESPONSEWK6_roc, x=md_RESPONSEWK6_spec, input='spec', ret='sens')
md_RESPONSEWK6_thr <- coords(md_RESPONSEWK6_roc, x=md_RESPONSEWK6_spec, input='spec', ret='thr')

points(coords(md_RESPONSEWK6_roc, x=cutoff, input='threshold', ret='specificity'),coords(md_RESPONSEWK6_roc, x=cutoff, input='threshold', ret='sensitivity'), col='black', cex=1.5, pch=10)

tax<-read.table("../data/Jan400.simple.taxonomy.txt", header=T, sep='\t')


#Abundance stripchart or most predictive otus
oturf_otus  <- as.character(ordered(otu_RESPONSEWK6_rf$Xopt))
oturf_otus <- oturf_otus[1:10]
no_abunds <- otu_RESPONSEWK6[otu_RESPONSEWK6$RESPONSEwk6=='0', oturf_otus]/10000 + 1e-5
no_abunds <-na.omit(no_abunds)
yes_abunds <- otu_RESPONSEWK6[otu_RESPONSEWK6$RESPONSEwk6=='1', oturf_otus]/10000 + 1e-5
yes_abunds<- na.omit(yes_abunds)


par(mar=c(3, 12.2, 2, 1))
plot(1, type="n", ylim=c(0,length(oturf_otus )*2), xlim=c(1e-5,1.5), log="x", ylab="", xlab="Week 0 Relative Abundance (%)", xaxt="n", yaxt="n")
set.seed(32016)
index <- 1
for(i in oturf_otus ){
	stripchart(at=index-0.35, jitter(yes_abunds[,i], amount=1e-6), pch=21, bg=alpha("royalblue1", alpha=0.5), method="jitter", jitter=0.2, add=T, cex=1, lwd=0.5)
	stripchart(at=index+0.35, jitter(no_abunds[,i], amount=1e-6), pch=21, bg=alpha("orange", alpha=0.5), method="jitter", jitter=0.2, add=T, cex=1, lwd=0.5)
	segments(median(yes_abunds[,i]),index-0.7,median(yes_abunds[,i]),index-0.1, lwd=6, col = "black", lty = "solid")
	segments(median(no_abunds[,i]),index+0.7,median(no_abunds[,i]),index+0.1, lwd=6, col = "black", lty = "solid")
	index <- index + 2
}

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
legend(x=0.6e-2, y=10,, legend=c("Week 6 Nonresponder", "Week 6 Responder"), pch=c(21, 21), pt.bg=c("orange","royalblue1"), cex=1)
mtext('D', at=1e-8, side=3, line=0.1, font=2, cex=2)


#Remission
par(mar=c(3,3,2,1), mgp=c(2,0.5,0))
plot(c(1,0),c(0,1), type='l', lty=2, xlim=c(1.01,0), ylim=c(-0.01,1.01), xaxs='i', yaxs='i', ylab='Sensitivity', xlab='Specificity', las=1)
plot(otu_remWK6_roc, add=T, lwd=2, col='royalblue', lty=1)
plot(md_remWK6_roc, add=T, lwd=2, col='grey5', lty=1)
plot(mdotu_remWK6_roc, add=T, lwd=2, col='red', lty=1)
#title("Predicting Week 6 Remission")
legend('bottomright', c(sprintf('Week 0 OTUs : AUC=%.3f', otu_remWK6_roc$auc), sprintf('Week 0 Clinical Data: AUC=%.3f',md_remWK6_roc$auc),sprintf('Combined: AUC=%.3f',mdotu_remWK6_roc$auc)), lwd=2, col=c('royalblue', "grey5", 'red'), bty='n', lty=1)
mtext('A', at=1.07, side=3, line=0.1, font=2, cex=2)

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

#Abundance stripchart or most predictive otus
tax<-read.table("../data/Jan400.simple.taxonomy.txt", header=T, sep='\t')

oturf_otus  <- as.character(otu_remWK6_rf$Xopt)
oturf_otus <- oturf_otus[1:10]
no_abunds <- otu_remWK6[otu_remWK6$REMISSwk6=='0', oturf_otus]/10000 + 1e-5
no_abunds <-na.omit(no_abunds)
yes_abunds <- otu_remWK6[otu_remWK6$REMISSwk6=='1', oturf_otus]/10000 + 1e-5
yes_abunds<- na.omit(yes_abunds)

par(mar=c(3, 12.2, 2, 1))
plot(1, type="n", ylim=c(0,length(oturf_otus )*2), xlim=c(1e-5,1.5), log="x", ylab="", xlab="Week 0 Relative Abundance (%)", xaxt="n", yaxt="n", cex=1)
set.seed(32016)
index <- 1
for(i in oturf_otus ){
	stripchart(at=index-0.35, jitter(yes_abunds[,i], amount=1e-6), pch=21, bg=alpha("royalblue1", alpha=0.5), method="jitter", jitter=0.2, add=T, cex=1, lwd=0.5)
	stripchart(at=index+0.35, jitter(no_abunds[,i], amount=1e-6), pch=21, bg=alpha("orange", alpha=0.5), method="jitter", jitter=0.2, add=T, cex=1, lwd=0.5)
	segments(median(yes_abunds[,i]),index-0.7,median(yes_abunds[,i]),index-0.1, lwd=6, col = "black", lty = "solid")
	segments(median(no_abunds[,i]),index+0.7,median(no_abunds[,i]),index+0.1, lwd=6, col = "black", lty = "solid")
	index <- index + 2
}
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
legend(x=1e-2, y=10,, legend=c("Week 6 Active CD", "Week 6 Remission"), pch=c(21, 21), pt.bg=c("orange","royalblue1"), cex=1)
mtext('B', at=1e-8, side=3, line=0.1, font=2, cex=2)

dev.off()



