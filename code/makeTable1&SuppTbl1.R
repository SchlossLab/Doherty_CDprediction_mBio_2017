
#Read in all data
source('../code/APmd.setup.R')




screen_RESPwk22<-APmd_RSPwk22[APmd_RSPwk22$visit=="Screening",] #removes any group with NA in RESPONSEwk22

screen_data<-screen_RESPwk22				#na.omit(screen_RESPwk22)
summary(subset(screen_data, select=c(group, USUBJID, visit, TRTGR, TRTGRINDMAN, RESPONSEwk8)))

summary(subset(screen_data, select=c(group, USUBJID, visit, TRTGR, TRTGRINDMAN, RESPONSEwk8)))

summary(subset(screen_data, select=c(group, USUBJID, visit, TRTGR, TRTGRINDMAN, RESPONSEwk8)))


screen_data<-screen_data[screen_data$TRTGRINDMAN!="Placebo_Not",]
screen_data<-screen_data[screen_data$TRTGRINDMAN!="Treated_Not",]

summary(screen_data[,c("TRTGR", "TRTGRINDMAN", "visit", "RESPONSEwk6", "RelRSPwk6", "REMISSwk6")])


screen.trtd<-screen_data[screen_data$TRTGRINDMAN!="Placebo_Placebo",]
screen.trtd<-screen.trtd[screen.trtd$TRTGRINDMAN!="Placebo_Treated",]
summary(screen.trtd[,1:6])
screen.plac<-screen_data[screen_data$TRTGRINDMAN!="Treated_Placebo",]
screen.plac<-screen.plac[screen.plac$TRTGRINDMAN!="Treated_Treated",]
summary(screen.plac[,1:6])

nao.screen_data<-na.omit(screen_data)

nao.screen.trtd<-nao.screen_data[nao.screen_data$TRTGRINDMAN!="Placebo_Placebo",]
nao.screen.trtd<-nao.screen.trtd[nao.screen.trtd$TRTGRINDMAN!="Placebo_Treated",]
summary(nao.screen.trtd[,1:6])
nao.screen.plac<-nao.screen_data[nao.screen_data$TRTGRINDMAN!="Treated_Placebo",]
nao.screen.plac<-nao.screen.plac[nao.screen.plac$TRTGRINDMAN!="Treated_Treated",]
summary(nao.screen.plac[,1:6])


tax<- read.table('../data/Jan400.simple.taxonomy.txt', header=T, sep="\t")
nao.screen.all.distmat<-read.table("../data/Jan400.screening.all.na.omit.cmd.thetayc.0.03.square.ave.dist")
nao.screen.all.dist<-as.dist(nao.screen.all.distmat)
nao.screen.trtd.distmat<-read.table("../data/Jan400.screening.ust.na.omit.cmd.thetayc.0.03.square.ave.dist")
nao.screen.trtd.dist<-as.dist(nao.screen.trtd.distmat)
nao.screen.plac.distmat<-read.table("../data/Jan400.screening.plac.na.omit.cmd.thetayc.0.03.square.ave.dist")
nao.screen.plac.dist<-as.dist(nao.screen.plac.distmat)

trtd_trtd.data.distmat<-read.table("../data/Jan400.trtd_trtd.accnos.na.omit.cmd.thetayc.0.03.square.ave.dist")
trtd_trtd.data.dist<-as.dist(trtd_trtd.data.distmat)
trtd_plac.data.distmat<-read.table("../data/Jan400.trtd_plac.accnos.na.omit.cmd.thetayc.0.03.square.ave.dist")
trtd_plac.data.dist<-as.dist(trtd_plac.data.distmat)
plac_plac.data.distmat<-read.table("../data/Jan400.plac_plac.accnos.na.omit.cmd.thetayc.0.03.square.ave.dist")
plac_plac.data.dist<-as.dist(plac_plac.data.distmat)
plac_trtd.data.distmat<-read.table("../data/Jan400.plac_trtd.accnos.na.omit.cmd.thetayc.0.03.square.ave.dist")
plac_trtd.data.dist<-as.dist(plac_trtd.data.distmat)
	


summary(nao.screen_data[,c("TRTGR")])
summary(screen_data[,c("TRTGR")])



set.seed(32016)
cdai.cor.test.data<-na.omit(subset(nao.screen_data, select= c(group, invsimpson, cdail_wk0)))
n.cdai.cortest<-nrow(cdai.cor.test.data)
n.cdai.cortest
cor.cdai<-cor.test(cdai.cor.test.data$cdail_wk0, cdai.cor.test.data$invsimpson, method = "spearman")
cor.cdai
cor.cdai.pval<-signif(cor.cdai$p.value, digits = 1)
cor.cdai.pval
cor.cdai.rho<-signif(cor.cdai$estimate, digits = 1)
cor.cdai.rho





set.seed(32016)
cdaiwk0.adonis<-adonis(nao.screen.all.dist ~ cdail_wk0, nao.screen_data)
cdaiwk0.adonis
cdaiwk0.adonis.pval<-signif(as.numeric(na.omit(cdaiwk0.adonis$aov.tab$`Pr(>F)`)), digits = 1)

CDAI_min<-toString(c('Min=', min(nao.screen_data$cdail_wk0)))
CDAI_min<-gsub(",", "", CDAI_min)
CDAI_min<-gsub(" ", "", CDAI_min)
CDAI_med<-toString(c("Median=", median(nao.screen_data$cdail_wk0)))
CDAI_med<-gsub(",", "", CDAI_med)
CDAI_med<-gsub(" ", "", CDAI_med)
CDAI_max<-toString(c("Max=", max(nao.screen_data$cdail_wk0)))
CDAI_max<-gsub(",", "", CDAI_max)
CDAI_max<-gsub(" ", "", CDAI_max)
CDAI_sum<-toString(c(CDAI_min, CDAI_med, CDAI_max))
CDAI_n<-n.cdai.cortest
CDAI_Spear_P<- toString(c('(', cor.cdai.pval, ')'))
CDAI_Spear_P<-gsub(",", "", CDAI_Spear_P)
CDAI_Spear_P<-gsub(" ", "", CDAI_Spear_P)
CDAI_Spear_rho<-toString(c('rho =', cor.cdai.rho))
CDAI_Spear_rho<-gsub(",", "", CDAI_Spear_rho)
#CDAI_Spear_rho<-gsub(" ", "", CDAI_Spear_rho)
CDAI_Spear_Prho<-c(CDAI_Spear_rho, CDAI_Spear_P)
CDAI_Spear<-toString(c(CDAI_Spear_Prho))
CDAI_Spear<-gsub(",", "", CDAI_Spear)
#CDAI_AMOVA_p<-toString(c(cdaiwk0.adonis.pval))
#CDAI_AMOVA_p<-gsub(",", "", CDAI_AMOVA_p)
#CDAI_AMOVA_p<-gsub(" ", "", CDAI_AMOVA_p)
#CDAI_AMOVA<-toString(c(CDAI_AMOVA_p))
#CDAI_AMOVA<-gsub(",", "", CDAI_AMOVA)
CDAI<- matrix(c('CDAI', CDAI_Spear_rho, cor.cdai$p.value, as.numeric(na.omit(cdaiwk0.adonis$aov.tab$`Pr(>F)`))), ncol = 4)



set.seed(32016)
stool.cor.test.data<-na.omit(subset(nao.screen_data, select= c(group, invsimpson, CDSTOOLM_Screening)))
n.stool.cortest<-nrow(stool.cor.test.data)
n.stool.cortest
cor.stool<-cor.test(stool.cor.test.data$CDSTOOLM_Screening, stool.cor.test.data$invsimpson, method = "spearman")
cor.stool
cor.stool.pval<-signif(cor.stool$p.value, digits = 1)
cor.stool.pval
cor.stool.rho<-signif(cor.stool$estimate, digits = 1)
cor.stool.rho




