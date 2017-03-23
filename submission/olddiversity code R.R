old R for diversity

set.seed(32016)
# all.RESPONSEwk6.wilcox.test.data<-na.omit(subset(nao.screen_data, select= c(group, invsimpson, RESPONSEwk6)))
# all.RESPONSEwk6.kw.test.data<-na.omit(subset(nao.screen_data, select= c(group, invsimpson, RESPONSEwk6, TRTGR)))
# all.RESPONSEwk6.kw.test <- kruskal.test(invsimpson ~ RESPONSEwk6 all.RESPONSEwk6.kw.test.data)
# all.n.YesRESPONSEwk6.wilcoxtest<-nrow(all.RESPONSEwk6.wilcox.test.data[all.RESPONSEwk6.wilcox.test.data$RESPONSEwk6=="Yes",])
# all.n.YesRESPONSEwk6.wilcoxtest
# all.n.NoRESPONSEwk6.wilcoxtest<-nrow(all.RESPONSEwk6.wilcox.test.data[all.RESPONSEwk6.wilcox.test.data$RESPONSEwk6=="No",])
# all.n.NoRESPONSEwk6.wilcoxtest
# all.wilcox.RESPONSEwk6<-wilcox.test(invsimpson ~ RESPONSEwk6, all.RESPONSEwk6.wilcox.test.data)
# all.wilcox.RESPONSEwk6
# all.wilcox.RESPONSEwk6.pval<-signif(all.wilcox.RESPONSEwk6$p.value, digits = 2)
# all.wilcox.RESPONSEwk6.pval
# 
# set.seed(32016)
# all.RESPONSEwk6.adonis<-adonis(nao.screen.all.dist ~ RESPONSEwk6, nao.screen_data)
# all.RESPONSEwk6.adonis
# all.RESPONSEwk6.adonis.pval<-signif(as.numeric(na.omit(all.RESPONSEwk6.adonis$aov.tab$`Pr(>F)`)), digits = 2)
# 
# all.YesRESPONSEwk6<-toString(c(all.n.YesRESPONSEwk6.wilcoxtest))
# all.YesRESPONSEwk6<-gsub(",", "", all.YesRESPONSEwk6)
# all.YesRESPONSEwk6<-gsub(" ", "", all.YesRESPONSEwk6)
# all.NoRESPONSEwk6<-toString(c(all.n.NoRESPONSEwk6.wilcoxtest))
# all.NoRESPONSEwk6<-gsub(",", "", all.NoRESPONSEwk6)
# all.NoRESPONSEwk6<-gsub(" ", "", all.NoRESPONSEwk6)
# 
# all.RESPONSEwk6_sum<-toString(c(all.NoRESPONSEwk6, all.YesRESPONSEwk6))
# all.RESPONSEwk6_wilcox_P<-toString(c(all.wilcox.RESPONSEwk6.pval))
# all.RESPONSEwk6_wilcox_P<-gsub(",", "", all.RESPONSEwk6_wilcox_P)
# all.RESPONSEwk6_wilcox_P<-gsub(" ", "", all.RESPONSEwk6_wilcox_P)
# 
# 
# all.RESPONSEwk6_AMOVA_p<-toString(c(all.RESPONSEwk6.adonis.pval))
# all.RESPONSEwk6_AMOVA_p<-gsub(",", "", all.RESPONSEwk6_AMOVA_p)
# all.RESPONSEwk6_AMOVA_p<-gsub(" ", "", all.RESPONSEwk6_AMOVA_p)
# all.RESPONSEwk6_AMOVA<-toString(c(all.RESPONSEwk6_AMOVA_p))
# all.RESPONSEwk6_AMOVA<-gsub(",", "", all.RESPONSEwk6_AMOVA)
# all.RESPONSEwk6<-matrix(c('RESPONSEwk6', all.RESPONSEwk6_sum, all.RESPONSEwk6_wilcox_P, all.RESPONSEwk6_AMOVA), ncol = 4)
# 
# set.seed(32016)
# trtd.RESPONSEwk6.wilcox.test.data<-na.omit(subset(nao.screen.trtd, select= c(group, invsimpson, RESPONSEwk6)))
# trtd.n.YesRESPONSEwk6.wilcoxtest<-nrow(trtd.RESPONSEwk6.wilcox.test.data[trtd.RESPONSEwk6.wilcox.test.data$RESPONSEwk6=="Yes",])
# trtd.n.YesRESPONSEwk6.wilcoxtest
# trtd.n.NoRESPONSEwk6.wilcoxtest<-nrow(trtd.RESPONSEwk6.wilcox.test.data[trtd.RESPONSEwk6.wilcox.test.data$RESPONSEwk6=="No",])
# trtd.n.NoRESPONSEwk6.wilcoxtest
# trtd.wilcox.RESPONSEwk6<-wilcox.test(invsimpson ~ RESPONSEwk6, trtd.RESPONSEwk6.wilcox.test.data)
# trtd.wilcox.RESPONSEwk6
# trtd.wilcox.RESPONSEwk6.pval<-signif(trtd.wilcox.RESPONSEwk6$p.value, digits = 2)
# trtd.wilcox.RESPONSEwk6.pval
# 
# set.seed(32016)
# trtd.RESPONSEwk6.adonis<-adonis(nao.screen.trtd.dist ~ RESPONSEwk6, nao.screen.trtd)
# trtd.RESPONSEwk6.adonis
# trtd.RESPONSEwk6.adonis.pval<-signif(as.numeric(na.omit(trtd.RESPONSEwk6.adonis$aov.tab$`Pr(>F)`)), digits = 2)
# 
# trtd.YesRESPONSEwk6<-toString(c(trtd.n.YesRESPONSEwk6.wilcoxtest))
# trtd.YesRESPONSEwk6<-gsub(",", "", trtd.YesRESPONSEwk6)
# trtd.YesRESPONSEwk6<-gsub(" ", "", trtd.YesRESPONSEwk6)
# trtd.NoRESPONSEwk6<-toString(c(trtd.n.NoRESPONSEwk6.wilcoxtest))
# trtd.NoRESPONSEwk6<-gsub(",", "", trtd.NoRESPONSEwk6)
# trtd.NoRESPONSEwk6<-gsub(" ", "", trtd.NoRESPONSEwk6)
# 
# trtd.RESPONSEwk6_sum<-toString(c(trtd.NoRESPONSEwk6, trtd.YesRESPONSEwk6))
# trtd.RESPONSEwk6_wilcox_P<-toString(c(trtd.wilcox.RESPONSEwk6.pval))
# trtd.RESPONSEwk6_wilcox_P<-gsub(",", "", trtd.RESPONSEwk6_wilcox_P)
# trtd.RESPONSEwk6_wilcox_P<-gsub(" ", "", trtd.RESPONSEwk6_wilcox_P)
# 
# 
# trtd.RESPONSEwk6_AMOVA_p<-toString(c(trtd.RESPONSEwk6.adonis.pval))
# trtd.RESPONSEwk6_AMOVA_p<-gsub(",", "", trtd.RESPONSEwk6_AMOVA_p)
# trtd.RESPONSEwk6_AMOVA_p<-gsub(" ", "", trtd.RESPONSEwk6_AMOVA_p)
# trtd.RESPONSEwk6_AMOVA<-toString(c(trtd.RESPONSEwk6_AMOVA_p))
# trtd.RESPONSEwk6_AMOVA<-gsub(",", "", trtd.RESPONSEwk6_AMOVA)
# trtd.RESPONSEwk6<-matrix(c('Treated', trtd.RESPONSEwk6_sum, trtd.RESPONSEwk6_wilcox_P, trtd.RESPONSEwk6_AMOVA), ncol = 4)
# 
# set.seed(32016)
# plac.RESPONSEwk6.wilcox.test.data<-na.omit(subset(nao.screen.plac, select= c(group, invsimpson, RESPONSEwk6)))
# plac.n.YesRESPONSEwk6.wilcoxtest<-nrow(plac.RESPONSEwk6.wilcox.test.data[plac.RESPONSEwk6.wilcox.test.data$RESPONSEwk6=="Yes",])
# plac.n.YesRESPONSEwk6.wilcoxtest
# plac.n.NoRESPONSEwk6.wilcoxtest<-nrow(plac.RESPONSEwk6.wilcox.test.data[plac.RESPONSEwk6.wilcox.test.data$RESPONSEwk6=="No",])
# plac.n.NoRESPONSEwk6.wilcoxtest
# plac.wilcox.RESPONSEwk6<-wilcox.test(invsimpson ~ RESPONSEwk6, plac.RESPONSEwk6.wilcox.test.data)
# plac.wilcox.RESPONSEwk6
# plac.wilcox.RESPONSEwk6.pval<-signif(plac.wilcox.RESPONSEwk6$p.value, digits = 2)
# plac.wilcox.RESPONSEwk6.pval
# 
# set.seed(32016)
# plac.RESPONSEwk6.adonis<-adonis(nao.screen.plac.dist ~ RESPONSEwk6, nao.screen.plac)
# plac.RESPONSEwk6.adonis
# plac.RESPONSEwk6.adonis.pval<-signif(as.numeric(na.omit(plac.RESPONSEwk6.adonis$aov.tab$`Pr(>F)`)), digits = 2)
# 
# plac.YesRESPONSEwk6<-toString(c(plac.n.YesRESPONSEwk6.wilcoxtest))
# plac.YesRESPONSEwk6<-gsub(",", "", plac.YesRESPONSEwk6)
# plac.YesRESPONSEwk6<-gsub(" ", "", plac.YesRESPONSEwk6)
# plac.NoRESPONSEwk6<-toString(c(plac.n.NoRESPONSEwk6.wilcoxtest))
# plac.NoRESPONSEwk6<-gsub(",", "", plac.NoRESPONSEwk6)
# plac.NoRESPONSEwk6<-gsub(" ", "", plac.NoRESPONSEwk6)
# 
# plac.RESPONSEwk6_sum<-toString(c(plac.NoRESPONSEwk6, plac.YesRESPONSEwk6))
# plac.RESPONSEwk6_wilcox_P<-toString(c(plac.wilcox.RESPONSEwk6.pval))
# plac.RESPONSEwk6_wilcox_P<-gsub(",", "", plac.RESPONSEwk6_wilcox_P)
# plac.RESPONSEwk6_wilcox_P<-gsub(" ", "", plac.RESPONSEwk6_wilcox_P)
# 
# 
# plac.RESPONSEwk6_AMOVA_p<-toString(c(plac.RESPONSEwk6.adonis.pval))
# plac.RESPONSEwk6_AMOVA_p<-gsub(",", "", plac.RESPONSEwk6_AMOVA_p)
# plac.RESPONSEwk6_AMOVA_p<-gsub(" ", "", plac.RESPONSEwk6_AMOVA_p)
# plac.RESPONSEwk6_AMOVA<-toString(c(plac.RESPONSEwk6_AMOVA_p))
# plac.RESPONSEwk6_AMOVA<-gsub(",", "", plac.RESPONSEwk6_AMOVA)
# plac.RESPONSEwk6<-matrix(c('Placebo', plac.RESPONSEwk6_sum, plac.RESPONSEwk6_wilcox_P, plac.RESPONSEwk6_AMOVA), ncol = 4)



set.seed(32016)
all.RelRSPwk6.wilcox.test.data<-na.omit(subset(nao.screen_data, select= c(group, invsimpson, RelRSPwk6)))

all.RelRSPwk6.kw.test.data<-na.omit(subset(nao.screen_data, select= c(group, invsimpson, RelRSPwk6, TRTGR)))
all.RelRSPwk6.kw.test.data$rRSPwk6TRTGR <- as.factor(paste(all.RelRSPwk6.kw.test.data$RelRSPwk6, all.RelRSPwk6.kw.test.data$TRTGR, sep = "_"))
all.RelRSPwk6.kw.test <- kruskal.test(all.RelRSPwk6.kw.test.data$invsimpson ~ all.RelRSPwk6.kw.test.data$rRSPwk6TRTGR, all.RelRSPwk6.kw.test.data)
all.RelRSPwk6.kw.test.pval <- all.RelRSPwk6.kw.test$p.value

# all.n.YesRelRSPwk6.wilcoxtest<-nrow(all.RelRSPwk6.wilcox.test.data[all.RelRSPwk6.wilcox.test.data$RelRSPwk6=="Yes",])
# all.n.YesRelRSPwk6.wilcoxtest
# all.n.NoRelRSPwk6.wilcoxtest<-nrow(all.RelRSPwk6.wilcox.test.data[all.RelRSPwk6.wilcox.test.data$RelRSPwk6=="No",])
# all.n.NoRelRSPwk6.wilcoxtest
# all.wilcox.RelRSPwk6<-wilcox.test(invsimpson ~ RelRSPwk6, all.RelRSPwk6.wilcox.test.data)
# all.wilcox.RelRSPwk6
# all.wilcox.RelRSPwk6.pval<-signif(all.wilcox.RelRSPwk6$p.value, digits = 2)
# all.wilcox.RelRSPwk6.pval

