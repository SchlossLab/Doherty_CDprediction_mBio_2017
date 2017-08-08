source('../code/R_packages_setup.R')

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
	

set.seed(32016)
all.RelRSPwk6.wilcox.test.data<-na.omit(subset(nao.screen_data, select= c(group, invsimpson, RelRSPwk6)))

YesRelRSPwk6.wilcoxtest <- all.RelRSPwk6.wilcox.test.data[all.RelRSPwk6.wilcox.test.data$RelRSPwk6=="Yes",]
Yes.inv.25quantile <- signif(quantile(YesRelRSPwk6.wilcoxtest$invsimpson, .25, type = 2), digits=3)
Yes.inv.75quantile <- signif(quantile(YesRelRSPwk6.wilcoxtest$invsimpson, .75, type = 2), digits=4)

NoRelRSPwk6.wilcoxtest <- all.RelRSPwk6.wilcox.test.data[all.RelRSPwk6.wilcox.test.data$RelRSPwk6=="No",]
No.inv.25quantile <- signif(quantile(NoRelRSPwk6.wilcoxtest$invsimpson, .25, type = 2), digits=3)
No.inv.75quantile <- signif(quantile(NoRelRSPwk6.wilcoxtest$invsimpson, .75, type = 2), digits=4)

all.n.YesRelRSPwk6.wilcoxtest<-nrow(all.RelRSPwk6.wilcox.test.data[all.RelRSPwk6.wilcox.test.data$RelRSPwk6=="Yes",])
all.n.YesRelRSPwk6.wilcoxtest
all.n.NoRelRSPwk6.wilcoxtest<-nrow(all.RelRSPwk6.wilcox.test.data[all.RelRSPwk6.wilcox.test.data$RelRSPwk6=="No",])
all.n.NoRelRSPwk6.wilcoxtest

all.RelRSPwk6.kw.test.data<-na.omit(subset(nao.screen_data, select= c(group, invsimpson, RelRSPwk6, TRTGR)))
all.RelRSPwk6.kw.test.data$rRSPwk6TRTGR <- as.factor(paste(all.RelRSPwk6.kw.test.data$RelRSPwk6, all.RelRSPwk6.kw.test.data$TRTGR, sep = "_"))
all.RelRSPwk6.kw.test <- kruskal.test(all.RelRSPwk6.kw.test.data$invsimpson ~ all.RelRSPwk6.kw.test.data$rRSPwk6TRTGR, all.RelRSPwk6.kw.test.data)
all.RelRSPwk6.kw.test.pval <- all.RelRSPwk6.kw.test$p.value

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

trtd.RelRSPwk6.wilcox.test.data<-na.omit(subset(nao.screen.trtd, select= c(group, invsimpson, RelRSPwk6)))
trtd.n.YesRelRSPwk6.wilcoxtest<-nrow(trtd.RelRSPwk6.wilcox.test.data[trtd.RelRSPwk6.wilcox.test.data$RelRSPwk6=="Yes",])
trtd.n.YesRelRSPwk6.wilcoxtest
trtd.n.NoRelRSPwk6.wilcoxtest<-nrow(trtd.RelRSPwk6.wilcox.test.data[trtd.RelRSPwk6.wilcox.test.data$RelRSPwk6=="No",])
trtd.n.NoRelRSPwk6.wilcoxtest

trtd.YesRelRSPwk6<-toString(c(trtd.n.YesRelRSPwk6.wilcoxtest))
trtd.YesRelRSPwk6<-gsub(",", "", trtd.YesRelRSPwk6)
trtd.YesRelRSPwk6<-gsub(" ", "", trtd.YesRelRSPwk6)
trtd.NoRelRSPwk6<-toString(c(trtd.n.NoRelRSPwk6.wilcoxtest))
trtd.NoRelRSPwk6<-gsub(",", "", trtd.NoRelRSPwk6)
trtd.NoRelRSPwk6<-gsub(" ", "", trtd.NoRelRSPwk6)

trtd.RelRSPwk6_sum<-toString(c(trtd.NoRelRSPwk6, trtd.YesRelRSPwk6))

plac.RelRSPwk6.wilcox.test.data<-na.omit(subset(nao.screen.plac, select= c(group, invsimpson, RelRSPwk6)))
plac.n.YesRelRSPwk6.wilcoxtest<-nrow(plac.RelRSPwk6.wilcox.test.data[plac.RelRSPwk6.wilcox.test.data$RelRSPwk6=="Yes",])
plac.n.YesRelRSPwk6.wilcoxtest
plac.n.NoRelRSPwk6.wilcoxtest<-nrow(plac.RelRSPwk6.wilcox.test.data[plac.RelRSPwk6.wilcox.test.data$RelRSPwk6=="No",])
plac.n.NoRelRSPwk6.wilcoxtest