set.seed(32016)
stool.adonis<-adonis(nao.screen.all.dist ~ CDSTOOLM_Screening, nao.screen_data)
stool.adonis
stool.adonis.pval<-signif(as.numeric(na.omit(stool.adonis$aov.tab$`Pr(>F)`)), digits = 1)

Stool_min<-toString(c('Min=', min(nao.screen_data$CDSTOOLM_Screening)))
Stool_min<-gsub(",", "", Stool_min)
Stool_min<-gsub(" ", "", Stool_min)
Stool_med<-toString(c("Median=", median(nao.screen_data$CDSTOOLM_Screening)))
Stool_med<-gsub(",", "", Stool_med)
Stool_med<-gsub(" ", "", Stool_med)
Stool_max<-toString(c("Max=", max(nao.screen_data$CDSTOOLM_Screening)))
Stool_max<-gsub(",", "", Stool_max)
Stool_max<-gsub(" ", "", Stool_max)
Stool_sum<-toString(c(Stool_min, Stool_med, Stool_max))
Stool_n<-n.stool.cortest
Stool_Spear_P<- toString(c("(", cor.stool.pval, ")"))
Stool_Spear_P<-gsub(",", "", Stool_Spear_P)
Stool_Spear_P<-gsub(" ", "", Stool_Spear_P)
Stool_Spear_rho<-toString(c('rho =', cor.stool.rho))
Stool_Spear_rho<-gsub(",", "", Stool_Spear_rho)
#Stool_Spear_rho<-gsub(" ", "", Stool_Spear_rho)
Stool_Spear_Prho<-c(Stool_Spear_rho, Stool_Spear_P)
Stool_Spear<-toString(c(Stool_Spear_Prho))
Stool_Spear<-gsub(",", "", Stool_Spear)

Stool<- matrix(c('Loose Stool Frequency (per week)', Stool_Spear_rho, cor.stool$p.value, as.numeric(na.omit(stool.adonis$aov.tab$`Pr(>F)`))), ncol = 4)




set.seed(32016)
CRP.cor.test.data<-na.omit(subset(nao.screen_data, select= c(group, invsimpson, BL_CRP)))
n.CRP.cortest<-nrow(CRP.cor.test.data)
n.CRP.cortest
cor.CRP<-cor.test(CRP.cor.test.data$BL_CRP, CRP.cor.test.data$invsimpson, method = "spearman")
cor.CRP
cor.CRP.pval<-signif(cor.CRP$p.value, digits = 1)
cor.CRP.pval
cor.CRP.rho<-signif(cor.CRP$estimate, digits = 1)
cor.CRP.rho




set.seed(32016)
BL_CRP.adonis<-adonis(nao.screen.all.dist ~ BL_CRP, nao.screen_data)
BL_CRP.adonis
BL_CRP.adonis.pval<-signif(as.numeric(na.omit(BL_CRP.adonis$aov.tab$`Pr(>F)`)), digits = 1)

CRP_min<-toString(c('Min=', min(nao.screen_data$BL_CRP)))
CRP_min<-gsub(",", "", CRP_min)
CRP_min<-gsub(" ", "", CRP_min)
CRP_med<-toString(c("Median=", median(nao.screen_data$BL_CRP)))
CRP_med<-gsub(",", "", CRP_med)
CRP_med<-gsub(" ", "", CRP_med)
CRP_max<-toString(c("Max=", max(nao.screen_data$BL_CRP)))
CRP_max<-gsub(",", "", CRP_max)
CRP_max<-gsub(" ", "", CRP_max)
CRP_sum<-toString(c(CRP_min, CRP_med, CRP_max))
CRP_n<-n.CRP.cortest
CRP_Spear_P<- toString(c('(', cor.CRP.pval, ")"))
CRP_Spear_P<-gsub(",", "", CRP_Spear_P)
CRP_Spear_P<-gsub(" ", "", CRP_Spear_P)
CRP_Spear_rho<-toString(c('rho =', cor.CRP.rho))
CRP_Spear_rho<-gsub(",", "", CRP_Spear_rho)
#CRP_Spear_rho<-gsub(" ", "", CRP_Spear_rho)
CRP_Spear_Prho<-c(CRP_Spear_rho, CRP_Spear_P)
CRP_Spear<-toString(c(CRP_Spear_Prho))
CRP_Spear<-gsub(",", "", CRP_Spear)

CRP<- matrix(c('C-Reactive Protein (mg/L serum)', CRP_Spear_rho, cor.CRP$p.value, as.numeric(na.omit(BL_CRP.adonis$aov.tab$`Pr(>F)`))), ncol = 4)



set.seed(32016)
FCALP.cor.test.data<-na.omit(subset(nao.screen_data, select= c(group, invsimpson, BL_FCALP)))
n.FCALP.cortest<-nrow(FCALP.cor.test.data)
n.FCALP.cortest
cor.FCALP<-cor.test(FCALP.cor.test.data$BL_FCALP, FCALP.cor.test.data$invsimpson, method = "spearman")
cor.FCALP
cor.FCALP.pval<-signif(cor.FCALP$p.value, digits = 1)
cor.FCALP.pval
cor.FCALP.rho<-signif(cor.FCALP$estimate, digits = 1)
cor.FCALP.rho




set.seed(32016)
BL_FCALP.adonis<-adonis(nao.screen.all.dist ~ BL_FCALP, nao.screen_data)
BL_FCALP.adonis
BL_FCALP.adonis.pval<-signif(as.numeric(na.omit(BL_FCALP.adonis$aov.tab$`Pr(>F)`)), digits = 1)

FCALP_min<-toString(c('Min=', min(nao.screen_data$BL_FCALP)))
FCALP_min<-gsub(",", "", FCALP_min)
FCALP_min<-gsub(" ", "", FCALP_min)
FCALP_med<-toString(c("Median=", median(nao.screen_data$BL_FCALP)))
FCALP_med<-gsub(",", "", FCALP_med)
FCALP_med<-gsub(" ", "", FCALP_med)
FCALP_max<-toString(c("Max=", max(nao.screen_data$BL_FCALP)))
FCALP_max<-gsub(",", "", FCALP_max)
FCALP_max<-gsub(" ", "", FCALP_max)
FCALP_sum<-toString(c(FCALP_min, FCALP_med, FCALP_max))
FCALP_n<-n.FCALP.cortest
FCALP_Spear_P<- toString(c('(', cor.FCALP.pval,")"))
FCALP_Spear_P<-gsub(",", "", FCALP_Spear_P)
FCALP_Spear_P<-gsub(" ", "", FCALP_Spear_P)
FCALP_Spear_rho<-toString(c('rho =', cor.FCALP.rho))
FCALP_Spear_rho<-gsub(",", "", FCALP_Spear_rho)
#FCALP_Spear_rho<-gsub(" ", "", FCALP_Spear_rho)
FCALP_Spear_Prho<-c(FCALP_Spear_rho, FCALP_Spear_P)
FCALP_Spear<-toString(c(FCALP_Spear_Prho))
FCALP_Spear<-gsub(",", "", FCALP_Spear)
FCALP_AMOVA_p<-toString(c(BL_FCALP.adonis.pval))
FCALP_AMOVA_p<-gsub(",", "", FCALP_AMOVA_p)
FCALP_AMOVA_p<-gsub(" ", "", FCALP_AMOVA_p)
FCALP_AMOVA<-toString(c(FCALP_AMOVA_p))
FCALP_AMOVA<-gsub(",", "", FCALP_AMOVA)
FCALP<- matrix(c('Fecal Calprotectin (µg/g)', FCALP_Spear_rho, cor.FCALP$p.value, as.numeric(na.omit(BL_FCALP.adonis$aov.tab$`Pr(>F)`))), ncol = 4)