set.seed(32016)
all.RelRSPwk6.adonis<-adonis(nao.screen.all.dist ~ RelRSPwk6, nao.screen_data, strata=nao.screen_data$TRTGR)
all.RelRSPwk6.adonis
all.RelRSPwk6.adonis.pval<-signif(as.numeric(na.omit(all.RelRSPwk6.adonis$aov.tab$`Pr(>F)`)), digits = 2)

all.YesRelRSPwk6<-toString(c(all.n.YesRelRSPwk6.wilcoxtest))
all.YesRelRSPwk6<-gsub(",", "", all.YesRelRSPwk6)
all.YesRelRSPwk6<-gsub(" ", "", all.YesRelRSPwk6)
all.NoRelRSPwk6<-toString(c(all.n.NoRelRSPwk6.wilcoxtest))
all.NoRelRSPwk6<-gsub(",", "", all.NoRelRSPwk6)
all.NoRelRSPwk6<-gsub(" ", "", all.NoRelRSPwk6)

all.RelRSPwk6_sum<-toString(c(all.NoRelRSPwk6, all.YesRelRSPwk6))
all.RelRSPwk6_wilcox_P<-toString(c(all.wilcox.RelRSPwk6.pval))
all.RelRSPwk6_wilcox_P<-gsub(",", "", all.RelRSPwk6_wilcox_P)
all.RelRSPwk6_wilcox_P<-gsub(" ", "", all.RelRSPwk6_wilcox_P)


all.RelRSPwk6_AMOVA_p<-toString(c(all.RelRSPwk6.adonis.pval))
all.RelRSPwk6_AMOVA_p<-gsub(",", "", all.RelRSPwk6_AMOVA_p)
all.RelRSPwk6_AMOVA_p<-gsub(" ", "", all.RelRSPwk6_AMOVA_p)
all.RelRSPwk6_AMOVA<-toString(c(all.RelRSPwk6_AMOVA_p))
all.RelRSPwk6_AMOVA<-gsub(",", "", all.RelRSPwk6_AMOVA)
all.RelRSPwk6<-matrix(c('Week 6 Response (Yes, No)', all.RelRSPwk6_sum, all.RelRSPwk6.kw.test.pval, all.RelRSPwk6_AMOVA), ncol = 4)

# set.seed(32016)
# trtd.RelRSPwk6.wilcox.test.data<-na.omit(subset(nao.screen.trtd, select= c(group, invsimpson, RelRSPwk6)))
# trtd.n.YesRelRSPwk6.wilcoxtest<-nrow(trtd.RelRSPwk6.wilcox.test.data[trtd.RelRSPwk6.wilcox.test.data$RelRSPwk6=="Yes",])
# trtd.n.YesRelRSPwk6.wilcoxtest
# trtd.n.NoRelRSPwk6.wilcoxtest<-nrow(trtd.RelRSPwk6.wilcox.test.data[trtd.RelRSPwk6.wilcox.test.data$RelRSPwk6=="No",])
# trtd.n.NoRelRSPwk6.wilcoxtest
# trtd.wilcox.RelRSPwk6<-wilcox.test(invsimpson ~ RelRSPwk6, trtd.RelRSPwk6.wilcox.test.data)
# trtd.wilcox.RelRSPwk6
# trtd.wilcox.RelRSPwk6.pval<-signif(trtd.wilcox.RelRSPwk6$p.value, digits = 2)
# trtd.wilcox.RelRSPwk6.pval
# 
# set.seed(32016)
# trtd.RelRSPwk6.adonis<-adonis(nao.screen.trtd.dist ~ RelRSPwk6, nao.screen.trtd)
# trtd.RelRSPwk6.adonis
# trtd.RelRSPwk6.adonis.pval<-signif(as.numeric(na.omit(trtd.RelRSPwk6.adonis$aov.tab$`Pr(>F)`)), digits = 2)
# 
# trtd.YesRelRSPwk6<-toString(c(trtd.n.YesRelRSPwk6.wilcoxtest))
# trtd.YesRelRSPwk6<-gsub(",", "", trtd.YesRelRSPwk6)
# trtd.YesRelRSPwk6<-gsub(" ", "", trtd.YesRelRSPwk6)
# trtd.NoRelRSPwk6<-toString(c(trtd.n.NoRelRSPwk6.wilcoxtest))
# trtd.NoRelRSPwk6<-gsub(",", "", trtd.NoRelRSPwk6)
# trtd.NoRelRSPwk6<-gsub(" ", "", trtd.NoRelRSPwk6)
# 
# trtd.RelRSPwk6_sum<-toString(c(trtd.NoRelRSPwk6, trtd.YesRelRSPwk6))
# trtd.RelRSPwk6_wilcox_P<-toString(c(trtd.wilcox.RelRSPwk6.pval))
# trtd.RelRSPwk6_wilcox_P<-gsub(",", "", trtd.RelRSPwk6_wilcox_P)
# trtd.RelRSPwk6_wilcox_P<-gsub(" ", "", trtd.RelRSPwk6_wilcox_P)
# 
# 
# trtd.RelRSPwk6_AMOVA_p<-toString(c(trtd.RelRSPwk6.adonis.pval))
# trtd.RelRSPwk6_AMOVA_p<-gsub(",", "", trtd.RelRSPwk6_AMOVA_p)
# trtd.RelRSPwk6_AMOVA_p<-gsub(" ", "", trtd.RelRSPwk6_AMOVA_p)
# trtd.RelRSPwk6_AMOVA<-toString(c(trtd.RelRSPwk6_AMOVA_p))
# trtd.RelRSPwk6_AMOVA<-gsub(",", "", trtd.RelRSPwk6_AMOVA)
# trtd.RelRSPwk6<-matrix(c('Treated', trtd.RelRSPwk6_sum, trtd.RelRSPwk6_wilcox_P, trtd.RelRSPwk6_AMOVA), ncol = 4)
# 
# set.seed(32016)
# plac.RelRSPwk6.wilcox.test.data<-na.omit(subset(nao.screen.plac, select= c(group, invsimpson, RelRSPwk6)))
# plac.n.YesRelRSPwk6.wilcoxtest<-nrow(plac.RelRSPwk6.wilcox.test.data[plac.RelRSPwk6.wilcox.test.data$RelRSPwk6=="Yes",])
# plac.n.YesRelRSPwk6.wilcoxtest
# plac.n.NoRelRSPwk6.wilcoxtest<-nrow(plac.RelRSPwk6.wilcox.test.data[plac.RelRSPwk6.wilcox.test.data$RelRSPwk6=="No",])
# plac.n.NoRelRSPwk6.wilcoxtest
# plac.wilcox.RelRSPwk6<-wilcox.test(invsimpson ~ RelRSPwk6, plac.RelRSPwk6.wilcox.test.data)
# plac.wilcox.RelRSPwk6
# plac.wilcox.RelRSPwk6.pval<-signif(plac.wilcox.RelRSPwk6$p.value, digits = 2)
# plac.wilcox.RelRSPwk6.pval
# 
# set.seed(32016)
# plac.RelRSPwk6.adonis<-adonis(nao.screen.plac.dist ~ RelRSPwk6, nao.screen.plac)
# plac.RelRSPwk6.adonis
# plac.RelRSPwk6.adonis.pval<-signif(as.numeric(na.omit(plac.RelRSPwk6.adonis$aov.tab$`Pr(>F)`)), digits = 2)
# 
# plac.YesRelRSPwk6<-toString(c(plac.n.YesRelRSPwk6.wilcoxtest))
# plac.YesRelRSPwk6<-gsub(",", "", plac.YesRelRSPwk6)
# plac.YesRelRSPwk6<-gsub(" ", "", plac.YesRelRSPwk6)
# plac.NoRelRSPwk6<-toString(c(plac.n.NoRelRSPwk6.wilcoxtest))
# plac.NoRelRSPwk6<-gsub(",", "", plac.NoRelRSPwk6)
# plac.NoRelRSPwk6<-gsub(" ", "", plac.NoRelRSPwk6)
# 
# plac.RelRSPwk6_sum<-toString(c(plac.NoRelRSPwk6, plac.YesRelRSPwk6))
# plac.RelRSPwk6_wilcox_P<-toString(c(plac.wilcox.RelRSPwk6.pval))
# plac.RelRSPwk6_wilcox_P<-gsub(",", "", plac.RelRSPwk6_wilcox_P)
# plac.RelRSPwk6_wilcox_P<-gsub(" ", "", plac.RelRSPwk6_wilcox_P)
# 
# 
# plac.RelRSPwk6_AMOVA_p<-toString(c(plac.RelRSPwk6.adonis.pval))
# plac.RelRSPwk6_AMOVA_p<-gsub(",", "", plac.RelRSPwk6_AMOVA_p)
# plac.RelRSPwk6_AMOVA_p<-gsub(" ", "", plac.RelRSPwk6_AMOVA_p)
# plac.RelRSPwk6_AMOVA<-toString(c(plac.RelRSPwk6_AMOVA_p))
# plac.RelRSPwk6_AMOVA<-gsub(",", "", plac.RelRSPwk6_AMOVA)
# plac.RelRSPwk6<-matrix(c('Placebo', plac.RelRSPwk6_sum, plac.RelRSPwk6_wilcox_P, plac.RelRSPwk6_AMOVA), ncol = 4)



set.seed(32016)
all.REMISSwk6.wilcox.test.data<-na.omit(subset(nao.screen_data, select= c(group, invsimpson, REMISSwk6)))

all.REMISSwk6.kw.test.data<-na.omit(subset(nao.screen_data, select= c(group, invsimpson, REMISSwk6, TRTGR)))
all.REMISSwk6.kw.test.data$REMwk6TRTGR <- as.factor(paste(all.REMISSwk6.kw.test.data$REMISSwk6, all.REMISSwk6.kw.test.data$TRTGR, sep = "_"))
all.REMISSwk6.kw.test <- kruskal.test(all.REMISSwk6.kw.test.data$invsimpson ~ all.REMISSwk6.kw.test.data$REMwk6TRTGR, all.REMISSwk6.kw.test.data)
all.REMISSwk6.kw.test
all.REMISSwk6.kw.test.pval <- all.REMISSwk6.kw.test$p.value
all.REMISSwk6.kwmc.test <- kruskalmc(all.REMISSwk6.kw.test.data$invsimpson ~ all.REMISSwk6.kw.test.data$REMwk6TRTGR, all.REMISSwk6.kw.test.data)
all.REMISSwk6.kwmc.test
all.n.YesREMISSwk6.wilcoxtest<-nrow(all.REMISSwk6.wilcox.test.data[all.REMISSwk6.wilcox.test.data$REMISSwk6=="Yes",])
all.n.YesREMISSwk6.wilcoxtest
all.n.NoREMISSwk6.wilcoxtest<-nrow(all.REMISSwk6.wilcox.test.data[all.REMISSwk6.wilcox.test.data$REMISSwk6=="No",])
all.n.NoREMISSwk6.wilcoxtest
all.wilcox.REMISSwk6<-wilcox.test(invsimpson ~ REMISSwk6, all.REMISSwk6.wilcox.test.data)
all.wilcox.REMISSwk6
all.wilcox.REMISSwk6.pval<-signif(all.wilcox.REMISSwk6$p.value, digits = 2)
all.wilcox.REMISSwk6.pval

set.seed(32016)
all.REMISSwk6.adonis<-adonis(nao.screen.all.dist ~ REMISSwk6, nao.screen_data, strata=nao.screen_data$TRTGR)
all.REMISSwk6.adonis
all.REMISSwk6.adonis.pval<-signif(as.numeric(na.omit(all.REMISSwk6.adonis$aov.tab$`Pr(>F)`)), digits = 2)

# all.REMISSwk6.adonis<-adonis(nao.screen.all.dist ~ REMISSwk6, nao.screen_data)
# all.REMISSwk6.adonis
# all.REMISSwk6.adonis.pval<-signif(as.numeric(na.omit(all.REMISSwk6.adonis$aov.tab$`Pr(>F)`)), digits = 2)

all.YesREMISSwk6<-toString(c(all.n.YesREMISSwk6.wilcoxtest))
all.YesREMISSwk6<-gsub(",", "", all.YesREMISSwk6)
all.YesREMISSwk6<-gsub(" ", "", all.YesREMISSwk6)
all.NoREMISSwk6<-toString(c(all.n.NoREMISSwk6.wilcoxtest))
all.NoREMISSwk6<-gsub(",", "", all.NoREMISSwk6)
all.NoREMISSwk6<-gsub(" ", "", all.NoREMISSwk6)