plac.YesRelRSPwk6<-toString(c(plac.n.YesRelRSPwk6.wilcoxtest))
plac.YesRelRSPwk6<-gsub(",", "", plac.YesRelRSPwk6)
plac.YesRelRSPwk6<-gsub(" ", "", plac.YesRelRSPwk6)
plac.NoRelRSPwk6<-toString(c(plac.n.NoRelRSPwk6.wilcoxtest))
plac.NoRelRSPwk6<-gsub(",", "", plac.NoRelRSPwk6)
plac.NoRelRSPwk6<-gsub(" ", "", plac.NoRelRSPwk6)

plac.RelRSPwk6_sum<-toString(c(plac.NoRelRSPwk6, plac.YesRelRSPwk6))

all.RelRSPwk6_AMOVA_p<-toString(c(all.RelRSPwk6.adonis.pval))
all.RelRSPwk6_AMOVA_p<-gsub(",", "", all.RelRSPwk6_AMOVA_p)
all.RelRSPwk6_AMOVA_p<-gsub(" ", "", all.RelRSPwk6_AMOVA_p)
all.RelRSPwk6_AMOVA<-toString(c(all.RelRSPwk6_AMOVA_p))
all.RelRSPwk6_AMOVA<-gsub(",", "", all.RelRSPwk6_AMOVA)
all.RelRSPwk6<-matrix(c('Week 6 Response (No, Yes)', trtd.RelRSPwk6_sum, plac.RelRSPwk6_sum, all.RelRSPwk6.kw.test.pval, all.RelRSPwk6_AMOVA), ncol = 5)

set.seed(32016)
all.REMISSwk6.wilcox.test.data<-na.omit(subset(nao.screen_data, select= c(group, invsimpson, REMISSwk6)))

all.REMISSwk6.invsimp <- all.REMISSwk6.wilcox.test.data[,-3]
row.names(all.REMISSwk6.invsimp) <- all.REMISSwk6.invsimp$group
all.REMISSwk6.invsimp <- all.REMISSwk6.invsimp[,-1]
REMwk6.invsimp.matrix <- aggregate(all.REMISSwk6.invsimp, by=list(all.REMISSwk6.wilcox.test.data$REMISSwk6), median)

row.names(REMwk6.invsimp.matrix) <- REMwk6.invsimp.matrix$Group.1
median.REMwk6.invsimp.matrix <- subset(REMwk6.invsimp.matrix, select=-c(Group.1))
median.REMwk6.invsimp.matrix <- as.matrix(t(subset(median.REMwk6.invsimp.matrix)))
colnames(median.REMwk6.invsimp.matrix) <- REMwk6.invsimp.matrix$Group.1
median.REMwk6.invsimp <- data.frame(median.REMwk6.invsimp.matrix)

all.REMISSwk6.Yes <- all.REMISSwk6.wilcox.test.data[all.REMISSwk6.wilcox.test.data$REMISSwk6=="Yes",]
quantile(all.REMISSwk6.Yes$invsimpson, type = 2)

REMwk6.YES.invsimp <- signif(median.REMwk6.invsimp$Yes, 4)

all.REMISSwk6.No <- all.REMISSwk6.wilcox.test.data[all.REMISSwk6.wilcox.test.data$REMISSwk6=="No",]
quantile(all.REMISSwk6.No$invsimpson, type = 2)

REMwk6.NO.invsimp <- signif(median.REMwk6.invsimp$No, 3)


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

all.YesREMISSwk6<-toString(c(all.n.YesREMISSwk6.wilcoxtest))
all.YesREMISSwk6<-gsub(",", "", all.YesREMISSwk6)
all.YesREMISSwk6<-gsub(" ", "", all.YesREMISSwk6)
all.NoREMISSwk6<-toString(c(all.n.NoREMISSwk6.wilcoxtest))
all.NoREMISSwk6<-gsub(",", "", all.NoREMISSwk6)
all.NoREMISSwk6<-gsub(" ", "", all.NoREMISSwk6)

all.REMISSwk6_sum<-toString(c(all.NoREMISSwk6, all.YesREMISSwk6))