set.seed(32016)
FLACT.cor.test.data<-na.omit(subset(nao.screen_data, select= c(group, invsimpson, BL_FLACT)))
n.FLACT.cortest<-nrow(FLACT.cor.test.data)
n.FLACT.cortest
cor.FLACT<-cor.test(FLACT.cor.test.data$BL_FLACT, FLACT.cor.test.data$invsimpson, method = "spearman")
cor.FLACT
cor.FLACT.pval<-signif(cor.FLACT$p.value, digits = 1)
cor.FLACT.pval
cor.FLACT.rho<-signif(cor.FLACT$estimate, digits = 1)
cor.FLACT.rho




set.seed(32016)
BL_FLACT.adonis<-adonis(nao.screen.all.dist ~ BL_FLACT, nao.screen_data)
BL_FLACT.adonis
BL_FLACT.adonis.pval<-signif(as.numeric(na.omit(BL_FLACT.adonis$aov.tab$`Pr(>F)`)), digits = 1)

FLACT_min<-toString(c('Min=', min(nao.screen_data$BL_FLACT)))
FLACT_min<-gsub(",", "", FLACT_min)
FLACT_min<-gsub(" ", "", FLACT_min)
FLACT_med<-toString(c("Median=", median(nao.screen_data$BL_FLACT)))
FLACT_med<-gsub(",", "", FLACT_med)
FLACT_med<-gsub(" ", "", FLACT_med)
FLACT_max<-toString(c("Max=", max(nao.screen_data$BL_FLACT)))
FLACT_max<-gsub(",", "", FLACT_max)
FLACT_max<-gsub(" ", "", FLACT_max)
FLACT_sum<-toString(c(FLACT_min, FLACT_med, FLACT_max))
FLACT_n<-n.FLACT.cortest
FLACT_Spear_P<- toString(c('(', cor.FLACT.pval,")"))
FLACT_Spear_P<-gsub(",", "", FLACT_Spear_P)
FLACT_Spear_P<-gsub(" ", "", FLACT_Spear_P)
FLACT_Spear_rho<-toString(c('rho =', cor.FLACT.rho))
FLACT_Spear_rho<-gsub(",", "", FLACT_Spear_rho)
#FLACT_Spear_rho<-gsub(" ", "", FLACT_Spear_rho)
FLACT_Spear_Prho<-c(FLACT_Spear_rho, FLACT_Spear_P)
FLACT_Spear<-toString(c(FLACT_Spear_Prho))
FLACT_Spear<-gsub(",", "", FLACT_Spear)
FLACT_AMOVA_p<-toString(c(BL_FLACT.adonis.pval))
FLACT_AMOVA_p<-gsub(",", "", FLACT_AMOVA_p)
FLACT_AMOVA_p<-gsub(" ", "", FLACT_AMOVA_p)
FLACT_AMOVA<-toString(c(FLACT_AMOVA_p))
FLACT_AMOVA<-gsub(",", "", FLACT_AMOVA)
FLACT<- matrix(c('Fecal Lactoferrin (µg/g)', FLACT_Spear_rho, cor.FLACT$p.value, as.numeric(na.omit(BL_FLACT.adonis$aov.tab$`Pr(>F)`))), ncol = 4)



set.seed(32016)
BMI.cor.test.data<-na.omit(subset(nao.screen_data, select= c(group, TRTGR, invsimpson, BL_BMI)))
n.BMI.cortest<-nrow(BMI.cor.test.data)
n.BMI.cortest
cor.BMI<-cor.test(BMI.cor.test.data$BL_BMI, BMI.cor.test.data$invsimpson, method = "spearman")
cor.BMI
cor.BMI.pval<-signif(cor.BMI$p.value, digits = 1)
cor.BMI.pval
cor.BMI.rho<-signif(cor.BMI$estimate, digits = 1)
cor.BMI.rho




set.seed(32016)
BL_BMI.adonis<-adonis(nao.screen.all.dist ~ BL_BMI, nao.screen_data)
BL_BMI.adonis
BL_BMI.adonis.pval<-signif(as.numeric(na.omit(BL_BMI.adonis$aov.tab$`Pr(>F)`)), digits = 1)

BMI_min<-toString(c('Min=', min(nao.screen_data$BL_BMI)))
BMI_min<-gsub(",", "", BMI_min)
BMI_min<-gsub(" ", "", BMI_min)
BMI_med<-toString(c("Median=", median(nao.screen_data$BL_BMI)))
BMI_med<-gsub(",", "", BMI_med)
BMI_med<-gsub(" ", "", BMI_med)
BMI_max<-toString(c("Max=", max(nao.screen_data$BL_BMI)))
BMI_max<-gsub(",", "", BMI_max)
BMI_max<-gsub(" ", "", BMI_max)
BMI_sum<-toString(c(BMI_min, BMI_med, BMI_max))
BMI_n<-n.BMI.cortest
BMI_Spear_P<- toString(c('(', cor.BMI.pval, ")"))
BMI_Spear_P<-gsub(",", "", BMI_Spear_P)
BMI_Spear_P<-gsub(" ", "", BMI_Spear_P)
BMI_Spear_rho<-toString(c('rho =', cor.BMI.rho))
BMI_Spear_rho<-gsub(",", "", BMI_Spear_rho)
#BMI_Spear_rho<-gsub(" ", "", BMI_Spear_rho)
BMI_Spear_Prho<-c(BMI_Spear_rho, BMI_Spear_P)
BMI_Spear<-toString(c(BMI_Spear_Prho))
BMI_Spear<-gsub(",", "", BMI_Spear)
BMI_AMOVA_p<-toString(c(BL_BMI.adonis.pval))
BMI_AMOVA_p<-gsub(",", "", BMI_AMOVA_p)
BMI_AMOVA_p<-gsub(" ", "", BMI_AMOVA_p)
BMI_AMOVA<-toString(c(BMI_AMOVA_p))
BMI_AMOVA<-gsub(",", "", BMI_AMOVA)
BMI<- matrix(c('BMI', BMI_Spear_rho, cor.BMI$p.value, as.numeric(na.omit(BL_BMI.adonis$aov.tab$`Pr(>F)`))), ncol = 4)



set.seed(32016)
weight.cor.test.data<-na.omit(subset(nao.screen_data, select= c(group, invsimpson, CDWEIGHM_Screening)))
n.weight.cortest<-nrow(weight.cor.test.data)
n.weight.cortest
cor.weight<-cor.test(weight.cor.test.data$CDWEIGHM_Screening, weight.cor.test.data$invsimpson, method = "spearman")
cor.weight
cor.weight.pval<-signif(cor.weight$p.value, digits = 1)
cor.weight.pval
cor.weight.rho<-signif(cor.weight$estimate, digits = 1)
cor.weight.rho




set.seed(32016)
CDWEIGHM_Screening.adonis<-adonis(nao.screen.all.dist ~ CDWEIGHM_Screening, nao.screen_data)
CDWEIGHM_Screening.adonis
CDWEIGHM_Screening.adonis.pval<-signif(as.numeric(na.omit(CDWEIGHM_Screening.adonis$aov.tab$`Pr(>F)`)), digits = 1)

