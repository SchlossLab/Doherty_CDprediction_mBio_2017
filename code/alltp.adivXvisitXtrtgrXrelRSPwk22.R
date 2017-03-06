alltime_data

#change in adiv over time?
wk0.all.adiv <- alltime_data[alltime_data$visit=="Screening", c("USUBJID", "visit", "invsimpson", "TRTGR", "RelRSPwk22")]
wk0.adiv <- wk0.all.adiv
colnames(wk0.all.adiv)[3] <- "Week0adiv"
wk0.all.adiv <- subset(wk0.all.adiv, select=-c(visit))

wk4.all.adiv <- alltime_data[alltime_data$visit=="Week 4", c("USUBJID","visit", "invsimpson", "TRTGR", "RelRSPwk22")]
wk4.adiv <- wk4.all.adiv
colnames(wk4.all.adiv)[3] <- "Week4adiv"
wk4.all.adiv <- subset(wk4.all.adiv, select=-c(visit))

wk6.all.adiv <- alltime_data[alltime_data$visit=="Week 6", c("USUBJID","visit", "invsimpson", "TRTGR", "RelRSPwk22")]
wk6.adiv <- wk6.all.adiv
colnames(wk6.all.adiv)[3] <- "Week6adiv"
wk6.all.adiv <- subset(wk6.all.adiv, select=-c(visit))

wk22.all.adiv <- alltime_data[alltime_data$visit=="Week 22", c("USUBJID","visit", "invsimpson", "TRTGR", "RelRSPwk22")]
wk22.adiv <- wk22.all.adiv
colnames(wk22.all.adiv)[3] <- "Week22adiv"
wk22.all.adiv <- subset(wk22.all.adiv, select=-c(visit))

adiv.wk04 <- merge(wk0.all.adiv, wk4.all.adiv)
adiv.wk046 <- merge(adiv.wk04, wk6.all.adiv)
adiv.alltp <- merge(adiv.wk046, wk22.all.adiv)

#adiv.alltp <- adiv.alltp[,-1]
#mean.adiv.byvis <- apply(adiv.alltp[,-c(1:2)], 2, mean)
treatedrespY <- wk0.all.adiv[wk0.all.adiv$TRTGR=="Treated",]
#treatedrespY <- treatedrespY[treatedrespY$visit=="Screening",]
treatedrespY <- treatedrespY[treatedrespY$RelRSPwk22=="Yes",]
alltp.treatedrespY <- adiv.alltp[adiv.alltp$USUBJID %in% treatedrespY$USUBJID,]
#alltp.treatedrespY <- alltp.treatedrespY[, -c(4:5)]
rownames(alltp.treatedrespY) <- alltp.treatedrespY$USUBJID
alltp.treatedrespY <- as.matrix(alltp.treatedrespY[,-c(1:3)])
mean.adiv.byvis <- apply(alltp.treatedrespY, 2, mean)

ggplot.wk04.adiv<-rbind(wk0.adiv, wk4.adiv)
ggplot.wk046.adiv<-rbind(ggplot.wk04.adiv, wk6.adiv)
ggplot.alltp.adiv<-rbind(ggplot.wk046.adiv, wk22.adiv)
treatedrespY <- ggplot.alltp.adiv[ggplot.alltp.adiv$TRTGR=="Treated",]
treatedrespY <- treatedrespY[treatedrespY$visit=="Screening",]
treatedrespY <- treatedrespY[treatedrespY$RelRSPwk22=="Yes",]
ggplot.alltp.treatedrespY <- ggplot.alltp.adiv[ggplot.alltp.adiv$USUBJID %in% treatedrespY$USUBJID,]
ggplot.alltp.treatedrespY <- ggplot.alltp.treatedrespY[, -c(4:5)]


kruskal.test(ggplot.alltp.treatedrespY$invsimpson~ggplot.alltp.adiv$visit)
kruskalmc(ggplot.alltp.adiv$invsimpson~ggplot.alltp.adiv$visit)
friedman.test(alltp.treatedrespY)
friedmanmc(alltp.treatedrespY)
pairwise.wilcox.test(ggplot.alltp.treatedrespY$invsimpson, ggplot.alltp.treatedrespY$visit, p.adj="bonferroni", exact=F, paired=T)

ggplot(ggplot.alltp.treatedrespY, aes(visit, invsimpson))+
	geom_boxplot() + theme(legend.position="none")


ggplot(ggplot.alltp.treatedrespY, aes(x=visit, y=invsimpson, fill=TRTGR)) +
	#stat_summary(fun.y=mean, geom="point", aes(fill = invsimpson), position = position_dodge(1)) +
	#stat_summary(fun.data = 'median_hilow', fun.args = (conf.int=0.5), position = position_dodge(1), geom='errorbar', aes(color = otu))+
	geom_boxplot(position=position_dodge(width = 1), alpha = .4) + guides(fill=FALSE) +
	ylab("Inverse Simpson") + xlab("Visit") + theme(legend.position="none") + 
	ggtitle("Change in alpha diversity by Treatment Group and Week 22 Response") + 
	facet_grid(.~TRTGR + RelRSPwk22, labeller = label_bquote((x) + nrow(x))) +
	theme(plot.title = element_text(hjust = 0.5))
#geom_segment(
aes(x=1,
		xend = 2,
		y = 31,
		yend = 31)
) +
	#geom_text(x=1.5, y= 33, label="*", size =10) 
	
	
	adiv.vist.aov<- aov(ggplot.alltp.adiv$invsimpson~ggplot.alltp.adiv$visit + Error(ggplot.alltp.adiv$USUBJID/ggplot.alltp.adiv$visit))
	TukeyHSD(adiv.vist.aov)
	