all.REMISSwk6_sum<-toString(c(all.NoREMISSwk6, all.YesREMISSwk6))
all.REMISSwk6_wilcox_P<-toString(c(all.wilcox.REMISSwk6.pval))
all.REMISSwk6_wilcox_P<-gsub(",", "", all.REMISSwk6_wilcox_P)
all.REMISSwk6_wilcox_P<-gsub(" ", "", all.REMISSwk6_wilcox_P)


all.REMISSwk6_AMOVA_p<-toString(c(all.REMISSwk6.adonis.pval))
all.REMISSwk6_AMOVA_p<-gsub(",", "", all.REMISSwk6_AMOVA_p)
all.REMISSwk6_AMOVA_p<-gsub(" ", "", all.REMISSwk6_AMOVA_p)
all.REMISSwk6_AMOVA<-toString(c(all.REMISSwk6_AMOVA_p))
all.REMISSwk6_AMOVA<-gsub(",", "", all.REMISSwk6_AMOVA)
all.REMISSwk6<-matrix(c('Week 6 Remission (Yes, No)', all.REMISSwk6_sum, all.REMISSwk6.kw.test.pval, all.REMISSwk6_AMOVA), ncol = 4)

# set.seed(32016)
# trtd.REMISSwk6.wilcox.test.data<-na.omit(subset(nao.screen.trtd, select= c(group, invsimpson, REMISSwk6)))
# trtd.n.YesREMISSwk6.wilcoxtest<-nrow(trtd.REMISSwk6.wilcox.test.data[trtd.REMISSwk6.wilcox.test.data$REMISSwk6=="Yes",])
# trtd.n.YesREMISSwk6.wilcoxtest
# trtd.n.NoREMISSwk6.wilcoxtest<-nrow(trtd.REMISSwk6.wilcox.test.data[trtd.REMISSwk6.wilcox.test.data$REMISSwk6=="No",])
# trtd.n.NoREMISSwk6.wilcoxtest
# trtd.wilcox.REMISSwk6<-wilcox.test(invsimpson ~ REMISSwk6, trtd.REMISSwk6.wilcox.test.data)
# trtd.wilcox.REMISSwk6
# trtd.wilcox.REMISSwk6.pval<-signif(trtd.wilcox.REMISSwk6$p.value, digits = 2)
# trtd.wilcox.REMISSwk6.pval
# 
# set.seed(32016)
# trtd.REMISSwk6.adonis<-adonis(nao.screen.trtd.dist ~ REMISSwk6, nao.screen.trtd)
# trtd.REMISSwk6.adonis
# trtd.REMISSwk6.adonis.pval<-signif(as.numeric(na.omit(trtd.REMISSwk6.adonis$aov.tab$`Pr(>F)`)), digits = 2)
# 
# trtd.YesREMISSwk6<-toString(c(trtd.n.YesREMISSwk6.wilcoxtest))
# trtd.YesREMISSwk6<-gsub(",", "", trtd.YesREMISSwk6)
# trtd.YesREMISSwk6<-gsub(" ", "", trtd.YesREMISSwk6)
# trtd.NoREMISSwk6<-toString(c(trtd.n.NoREMISSwk6.wilcoxtest))
# trtd.NoREMISSwk6<-gsub(",", "", trtd.NoREMISSwk6)
# trtd.NoREMISSwk6<-gsub(" ", "", trtd.NoREMISSwk6)
# 
# trtd.REMISSwk6_sum<-toString(c(trtd.NoREMISSwk6, trtd.YesREMISSwk6))
# trtd.REMISSwk6_wilcox_P<-toString(c(trtd.wilcox.REMISSwk6.pval))
# trtd.REMISSwk6_wilcox_P<-gsub(",", "", trtd.REMISSwk6_wilcox_P)
# trtd.REMISSwk6_wilcox_P<-gsub(" ", "", trtd.REMISSwk6_wilcox_P)
# 
# 
# trtd.REMISSwk6_AMOVA_p<-toString(c(trtd.REMISSwk6.adonis.pval))
# trtd.REMISSwk6_AMOVA_p<-gsub(",", "", trtd.REMISSwk6_AMOVA_p)
# trtd.REMISSwk6_AMOVA_p<-gsub(" ", "", trtd.REMISSwk6_AMOVA_p)
# trtd.REMISSwk6_AMOVA<-toString(c(trtd.REMISSwk6_AMOVA_p))
# trtd.REMISSwk6_AMOVA<-gsub(",", "", trtd.REMISSwk6_AMOVA)
# trtd.REMISSwk6<-matrix(c('Treated', trtd.REMISSwk6_sum, trtd.REMISSwk6_wilcox_P, trtd.REMISSwk6_AMOVA), ncol = 4)
# 
# set.seed(32016)
# plac.REMISSwk6.wilcox.test.data<-na.omit(subset(nao.screen.plac, select= c(group, invsimpson, REMISSwk6)))
# plac.n.YesREMISSwk6.wilcoxtest<-nrow(plac.REMISSwk6.wilcox.test.data[plac.REMISSwk6.wilcox.test.data$REMISSwk6=="Yes",])
# plac.n.YesREMISSwk6.wilcoxtest
# plac.n.NoREMISSwk6.wilcoxtest<-nrow(plac.REMISSwk6.wilcox.test.data[plac.REMISSwk6.wilcox.test.data$REMISSwk6=="No",])
# plac.n.NoREMISSwk6.wilcoxtest
# plac.wilcox.REMISSwk6<-wilcox.test(invsimpson ~ REMISSwk6, plac.REMISSwk6.wilcox.test.data)
# plac.wilcox.REMISSwk6
# plac.wilcox.REMISSwk6.pval<-signif(plac.wilcox.REMISSwk6$p.value, digits = 2)
# plac.wilcox.REMISSwk6.pval
# 
# set.seed(32016)
# plac.REMISSwk6.adonis<-adonis(nao.screen.plac.dist ~ REMISSwk6, nao.screen.plac)
# plac.REMISSwk6.adonis
# plac.REMISSwk6.adonis.pval<-signif(as.numeric(na.omit(plac.REMISSwk6.adonis$aov.tab$`Pr(>F)`)), digits = 2)
# 
# plac.YesREMISSwk6<-toString(c(plac.n.YesREMISSwk6.wilcoxtest))
# plac.YesREMISSwk6<-gsub(",", "", plac.YesREMISSwk6)
# plac.YesREMISSwk6<-gsub(" ", "", plac.YesREMISSwk6)
# plac.NoREMISSwk6<-toString(c(plac.n.NoREMISSwk6.wilcoxtest))
# plac.NoREMISSwk6<-gsub(",", "", plac.NoREMISSwk6)
# plac.NoREMISSwk6<-gsub(" ", "", plac.NoREMISSwk6)
# 
# plac.REMISSwk6_sum<-toString(c(plac.NoREMISSwk6, plac.YesREMISSwk6))
# plac.REMISSwk6_wilcox_P<-toString(c(plac.wilcox.REMISSwk6.pval))
# plac.REMISSwk6_wilcox_P<-gsub(",", "", plac.REMISSwk6_wilcox_P)
# plac.REMISSwk6_wilcox_P<-gsub(" ", "", plac.REMISSwk6_wilcox_P)
# 
# 
# plac.REMISSwk6_AMOVA_p<-toString(c(plac.REMISSwk6.adonis.pval))
# plac.REMISSwk6_AMOVA_p<-gsub(",", "", plac.REMISSwk6_AMOVA_p)
# plac.REMISSwk6_AMOVA_p<-gsub(" ", "", plac.REMISSwk6_AMOVA_p)
# plac.REMISSwk6_AMOVA<-toString(c(plac.REMISSwk6_AMOVA_p))
# plac.REMISSwk6_AMOVA<-gsub(",", "", plac.REMISSwk6_AMOVA)
# plac.REMISSwk6<-matrix(c('Placebo', plac.REMISSwk6_sum, plac.REMISSwk6_wilcox_P, plac.REMISSwk6_AMOVA), ncol = 4)
# 
# 
# all.RESPONSEwk6
# trtd.RESPONSEwk6
# plac.RESPONSEwk6
# all.RelRSPwk6
# trtd.RelRSPwk6
# plac.RelRSPwk6
# all.REMISSwk6
# trtd.REMISSwk6
# plac.REMISSwk6
```

```{r wk22-diversity, include=F}
set.seed(32016)
# all.RESPONSEwk22.wilcox.test.data<-na.omit(subset(nao.screen_data, select= c(group, invsimpson, RESPONSEwk22)))
# 
# 
# all.n.YesRESPONSEwk22.wilcoxtest<-nrow(all.RESPONSEwk22.wilcox.test.data[all.RESPONSEwk22.wilcox.test.data$RESPONSEwk22=="Yes",])
# all.n.YesRESPONSEwk22.wilcoxtest
# all.n.NoRESPONSEwk22.wilcoxtest<-nrow(all.RESPONSEwk22.wilcox.test.data[all.RESPONSEwk22.wilcox.test.data$RESPONSEwk22=="No",])
# all.n.NoRESPONSEwk22.wilcoxtest
# all.wilcox.RESPONSEwk22<-wilcox.test(invsimpson ~ RESPONSEwk22, all.RESPONSEwk22.wilcox.test.data)
# all.wilcox.RESPONSEwk22
# all.wilcox.RESPONSEwk22.pval<-signif(all.wilcox.RESPONSEwk22$p.value, digits = 2)
# all.wilcox.RESPONSEwk22.pval
# 
# set.seed(32016)
# 
# all.RESPONSEwk22.adonis<-adonis(nao.screen.all.dist ~ RESPONSEwk22, nao.screen_data)
# all.RESPONSEwk22.adonis
# all.RESPONSEwk22.adonis.pval<-signif(as.numeric(na.omit(all.RESPONSEwk22.adonis$aov.tab$`Pr(>F)`)), digits = 2)
# 
# all.YesRESPONSEwk22<-toString(c(all.n.YesRESPONSEwk22.wilcoxtest))
# all.YesRESPONSEwk22<-gsub(",", "", all.YesRESPONSEwk22)
# all.YesRESPONSEwk22<-gsub(" ", "", all.YesRESPONSEwk22)
# all.NoRESPONSEwk22<-toString(c(all.n.NoRESPONSEwk22.wilcoxtest))
# all.NoRESPONSEwk22<-gsub(",", "", all.NoRESPONSEwk22)
# all.NoRESPONSEwk22<-gsub(" ", "", all.NoRESPONSEwk22)
# 
# all.RESPONSEwk22_sum<-toString(c(all.NoRESPONSEwk22, all.YesRESPONSEwk22))
# all.RESPONSEwk22_wilcox_P<-toString(c(all.wilcox.RESPONSEwk22.pval))
# all.RESPONSEwk22_wilcox_P<-gsub(",", "", all.RESPONSEwk22_wilcox_P)
# all.RESPONSEwk22_wilcox_P<-gsub(" ", "", all.RESPONSEwk22_wilcox_P)
# 
# 
# all.RESPONSEwk22_AMOVA_p<-toString(c(all.RESPONSEwk22.adonis.pval))
# all.RESPONSEwk22_AMOVA_p<-gsub(",", "", all.RESPONSEwk22_AMOVA_p)
# all.RESPONSEwk22_AMOVA_p<-gsub(" ", "", all.RESPONSEwk22_AMOVA_p)
# all.RESPONSEwk22_AMOVA<-toString(c(all.RESPONSEwk22_AMOVA_p))
# all.RESPONSEwk22_AMOVA<-gsub(",", "", all.RESPONSEwk22_AMOVA)
# all.RESPONSEwk22<-matrix(c('RESPONSEwk22', all.RESPONSEwk22_sum, all.RESPONSEwk22_wilcox_P, all.RESPONSEwk22_AMOVA), ncol = 4)
# 
# set.seed(32016)
# trtd.RESPONSEwk22.wilcox.test.data<-na.omit(subset(nao.screen.trtd, select= c(group, invsimpson, RESPONSEwk22)))
# trtd.n.YesRESPONSEwk22.wilcoxtest<-nrow(trtd.RESPONSEwk22.wilcox.test.data[trtd.RESPONSEwk22.wilcox.test.data$RESPONSEwk22=="Yes",])
# trtd.n.YesRESPONSEwk22.wilcoxtest
# trtd.n.NoRESPONSEwk22.wilcoxtest<-nrow(trtd.RESPONSEwk22.wilcox.test.data[trtd.RESPONSEwk22.wilcox.test.data$RESPONSEwk22=="No",])
# trtd.n.NoRESPONSEwk22.wilcoxtest
# trtd.wilcox.RESPONSEwk22<-wilcox.test(invsimpson ~ RESPONSEwk22, trtd.RESPONSEwk22.wilcox.test.data)
# trtd.wilcox.RESPONSEwk22
# trtd.wilcox.RESPONSEwk22.pval<-signif(trtd.wilcox.RESPONSEwk22$p.value, digits = 2)
# trtd.wilcox.RESPONSEwk22.pval
# 
# set.seed(32016)
# trtd.RESPONSEwk22.adonis<-adonis(nao.screen.trtd.dist ~ RESPONSEwk22, nao.screen.trtd)
# trtd.RESPONSEwk22.adonis
# trtd.RESPONSEwk22.adonis.pval<-signif(as.numeric(na.omit(trtd.RESPONSEwk22.adonis$aov.tab$`Pr(>F)`)), digits = 2)
# 
# trtd.YesRESPONSEwk22<-toString(c(trtd.n.YesRESPONSEwk22.wilcoxtest))
# trtd.YesRESPONSEwk22<-gsub(",", "", trtd.YesRESPONSEwk22)
# trtd.YesRESPONSEwk22<-gsub(" ", "", trtd.YesRESPONSEwk22)
# trtd.NoRESPONSEwk22<-toString(c(trtd.n.NoRESPONSEwk22.wilcoxtest))
# trtd.NoRESPONSEwk22<-gsub(",", "", trtd.NoRESPONSEwk22)
# trtd.NoRESPONSEwk22<-gsub(" ", "", trtd.NoRESPONSEwk22)
# 
# trtd.RESPONSEwk22_sum<-toString(c(trtd.NoRESPONSEwk22, trtd.YesRESPONSEwk22))
# trtd.RESPONSEwk22_wilcox_P<-toString(c(trtd.wilcox.RESPONSEwk22.pval))
# trtd.RESPONSEwk22_wilcox_P<-gsub(",", "", trtd.RESPONSEwk22_wilcox_P)
# trtd.RESPONSEwk22_wilcox_P<-gsub(" ", "", trtd.RESPONSEwk22_wilcox_P)
# 
# 
# trtd.RESPONSEwk22_AMOVA_p<-toString(c(trtd.RESPONSEwk22.adonis.pval))
# trtd.RESPONSEwk22_AMOVA_p<-gsub(",", "", trtd.RESPONSEwk22_AMOVA_p)
# trtd.RESPONSEwk22_AMOVA_p<-gsub(" ", "", trtd.RESPONSEwk22_AMOVA_p)
# trtd.RESPONSEwk22_AMOVA<-toString(c(trtd.RESPONSEwk22_AMOVA_p))
# trtd.RESPONSEwk22_AMOVA<-gsub(",", "", trtd.RESPONSEwk22_AMOVA)
# trtd.RESPONSEwk22<-matrix(c('Treated', trtd.RESPONSEwk22_sum, trtd.RESPONSEwk22_wilcox_P, trtd.RESPONSEwk22_AMOVA), ncol = 4)
# 
# set.seed(32016)
# plac.RESPONSEwk22.wilcox.test.data<-na.omit(subset(nao.screen.plac, select= c(group, invsimpson, RESPONSEwk22)))
# plac.n.YesRESPONSEwk22.wilcoxtest<-nrow(plac.RESPONSEwk22.wilcox.test.data[plac.RESPONSEwk22.wilcox.test.data$RESPONSEwk22=="Yes",])
# plac.n.YesRESPONSEwk22.wilcoxtest
# plac.n.NoRESPONSEwk22.wilcoxtest<-nrow(plac.RESPONSEwk22.wilcox.test.data[plac.RESPONSEwk22.wilcox.test.data$RESPONSEwk22=="No",])
# plac.n.NoRESPONSEwk22.wilcoxtest
# plac.wilcox.RESPONSEwk22<-wilcox.test(invsimpson ~ RESPONSEwk22, plac.RESPONSEwk22.wilcox.test.data)
# plac.wilcox.RESPONSEwk22
# plac.wilcox.RESPONSEwk22.pval<-signif(plac.wilcox.RESPONSEwk22$p.value, digits = 2)
# plac.wilcox.RESPONSEwk22.pval
# 
# set.seed(32016)
# plac.RESPONSEwk22.adonis<-adonis(nao.screen.plac.dist ~ RESPONSEwk22, nao.screen.plac)
# plac.RESPONSEwk22.adonis
# plac.RESPONSEwk22.adonis.pval<-signif(as.numeric(na.omit(plac.RESPONSEwk22.adonis$aov.tab$`Pr(>F)`)), digits = 2)
# 
# plac.YesRESPONSEwk22<-toString(c(plac.n.YesRESPONSEwk22.wilcoxtest))
# plac.YesRESPONSEwk22<-gsub(",", "", plac.YesRESPONSEwk22)
# plac.YesRESPONSEwk22<-gsub(" ", "", plac.YesRESPONSEwk22)
# plac.NoRESPONSEwk22<-toString(c(plac.n.NoRESPONSEwk22.wilcoxtest))
# plac.NoRESPONSEwk22<-gsub(",", "", plac.NoRESPONSEwk22)
# plac.NoRESPONSEwk22<-gsub(" ", "", plac.NoRESPONSEwk22)
# 
# plac.RESPONSEwk22_sum<-toString(c(plac.NoRESPONSEwk22, plac.YesRESPONSEwk22))
# plac.RESPONSEwk22_wilcox_P<-toString(c(plac.wilcox.RESPONSEwk22.pval))
# plac.RESPONSEwk22_wilcox_P<-gsub(",", "", plac.RESPONSEwk22_wilcox_P)
# plac.RESPONSEwk22_wilcox_P<-gsub(" ", "", plac.RESPONSEwk22_wilcox_P)
# 
# 
# plac.RESPONSEwk22_AMOVA_p<-toString(c(plac.RESPONSEwk22.adonis.pval))
# plac.RESPONSEwk22_AMOVA_p<-gsub(",", "", plac.RESPONSEwk22_AMOVA_p)
# plac.RESPONSEwk22_AMOVA_p<-gsub(" ", "", plac.RESPONSEwk22_AMOVA_p)
# plac.RESPONSEwk22_AMOVA<-toString(c(plac.RESPONSEwk22_AMOVA_p))
# plac.RESPONSEwk22_AMOVA<-gsub(",", "", plac.RESPONSEwk22_AMOVA)
# plac.RESPONSEwk22<-matrix(c('Placebo', plac.RESPONSEwk22_sum, plac.RESPONSEwk22_wilcox_P, plac.RESPONSEwk22_AMOVA), ncol = 4)
# 