weight_min<-toString(c('Min=', min(nao.screen_data$CDWEIGHM_Screening)))
weight_min<-gsub(",", "", weight_min)
weight_min<-gsub(" ", "", weight_min)
weight_med<-toString(c("Median=", median(nao.screen_data$CDWEIGHM_Screening)))
weight_med<-gsub(",", "", weight_med)
weight_med<-gsub(" ", "", weight_med)
weight_max<-toString(c("Max=", max(nao.screen_data$CDWEIGHM_Screening)))
weight_max<-gsub(",", "", weight_max)
weight_max<-gsub(" ", "", weight_max)
weight_sum<-toString(c(weight_min, weight_med, weight_max))
weight_n<-n.weight.cortest
weight_Spear_P<- toString(c('(', cor.weight.pval, ")"))
weight_Spear_P<-gsub(",", "", weight_Spear_P)
weight_Spear_P<-gsub(" ", "", weight_Spear_P)
weight_Spear_rho<-toString(c('rho =', cor.weight.rho))
weight_Spear_rho<-gsub(",", "", weight_Spear_rho)
#weight_Spear_rho<-gsub(" ", "", weight_Spear_rho)
weight_Spear_Prho<-c(weight_Spear_rho, weight_Spear_P)
weight_Spear<-toString(c(weight_Spear_Prho))
weight_Spear<-gsub(",", "", weight_Spear)
weight_AMOVA_p<-toString(c(CDWEIGHM_Screening.adonis.pval))
weight_AMOVA_p<-gsub(",", "", weight_AMOVA_p)
weight_AMOVA_p<-gsub(" ", "", weight_AMOVA_p)
weight_AMOVA<-toString(c(weight_AMOVA_p))
weight_AMOVA<-gsub(",", "", weight_AMOVA)
weight<- matrix(c('Weight (kg)', weight_Spear_rho, cor.weight$p.value, as.numeric(na.omit(CDWEIGHM_Screening.adonis$aov.tab$`Pr(>F)`))), ncol = 4)



set.seed(32016)
AGE.cor.test.data<-na.omit(subset(nao.screen_data, select= c(group, TRTGR, invsimpson, AGE)))
n.AGE.cortest<-nrow(AGE.cor.test.data)
n.AGE.cortest
cor.AGE<-cor.test(AGE.cor.test.data$AGE, AGE.cor.test.data$invsimpson, method = "spearman")
cor.AGE
cor.AGE.pval<-signif(cor.AGE$p.value, digits = 1)
cor.AGE.pval
cor.AGE.rho<-signif(cor.AGE$estimate, digits = 1)
cor.AGE.rho


AGE.total.mean<-mean(AGE.cor.test.data$AGE)
AGE.total.sd<-sd(AGE.cor.test.data$AGE)

AGE.trtd<-AGE.cor.test.data[AGE.cor.test.data$TRTGR=="Treated",]
AGE.trtd.mean<-signif(mean(AGE.cor.test.data$AGE), digits = 2)
AGE.trtd.sd<-sd(AGE.cor.test.data$AGE)

AGE.plac<-AGE.cor.test.data[AGE.cor.test.data$TRTGR=="Placebo",]
AGE.plac.mean<-signif(mean(AGE.cor.test.data$AGE), digits=2)
AGE.plac.sd<-sd(AGE.cor.test.data$AGE)






set.seed(32016)
AGE.adonis<-adonis(nao.screen.all.dist ~ AGE, nao.screen_data)
AGE.adonis
AGE.adonis.pval<-signif(as.numeric(na.omit(AGE.adonis$aov.tab$`Pr(>F)`)), digits = 1)

AGE_min<-toString(c('Min=', min(nao.screen_data$AGE)))
AGE_min<-gsub(",", "", AGE_min)
AGE_min<-gsub(" ", "", AGE_min)
AGE_med<-toString(c("Median=", median(nao.screen_data$AGE)))
AGE_med<-gsub(",", "", AGE_med)
AGE_med<-gsub(" ", "", AGE_med)
AGE_max<-toString(c("Max=", max(nao.screen_data$AGE)))
AGE_max<-gsub(",", "", AGE_max)
AGE_max<-gsub(" ", "", AGE_max)
AGE_sum<-toString(c(AGE_min, AGE_med, AGE_max))
AGE_n<-n.AGE.cortest

AGE_Spear_P<- toString(c('(', cor.AGE.pval, ")"))
AGE_Spear_P<-gsub(",", "", AGE_Spear_P)
AGE_Spear_P<-gsub(" ", "", AGE_Spear_P)
AGE_Spear_rho<-toString(c('rho =', cor.AGE.rho))
AGE_Spear_rho<-gsub(",", "", AGE_Spear_rho)
#AGE_Spear_rho<-gsub("rho", expression("\U03C1"), AGE_Spear_rho)
AGE_Spear_Prho<-c(AGE_Spear_rho, AGE_Spear_P)
AGE_Spear<-toString(c(AGE_Spear_Prho))
AGE_Spear<-gsub(",", "", AGE_Spear)
AGE_AMOVA_p<-toString(c(AGE.adonis.pval))
AGE_AMOVA_p<-gsub(",", "", AGE_AMOVA_p)
AGE_AMOVA_p<-gsub(" ", "", AGE_AMOVA_p)
AGE_AMOVA<-toString(c(AGE_AMOVA_p))
AGE_AMOVA<-gsub(",", "", AGE_AMOVA)
AGE<- matrix(c('Age (years)', AGE_Spear_rho, cor.AGE$p.value, as.numeric(na.omit(AGE.adonis$aov.tab$`Pr(>F)`))), ncol = 4)



set.seed(32016)
SEX.wilcox.test.data<-na.omit(subset(nao.screen_data, select= c(group, invsimpson, SEX)))
n.MSEX.wilcoxtest<-nrow(SEX.wilcox.test.data[SEX.wilcox.test.data$SEX=="M",])
n.MSEX.wilcoxtest
n.FSEX.wilcoxtest<-nrow(SEX.wilcox.test.data[SEX.wilcox.test.data$SEX=="F",])
n.FSEX.wilcoxtest
wilcox.SEX<-wilcox.test(invsimpson ~ SEX, SEX.wilcox.test.data)
summary(wilcox.SEX)
wilcox.SEX.pval<-signif(wilcox.SEX$p.value, digits = 1)
wilcox.SEX.pval
wilcox.SEX.method<-wilcox.SEX$method
subT<-wilcox.SEX.method




set.seed(32016)
SEX.adonis<-adonis(nao.screen.all.dist ~ SEX, nao.screen_data)
SEX.adonis
SEX.adonis.pval<-signif(as.numeric(na.omit(SEX.adonis$aov.tab$`Pr(>F)`)), digits = 1)
MSEX<-toString(c(n.MSEX.wilcoxtest))
FSEX<-toString(c(n.FSEX.wilcoxtest))


SEX_sum<-toString(c(FSEX, "/", MSEX))
SEX_sum<-gsub(",", "", SEX_sum)
SEX_sum<-gsub(" ", "", SEX_sum)

SEX<- matrix(c('Sex (F/M)', "-", wilcox.SEX$p.value, as.numeric(na.omit(SEX.adonis$aov.tab$`Pr(>F)`))), ncol = 4)




