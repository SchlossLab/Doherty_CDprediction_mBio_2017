wk046_data

#change in adiv over time?
wk0.all.adiv <- wk046_data[wk046_data$visit=="Screening", c("USUBJID", "visit", "invsimpson", "INDTRTGR", "RelRSPwk22")]
wk0.adiv <- wk0.all.adiv
colnames(wk0.all.adiv)[3] <- "Week0adiv"
wk0.all.adiv <- subset(wk0.all.adiv, select=-c(visit))

wk4.all.adiv <- wk046_data[wk046_data$visit=="Week 4", c("USUBJID","visit", "invsimpson", "INDTRTGR", "RelRSPwk22")]
wk4.adiv <- wk4.all.adiv
colnames(wk4.all.adiv)[3] <- "Week4adiv"
wk4.all.adiv <- subset(wk4.all.adiv, select=-c(visit))

wk6.all.adiv <- wk046_data[wk046_data$visit=="Week 6", c("USUBJID","visit", "invsimpson", "INDTRTGR", "RelRSPwk22")]
wk6.adiv <- wk6.all.adiv
colnames(wk6.all.adiv)[3] <- "Week6adiv"
wk6.all.adiv <- subset(wk6.all.adiv, select=-c(visit))

adiv.wk04 <- merge(wk0.all.adiv, wk4.all.adiv)
adiv.wk046 <- merge(adiv.wk04, wk6.all.adiv)
rownames(adiv.wk046) <- adiv.wk046$USUBJID
adiv.wk046 <- adiv.wk046[,-c(1:3)]
mean.adiv.byvis <- apply(adiv.wk046, 2, mean)

ggplot.wk04.adiv<-rbind(wk0.adiv, wk4.adiv)
ggplot.wk046.adiv<-rbind(ggplot.wk04.adiv, wk6.adiv)
kruskal.test(ggplot.wk046.adiv$invsimpson~ggplot.wk046.adiv$visit)
kruskalmc(ggplot.wk046.adiv$invsimpson~ggplot.wk046.adiv$visit)
friedman.test(adiv.wk046)
friedmanmc(adiv.wk046)
pairwise.wilcox.test(ggplot.wk046.adiv$invsimpson, ggplot.wk046.adiv$visit, p.adj="bonferroni", exact=F, paired=T)

ggplot(ggplot.wk046.adiv, aes(visit, invsimpson))+
	geom_boxplot() + theme(legend.position="none")


ggplot(ggplot.wk046.adiv, aes(x=visit, y=invsimpson, fill=INDTRTGR)) +
	#stat_summary(fun.y=mean, geom="point", aes(fill = invsimpson), position = position_dodge(1)) +
	#stat_summary(fun.data = 'median_hilow', fun.args = (conf.int=0.5), position = position_dodge(1), geom='errorbar', aes(color = otu))+
	geom_boxplot(position=position_dodge(width = 1), alpha = .4) + guides(fill=FALSE) +
	ylab("Inverse Simpson") + xlab("Visit") + theme(legend.position="none") + 
	ggtitle("Change in alpha diversity by Treatment Group and Week 22 Response") + 
	facet_grid(.~INDTRTGR + RelRSPwk22, labeller = label_bquote((x) + nrow(x))) +
	theme(plot.title = element_text(hjust = 0.5))
#geom_segment(
aes(x=1,
		xend = 2,
		y = 31,
		yend = 31)
) +
	#geom_text(x=1.5, y= 33, label="*", size =10) 
	
	
	adiv.vist.aov<- aov(ggplot.wk046.adiv$invsimpson~ggplot.wk046.adiv$visit + Error(ggplot.wk046.adiv$USUBJID/ggplot.wk046.adiv$visit))
	TukeyHSD(adiv.vist.aov)
	