set.seed(32016)
all.RelRSPwk22.wilcox.test.data<-na.omit(subset(nao.screen_data, select= c(group, invsimpson, RelRSPwk22)))
all.RelRSPwk22.kw.test.data<-na.omit(subset(nao.screen_data, select= c(group, invsimpson, RelRSPwk22, TRTGRINDMAN)))
all.RelRSPwk22.kw.test.data$rRSPwk22TRTGRINDMAN <- as.factor(paste(all.RelRSPwk22.kw.test.data$RelRSPwk22, all.RelRSPwk22.kw.test.data$TRTGRINDMAN, sep = "_"))
all.RelRSPwk22.kw.test <- kruskal.test(all.RelRSPwk22.kw.test.data$invsimpson ~ all.RelRSPwk22.kw.test.data$rRSPwk22TRTGRINDMAN, all.RelRSPwk22.kw.test.data)
all.RelRSPwk22.kw.test.pval <- all.RelRSPwk22.kw.test$p.value


all.n.YesRelRSPwk22.wilcoxtest<-nrow(all.RelRSPwk22.wilcox.test.data[all.RelRSPwk22.wilcox.test.data$RelRSPwk22=="Yes",])
all.n.YesRelRSPwk22.wilcoxtest
all.n.NoRelRSPwk22.wilcoxtest<-nrow(all.RelRSPwk22.wilcox.test.data[all.RelRSPwk22.wilcox.test.data$RelRSPwk22=="No",])
all.n.NoRelRSPwk22.wilcoxtest
all.wilcox.RelRSPwk22<-wilcox.test(invsimpson ~ RelRSPwk22, all.RelRSPwk22.wilcox.test.data)
all.wilcox.RelRSPwk22
all.wilcox.RelRSPwk22.pval<-signif(all.wilcox.RelRSPwk22$p.value, digits = 2)
all.wilcox.RelRSPwk22.pval

set.seed(32016)
kruskalmc(nao.screen_data$invsimpson, nao.screen_data$RelRSPwk22, data=nao.screen_data)

set.seed(32016)
all.RelRSPwk22.adonis<-adonis(nao.screen.all.dist ~ RelRSPwk22, nao.screen_data, strata=nao.screen_data$TRTGRINDMAN)
all.RelRSPwk22.adonis
all.RelRSPwk22.adonis.pval<-signif(as.numeric(na.omit(all.RelRSPwk22.adonis$aov.tab$`Pr(>F)`)), digits = 2)

# all.RelRSPwk22.adonis<-adonis(nao.screen.all.dist ~ RelRSPwk22, nao.screen_data)
# all.RelRSPwk22.adonis
# all.RelRSPwk22.adonis.pval<-signif(as.numeric(na.omit(all.RelRSPwk22.adonis$aov.tab$`Pr(>F)`)), digits = 2)
# 
# set.seed(32016)
# all.RelRSPwk22.adonis<-adonis(nao.screen.all.dist ~ RelRSPwk22, nao.screen_data, strata = nao.screen_data$TRTGRINDMAN)
# all.RelRSPwk22.adonis
# 
# set.seed(32016)
# all.RelRSPwk22.adonis<-adonis(nao.screen.all.dist ~ RelRSPwk22*TRTGRINDMAN, nao.screen_data)
# all.RelRSPwk22.adonis

all.YesRelRSPwk22<-toString(c(all.n.YesRelRSPwk22.wilcoxtest))
all.YesRelRSPwk22<-gsub(",", "", all.YesRelRSPwk22)
all.YesRelRSPwk22<-gsub(" ", "", all.YesRelRSPwk22)
all.NoRelRSPwk22<-toString(c(all.n.NoRelRSPwk22.wilcoxtest))
all.NoRelRSPwk22<-gsub(",", "", all.NoRelRSPwk22)
all.NoRelRSPwk22<-gsub(" ", "", all.NoRelRSPwk22)

all.RelRSPwk22_sum<-toString(c(all.NoRelRSPwk22, all.YesRelRSPwk22))
all.RelRSPwk22_wilcox_P<-toString(c(all.wilcox.RelRSPwk22.pval))
all.RelRSPwk22_wilcox_P<-gsub(",", "", all.RelRSPwk22_wilcox_P)
all.RelRSPwk22_wilcox_P<-gsub(" ", "", all.RelRSPwk22_wilcox_P)


all.RelRSPwk22_AMOVA_p<-toString(c(all.RelRSPwk22.adonis.pval))
all.RelRSPwk22_AMOVA_p<-gsub(",", "", all.RelRSPwk22_AMOVA_p)
all.RelRSPwk22_AMOVA_p<-gsub(" ", "", all.RelRSPwk22_AMOVA_p)
all.RelRSPwk22_AMOVA<-toString(c(all.RelRSPwk22_AMOVA_p))
all.RelRSPwk22_AMOVA<-gsub(",", "", all.RelRSPwk22_AMOVA)
all.RelRSPwk22<-matrix(c('Week 22 Response (Yes, No)', all.RelRSPwk22_sum, all.RelRSPwk22_wilcox_P, all.RelRSPwk22_AMOVA), ncol = 4)