set.seed(32016)
BCORT.wilcox.test.data<-na.omit(subset(nao.screen_data, select= c(group, invsimpson, BCORT)))
YesBCORT.wilcoxtest<-BCORT.wilcox.test.data[BCORT.wilcox.test.data$BCORT=="Yes",]
n.YesBCORT.wilcoxtest<-nrow(YesBCORT.wilcoxtest)
NoBCORT.wilcoxtest<-BCORT.wilcox.test.data[BCORT.wilcox.test.data$BCORT=="No",]
n.NoBCORT.wilcoxtest<-nrow(NoBCORT.wilcoxtest)
wilcox.BCORT<-wilcox.test(invsimpson ~ BCORT, BCORT.wilcox.test.data)
summary(wilcox.BCORT)
wilcox.BCORT.pval<-signif(wilcox.BCORT$p.value, digits = 1)
wilcox.BCORT.pval
wilcox.BCORT.method<-wilcox.BCORT$method
subT<-wilcox.BCORT.method
nYesString<-toString(c("Yes=", n.YesBCORT.wilcoxtest))
nYesString<-gsub(",", "", nYesString)
nNoString<-toString(c("No=", n.NoBCORT.wilcoxtest))
nNoString<-gsub(",", "", nNoString)




set.seed(32016)
BCORT.adonis<-adonis(nao.screen.all.dist ~ BCORT, nao.screen_data)
BCORT.adonis
BCORT.adonis.pval<-signif(as.numeric(na.omit(BCORT.adonis$aov.tab$`Pr(>F)`)), digits = 1)

YesBCORT<-toString(c(n.YesBCORT.wilcoxtest))

NoBCORT<-toString(c(n.NoBCORT.wilcoxtest))


BCORT_sum<-toString(c(YesBCORT, "/", NoBCORT))
BCORT_sum<-gsub(",", "", BCORT_sum)
BCORT_sum<-gsub(" ", "", BCORT_sum)

BCORT<- matrix(c('Corticosteroid Use (Y/N)', "-", wilcox.BCORT$p.value, as.numeric(na.omit(BCORT.adonis$aov.tab$`Pr(>F)`))), ncol = 4)



set.seed(32016)
cor.test(nao.screen_data$invsimpson, nao.screen_data$DDUR, method = "spearman")


DDUR.cor.test.data<-na.omit(subset(nao.screen_data, select= c(group, invsimpson, DDUR)))
n.DDUR.cortest<-nrow(DDUR.cor.test.data)
n.DDUR.cortest
cor.DDUR<-cor.test(DDUR.cor.test.data$DDUR, DDUR.cor.test.data$invsimpson, method = "spearman")
cor.DDUR
cor.DDUR.pval<-signif(cor.DDUR$p.value, digits = 1)
cor.DDUR.pval
cor.DDUR.rho<-signif(cor.DDUR$estimate, digits = 1)
cor.DDUR.rho





set.seed(32016)
DDUR.adonis<-adonis(nao.screen.all.dist ~ DDUR, nao.screen_data)
DDUR.adonis
DDUR.adonis.pval<-signif(as.numeric(na.omit(DDUR.adonis$aov.tab$`Pr(>F)`)), digits = 1)

DDUR_min<-toString(c('Min=', min(nao.screen_data$DDUR)))
DDUR_min<-gsub(",", "", DDUR_min)
DDUR_min<-gsub(" ", "", DDUR_min)
DDUR_med<-toString(c("Median=", median(nao.screen_data$DDUR)))
DDUR_med<-gsub(",", "", DDUR_med)
DDUR_med<-gsub(" ", "", DDUR_med)
DDUR_max<-toString(c("Max=", max(nao.screen_data$DDUR)))
DDUR_max<-gsub(",", "", DDUR_max)
DDUR_max<-gsub(" ", "", DDUR_max)
DDUR_sum<-toString(c(DDUR_min, DDUR_med, DDUR_max))
DDUR_n<-n.DDUR.cortest
DDUR_Spear_P<- toString(c("(", cor.DDUR.pval, ")"))
DDUR_Spear_P<-gsub(",", "", DDUR_Spear_P)
DDUR_Spear_P<-gsub(" ", "", DDUR_Spear_P)
DDUR_Spear_rho<-toString(c('rho =', cor.DDUR.rho))
DDUR_Spear_rho<-gsub(",", "", DDUR_Spear_rho)
#DDUR_Spear_rho<-gsub(" ", "", DDUR_Spear_rho)
DDUR_Spear_Prho<-c(DDUR_Spear_rho, DDUR_Spear_P)
DDUR_Spear_Prho<-toString(c(DDUR_Spear_Prho))
DDUR_Spear_Prho<-gsub(",", "", DDUR_Spear_Prho)

DDUR<- matrix(c('Disease Duration (years)', DDUR_Spear_rho, cor.DDUR$p.value, as.numeric(na.omit(DDUR.adonis$aov.tab$`Pr(>F)`))), ncol = 4)



set.seed(32016)
summary(nao.screen_data$tissinvol)

tissinvol.kw.data<-na.omit(subset(nao.screen_data, select= c(group, invsimpson, tissinvol)))
levels(tissinvol.kw.data$tissinvol)[2]<-"Colon-Ileum"
tissinvol.kw<-kruskal.test(invsimpson ~ tissinvol, tissinvol.kw.data)
tissinvol.kw
#plot(invsimpson ~ tissinvol, tissinvol.kw.data)
Colon.kw<-tissinvol.kw.data[tissinvol.kw.data$tissinvol=="Colon",]
n.Colon.kw<-nrow(Colon.kw)
Colon_Ileum.kw<-tissinvol.kw.data[tissinvol.kw.data$tissinvol=="Colon-Ileum",]
n.Colon_Ileum.kw<-nrow(Colon_Ileum.kw)
Ileum.kw<-tissinvol.kw.data[tissinvol.kw.data$tissinvol=="Ileum",]
n.Ileum.kw<-nrow(Ileum.kw)
kmc<-kruskalmc(invsimpson ~ tissinvol, tissinvol.kw.data)
kw.tissinvol<-kruskal.test(invsimpson ~ tissinvol, tissinvol.kw.data)
summary(kw.tissinvol)
kw.tissinvol.pval<-signif(kw.tissinvol$p.value, digits = 1)
kw.tissinvol.pval
kw.tissinvol.method<-kw.tissinvol$method
subT<-kw.tissinvol.method
nColonString<-toString(c("Colon =", n.Colon.kw))
nColonString<-gsub(",", "", nColonString)
nColon_IleumString<-toString(c("Colon-Ileum =", n.Colon_Ileum.kw))
nColon_IleumString<-gsub(",", "", nColon_IleumString)
nIleumString<-toString(c("Ileum =", n.Ileum.kw))
nIleumString<-gsub(",", "", nIleumString)

kruskalmc(invsimpson ~ tissinvol, tissinvol.kw.data)



set.seed(32016)
tissinvol.adonis<-adonis(nao.screen.all.dist ~ tissinvol, nao.screen_data)
tissinvol.adonis
tissinvol.adonis.pval<-signif(as.numeric(na.omit(tissinvol.adonis$aov.tab$`Pr(>F)`)), digits = 1)

Colon<-toString(c('Colon=', n.Colon.kw))
Colon<-gsub(",", "", Colon)
Colon<-gsub(" ", "", Colon)
ColIle<-toString(c('Colon-Ileum=', n.Colon_Ileum.kw))
ColIle<-gsub(",", "", ColIle)
ColIle<-gsub(" ", "", ColIle)
Ileum<-toString(c('Ileum=', n.Ileum.kw))
Ileum<-gsub(",", "", Ileum)
Ileum<-gsub(" ", "", Ileum)

tissinvol_sum<-toString(c(Colon, ColIle, Ileum))

tissinvol<- matrix(c('Tissue Involvement', "-", kw.tissinvol$p.value, as.numeric(na.omit(tissinvol.adonis$aov.tab$`Pr(>F)`))), ncol = 4)



set.seed(32016)