trtd.REMISSwk6.wilcox.test.data<-na.omit(subset(nao.screen.trtd, select= c(group, invsimpson, REMISSwk6)))
trtd.n.YesREMISSwk6.wilcoxtest<-nrow(trtd.REMISSwk6.wilcox.test.data[trtd.REMISSwk6.wilcox.test.data$REMISSwk6=="Yes",])
trtd.n.YesREMISSwk6.wilcoxtest
trtd.n.NoREMISSwk6.wilcoxtest<-nrow(trtd.REMISSwk6.wilcox.test.data[trtd.REMISSwk6.wilcox.test.data$REMISSwk6=="No",])
trtd.n.NoREMISSwk6.wilcoxtest
trtd.YesREMISSwk6<-toString(c(trtd.n.YesREMISSwk6.wilcoxtest))
trtd.YesREMISSwk6<-gsub(",", "", trtd.YesREMISSwk6)
trtd.YesREMISSwk6<-gsub(" ", "", trtd.YesREMISSwk6)
trtd.NoREMISSwk6<-toString(c(trtd.n.NoREMISSwk6.wilcoxtest))
trtd.NoREMISSwk6<-gsub(",", "", trtd.NoREMISSwk6)
trtd.NoREMISSwk6<-gsub(" ", "", trtd.NoREMISSwk6)

trtd.REMISSwk6_sum<-toString(c(trtd.NoREMISSwk6, trtd.YesREMISSwk6))

plac.REMISSwk6.wilcox.test.data<-na.omit(subset(nao.screen.plac, select= c(group, invsimpson, REMISSwk6)))
plac.n.YesREMISSwk6.wilcoxtest<-nrow(plac.REMISSwk6.wilcox.test.data[plac.REMISSwk6.wilcox.test.data$REMISSwk6=="Yes",])
plac.n.YesREMISSwk6.wilcoxtest
plac.n.NoREMISSwk6.wilcoxtest<-nrow(plac.REMISSwk6.wilcox.test.data[plac.REMISSwk6.wilcox.test.data$REMISSwk6=="No",])
plac.n.NoREMISSwk6.wilcoxtest
plac.YesREMISSwk6<-toString(c(plac.n.YesREMISSwk6.wilcoxtest))
plac.YesREMISSwk6<-gsub(",", "", plac.YesREMISSwk6)
plac.YesREMISSwk6<-gsub(" ", "", plac.YesREMISSwk6)
plac.NoREMISSwk6<-toString(c(plac.n.NoREMISSwk6.wilcoxtest))
plac.NoREMISSwk6<-gsub(",", "", plac.NoREMISSwk6)
plac.NoREMISSwk6<-gsub(" ", "", plac.NoREMISSwk6)

plac.REMISSwk6_sum<-toString(c(plac.NoREMISSwk6, plac.YesREMISSwk6))




all.REMISSwk6_AMOVA_p<-toString(c(all.REMISSwk6.adonis.pval))
all.REMISSwk6_AMOVA_p<-gsub(",", "", all.REMISSwk6_AMOVA_p)
all.REMISSwk6_AMOVA_p<-gsub(" ", "", all.REMISSwk6_AMOVA_p)
all.REMISSwk6_AMOVA<-toString(c(all.REMISSwk6_AMOVA_p))
all.REMISSwk6_AMOVA<-gsub(",", "", all.REMISSwk6_AMOVA)
all.REMISSwk6<-matrix(c('Week 6 Remission (No, Yes)', trtd.REMISSwk6_sum, plac.REMISSwk6_sum, all.REMISSwk6.kw.test.pval, all.REMISSwk6_AMOVA), ncol = 5)

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

all.YesRelRSPwk22<-toString(c(all.n.YesRelRSPwk22.wilcoxtest))
all.YesRelRSPwk22<-gsub(",", "", all.YesRelRSPwk22)
all.YesRelRSPwk22<-gsub(" ", "", all.YesRelRSPwk22)
all.NoRelRSPwk22<-toString(c(all.n.NoRelRSPwk22.wilcoxtest))
all.NoRelRSPwk22<-gsub(",", "", all.NoRelRSPwk22)
all.NoRelRSPwk22<-gsub(" ", "", all.NoRelRSPwk22)

all.RelRSPwk22_sum<-toString(c(all.NoRelRSPwk22, all.YesRelRSPwk22))