# set.seed(32016)
# trtd.RelRSPwk22.wilcox.test.data<-na.omit(subset(nao.screen.trtd, select= c(group, invsimpson, RelRSPwk22)))
# trtd.n.YesRelRSPwk22.wilcoxtest<-nrow(trtd.RelRSPwk22.wilcox.test.data[trtd.RelRSPwk22.wilcox.test.data$RelRSPwk22=="Yes",])
# trtd.n.YesRelRSPwk22.wilcoxtest
# trtd.n.NoRelRSPwk22.wilcoxtest<-nrow(trtd.RelRSPwk22.wilcox.test.data[trtd.RelRSPwk22.wilcox.test.data$RelRSPwk22=="No",])
# trtd.n.NoRelRSPwk22.wilcoxtest
# trtd.wilcox.RelRSPwk22<-wilcox.test(invsimpson ~ RelRSPwk22, trtd.RelRSPwk22.wilcox.test.data)
# trtd.wilcox.RelRSPwk22
# trtd.wilcox.RelRSPwk22.pval<-signif(trtd.wilcox.RelRSPwk22$p.value, digits = 2)
# trtd.wilcox.RelRSPwk22.pval
# 
# kruskalmc(nao.screen.trtd$invsimpson, nao.screen.trtd$RelRSPwk22, data=nao.screen.trtd)
# 
# set.seed(32016)
# trtd.RelRSPwk22.adonis<-adonis(nao.screen.trtd.dist ~ RelRSPwk22, nao.screen.trtd)
# trtd.RelRSPwk22.adonis
# trtd.RelRSPwk22.adonis.pval<-signif(as.numeric(na.omit(trtd.RelRSPwk22.adonis$aov.tab$`Pr(>F)`)), digits = 2)
# 
# trtd.YesRelRSPwk22<-toString(c(trtd.n.YesRelRSPwk22.wilcoxtest))
# trtd.YesRelRSPwk22<-gsub(",", "", trtd.YesRelRSPwk22)
# trtd.YesRelRSPwk22<-gsub(" ", "", trtd.YesRelRSPwk22)
# trtd.NoRelRSPwk22<-toString(c(trtd.n.NoRelRSPwk22.wilcoxtest))
# trtd.NoRelRSPwk22<-gsub(",", "", trtd.NoRelRSPwk22)
# trtd.NoRelRSPwk22<-gsub(" ", "", trtd.NoRelRSPwk22)
# 
# trtd.RelRSPwk22_sum<-toString(c(trtd.NoRelRSPwk22, trtd.YesRelRSPwk22))
# trtd.RelRSPwk22_wilcox_P<-toString(c(trtd.wilcox.RelRSPwk22.pval))
# trtd.RelRSPwk22_wilcox_P<-gsub(",", "", trtd.RelRSPwk22_wilcox_P)
# trtd.RelRSPwk22_wilcox_P<-gsub(" ", "", trtd.RelRSPwk22_wilcox_P)
# 
# 
# trtd.RelRSPwk22_AMOVA_p<-toString(c(trtd.RelRSPwk22.adonis.pval))
# trtd.RelRSPwk22_AMOVA_p<-gsub(",", "", trtd.RelRSPwk22_AMOVA_p)
# trtd.RelRSPwk22_AMOVA_p<-gsub(" ", "", trtd.RelRSPwk22_AMOVA_p)
# trtd.RelRSPwk22_AMOVA<-toString(c(trtd.RelRSPwk22_AMOVA_p))
# trtd.RelRSPwk22_AMOVA<-gsub(",", "", trtd.RelRSPwk22_AMOVA)
# trtd.RelRSPwk22<-matrix(c('Treated', trtd.RelRSPwk22_sum, trtd.RelRSPwk22_wilcox_P, trtd.RelRSPwk22_AMOVA), ncol = 4)
# 
# set.seed(32016)
# plac.RelRSPwk22.wilcox.test.data<-na.omit(subset(nao.screen.plac, select= c(group, invsimpson, RelRSPwk22)))
# plac.n.YesRelRSPwk22.wilcoxtest<-nrow(plac.RelRSPwk22.wilcox.test.data[plac.RelRSPwk22.wilcox.test.data$RelRSPwk22=="Yes",])
# plac.n.YesRelRSPwk22.wilcoxtest
# plac.n.NoRelRSPwk22.wilcoxtest<-nrow(plac.RelRSPwk22.wilcox.test.data[plac.RelRSPwk22.wilcox.test.data$RelRSPwk22=="No",])
# plac.n.NoRelRSPwk22.wilcoxtest
# plac.wilcox.RelRSPwk22<-wilcox.test(invsimpson ~ RelRSPwk22, plac.RelRSPwk22.wilcox.test.data)
# plac.wilcox.RelRSPwk22
# plac.wilcox.RelRSPwk22.pval<-signif(plac.wilcox.RelRSPwk22$p.value, digits = 2)
# plac.wilcox.RelRSPwk22.pval
# 
# set.seed(32016)
# plac.RelRSPwk22.adonis<-adonis(nao.screen.plac.dist ~ RelRSPwk22, nao.screen.plac)
# plac.RelRSPwk22.adonis
# plac.RelRSPwk22.adonis.pval<-signif(as.numeric(na.omit(plac.RelRSPwk22.adonis$aov.tab$`Pr(>F)`)), digits = 2)
# 
# plac.YesRelRSPwk22<-toString(c(plac.n.YesRelRSPwk22.wilcoxtest))
# plac.YesRelRSPwk22<-gsub(",", "", plac.YesRelRSPwk22)
# plac.YesRelRSPwk22<-gsub(" ", "", plac.YesRelRSPwk22)
# plac.NoRelRSPwk22<-toString(c(plac.n.NoRelRSPwk22.wilcoxtest))
# plac.NoRelRSPwk22<-gsub(",", "", plac.NoRelRSPwk22)
# plac.NoRelRSPwk22<-gsub(" ", "", plac.NoRelRSPwk22)
# 
# plac.RelRSPwk22_sum<-toString(c(plac.NoRelRSPwk22, plac.YesRelRSPwk22))
# plac.RelRSPwk22_wilcox_P<-toString(c(plac.wilcox.RelRSPwk22.pval))
# plac.RelRSPwk22_wilcox_P<-gsub(",", "", plac.RelRSPwk22_wilcox_P)
# plac.RelRSPwk22_wilcox_P<-gsub(" ", "", plac.RelRSPwk22_wilcox_P)
# 
# 
# plac.RelRSPwk22_AMOVA_p<-toString(c(plac.RelRSPwk22.adonis.pval))
# plac.RelRSPwk22_AMOVA_p<-gsub(",", "", plac.RelRSPwk22_AMOVA_p)
# plac.RelRSPwk22_AMOVA_p<-gsub(" ", "", plac.RelRSPwk22_AMOVA_p)
# plac.RelRSPwk22_AMOVA<-toString(c(plac.RelRSPwk22_AMOVA_p))
# plac.RelRSPwk22_AMOVA<-gsub(",", "", plac.RelRSPwk22_AMOVA)
# plac.RelRSPwk22<-matrix(c('Placebo', plac.RelRSPwk22_sum, plac.RelRSPwk22_wilcox_P, plac.RelRSPwk22_AMOVA), ncol = 4)



set.seed(32016)
all.REMISSwk22.wilcox.test.data<-na.omit(subset(nao.screen_data, select= c(group, invsimpson, REMISSwk22)))
all.REMISSwk22.kw.test.data<-na.omit(subset(nao.screen_data, select= c(group, invsimpson, REMISSwk22, TRTGRINDMAN)))
all.REMISSwk22.kw.test.data$REMwk6TRTGRINDMAN <- as.factor(paste(all.REMISSwk22.kw.test.data$REMISSwk22, all.REMISSwk22.kw.test.data$TRTGRINDMAN, sep = "_"))
all.REMISSwk22.kw.test <- kruskal.test(all.REMISSwk22.kw.test.data$invsimpson ~ all.REMISSwk22.kw.test.data$REMwk6TRTGRINDMAN, all.REMISSwk22.kw.test.data)
all.REMISSwk22.kw.test.pval <- all.REMISSwk22.kw.test$p.value

all.n.YesREMISSwk22.wilcoxtest<-nrow(all.REMISSwk22.wilcox.test.data[all.REMISSwk22.wilcox.test.data$REMISSwk22=="Yes",])
all.n.YesREMISSwk22.wilcoxtest
all.n.NoREMISSwk22.wilcoxtest<-nrow(all.REMISSwk22.wilcox.test.data[all.REMISSwk22.wilcox.test.data$REMISSwk22=="No",])
all.n.NoREMISSwk22.wilcoxtest
all.wilcox.REMISSwk22<-wilcox.test(invsimpson ~ REMISSwk22, all.REMISSwk22.wilcox.test.data)
all.wilcox.REMISSwk22
all.wilcox.REMISSwk22.pval<-signif(all.wilcox.REMISSwk22$p.value, digits = 2)
all.wilcox.REMISSwk22.pval

set.seed(32016)
all.REMISSwk22.adonis<-adonis(nao.screen.all.dist ~ REMISSwk22, nao.screen_data, strata=nao.screen_data$TRTGRINDMAN)
all.REMISSwk22.adonis
all.REMISSwk22.adonis.pval<-signif(as.numeric(na.omit(all.REMISSwk22.adonis$aov.tab$`Pr(>F)`)), digits = 2)

kruskalmc(nao.screen_data$invsimpson, nao.screen_data$REMISSwk22, data=nao.screen.trtd)

all.YesREMISSwk22<-toString(c(all.n.YesREMISSwk22.wilcoxtest))
all.YesREMISSwk22<-gsub(",", "", all.YesREMISSwk22)
all.YesREMISSwk22<-gsub(" ", "", all.YesREMISSwk22)
all.NoREMISSwk22<-toString(c(all.n.NoREMISSwk22.wilcoxtest))
all.NoREMISSwk22<-gsub(",", "", all.NoREMISSwk22)
all.NoREMISSwk22<-gsub(" ", "", all.NoREMISSwk22)

all.REMISSwk22_sum<-toString(c(all.NoREMISSwk22, all.YesREMISSwk22))
all.REMISSwk22_wilcox_P<-toString(c(all.wilcox.REMISSwk22.pval))
all.REMISSwk22_wilcox_P<-gsub(",", "", all.REMISSwk22_wilcox_P)
all.REMISSwk22_wilcox_P<-gsub(" ", "", all.REMISSwk22_wilcox_P)


all.REMISSwk22_AMOVA_p<-toString(c(all.REMISSwk22.adonis.pval))
all.REMISSwk22_AMOVA_p<-gsub(",", "", all.REMISSwk22_AMOVA_p)
all.REMISSwk22_AMOVA_p<-gsub(" ", "", all.REMISSwk22_AMOVA_p)
all.REMISSwk22_AMOVA<-toString(c(all.REMISSwk22_AMOVA_p))
all.REMISSwk22_AMOVA<-gsub(",", "", all.REMISSwk22_AMOVA)
all.REMISSwk22<-matrix(c('Week 22 Remission (Yes, No)', all.REMISSwk22_sum, all.REMISSwk22_wilcox_P, all.REMISSwk22_AMOVA), ncol = 4)