BOWSTRICT.wilcox.test.data<-na.omit(subset(nao.screen_data, select= c(group, invsimpson, BOWSTRICT)))
n.YesBOWSTRICT.wilcoxtest<-nrow(BOWSTRICT.wilcox.test.data[BOWSTRICT.wilcox.test.data$BOWSTRICT=="Strict_stenosis",])
n.YesBOWSTRICT.wilcoxtest
n.NoBOWSTRICT.wilcoxtest<-nrow(BOWSTRICT.wilcox.test.data[BOWSTRICT.wilcox.test.data$BOWSTRICT=="Other",])
n.NoBOWSTRICT.wilcoxtest
wilcox.BOWSTRICT<-wilcox.test(invsimpson ~ BOWSTRICT, BOWSTRICT.wilcox.test.data)
summary(wilcox.BOWSTRICT)
wilcox.BOWSTRICT.pval<-signif(wilcox.BOWSTRICT$p.value, digits = 1)
wilcox.BOWSTRICT.pval

#plot(invsimpson~BOWSTRICT, nao.screen_data)



set.seed(32016)
BOWSTRICT.adonis<-adonis(nao.screen.all.dist ~ BOWSTRICT, nao.screen_data)
BOWSTRICT.adonis
BOWSTRICT.adonis.pval<-signif(as.numeric(na.omit(BOWSTRICT.adonis$aov.tab$`Pr(>F)`)), digits = 1)

YesBOWSTRICT<-toString(c('Yes=', n.YesBOWSTRICT.wilcoxtest))
YesBOWSTRICT<-gsub(",", "", YesBOWSTRICT)
YesBOWSTRICT<-gsub(" ", "", YesBOWSTRICT)
NoBOWSTRICT<-toString(c("No=", n.NoBOWSTRICT.wilcoxtest))
NoBOWSTRICT<-gsub(",", "", NoBOWSTRICT)
NoBOWSTRICT<-gsub(" ", "", NoBOWSTRICT)

BOWSTRICT_sum<-toString(c(NoBOWSTRICT, YesBOWSTRICT))


BOWSTRICT<-matrix(c('Bowel Stricture', "-", wilcox.BOWSTRICT$p.value, as.numeric(na.omit(BOWSTRICT.adonis$aov.tab$`Pr(>F)`))), ncol = 4)



N.cohort.data<-na.omit(subset(nao.screen_data, select= c(group, TRTGR)))
N_trtd <- nrow(N.cohort.data[N.cohort.data$TRTGR=="Treated",])
N_plac <- nrow(N.cohort.data[N.cohort.data$TRTGR=="Placebo",])
N_total <- nrow(N.cohort.data)
N.cohort<- matrix(c('', paste("n =", N_trtd), paste("n =", N_plac), paste("n =",N_total)), ncol = 4)

set.seed(32016)
AGE.total.mean<-signif(mean(AGE.cor.test.data$AGE), digits = 2)
AGE.total.sd<-signif(sd(AGE.cor.test.data$AGE), digits = 2)
AGE_total<-toString(c(AGE.total.mean, "±", AGE.total.sd))
AGE_total<-gsub(",", "", AGE_total)
#AGE_total<-gsub(" ", "", AGE_total)

AGE.trtd<-AGE.cor.test.data[AGE.cor.test.data$TRTGR=="Treated",]
AGE.trtd.mean<-signif(mean(AGE.trtd$AGE), digits = 2)
AGE.trtd.sd<-signif(sd(AGE.trtd$AGE), digits = 2)
AGE_trtd<-toString(c(AGE.trtd.mean, " ± ", AGE.trtd.sd))
AGE_trtd<-gsub(",", "", AGE_trtd)
#AGE_trtd<-gsub(" ", "", AGE_trtd)

AGE.plac<-AGE.cor.test.data[AGE.cor.test.data$TRTGR=="Placebo",]
AGE.plac.mean<-signif(mean(AGE.plac$AGE), digits = 2)
AGE.plac.sd<-signif(sd(AGE.plac$AGE), digits = 2)
AGE_plac<-toString(c(AGE.plac.mean, " ± ", AGE.plac.sd))
AGE_plac<-gsub(",", "", AGE_plac)
#AGE_plac<-gsub(" ", "", AGE_plac)

AGE.cohort<- matrix(c('Age (years)', AGE_trtd, AGE_plac, AGE_total), ncol = 4)

SEX.cohort.data<-na.omit(subset(nao.screen_data, select= c(group, TRTGR, SEX)))
n.MSEX.total<-nrow(SEX.cohort.data[SEX.cohort.data$SEX=="M",])
n.MSEX.total
n.FSEX.total<-nrow(SEX.cohort.data[SEX.cohort.data$SEX=="F",])
n.FSEX.total

SEX_total<-toString(c(signif(n.MSEX.total/(n.FSEX.total+n.MSEX.total)*100, 3)))
SEX_total<-gsub(",", "", SEX_total)
#SEX_total<-gsub(" ", "", SEX_total)

SEX.trtd<-SEX.cohort.data[SEX.cohort.data$TRTGR=="Treated",]
n.MSEX.trtd<-nrow(SEX.trtd[SEX.trtd$SEX=="M",])
n.MSEX.trtd
n.FSEX.trtd<-nrow(SEX.trtd[SEX.trtd$SEX=="F",])
n.FSEX.trtd
SEX_trtd<-toString(c(signif(n.MSEX.trtd/(n.FSEX.trtd + n.MSEX.trtd)*100, 3)))
SEX_trtd<-gsub(",", "", SEX_trtd)
#SEX_trtd<-gsub(" ", "", SEX_trtd)


SEX.plac<-SEX.cohort.data[SEX.cohort.data$TRTGR=="Placebo",]
n.MSEX.plac<-nrow(SEX.plac[SEX.plac$SEX=="M",])
n.MSEX.plac
n.FSEX.plac<-nrow(SEX.plac[SEX.plac$SEX=="F",])
n.FSEX.plac
SEX_plac<-toString(c(signif(n.MSEX.plac/(n.FSEX.plac +n.MSEX.plac)*100, 3)))
SEX_plac<-gsub(",", "", SEX_plac)
#SEX_plac<-gsub(" ", "", SEX_plac)

SEX.cohort<- matrix(c('Sex (% Male)', SEX_trtd, SEX_plac, SEX_total), ncol = 4)

RACE.cohort.data<-na.omit(subset(nao.screen_data, select= c(group, TRTGR, RACE)))
n.CRACE.total<-nrow(RACE.cohort.data[RACE.cohort.data$RACE=="Caucasian",])
n.CRACE.total
n.ORACE.total<-nrow(RACE.cohort.data[RACE.cohort.data$RACE!="Caucasian",])
n.ORACE.total

RACE_total<-toString(c(signif(n.CRACE.total/(n.CRACE.total+n.ORACE.total)*100, 3)))
RACE_total<-gsub(",", "", RACE_total)
#RACE_total<-gsub(" ", "", RACE_total)

RACE.trtd<-RACE.cohort.data[RACE.cohort.data$TRTGR=="Treated",]
n.CRACE.trtd<-nrow(RACE.trtd[RACE.trtd$RACE=="Caucasian",])
n.CRACE.trtd
n.ORACE.trtd<-nrow(RACE.trtd[RACE.trtd$RACE!="Caucasian",])
n.ORACE.trtd
RACE_trtd<-toString(c(signif(n.CRACE.trtd/(n.CRACE.trtd+n.ORACE.trtd)*100, 3)))
RACE_trtd<-gsub(",", "", RACE_trtd)
#RACE_trtd<-gsub(" ", "", RACE_trtd)