trtd.RelRSPwk22.wilcox.test.data<-na.omit(subset(nao.screen.trtd, select= c(group, invsimpson, RelRSPwk22, TRTGRINDMAN)))
trtd.RelRSPwk22.wilcox.test.data<-trtd.RelRSPwk22.wilcox.test.data[trtd.RelRSPwk22.wilcox.test.data$TRTGRINDMAN=="Treated_Treated",]
n.trtd.RelRSPwk22.wilcox.test.data <- nrow(trtd.RelRSPwk22.wilcox.test.data)
trtd.n.YesRelRSPwk22.wilcoxtest<-nrow(trtd.RelRSPwk22.wilcox.test.data[trtd.RelRSPwk22.wilcox.test.data$RelRSPwk22=="Yes",])
trtd.n.YesRelRSPwk22.wilcoxtest
trtd.n.NoRelRSPwk22.wilcoxtest<-nrow(trtd.RelRSPwk22.wilcox.test.data[trtd.RelRSPwk22.wilcox.test.data$RelRSPwk22=="No",])
trtd.n.NoRelRSPwk22.wilcoxtest
trtd.YesRelRSPwk22<-toString(c(trtd.n.YesRelRSPwk22.wilcoxtest))
trtd.YesRelRSPwk22<-gsub(",", "", trtd.YesRelRSPwk22)
trtd.YesRelRSPwk22<-gsub(" ", "", trtd.YesRelRSPwk22)
trtd.NoRelRSPwk22<-toString(c(trtd.n.NoRelRSPwk22.wilcoxtest))
trtd.NoRelRSPwk22<-gsub(",", "", trtd.NoRelRSPwk22)
trtd.NoRelRSPwk22<-gsub(" ", "", trtd.NoRelRSPwk22)

trtd.RelRSPwk22_sum<-toString(c(trtd.NoRelRSPwk22, trtd.YesRelRSPwk22))

plac.RelRSPwk22.wilcox.test.data<-na.omit(subset(nao.screen.plac, select= c(group, invsimpson, RelRSPwk22, TRTGRINDMAN)))
plac.RelRSPwk22.wilcox.test.data<-plac.RelRSPwk22.wilcox.test.data[plac.RelRSPwk22.wilcox.test.data$TRTGRINDMAN=="Placebo_Placebo",]
n.plac.RelRSPwk22.wilcox.test.data <- nrow(plac.RelRSPwk22.wilcox.test.data)
plac.n.YesRelRSPwk22.wilcoxtest<-nrow(plac.RelRSPwk22.wilcox.test.data[plac.RelRSPwk22.wilcox.test.data$RelRSPwk22=="Yes",])
plac.n.YesRelRSPwk22.wilcoxtest
plac.n.NoRelRSPwk22.wilcoxtest<-nrow(plac.RelRSPwk22.wilcox.test.data[plac.RelRSPwk22.wilcox.test.data$RelRSPwk22=="No",])
plac.n.NoRelRSPwk22.wilcoxtest
plac.YesRelRSPwk22<-toString(c(plac.n.YesRelRSPwk22.wilcoxtest))
plac.YesRelRSPwk22<-gsub(",", "", plac.YesRelRSPwk22)
plac.YesRelRSPwk22<-gsub(" ", "", plac.YesRelRSPwk22)
plac.NoRelRSPwk22<-toString(c(plac.n.NoRelRSPwk22.wilcoxtest))
plac.NoRelRSPwk22<-gsub(",", "", plac.NoRelRSPwk22)
plac.NoRelRSPwk22<-gsub(" ", "", plac.NoRelRSPwk22)

plac.RelRSPwk22_sum<-toString(c(plac.NoRelRSPwk22, plac.YesRelRSPwk22))


all.RelRSPwk22_AMOVA_p<-toString(c(all.RelRSPwk22.adonis.pval))
all.RelRSPwk22_AMOVA_p<-gsub(",", "", all.RelRSPwk22_AMOVA_p)
all.RelRSPwk22_AMOVA_p<-gsub(" ", "", all.RelRSPwk22_AMOVA_p)
all.RelRSPwk22_AMOVA<-toString(c(all.RelRSPwk22_AMOVA_p))
all.RelRSPwk22_AMOVA<-gsub(",", "", all.RelRSPwk22_AMOVA)
all.RelRSPwk22<-matrix(c('Week 22 Response (No, Yes)', trtd.RelRSPwk22_sum, plac.RelRSPwk22_sum, all.RelRSPwk22.kw.test.pval, all.RelRSPwk22_AMOVA), ncol = 5)

set.seed(32016)
all.REMISSwk22.wilcox.test.data<-na.omit(subset(nao.screen_data, select= c(group, invsimpson, REMISSwk22)))
all.REMISSwk22.kw.test.data<-na.omit(subset(nao.screen_data, select= c(group, invsimpson, REMISSwk22, TRTGRINDMAN)))

