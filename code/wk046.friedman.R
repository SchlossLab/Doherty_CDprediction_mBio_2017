#wk046_data.relRSP22Y

#change in adiv over time?
wk0.all.relRSP22Y.adiv <- wk046_data.relRSP22Y[wk046_data.relRSP22Y$visit=="Screening", c("USUBJID", "visit", "invsimpson", "TRTGR")]
wk0.relRSP22Y.adiv <- wk0.all.relRSP22Y.adiv
colnames(wk0.all.relRSP22Y.adiv)[3] <- "Week0adiv"
wk0.all.relRSP22Y.adiv <- subset(wk0.all.relRSP22Y.adiv, select=-c(visit))

wk4.all.relRSP22Y.adiv <- wk046_data.relRSP22Y[wk046_data.relRSP22Y$visit=="Week 4", c("USUBJID","visit", "invsimpson", "TRTGR")]
wk4.relRSP22Y.adiv <- wk4.all.relRSP22Y.adiv
colnames(wk4.all.relRSP22Y.adiv)[3] <- "Week4adiv"
wk4.all.relRSP22Y.adiv <- subset(wk4.all.relRSP22Y.adiv, select=-c(visit))

wk6.all.relRSP22Y.adiv <- wk046_data.relRSP22Y[wk046_data.relRSP22Y$visit=="Week 6", c("USUBJID","visit", "invsimpson", "TRTGR")]
wk6.relRSP22Y.adiv <- wk6.all.relRSP22Y.adiv
colnames(wk6.all.relRSP22Y.adiv)[3] <- "Week6adiv"
wk6.all.relRSP22Y.adiv <- subset(wk6.all.relRSP22Y.adiv, select=-c(visit))

adiv.wk04 <- merge(wk0.all.relRSP22Y.adiv, wk4.all.relRSP22Y.adiv)
adiv.wk046 <- merge(adiv.wk04, wk6.all.relRSP22Y.adiv)
rownames(adiv.wk046) <- adiv.wk046$USUBJID
adiv.wk046 <- adiv.wk046[,-c(1)]
adiv.wk046.trtd <- adiv.wk046[adiv.wk046$TRTGR=="Treated",]
adiv.wk046.trtd <- adiv.wk046.trtd[,-c(1)]
adiv.wk046.trtd.mat <- as.matrix(adiv.wk046.trtd)
#mean.adiv.wk046.trtd <- adiv.wk046.trtd[,-c(1)]
mean.adiv.byvis.trtd <- apply(adiv.wk046.trtd, 2, mean)

ggplot.wk04.adiv<-rbind(wk0.relRSP22Y.adiv, wk4.relRSP22Y.adiv)
ggplot.wk046.adiv<-rbind(ggplot.wk04.adiv, wk6.relRSP22Y.adiv)
kruskal.test(ggplot.wk046.adiv$invsimpson~ggplot.wk046.adiv$visit)
kruskalmc(ggplot.wk046.adiv$invsimpson~ggplot.wk046.adiv$visit)
friedman.test(adiv.wk046.trtd.mat)
friedmanmc(adiv.wk046.trtd.mat)
pairwise.wilcox.test(ggplot.wk046.adiv$invsimpson, ggplot.wk046.adiv$visit, p.adj="bonferroni", exact=F, paired=T)

ggplot(ggplot.wk046.adiv, aes(visit, invsimpson))+
	geom_boxplot() + theme(legend.position="none")


ggplot(ggplot.wk046.adiv, aes(x=visit, y=invsimpson, fill=TRTGR)) +
	#stat_summary(fun.y=mean, geom="point", aes(fill = invsimpson), position = position_dodge(1)) +
	#stat_summary(fun.data = 'median_hilow', fun.args = (conf.int=0.5), position = position_dodge(1), geom='errorbar', aes(color = otu))+
	geom_boxplot(position=position_dodge(width = 1), alpha = .4) + guides(fill=FALSE) +
	ylab("Inverse Simpson") + xlab("Visit") + theme(legend.position="none") + 
	ggtitle("Change in alpha diversity in Week 22 Responders") + facet_grid(.~TRTGR, labeller = label_bquote((x) + nrow(x)))
	#geom_segment(
		aes(x=1,
				xend = 2,
				y = 31,
				yend = 31)
	) +
	#geom_text(x=1.5, y= 33, label="*", size =10) 


adiv.vist.aov<- aov(ggplot.wk046.adiv$invsimpson~ggplot.wk046.adiv$visit + Error(ggplot.wk046.adiv$USUBJID/ggplot.wk046.adiv$visit))
TukeyHSD(adiv.vist.aov)