RACE.plac<-RACE.cohort.data[RACE.cohort.data$TRTGR=="Placebo",]
n.CRACE.plac<-nrow(RACE.plac[RACE.plac$RACE=="Caucasian",])
n.CRACE.plac
n.ORACE.plac<-nrow(RACE.plac[RACE.plac$RACE!="Caucasian",])
n.ORACE.plac
RACE_plac<-toString(c(signif(n.CRACE.plac/(n.CRACE.plac+n.ORACE.plac)*100, 3)))
RACE_plac<-gsub(",", "", RACE_plac)
#RACE_plac<-gsub(" ", "", RACE_plac)

RACE.cohort<- matrix(c('Race (% Caucasian)', RACE_trtd, RACE_plac, RACE_total), ncol = 4)

BCORT.cohort.data<-na.omit(subset(nao.screen_data, select= c(group, TRTGR, BCORT)))
n.YesBCORT.total<-nrow(BCORT.cohort.data[BCORT.cohort.data$BCORT=="Yes",])
n.YesBCORT.total
n.NoBCORT.total<-nrow(BCORT.cohort.data[BCORT.cohort.data$BCORT!="Yes",])
n.NoBCORT.total

BCORT_total<-toString(c(signif(n.YesBCORT.total/(n.YesBCORT.total+n.NoBCORT.total)*100, 3)))
BCORT_total<-gsub(",", "", BCORT_total)
BCORT_total<-gsub(" ", "", BCORT_total)

BCORT.trtd<-BCORT.cohort.data[BCORT.cohort.data$TRTGR=="Treated",]
n.YesBCORT.trtd<-nrow(BCORT.trtd[BCORT.trtd$BCORT=="Yes",])
n.YesBCORT.trtd
n.NoBCORT.trtd<-nrow(BCORT.trtd[BCORT.trtd$BCORT!="Yes",])
n.NoBCORT.trtd
BCORT_trtd<-toString(c(signif(n.YesBCORT.trtd/(n.YesBCORT.trtd+n.NoBCORT.trtd)*100, 3)))
BCORT_trtd<-gsub(",", "", BCORT_trtd)
BCORT_trtd<-gsub(" ", "", BCORT_trtd)


BCORT.plac<-BCORT.cohort.data[BCORT.cohort.data$TRTGR=="Placebo",]
n.YesBCORT.plac<-nrow(BCORT.plac[BCORT.plac$BCORT=="Yes",])
n.YesBCORT.plac
n.NoBCORT.plac<-nrow(BCORT.plac[BCORT.plac$BCORT!="Yes",])
n.NoBCORT.plac
BCORT_plac<-toString(c(signif(n.YesBCORT.plac/(n.YesBCORT.plac+n.NoBCORT.plac)*100, 3)))
BCORT_plac<-gsub(",", "", BCORT_plac)
BCORT_plac<-gsub(" ", "", BCORT_plac)

BCORT.cohort<- matrix(c('Corticosteroid Use (%)', BCORT_trtd, BCORT_plac, BCORT_total), ncol = 4)

BL_BMI.cohort.data<-na.omit(subset(nao.screen_data, select= c(group, TRTGR, BL_BMI)))
BL_BMI.total.mean<-signif(mean(BL_BMI.cohort.data$BL_BMI), digits = 2)
BL_BMI.total.sd<-signif(sd(BL_BMI.cohort.data$BL_BMI), digits = 2)
BL_BMI_total<-toString(c(BL_BMI.total.mean, " ± ", BL_BMI.total.sd))
BL_BMI_total<-gsub(",", "", BL_BMI_total)
#BL_BMI_total<-gsub(" ", "", BL_BMI_total)

BL_BMI.trtd<-BL_BMI.cohort.data[BL_BMI.cohort.data$TRTGR=="Treated",]
BL_BMI.trtd.mean<-signif(mean(BL_BMI.trtd$BL_BMI), digits = 2)
BL_BMI.trtd.sd<-signif(sd(BL_BMI.trtd$BL_BMI), digits = 2)
BL_BMI_trtd<-toString(c(BL_BMI.trtd.mean, " ± ", BL_BMI.trtd.sd))
BL_BMI_trtd<-gsub(",", "", BL_BMI_trtd)
#BL_BMI_trtd<-gsub(" ", "", BL_BMI_trtd)

BL_BMI.plac<-BL_BMI.cohort.data[BL_BMI.cohort.data$TRTGR=="Placebo",]
BL_BMI.plac.mean<-signif(mean(BL_BMI.plac$BL_BMI), digits = 2)
BL_BMI.plac.sd<-signif(sd(BL_BMI.plac$BL_BMI), digits = 2)
BL_BMI_plac<-toString(c(BL_BMI.plac.mean, " ± ", BL_BMI.plac.sd))
BL_BMI_plac<-gsub(",", "", BL_BMI_plac)
#BL_BMI_plac<-gsub(" ", "", BL_BMI_plac)

BL_BMI.cohort<- matrix(c('BMI (kg/m^2)', BL_BMI_trtd, BL_BMI_plac, BL_BMI_total), ncol = 4)


DDUR.cohort.data<-na.omit(subset(nao.screen_data, select= c(group, TRTGR, DDUR)))
DDUR.total.mean<-signif(mean(DDUR.cohort.data$DDUR), digits = 2)
DDUR.total.sd<-signif(sd(DDUR.cohort.data$DDUR), digits = 2)
DDUR_total<-toString(c(DDUR.total.mean, " ± ", DDUR.total.sd))
DDUR_total<-gsub(",", "", DDUR_total)
#DDUR_total<-gsub(" ", "", DDUR_total)

DDUR.trtd<-DDUR.cohort.data[DDUR.cohort.data$TRTGR=="Treated",]
DDUR.trtd.mean<-signif(mean(DDUR.trtd$DDUR), digits = 2)
DDUR.trtd.sd<-signif(sd(DDUR.trtd$DDUR), digits = 2)
DDUR_trtd<-toString(c(DDUR.trtd.mean, " ± ", DDUR.trtd.sd))
DDUR_trtd<-gsub(",", "", DDUR_trtd)
#DDUR_trtd<-gsub(" ", "", DDUR_trtd)

DDUR.plac<-DDUR.cohort.data[DDUR.cohort.data$TRTGR=="Placebo",]
DDUR.plac.mean<-signif(mean(DDUR.plac$DDUR), digits = 2)
DDUR.plac.sd<-signif(sd(DDUR.plac$DDUR), digits = 2)
DDUR_plac<-toString(c(DDUR.plac.mean, " ± ", DDUR.plac.sd))
DDUR_plac<-gsub(",", "", DDUR_plac)
#DDUR_plac<-gsub(" ", "", DDUR_plac)

DDUR.cohort<- matrix(c('Disease Duration (years)', DDUR_trtd, DDUR_plac, DDUR_total), ncol = 4)

cdail_wk0.cohort.data<-na.omit(subset(nao.screen_data, select= c(group, TRTGR, cdail_wk0)))
cdail_wk0.total.mean<-signif(mean(cdail_wk0.cohort.data$cdail_wk0), digits = 2)
cdail_wk0.total.sd<-signif(sd(cdail_wk0.cohort.data$cdail_wk0), digits = 2)
cdail_wk0_total<-toString(c(cdail_wk0.total.mean, " ± ", cdail_wk0.total.sd))
cdail_wk0_total<-gsub(",", "", cdail_wk0_total)
#cdail_wk0_total<-gsub(" ", "", cdail_wk0_total)

