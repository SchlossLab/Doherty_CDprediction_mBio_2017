#change in adiv over time?
wk0.ust.relRSP22Y.adiv <- wk046.ust.relRSP22Y[wk046.ust.relRSP22Y$visit=="Screening", c("USUBJID", "visit", "invsimpson")]
wk0.relRSP22Y.adiv <- wk0.ust.relRSP22Y.adiv
colnames(wk0.ust.relRSP22Y.adiv)[3] <- "Week0adiv"
wk0.ust.relRSP22Y.adiv <- subset(wk0.ust.relRSP22Y.adiv, select=-c(visit))

wk4.ust.relRSP22Y.adiv <- wk046.ust.relRSP22Y[wk046.ust.relRSP22Y$visit=="Week 4", c("USUBJID","visit", "invsimpson")]
wk4.relRSP22Y.adiv <- wk4.ust.relRSP22Y.adiv
colnames(wk4.ust.relRSP22Y.adiv)[3] <- "Week4adiv"
wk4.ust.relRSP22Y.adiv <- subset(wk4.ust.relRSP22Y.adiv, select=-c(visit))

wk6.ust.relRSP22Y.adiv <- wk046.ust.relRSP22Y[wk046.ust.relRSP22Y$visit=="Week 6", c("USUBJID","visit", "invsimpson")]
wk6.relRSP22Y.adiv <- wk6.ust.relRSP22Y.adiv
colnames(wk6.ust.relRSP22Y.adiv)[3] <- "Week6adiv"
wk6.ust.relRSP22Y.adiv <- subset(wk6.ust.relRSP22Y.adiv, select=-c(visit))

adiv.wk04 <- merge(wk0.ust.relRSP22Y.adiv, wk4.ust.relRSP22Y.adiv)
adiv.wk046 <- merge(adiv.wk04, wk6.ust.relRSP22Y.adiv)
rownames(adiv.wk046) <- adiv.wk046$USUBJID
adiv.wk046 <- as.matrix(adiv.wk046[,-1])
mean.adiv.byvis <- apply(adiv.wk046, 2, mean)

ggplot.wk04.adiv<-rbind(wk0.relRSP22Y.adiv, wk4.relRSP22Y.adiv)
ggplot.wk046.adiv<-rbind(ggplot.wk04.adiv, wk6.relRSP22Y.adiv)
kruskal.test(ggplot.wk046.adiv$invsimpson~ggplot.wk046.adiv$visit)
kruskalmc(ggplot.wk046.adiv$invsimpson~ggplot.wk046.adiv$visit)
friedman.test(adiv.wk046)
friedmanmc(adiv.wk046)
pairwise.wilcox.test(ggplot.wk046.adiv$invsimpson, ggplot.wk046.adiv$visit, p.adj="bonferroni", exact=F, paired=T)

ggplot(ggplot.wk046.adiv, aes(visit, invsimpson))+
	geom_boxplot() + theme(legend.position="none")


ggplot(ggplot.wk046.adiv, aes(x=visit, y=invsimpson)) +
	#stat_summary(fun.y=median, geom="bar", aes(fill = invsimpson), position = position_dodge(1), color="red") +
	#stat_summary(fun.data = 'median_hilow', fun.args = (conf.int=0.5), position = position_dodge(1), geom='errorbar', aes(color = "red"))+
	geom_boxplot(position=position_dodge(width = 1), alpha = .4) + guides(fill=FALSE) +
	ylab("Inverse Simpson") + xlab("Visit") + theme(legend.position="none") + 
	ggtitle("Change in alpha diversity in Treated Week 22 Responders") +
	geom_segment(aes(x=1, xend = 2, y = 31, yend = 31)) +
	geom_text(x=1.5, y= 33, label="*", size =10) + theme_bw()


adiv.vist.aov<- aov(ggplot.wk046.adiv$invsimpson~ggplot.wk046.adiv$visit + Error(ggplot.wk046.adiv$USUBJID/ggplot.wk046.adiv$visit))
TukeyHSD(adiv.vist.aov)

#change in adiv over time? Plac

wk0.plac.relRSP22Y.adiv <- wk046.plac.relRSP22Y[wk046.plac.relRSP22Y$visit=="Screening", c("USUBJID", "visit", "invsimpson")]
wk0.relRSP22Y.adiv <- wk0.plac.relRSP22Y.adiv
colnames(wk0.plac.relRSP22Y.adiv)[3] <- "Week0adiv"
wk0.plac.relRSP22Y.adiv <- subset(wk0.plac.relRSP22Y.adiv, select=-c(visit))

wk4.plac.relRSP22Y.adiv <- wk046.plac.relRSP22Y[wk046.plac.relRSP22Y$visit=="Week 4", c("USUBJID","visit", "invsimpson")]
wk4.relRSP22Y.adiv <- wk4.plac.relRSP22Y.adiv
colnames(wk4.plac.relRSP22Y.adiv)[3] <- "Week4adiv"
wk4.plac.relRSP22Y.adiv <- subset(wk4.plac.relRSP22Y.adiv, select=-c(visit))

wk6.plac.relRSP22Y.adiv <- wk046.plac.relRSP22Y[wk046.plac.relRSP22Y$visit=="Week 6", c("USUBJID","visit", "invsimpson")]
wk6.relRSP22Y.adiv <- wk6.plac.relRSP22Y.adiv
colnames(wk6.plac.relRSP22Y.adiv)[3] <- "Week6adiv"
wk6.plac.relRSP22Y.adiv <- subset(wk6.plac.relRSP22Y.adiv, select=-c(visit))

plac.adiv.wk04 <- merge(wk0.plac.relRSP22Y.adiv, wk4.plac.relRSP22Y.adiv)
plac.adiv.wk046 <- merge(plac.adiv.wk04, wk6.plac.relRSP22Y.adiv)
rownames(plac.adiv.wk046) <- plac.adiv.wk046$USUBJID
plac.adiv.wk046 <- as.matrix(plac.adiv.wk046[,-1])
mean.plac.adiv.byvis <- apply(plac.adiv.wk046, 2, mean)

ggplot.wk04.adiv<-rbind(wk0.relRSP22Y.adiv, wk4.relRSP22Y.adiv)
ggplot.wk046.adiv<-rbind(ggplot.wk04.adiv, wk6.relRSP22Y.adiv)
kruskal.test(ggplot.wk046.adiv$invsimpson~ggplot.wk046.adiv$visit)
kruskalmc(ggplot.wk046.adiv$invsimpson~ggplot.wk046.adiv$visit)
friedman.test(adiv.wk046)
friedmanmc(adiv.wk046)

ggplot(ggplot.wk046.adiv, aes(visit, invsimpson))+
	geom_jitter()

ggplot(ggplot.wk046.adiv, aes(x=visit, y=invsimpson)) +
	#stat_summary(fun.y=median, geom="point", aes(fill = otu), position = position_dodge(1)) +
	#stat_summary(fun.data = 'median_hilow', fun.args = (conf.int=0.5), position = position_dodge(1), geom='errorbar', aes(color = otu))+
	geom_jitter(position=position_dodge(width = 1), alpha = .4) + guides(fill=FALSE) +
	ylab("Inverse Simpson") + xlab("Visit") + theme(legend.position="none")

adiv.vist.aov<- aov(ggplot.wk046.adiv$invsimpson~ggplot.wk046.adiv$visit + Error(ggplot.wk046.adiv$USUBJID/ggplot.wk046.adiv$visit))
TukeyHSD(adiv.vist.aov)