# set.seed(32016)
# trtd.REMISSwk22.wilcox.test.data<-na.omit(subset(nao.screen.trtd, select= c(group, invsimpson, REMISSwk22)))
# trtd.n.YesREMISSwk22.wilcoxtest<-nrow(trtd.REMISSwk22.wilcox.test.data[trtd.REMISSwk22.wilcox.test.data$REMISSwk22=="Yes",])
# trtd.n.YesREMISSwk22.wilcoxtest
# trtd.n.NoREMISSwk22.wilcoxtest<-nrow(trtd.REMISSwk22.wilcox.test.data[trtd.REMISSwk22.wilcox.test.data$REMISSwk22=="No",])
# trtd.n.NoREMISSwk22.wilcoxtest
# trtd.wilcox.REMISSwk22<-wilcox.test(invsimpson ~ REMISSwk22, trtd.REMISSwk22.wilcox.test.data)
# trtd.wilcox.REMISSwk22
# trtd.wilcox.REMISSwk22.pval<-signif(trtd.wilcox.REMISSwk22$p.value, digits = 2)
# trtd.wilcox.REMISSwk22.pval
# 
# set.seed(32016)
# trtd.REMISSwk22.adonis<-adonis(nao.screen.trtd.dist ~ REMISSwk22, nao.screen.trtd)
# trtd.REMISSwk22.adonis
# trtd.REMISSwk22.adonis.pval<-signif(as.numeric(na.omit(trtd.REMISSwk22.adonis$aov.tab$`Pr(>F)`)), digits = 2)
# 
# trtd.YesREMISSwk22<-toString(c(trtd.n.YesREMISSwk22.wilcoxtest))
# trtd.YesREMISSwk22<-gsub(",", "", trtd.YesREMISSwk22)
# trtd.YesREMISSwk22<-gsub(" ", "", trtd.YesREMISSwk22)
# trtd.NoREMISSwk22<-toString(c(trtd.n.NoREMISSwk22.wilcoxtest))
# trtd.NoREMISSwk22<-gsub(",", "", trtd.NoREMISSwk22)
# trtd.NoREMISSwk22<-gsub(" ", "", trtd.NoREMISSwk22)
# 
# trtd.REMISSwk22_sum<-toString(c(trtd.NoREMISSwk22, trtd.YesREMISSwk22))
# trtd.REMISSwk22_wilcox_P<-toString(c(trtd.wilcox.REMISSwk22.pval))
# trtd.REMISSwk22_wilcox_P<-gsub(",", "", trtd.REMISSwk22_wilcox_P)
# trtd.REMISSwk22_wilcox_P<-gsub(" ", "", trtd.REMISSwk22_wilcox_P)
# 
# 
# trtd.REMISSwk22_AMOVA_p<-toString(c(trtd.REMISSwk22.adonis.pval))
# trtd.REMISSwk22_AMOVA_p<-gsub(",", "", trtd.REMISSwk22_AMOVA_p)
# trtd.REMISSwk22_AMOVA_p<-gsub(" ", "", trtd.REMISSwk22_AMOVA_p)
# trtd.REMISSwk22_AMOVA<-toString(c(trtd.REMISSwk22_AMOVA_p))
# trtd.REMISSwk22_AMOVA<-gsub(",", "", trtd.REMISSwk22_AMOVA)
# trtd.REMISSwk22<-matrix(c('Treated', trtd.REMISSwk22_sum, trtd.REMISSwk22_wilcox_P, trtd.REMISSwk22_AMOVA), ncol = 4)
# 
# set.seed(32016)
# plac.REMISSwk22.wilcox.test.data<-na.omit(subset(nao.screen.plac, select= c(group, invsimpson, REMISSwk22)))
# plac.n.YesREMISSwk22.wilcoxtest<-nrow(plac.REMISSwk22.wilcox.test.data[plac.REMISSwk22.wilcox.test.data$REMISSwk22=="Yes",])
# plac.n.YesREMISSwk22.wilcoxtest
# plac.n.NoREMISSwk22.wilcoxtest<-nrow(plac.REMISSwk22.wilcox.test.data[plac.REMISSwk22.wilcox.test.data$REMISSwk22=="No",])
# plac.n.NoREMISSwk22.wilcoxtest
# plac.wilcox.REMISSwk22<-wilcox.test(invsimpson ~ REMISSwk22, plac.REMISSwk22.wilcox.test.data)
# plac.wilcox.REMISSwk22
# plac.wilcox.REMISSwk22.pval<-signif(plac.wilcox.REMISSwk22$p.value, digits = 2)
# plac.wilcox.REMISSwk22.pval
# 
# set.seed(32016)
# plac.REMISSwk22.adonis<-adonis(nao.screen.plac.dist ~ REMISSwk22, nao.screen.plac)
# plac.REMISSwk22.adonis
# plac.REMISSwk22.adonis.pval<-signif(as.numeric(na.omit(plac.REMISSwk22.adonis$aov.tab$`Pr(>F)`)), digits = 2)
# 
# plac.YesREMISSwk22<-toString(c(plac.n.YesREMISSwk22.wilcoxtest))
# plac.YesREMISSwk22<-gsub(",", "", plac.YesREMISSwk22)
# plac.YesREMISSwk22<-gsub(" ", "", plac.YesREMISSwk22)
# plac.NoREMISSwk22<-toString(c(plac.n.NoREMISSwk22.wilcoxtest))
# plac.NoREMISSwk22<-gsub(",", "", plac.NoREMISSwk22)
# plac.NoREMISSwk22<-gsub(" ", "", plac.NoREMISSwk22)
# 
# plac.REMISSwk22_sum<-toString(c(plac.NoREMISSwk22, plac.YesREMISSwk22))
# plac.REMISSwk22_wilcox_P<-toString(c(plac.wilcox.REMISSwk22.pval))
# plac.REMISSwk22_wilcox_P<-gsub(",", "", plac.REMISSwk22_wilcox_P)
# plac.REMISSwk22_wilcox_P<-gsub(" ", "", plac.REMISSwk22_wilcox_P)
# 
# 
# plac.REMISSwk22_AMOVA_p<-toString(c(plac.REMISSwk22.adonis.pval))
# plac.REMISSwk22_AMOVA_p<-gsub(",", "", plac.REMISSwk22_AMOVA_p)
# plac.REMISSwk22_AMOVA_p<-gsub(" ", "", plac.REMISSwk22_AMOVA_p)
# plac.REMISSwk22_AMOVA<-toString(c(plac.REMISSwk22_AMOVA_p))
# plac.REMISSwk22_AMOVA<-gsub(",", "", plac.REMISSwk22_AMOVA)
# plac.REMISSwk22<-matrix(c('Placebo', plac.REMISSwk22_sum, plac.REMISSwk22_wilcox_P, plac.REMISSwk22_AMOVA), ncol = 4)
# 
# 
# # all.RESPONSEwk22
# # trtd.RESPONSEwk22
# # plac.RESPONSEwk22
# all.RelRSPwk22
# trtd.RelRSPwk22
# plac.RelRSPwk22
# all.REMISSwk22
# trtd.REMISSwk22
# plac.REMISSwk22
# 
# 
# set.seed(32016)
# trtd_trtd.data<-nao.screen.trtd[nao.screen.trtd$TRTGRINDMAN=="Treated_Treated",]
# trtd_trtd.RelRSPwk22.wilcox.test.data<-na.omit(subset(trtd_trtd.data, select= c(group, invsimpson, RelRSPwk22)))
# trtd_trtd.n.YesRelRSPwk22.wilcoxtest<-nrow(trtd_trtd.RelRSPwk22.wilcox.test.data[trtd_trtd.RelRSPwk22.wilcox.test.data$RelRSPwk22=="Yes",])
# trtd_trtd.n.YesRelRSPwk22.wilcoxtest
# trtd_trtd.n.NoRelRSPwk22.wilcoxtest<-nrow(trtd_trtd.RelRSPwk22.wilcox.test.data[trtd_trtd.RelRSPwk22.wilcox.test.data$RelRSPwk22=="No",])
# trtd_trtd.n.NoRelRSPwk22.wilcoxtest
# trtd_trtd.wilcox.RelRSPwk22<-wilcox.test(invsimpson ~ RelRSPwk22, trtd_trtd.RelRSPwk22.wilcox.test.data)
# trtd_trtd.wilcox.RelRSPwk22
# trtd_trtd.wilcox.RelRSPwk22.pval<-signif(trtd_trtd.wilcox.RelRSPwk22$p.value, digits = 2)
# trtd_trtd.wilcox.RelRSPwk22.pval
# 
# set.seed(32016)
# trtd_trtd.RelRSPwk22.adonis<-adonis(trtd_trtd.data.dist ~ RelRSPwk22, trtd_trtd.data)
# trtd_trtd.RelRSPwk22.adonis
# trtd_trtd.RelRSPwk22.adonis.pval<-signif(as.numeric(na.omit(trtd_trtd.RelRSPwk22.adonis$aov.tab$`Pr(>F)`)), digits = 2)
# 
# trtd_trtd.YesRelRSPwk22<-toString(c(trtd_trtd.n.YesRelRSPwk22.wilcoxtest))
# trtd_trtd.YesRelRSPwk22<-gsub(",", "", trtd_trtd.YesRelRSPwk22)
# trtd_trtd.YesRelRSPwk22<-gsub(" ", "", trtd_trtd.YesRelRSPwk22)
# trtd_trtd.NoRelRSPwk22<-toString(c(trtd_trtd.n.NoRelRSPwk22.wilcoxtest))
# trtd_trtd.NoRelRSPwk22<-gsub(",", "", trtd_trtd.NoRelRSPwk22)
# trtd_trtd.NoRelRSPwk22<-gsub(" ", "", trtd_trtd.NoRelRSPwk22)
# 
# trtd_trtd.RelRSPwk22_sum<-toString(c(trtd_trtd.NoRelRSPwk22, trtd_trtd.YesRelRSPwk22))
# trtd_trtd.RelRSPwk22_wilcox_P<-toString(c(trtd_trtd.wilcox.RelRSPwk22.pval))
# trtd_trtd.RelRSPwk22_wilcox_P<-gsub(",", "", trtd_trtd.RelRSPwk22_wilcox_P)
# trtd_trtd.RelRSPwk22_wilcox_P<-gsub(" ", "", trtd_trtd.RelRSPwk22_wilcox_P)
# 
# 
# trtd_trtd.RelRSPwk22_AMOVA_p<-toString(c(trtd_trtd.RelRSPwk22.adonis.pval))
# trtd_trtd.RelRSPwk22_AMOVA_p<-gsub(",", "", trtd_trtd.RelRSPwk22_AMOVA_p)
# trtd_trtd.RelRSPwk22_AMOVA_p<-gsub(" ", "", trtd_trtd.RelRSPwk22_AMOVA_p)
# trtd_trtd.RelRSPwk22_AMOVA<-toString(c(trtd_trtd.RelRSPwk22_AMOVA_p))
# trtd_trtd.RelRSPwk22_AMOVA<-gsub(",", "", trtd_trtd.RelRSPwk22_AMOVA)
# trtd_trtd.RelRSPwk22<-matrix(c('Treated_Treated', trtd_trtd.RelRSPwk22_sum, trtd_trtd.RelRSPwk22_wilcox_P, trtd_trtd.RelRSPwk22_AMOVA), ncol = 4)
# 
# set.seed(32016)
# plac_plac.data<-nao.screen.plac[nao.screen.plac$TRTGRINDMAN=="Placebo_Placebo",]
# plac_plac.RelRSPwk22.wilcox.test.data<-na.omit(subset(plac_plac.data, select= c(group, invsimpson, RelRSPwk22)))
# plac_plac.n.YesRelRSPwk22.wilcoxtest<-nrow(plac_plac.RelRSPwk22.wilcox.test.data[plac_plac.RelRSPwk22.wilcox.test.data$RelRSPwk22=="Yes",])
# plac_plac.n.YesRelRSPwk22.wilcoxtest
# plac_plac.n.NoRelRSPwk22.wilcoxtest<-nrow(plac_plac.RelRSPwk22.wilcox.test.data[plac_plac.RelRSPwk22.wilcox.test.data$RelRSPwk22=="No",])
# plac_plac.n.NoRelRSPwk22.wilcoxtest
# plac_plac.wilcox.RelRSPwk22<-wilcox.test(invsimpson ~ RelRSPwk22, plac_plac.RelRSPwk22.wilcox.test.data)
# plac_plac.wilcox.RelRSPwk22
# plac_plac.wilcox.RelRSPwk22.pval<-signif(plac_plac.wilcox.RelRSPwk22$p.value, digits = 2)
# plac_plac.wilcox.RelRSPwk22.pval
# 
# set.seed(32016)
# plac_plac.RelRSPwk22.adonis<-adonis(plac_plac.data.dist ~ RelRSPwk22, plac_plac.data)
# plac_plac.RelRSPwk22.adonis
# plac_plac.RelRSPwk22.adonis.pval<-signif(as.numeric(na.omit(plac_plac.RelRSPwk22.adonis$aov.tab$`Pr(>F)`)), digits = 2)
# 
# plac_plac.YesRelRSPwk22<-toString(c(plac_plac.n.YesRelRSPwk22.wilcoxtest))
# plac_plac.YesRelRSPwk22<-gsub(",", "", plac_plac.YesRelRSPwk22)
# plac_plac.YesRelRSPwk22<-gsub(" ", "", plac_plac.YesRelRSPwk22)
# plac_plac.NoRelRSPwk22<-toString(c(plac_plac.n.NoRelRSPwk22.wilcoxtest))
# plac_plac.NoRelRSPwk22<-gsub(",", "", plac_plac.NoRelRSPwk22)
# plac_plac.NoRelRSPwk22<-gsub(" ", "", plac_plac.NoRelRSPwk22)
# 
# plac_plac.RelRSPwk22_sum<-toString(c(plac_plac.NoRelRSPwk22, plac_plac.YesRelRSPwk22))
# plac_plac.RelRSPwk22_wilcox_P<-toString(c(plac_plac.wilcox.RelRSPwk22.pval))
# plac_plac.RelRSPwk22_wilcox_P<-gsub(",", "", plac_plac.RelRSPwk22_wilcox_P)
# plac_plac.RelRSPwk22_wilcox_P<-gsub(" ", "", plac_plac.RelRSPwk22_wilcox_P)
# 
# 
# plac_plac.RelRSPwk22_AMOVA_p<-toString(c(plac_plac.RelRSPwk22.adonis.pval))
# plac_plac.RelRSPwk22_AMOVA_p<-gsub(",", "", plac_plac.RelRSPwk22_AMOVA_p)
# plac_plac.RelRSPwk22_AMOVA_p<-gsub(" ", "", plac_plac.RelRSPwk22_AMOVA_p)
# plac_plac.RelRSPwk22_AMOVA<-toString(c(plac_plac.RelRSPwk22_AMOVA_p))
# plac_plac.RelRSPwk22_AMOVA<-gsub(",", "", plac_plac.RelRSPwk22_AMOVA)
# plac_plac.RelRSPwk22<-matrix(c('Placebo_Placebo', plac_plac.RelRSPwk22_sum, plac_plac.RelRSPwk22_wilcox_P, plac_plac.RelRSPwk22_AMOVA), ncol = 4)
# 
# 
# set.seed(32016)
# all.REMISSwk22.adonis<-adonis(nao.screen.all.dist ~ REMISSwk22, nao.screen_data, strata=nao.screen_data$TRTGRINDMAN)
# 
# set.seed(32016)
# trtd_trtd.REMISSwk22.wilcox.test.data<-na.omit(subset(trtd_trtd.data, select= c(group, invsimpson, REMISSwk22)))
# trtd_trtd.n.YesREMISSwk22.wilcoxtest<-nrow(trtd_trtd.REMISSwk22.wilcox.test.data[trtd_trtd.REMISSwk22.wilcox.test.data$REMISSwk22=="Yes",])
# trtd_trtd.n.YesREMISSwk22.wilcoxtest
# trtd_trtd.n.NoREMISSwk22.wilcoxtest<-nrow(trtd_trtd.REMISSwk22.wilcox.test.data[trtd_trtd.REMISSwk22.wilcox.test.data$REMISSwk22=="No",])
# trtd_trtd.n.NoREMISSwk22.wilcoxtest
# trtd_trtd.wilcox.REMISSwk22<-wilcox.test(invsimpson ~ REMISSwk22, trtd_trtd.REMISSwk22.wilcox.test.data)
# trtd_trtd.wilcox.REMISSwk22
# trtd_trtd.wilcox.REMISSwk22.pval<-signif(trtd_trtd.wilcox.REMISSwk22$p.value, digits = 2)
# trtd_trtd.wilcox.REMISSwk22.pval
# 
# set.seed(32016)
# trtd_trtd.REMISSwk22.adonis<-adonis(trtd_trtd.data.dist ~ REMISSwk22, trtd_trtd.data)
# trtd_trtd.REMISSwk22.adonis
# trtd_trtd.REMISSwk22.adonis.pval<-signif(as.numeric(na.omit(trtd_trtd.REMISSwk22.adonis$aov.tab$`Pr(>F)`)), digits = 2)
# 
# trtd_trtd.YesREMISSwk22<-toString(c(trtd_trtd.n.YesREMISSwk22.wilcoxtest))
# trtd_trtd.YesREMISSwk22<-gsub(",", "", trtd_trtd.YesREMISSwk22)
# trtd_trtd.YesREMISSwk22<-gsub(" ", "", trtd_trtd.YesREMISSwk22)
# trtd_trtd.NoREMISSwk22<-toString(c(trtd_trtd.n.NoREMISSwk22.wilcoxtest))
# trtd_trtd.NoREMISSwk22<-gsub(",", "", trtd_trtd.NoREMISSwk22)
# trtd_trtd.NoREMISSwk22<-gsub(" ", "", trtd_trtd.NoREMISSwk22)
# 
# trtd_trtd.REMISSwk22_sum<-toString(c(trtd_trtd.NoREMISSwk22, trtd_trtd.YesREMISSwk22))
# trtd_trtd.REMISSwk22_wilcox_P<-toString(c(trtd_trtd.wilcox.REMISSwk22.pval))
# trtd_trtd.REMISSwk22_wilcox_P<-gsub(",", "", trtd_trtd.REMISSwk22_wilcox_P)
# trtd_trtd.REMISSwk22_wilcox_P<-gsub(" ", "", trtd_trtd.REMISSwk22_wilcox_P)
# 
# 
# trtd_trtd.REMISSwk22_AMOVA_p<-toString(c(trtd_trtd.REMISSwk22.adonis.pval))
# trtd_trtd.REMISSwk22_AMOVA_p<-gsub(",", "", trtd_trtd.REMISSwk22_AMOVA_p)
# trtd_trtd.REMISSwk22_AMOVA_p<-gsub(" ", "", trtd_trtd.REMISSwk22_AMOVA_p)
# trtd_trtd.REMISSwk22_AMOVA<-toString(c(trtd_trtd.REMISSwk22_AMOVA_p))
# trtd_trtd.REMISSwk22_AMOVA<-gsub(",", "", trtd_trtd.REMISSwk22_AMOVA)
# trtd_trtd.REMISSwk22<-matrix(c('Treated_Treated', trtd_trtd.REMISSwk22_sum, trtd_trtd.REMISSwk22_wilcox_P, trtd_trtd.REMISSwk22_AMOVA), ncol = 4)
# 
# set.seed(32016)
# plac_plac.REMISSwk22.wilcox.test.data<-na.omit(subset(plac_plac.data, select= c(group, invsimpson, REMISSwk22)))
# plac_plac.n.YesREMISSwk22.wilcoxtest<-nrow(plac_plac.REMISSwk22.wilcox.test.data[plac_plac.REMISSwk22.wilcox.test.data$REMISSwk22=="Yes",])
# plac_plac.n.YesREMISSwk22.wilcoxtest
# plac_plac.n.NoREMISSwk22.wilcoxtest<-nrow(plac_plac.REMISSwk22.wilcox.test.data[plac_plac.REMISSwk22.wilcox.test.data$REMISSwk22=="No",])
# plac_plac.n.NoREMISSwk22.wilcoxtest
# plac_plac.wilcox.REMISSwk22<-wilcox.test(invsimpson ~ REMISSwk22, plac_plac.REMISSwk22.wilcox.test.data)
# plac_plac.wilcox.REMISSwk22
# plac_plac.wilcox.REMISSwk22.pval<-signif(plac_plac.wilcox.REMISSwk22$p.value, digits = 2)
# plac_plac.wilcox.REMISSwk22.pval
# 
# set.seed(32016)
# plac_plac.REMISSwk22.adonis<-adonis(plac_plac.data.dist ~ REMISSwk22, plac_plac.data)
# plac_plac.REMISSwk22.adonis
# plac_plac.REMISSwk22.adonis.pval<-signif(as.numeric(na.omit(plac_plac.REMISSwk22.adonis$aov.tab$`Pr(>F)`)), digits = 2)
# 
# plac_plac.YesREMISSwk22<-toString(c(plac_plac.n.YesREMISSwk22.wilcoxtest))
# plac_plac.YesREMISSwk22<-gsub(",", "", plac_plac.YesREMISSwk22)
# plac_plac.YesREMISSwk22<-gsub(" ", "", plac_plac.YesREMISSwk22)
# plac_plac.NoREMISSwk22<-toString(c(plac_plac.n.NoREMISSwk22.wilcoxtest))
# plac_plac.NoREMISSwk22<-gsub(",", "", plac_plac.NoREMISSwk22)
# plac_plac.NoREMISSwk22<-gsub(" ", "", plac_plac.NoREMISSwk22)
# 
# plac_plac.REMISSwk22_sum<-toString(c(plac_plac.NoREMISSwk22, plac_plac.YesREMISSwk22))
# plac_plac.REMISSwk22_wilcox_P<-toString(c(plac_plac.wilcox.REMISSwk22.pval))
# plac_plac.REMISSwk22_wilcox_P<-gsub(",", "", plac_plac.REMISSwk22_wilcox_P)
# plac_plac.REMISSwk22_wilcox_P<-gsub(" ", "", plac_plac.REMISSwk22_wilcox_P)
# 
# 
# plac_plac.REMISSwk22_AMOVA_p<-toString(c(plac_plac.REMISSwk22.adonis.pval))
# plac_plac.REMISSwk22_AMOVA_p<-gsub(",", "", plac_plac.REMISSwk22_AMOVA_p)
# plac_plac.REMISSwk22_AMOVA_p<-gsub(" ", "", plac_plac.REMISSwk22_AMOVA_p)
# plac_plac.REMISSwk22_AMOVA<-toString(c(plac_plac.REMISSwk22_AMOVA_p))
# plac_plac.REMISSwk22_AMOVA<-gsub(",", "", plac_plac.REMISSwk22_AMOVA)
# plac_plac.REMISSwk22<-matrix(c('Placebo_Placebo', plac_plac.REMISSwk22_sum, plac_plac.REMISSwk22_wilcox_P, plac_plac.REMISSwk22_AMOVA), ncol = 4)
# 
# 
# 
# set.seed(32016)
# trtd_plac.data<-nao.screen.trtd[nao.screen.trtd$TRTGRINDMAN=="Treated_Placebo",]
# trtd_plac.RelRSPwk22.wilcox.test.data<-na.omit(subset(trtd_plac.data, select= c(group, invsimpson, RelRSPwk22)))
# trtd_plac.n.YesRelRSPwk22.wilcoxtest<-nrow(trtd_plac.RelRSPwk22.wilcox.test.data[trtd_plac.RelRSPwk22.wilcox.test.data$RelRSPwk22=="Yes",])
# trtd_plac.n.YesRelRSPwk22.wilcoxtest
# trtd_plac.n.NoRelRSPwk22.wilcoxtest<-nrow(trtd_plac.RelRSPwk22.wilcox.test.data[trtd_plac.RelRSPwk22.wilcox.test.data$RelRSPwk22=="No",])
# trtd_plac.n.NoRelRSPwk22.wilcoxtest
# trtd_plac.wilcox.RelRSPwk22<-wilcox.test(invsimpson ~ RelRSPwk22, trtd_plac.RelRSPwk22.wilcox.test.data)
# trtd_plac.wilcox.RelRSPwk22
# trtd_plac.wilcox.RelRSPwk22.pval<-signif(trtd_plac.wilcox.RelRSPwk22$p.value, digits = 2)
# trtd_plac.wilcox.RelRSPwk22.pval
# 
# set.seed(32016)
# trtd_plac.RelRSPwk22.adonis<-adonis(trtd_plac.data.dist ~ RelRSPwk22, trtd_plac.data)
# trtd_plac.RelRSPwk22.adonis
# trtd_plac.RelRSPwk22.adonis.pval<-signif(as.numeric(na.omit(trtd_plac.RelRSPwk22.adonis$aov.tab$`Pr(>F)`)), digits = 2)
# 
# trtd_plac.YesRelRSPwk22<-toString(c(trtd_plac.n.YesRelRSPwk22.wilcoxtest))
# trtd_plac.YesRelRSPwk22<-gsub(",", "", trtd_plac.YesRelRSPwk22)
# trtd_plac.YesRelRSPwk22<-gsub(" ", "", trtd_plac.YesRelRSPwk22)
# trtd_plac.NoRelRSPwk22<-toString(c(trtd_plac.n.NoRelRSPwk22.wilcoxtest))
# trtd_plac.NoRelRSPwk22<-gsub(",", "", trtd_plac.NoRelRSPwk22)
# trtd_plac.NoRelRSPwk22<-gsub(" ", "", trtd_plac.NoRelRSPwk22)
# 
# trtd_plac.RelRSPwk22_sum<-toString(c(trtd_plac.NoRelRSPwk22, trtd_plac.YesRelRSPwk22))
# trtd_plac.RelRSPwk22_wilcox_P<-toString(c(trtd_plac.wilcox.RelRSPwk22.pval))
# trtd_plac.RelRSPwk22_wilcox_P<-gsub(",", "", trtd_plac.RelRSPwk22_wilcox_P)
# trtd_plac.RelRSPwk22_wilcox_P<-gsub(" ", "", trtd_plac.RelRSPwk22_wilcox_P)
# 
# 
# trtd_plac.RelRSPwk22_AMOVA_p<-toString(c(trtd_plac.RelRSPwk22.adonis.pval))
# trtd_plac.RelRSPwk22_AMOVA_p<-gsub(",", "", trtd_plac.RelRSPwk22_AMOVA_p)
# trtd_plac.RelRSPwk22_AMOVA_p<-gsub(" ", "", trtd_plac.RelRSPwk22_AMOVA_p)
# trtd_plac.RelRSPwk22_AMOVA<-toString(c(trtd_plac.RelRSPwk22_AMOVA_p))
# trtd_plac.RelRSPwk22_AMOVA<-gsub(",", "", trtd_plac.RelRSPwk22_AMOVA)
# trtd_plac.RelRSPwk22<-matrix(c('Treated_Placebo', trtd_plac.RelRSPwk22_sum, trtd_plac.RelRSPwk22_wilcox_P, trtd_plac.RelRSPwk22_AMOVA), ncol = 4)
# 
# set.seed(32016)
# plac_trtd.data<-nao.screen.plac[nao.screen.plac$TRTGRINDMAN=="Placebo_Treated",]
# plac_trtd.RelRSPwk22.wilcox.test.data<-na.omit(subset(plac_trtd.data, select= c(group, invsimpson, RelRSPwk22)))
# plac_trtd.n.YesRelRSPwk22.wilcoxtest<-nrow(plac_trtd.RelRSPwk22.wilcox.test.data[plac_trtd.RelRSPwk22.wilcox.test.data$RelRSPwk22=="Yes",])
# plac_trtd.n.YesRelRSPwk22.wilcoxtest
# plac_trtd.n.NoRelRSPwk22.wilcoxtest<-nrow(plac_trtd.RelRSPwk22.wilcox.test.data[plac_trtd.RelRSPwk22.wilcox.test.data$RelRSPwk22=="No",])
# plac_trtd.n.NoRelRSPwk22.wilcoxtest
# plac_trtd.wilcox.RelRSPwk22<-wilcox.test(invsimpson ~ RelRSPwk22, plac_trtd.RelRSPwk22.wilcox.test.data)
# plac_trtd.wilcox.RelRSPwk22
# plac_trtd.wilcox.RelRSPwk22.pval<-signif(plac_trtd.wilcox.RelRSPwk22$p.value, digits = 2)
# plac_trtd.wilcox.RelRSPwk22.pval
# 
# set.seed(32016)
# plac_trtd.RelRSPwk22.adonis<-adonis(plac_trtd.data.dist ~ RelRSPwk22, plac_trtd.data)
# plac_trtd.RelRSPwk22.adonis
# plac_trtd.RelRSPwk22.adonis.pval<-signif(as.numeric(na.omit(plac_trtd.RelRSPwk22.adonis$aov.tab$`Pr(>F)`)), digits = 2)
# 
# plac_trtd.YesRelRSPwk22<-toString(c(plac_trtd.n.YesRelRSPwk22.wilcoxtest))
# plac_trtd.YesRelRSPwk22<-gsub(",", "", plac_trtd.YesRelRSPwk22)
# plac_trtd.YesRelRSPwk22<-gsub(" ", "", plac_trtd.YesRelRSPwk22)
# plac_trtd.NoRelRSPwk22<-toString(c(plac_trtd.n.NoRelRSPwk22.wilcoxtest))
# plac_trtd.NoRelRSPwk22<-gsub(",", "", plac_trtd.NoRelRSPwk22)
# plac_trtd.NoRelRSPwk22<-gsub(" ", "", plac_trtd.NoRelRSPwk22)
# 
# plac_trtd.RelRSPwk22_sum<-toString(c(plac_trtd.NoRelRSPwk22, plac_trtd.YesRelRSPwk22))
# plac_trtd.RelRSPwk22_wilcox_P<-toString(c(plac_trtd.wilcox.RelRSPwk22.pval))
# plac_trtd.RelRSPwk22_wilcox_P<-gsub(",", "", plac_trtd.RelRSPwk22_wilcox_P)
# plac_trtd.RelRSPwk22_wilcox_P<-gsub(" ", "", plac_trtd.RelRSPwk22_wilcox_P)
# 
# 
# plac_trtd.RelRSPwk22_AMOVA_p<-toString(c(plac_trtd.RelRSPwk22.adonis.pval))
# plac_trtd.RelRSPwk22_AMOVA_p<-gsub(",", "", plac_trtd.RelRSPwk22_AMOVA_p)
# plac_trtd.RelRSPwk22_AMOVA_p<-gsub(" ", "", plac_trtd.RelRSPwk22_AMOVA_p)
# plac_trtd.RelRSPwk22_AMOVA<-toString(c(plac_trtd.RelRSPwk22_AMOVA_p))
# plac_trtd.RelRSPwk22_AMOVA<-gsub(",", "", plac_trtd.RelRSPwk22_AMOVA)
# plac_trtd.RelRSPwk22<-matrix(c('Placebo_Treated', plac_trtd.RelRSPwk22_sum, plac_trtd.RelRSPwk22_wilcox_P, plac_trtd.RelRSPwk22_AMOVA), ncol = 4)