cdail_wk0.trtd<-cdail_wk0.cohort.data[cdail_wk0.cohort.data$TRTGR=="Treated",]
cdail_wk0.trtd.mean<-signif(mean(cdail_wk0.trtd$cdail_wk0), digits = 2)
cdail_wk0.trtd.sd<-signif(sd(cdail_wk0.trtd$cdail_wk0), digits = 2)
cdail_wk0_trtd<-toString(c(cdail_wk0.trtd.mean, " ± ", cdail_wk0.trtd.sd))
cdail_wk0_trtd<-gsub(",", "", cdail_wk0_trtd)
#cdail_wk0_trtd<-gsub(" ", "", cdail_wk0_trtd)

cdail_wk0.plac<-cdail_wk0.cohort.data[cdail_wk0.cohort.data$TRTGR=="Placebo",]
cdail_wk0.plac.mean<-signif(mean(cdail_wk0.plac$cdail_wk0), digits = 2)
cdail_wk0.plac.sd<-signif(sd(cdail_wk0.plac$cdail_wk0), digits = 2)
cdail_wk0_plac<-toString(c(cdail_wk0.plac.mean, " ± ", cdail_wk0.plac.sd))
cdail_wk0_plac<-gsub(",", "", cdail_wk0_plac)
#cdail_wk0_plac<-gsub(" ", "", cdail_wk0_plac)

cdail_wk0.cohort<- matrix(c('CDAI', cdail_wk0_trtd, cdail_wk0_plac, cdail_wk0_total), ncol = 4)

BOWSTRICT.cohort.data<-na.omit(subset(nao.screen_data, select= c(group, TRTGR, BOWSTRICT)))
n.YesBOWSTRICT.total<-nrow(BOWSTRICT.cohort.data[BOWSTRICT.cohort.data$BOWSTRICT=="Strict_stenosis",])
n.YesBOWSTRICT.total
n.NoBOWSTRICT.total<-nrow(BOWSTRICT.cohort.data[BOWSTRICT.cohort.data$BOWSTRICT=="Other",])
n.NoBOWSTRICT.total

BOWSTRICT_total<-toString(c(signif(n.YesBOWSTRICT.total/(n.YesBOWSTRICT.total+n.NoBOWSTRICT.total)*100, 3)))
BOWSTRICT_total<-gsub(",", "", BOWSTRICT_total)
BOWSTRICT_total<-gsub(" ", "", BOWSTRICT_total)

BOWSTRICT.trtd<-BOWSTRICT.cohort.data[BOWSTRICT.cohort.data$TRTGR=="Treated",]
n.YesBOWSTRICT.trtd<-nrow(BOWSTRICT.trtd[BOWSTRICT.trtd$BOWSTRICT=="Strict_stenosis",])
n.YesBOWSTRICT.trtd
n.NoBOWSTRICT.trtd<-nrow(BOWSTRICT.trtd[BOWSTRICT.trtd$BOWSTRICT=="Other",])
n.NoBOWSTRICT.trtd
BOWSTRICT_trtd<-toString(c(signif(n.YesBOWSTRICT.trtd/(n.YesBOWSTRICT.trtd+n.NoBOWSTRICT.trtd)*100, 3)))
BOWSTRICT_trtd<-gsub(",", "", BOWSTRICT_trtd)
BOWSTRICT_trtd<-gsub(" ", "", BOWSTRICT_trtd)


BOWSTRICT.plac<-BOWSTRICT.cohort.data[BOWSTRICT.cohort.data$TRTGR=="Placebo",]
n.YesBOWSTRICT.plac<-nrow(BOWSTRICT.plac[BOWSTRICT.plac$BOWSTRICT=="Strict_stenosis",])
n.YesBOWSTRICT.plac
n.NoBOWSTRICT.plac<-nrow(BOWSTRICT.plac[BOWSTRICT.plac$BOWSTRICT=="Other",])
n.NoBOWSTRICT.plac
BOWSTRICT_plac<-toString(c(signif(n.YesBOWSTRICT.plac/(n.YesBOWSTRICT.plac+n.NoBOWSTRICT.plac)*100, 3)))
BOWSTRICT_plac<-gsub(",", "", BOWSTRICT_plac)
BOWSTRICT_plac<-gsub(" ", "", BOWSTRICT_plac)

BOWSTRICT.cohort<- matrix(c('Bowel Stricture (%)', BOWSTRICT_trtd, BOWSTRICT_plac, BOWSTRICT_total), ncol = 4)

tissinvol.cohort.data<-na.omit(subset(nao.screen_data, select= c(group, TRTGR, tissinvol)))
n.Colon.total<-nrow(tissinvol.cohort.data[tissinvol.cohort.data$tissinvol=="Colon",])
n.Colon.total <- signif(n.Colon.total/N_total*100, 3)
n.Colon_Ileum.total<-nrow(tissinvol.cohort.data[tissinvol.cohort.data$tissinvol=="Colon_Ileum",])
n.Colon_Ileum.total <- signif(n.Colon_Ileum.total/N_total*100, 3)
n.Ileum.total<-nrow(tissinvol.cohort.data[tissinvol.cohort.data$tissinvol=="Ileum",])
n.Ileum.total <- signif(n.Ileum.total/N_total*100,3)


tissinvol_total<-toString(c(n.Colon.total, "/", n.Colon_Ileum.total, "/", n.Ileum.total))
tissinvol_total<-gsub(",", "", tissinvol_total)
tissinvol_total<-gsub(" ", "", tissinvol_total)

tissinvol.trtd<-tissinvol.cohort.data[tissinvol.cohort.data$TRTGR=="Treated",]
n.Colon.trtd<-nrow(tissinvol.trtd[tissinvol.trtd$tissinvol=="Colon",])
n.Colon.trtd <- signif(n.Colon.trtd/N_trtd*100, 3)
n.Colon_Ileum.trtd<-nrow(tissinvol.trtd[tissinvol.trtd$tissinvol=="Colon_Ileum",])
n.Colon_Ileum.trtd <- signif(n.Colon_Ileum.trtd/N_trtd*100, 3)
n.Ileum.trtd<-nrow(tissinvol.trtd[tissinvol.trtd$tissinvol=="Ileum",])
n.Ileum.trtd <- signif(n.Ileum.trtd/N_trtd*100, 3)

tissinvol_trtd<-toString(c(n.Colon.trtd, "/", n.Colon_Ileum.trtd, "/", n.Ileum.trtd))
tissinvol_trtd<-gsub(",", "", tissinvol_trtd)
tissinvol_trtd<-gsub(" ", "", tissinvol_trtd)

tissinvol.plac<-tissinvol.cohort.data[tissinvol.cohort.data$TRTGR=="Placebo",]
n.Colon.plac<-nrow(tissinvol.plac[tissinvol.plac$tissinvol=="Colon",])
n.Colon.plac <- signif(n.Colon.plac/N_plac*100, 3)
n.Colon_Ileum.plac<-nrow(tissinvol.plac[tissinvol.plac$tissinvol=="Colon_Ileum",])
n.Colon_Ileum.plac <- signif(n.Colon_Ileum.plac/N_plac*100, 3)
n.Ileum.plac<-nrow(tissinvol.plac[tissinvol.plac$tissinvol=="Ileum",])
n.Ileum.plac <- signif(n.Ileum.plac/N_plac*100, 3)


tissinvol_plac<-toString(c(n.Colon.plac, "/", n.Colon_Ileum.plac, "/", n.Ileum.plac))
tissinvol_plac<-gsub(",", "", tissinvol_plac)
tissinvol_plac<-gsub(" ", "", tissinvol_plac)

tissinvol.cohort<- matrix(c('Tissue Involvement (%) \nColon/Ileocolic/Ileal', tissinvol_trtd, tissinvol_plac, tissinvol_total), ncol = 4)

source("../code/Table1_baseline_metadata.R")
source('../code/Supptable1.cohortdiv.R')