all.REMISSwk22.kw.test.data$REMwk6TRTGRINDMAN <-
	as.factor(paste(all.REMISSwk22.kw.test.data$REMISSwk22, all.REMISSwk22.kw.test.data$TRTGRINDMAN, sep = "_"))
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

trtd.REMISSwk22.wilcox.test.data<-na.omit(subset(nao.screen.trtd, select= c(group, invsimpson, REMISSwk22, TRTGRINDMAN)))
trtd.REMISSwk22.wilcox.test.data<-trtd.REMISSwk22.wilcox.test.data[trtd.REMISSwk22.wilcox.test.data$TRTGRINDMAN=="Treated_Treated",]
trtd.n.YesREMISSwk22.wilcoxtest<-nrow(trtd.REMISSwk22.wilcox.test.data[trtd.REMISSwk22.wilcox.test.data$REMISSwk22=="Yes",])
trtd.n.YesREMISSwk22.wilcoxtest
trtd.n.NoREMISSwk22.wilcoxtest<-nrow(trtd.REMISSwk22.wilcox.test.data[trtd.REMISSwk22.wilcox.test.data$REMISSwk22=="No",])
trtd.n.NoREMISSwk22.wilcoxtest
trtd.YesREMISSwk22<-toString(c(trtd.n.YesREMISSwk22.wilcoxtest))
trtd.YesREMISSwk22<-gsub(",", "", trtd.YesREMISSwk22)
trtd.YesREMISSwk22<-gsub(" ", "", trtd.YesREMISSwk22)
trtd.NoREMISSwk22<-toString(c(trtd.n.NoREMISSwk22.wilcoxtest))
trtd.NoREMISSwk22<-gsub(",", "", trtd.NoREMISSwk22)
trtd.NoREMISSwk22<-gsub(" ", "", trtd.NoREMISSwk22)

trtd.REMISSwk22_sum<-toString(c(trtd.NoREMISSwk22, trtd.YesREMISSwk22))

plac.REMISSwk22.wilcox.test.data<-na.omit(subset(nao.screen.plac, select= c(group, invsimpson, REMISSwk22, TRTGRINDMAN)))
plac.REMISSwk22.wilcox.test.data<-plac.REMISSwk22.wilcox.test.data[plac.REMISSwk22.wilcox.test.data$TRTGRINDMAN=="Placebo_Placebo",]
plac.n.YesREMISSwk22.wilcoxtest<-nrow(plac.REMISSwk22.wilcox.test.data[plac.REMISSwk22.wilcox.test.data$REMISSwk22=="Yes",])
plac.n.YesREMISSwk22.wilcoxtest
plac.n.NoREMISSwk22.wilcoxtest<-nrow(plac.REMISSwk22.wilcox.test.data[plac.REMISSwk22.wilcox.test.data$REMISSwk22=="No",])
plac.n.NoREMISSwk22.wilcoxtest
plac.YesREMISSwk22<-toString(c(plac.n.YesREMISSwk22.wilcoxtest))
plac.YesREMISSwk22<-gsub(",", "", plac.YesREMISSwk22)
plac.YesREMISSwk22<-gsub(" ", "", plac.YesREMISSwk22)
plac.NoREMISSwk22<-toString(c(plac.n.NoREMISSwk22.wilcoxtest))
plac.NoREMISSwk22<-gsub(",", "", plac.NoREMISSwk22)
plac.NoREMISSwk22<-gsub(" ", "", plac.NoREMISSwk22)

plac.REMISSwk22_sum<-toString(c(plac.NoREMISSwk22, plac.YesREMISSwk22))


all.REMISSwk22_AMOVA_p<-toString(c(all.REMISSwk22.adonis.pval))
all.REMISSwk22_AMOVA_p<-gsub(",", "", all.REMISSwk22_AMOVA_p)
all.REMISSwk22_AMOVA_p<-gsub(" ", "", all.REMISSwk22_AMOVA_p)
all.REMISSwk22_AMOVA<-toString(c(all.REMISSwk22_AMOVA_p))
all.REMISSwk22_AMOVA<-gsub(",", "", all.REMISSwk22_AMOVA)
all.REMISSwk22<-matrix(c('Week 22 Remission (No, Yes)', trtd.REMISSwk22_sum, plac.REMISSwk22_sum, all.REMISSwk22.kw.test.pval, all.REMISSwk22_AMOVA), ncol = 5)

source('../code/table2diversity.R')