# set.seed(32016)
# all.REMISSwk22.adonis<-adonis(nao.screen.all.dist ~ REMISSwk22, nao.screen_data, strata=nao.screen_data$TRTGRINDMAN)
# all.REMISSwk22.adonis
# 
# set.seed(32016)
# all.REMISSwk22.adonis<-adonis(nao.screen.all.dist ~ REMISSwk22*TRTGRINDMAN, nao.screen_data)
# all.REMISSwk22.adonis
# 
# set.seed(32016)
# all.REMISSwk22.adonis<-adonis(nao.screen.all.dist ~ REMISSwk22*TRTGRINDMAN, nao.screen_data, strata=nao.screen_data$TRTGRINDMAN)
# all.REMISSwk22.adonis

# set.seed(32016)
# trtd_plac.REMISSwk22.wilcox.test.data<-na.omit(subset(trtd_plac.data, select= c(group, invsimpson, REMISSwk22)))
# trtd_plac.n.YesREMISSwk22.wilcoxtest<-nrow(trtd_plac.REMISSwk22.wilcox.test.data[trtd_plac.REMISSwk22.wilcox.test.data$REMISSwk22=="Yes",])
# trtd_plac.n.YesREMISSwk22.wilcoxtest
# trtd_plac.n.NoREMISSwk22.wilcoxtest<-nrow(trtd_plac.REMISSwk22.wilcox.test.data[trtd_plac.REMISSwk22.wilcox.test.data$REMISSwk22=="No",])
# trtd_plac.n.NoREMISSwk22.wilcoxtest
# trtd_plac.wilcox.REMISSwk22<-wilcox.test(invsimpson ~ REMISSwk22, trtd_plac.REMISSwk22.wilcox.test.data)
# trtd_plac.wilcox.REMISSwk22
# trtd_plac.wilcox.REMISSwk22.pval<-signif(trtd_plac.wilcox.REMISSwk22$p.value, digits = 2)
# trtd_plac.wilcox.REMISSwk22.pval
# 
# set.seed(32016)
# trtd_plac.REMISSwk22.adonis<-adonis(trtd_plac.data.dist ~ REMISSwk22, trtd_plac.data)
# trtd_plac.REMISSwk22.adonis
# trtd_plac.REMISSwk22.adonis.pval<-signif(as.numeric(na.omit(trtd_plac.REMISSwk22.adonis$aov.tab$`Pr(>F)`)), digits = 2)
# 
# trtd_plac.YesREMISSwk22<-toString(c(trtd_plac.n.YesREMISSwk22.wilcoxtest))
# trtd_plac.YesREMISSwk22<-gsub(",", "", trtd_plac.YesREMISSwk22)
# trtd_plac.YesREMISSwk22<-gsub(" ", "", trtd_plac.YesREMISSwk22)
# trtd_plac.NoREMISSwk22<-toString(c(trtd_plac.n.NoREMISSwk22.wilcoxtest))
# trtd_plac.NoREMISSwk22<-gsub(",", "", trtd_plac.NoREMISSwk22)
# trtd_plac.NoREMISSwk22<-gsub(" ", "", trtd_plac.NoREMISSwk22)
# 
# trtd_plac.REMISSwk22_sum<-toString(c(trtd_plac.NoREMISSwk22, trtd_plac.YesREMISSwk22))
# trtd_plac.REMISSwk22_wilcox_P<-toString(c(trtd_plac.wilcox.REMISSwk22.pval))
# trtd_plac.REMISSwk22_wilcox_P<-gsub(",", "", trtd_plac.REMISSwk22_wilcox_P)
# trtd_plac.REMISSwk22_wilcox_P<-gsub(" ", "", trtd_plac.REMISSwk22_wilcox_P)
# 
# 
# trtd_plac.REMISSwk22_AMOVA_p<-toString(c(trtd_plac.REMISSwk22.adonis.pval))
# trtd_plac.REMISSwk22_AMOVA_p<-gsub(",", "", trtd_plac.REMISSwk22_AMOVA_p)
# trtd_plac.REMISSwk22_AMOVA_p<-gsub(" ", "", trtd_plac.REMISSwk22_AMOVA_p)
# trtd_plac.REMISSwk22_AMOVA<-toString(c(trtd_plac.REMISSwk22_AMOVA_p))
# trtd_plac.REMISSwk22_AMOVA<-gsub(",", "", trtd_plac.REMISSwk22_AMOVA)
# trtd_plac.REMISSwk22<-matrix(c('Treated_Placebo', trtd_plac.REMISSwk22_sum, trtd_plac.REMISSwk22_wilcox_P, trtd_plac.REMISSwk22_AMOVA), ncol = 4)
# 
# set.seed(32016)
# plac_trtd.REMISSwk22.wilcox.test.data<-na.omit(subset(plac_trtd.data, select= c(group, invsimpson, REMISSwk22)))
# plac_trtd.n.YesREMISSwk22.wilcoxtest<-nrow(plac_trtd.REMISSwk22.wilcox.test.data[plac_trtd.REMISSwk22.wilcox.test.data$REMISSwk22=="Yes",])
# plac_trtd.n.YesREMISSwk22.wilcoxtest
# plac_trtd.n.NoREMISSwk22.wilcoxtest<-nrow(plac_trtd.REMISSwk22.wilcox.test.data[plac_trtd.REMISSwk22.wilcox.test.data$REMISSwk22=="No",])
# plac_trtd.n.NoREMISSwk22.wilcoxtest
# plac_trtd.wilcox.REMISSwk22<-wilcox.test(invsimpson ~ REMISSwk22, plac_trtd.REMISSwk22.wilcox.test.data)
# plac_trtd.wilcox.REMISSwk22
# plac_trtd.wilcox.REMISSwk22.pval<-signif(plac_trtd.wilcox.REMISSwk22$p.value, digits = 2)
# plac_trtd.wilcox.REMISSwk22.pval
# 
# set.seed(32016)
# plac_trtd.REMISSwk22.adonis<-adonis(plac_trtd.data.dist ~ REMISSwk22, plac_trtd.data)
# plac_trtd.REMISSwk22.adonis
# plac_trtd.REMISSwk22.adonis.pval<-signif(as.numeric(na.omit(plac_trtd.REMISSwk22.adonis$aov.tab$`Pr(>F)`)), digits = 2)
# 
# plac_trtd.YesREMISSwk22<-toString(c(plac_trtd.n.YesREMISSwk22.wilcoxtest))
# plac_trtd.YesREMISSwk22<-gsub(",", "", plac_trtd.YesREMISSwk22)
# plac_trtd.YesREMISSwk22<-gsub(" ", "", plac_trtd.YesREMISSwk22)
# plac_trtd.NoREMISSwk22<-toString(c(plac_trtd.n.NoREMISSwk22.wilcoxtest))
# plac_trtd.NoREMISSwk22<-gsub(",", "", plac_trtd.NoREMISSwk22)
# plac_trtd.NoREMISSwk22<-gsub(" ", "", plac_trtd.NoREMISSwk22)
# 
# plac_trtd.REMISSwk22_sum<-toString(c(plac_trtd.NoREMISSwk22, plac_trtd.YesREMISSwk22))
# plac_trtd.REMISSwk22_wilcox_P<-toString(c(plac_trtd.wilcox.REMISSwk22.pval))
# plac_trtd.REMISSwk22_wilcox_P<-gsub(",", "", plac_trtd.REMISSwk22_wilcox_P)
# plac_trtd.REMISSwk22_wilcox_P<-gsub(" ", "", plac_trtd.REMISSwk22_wilcox_P)
# 
# 
# plac_trtd.REMISSwk22_AMOVA_p<-toString(c(plac_trtd.REMISSwk22.adonis.pval))
# plac_trtd.REMISSwk22_AMOVA_p<-gsub(",", "", plac_trtd.REMISSwk22_AMOVA_p)
# plac_trtd.REMISSwk22_AMOVA_p<-gsub(" ", "", plac_trtd.REMISSwk22_AMOVA_p)
# plac_trtd.REMISSwk22_AMOVA<-toString(c(plac_trtd.REMISSwk22_AMOVA_p))
# plac_trtd.REMISSwk22_AMOVA<-gsub(",", "", plac_trtd.REMISSwk22_AMOVA)
# plac_trtd.REMISSwk22<-matrix(c('Placebo_Treated', plac_trtd.REMISSwk22_sum, plac_trtd.REMISSwk22_wilcox_P, plac_trtd.REMISSwk22_AMOVA), ncol = 4)
# 
# 
# 
# trtd_plac.RelRSPwk22
# plac_trtd.RelRSPwk22
# 
# trtd_plac.REMISSwk22
# plac_trtd.REMISSwk22
# 
# trtd_trtd.RelRSPwk22
# plac_plac.RelRSPwk22
# 
# trtd_trtd.REMISSwk22
# plac_plac.REMISSwk22