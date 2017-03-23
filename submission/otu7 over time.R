wk046_data

#change in Otu00007 over time?
wk0.all.Otu00007 <- wk046_data[wk046_data$visit=="Screening", c("USUBJID", "visit", "Otu00007", "INDTRTGR", "RelRSPwk22", "TRTGRINDMAN" )]
wk0.Otu00007 <- wk0.all.Otu00007
colnames(wk0.all.Otu00007)[3] <- "Week0Otu00007"
wk0.all.Otu00007 <- subset(wk0.all.Otu00007, select=-c(visit))

wk4.all.Otu00007 <- wk046_data[wk046_data$visit=="Week 4", c("USUBJID","visit", "Otu00007", "INDTRTGR", "RelRSPwk22", "TRTGRINDMAN")]
wk4.Otu00007 <- wk4.all.Otu00007
colnames(wk4.all.Otu00007)[3] <- "Week4Otu00007"
wk4.all.Otu00007 <- subset(wk4.all.Otu00007, select=-c(visit))

wk6.all.Otu00007 <- wk046_data[wk046_data$visit=="Week 6", c("USUBJID","visit", "Otu00007", "INDTRTGR", "RelRSPwk22", "TRTGRINDMAN")]
wk6.Otu00007 <- wk6.all.Otu00007
colnames(wk6.all.Otu00007)[3] <- "Week6Otu00007"
wk6.all.Otu00007 <- subset(wk6.all.Otu00007, select=-c(visit))

Otu00007.wk04 <- merge(wk0.all.Otu00007, wk4.all.Otu00007)
Otu00007.wk046 <- merge(Otu00007.wk04, wk6.all.Otu00007)
rownames(Otu00007.wk046) <- Otu00007.wk046$USUBJID
#Otu00007.wk046.trtd

Otu00007.wk046.mat <- Otu00007.wk046[,-c(1:4)]
mean.Otu00007.byvis <- apply(Otu00007.wk046.mat, 2, mean)


#Otu00007.wk046 <- Otu00007.wk046[,-1]
#mean.Otu00007.byvis <- apply(Otu00007.wk046[,-c(1:2)], 2, mean)
treatedresp <- wk0.all.Otu00007[wk0.all.Otu00007$INDTRTGR=="Treated",]
#treatedrespY <- treatedrespY[treatedrespY$visit=="Screening",]
treatedrespY <- treatedresp[treatedresp$RelRSPwk22=="Yes",]
treatedrespN <- treatedresp[treatedresp$RelRSPwk22=="No",]
wk046.treatedrespY <- Otu00007.wk046[Otu00007.wk046$USUBJID %in% treatedrespY$USUBJID,]
#wk046.treatedrespY <- wk046.treatedrespY[, -c(1:3)]
#rownames(wk046.treatedrespY) <- wk046.treatedrespY$USUBJID
wk046.treatedrespY <- as.matrix(subset(wk046.treatedrespY,select = -c(USUBJID, INDTRTGR, RelRSPwk22, TRTGRINDMAN)))
mean.wk046.treatedrespY.Otu00007.byvis <- apply(wk046.treatedrespY, 2, mean)

wk046.treatedrespN <- Otu00007.wk046[Otu00007.wk046$USUBJID %in% treatedrespN$USUBJID,]
#wk046.treatedrespN <- wk046.treatedrespN[, -c(4:5)]
rownames(wk046.treatedrespN) <- wk046.treatedrespN$USUBJID
wk046.treatedrespN <- as.matrix(subset(wk046.treatedrespN,select = -c(USUBJID, INDTRTGR, RelRSPwk22, TRTGRINDMAN)))
mean.wk046.treatedrespN.Otu00007.byvis <- apply(wk046.treatedrespN, 2, mean)


ggplot.wk04.Otu00007<-rbind(wk0.Otu00007, wk4.Otu00007)
ggplot.wk046.Otu00007<-rbind(ggplot.wk04.Otu00007, wk6.Otu00007)
kruskal.test(ggplot.wk046.Otu00007$Otu00007~ggplot.wk046.Otu00007$visit)
kruskalmc(ggplot.wk046.Otu00007$Otu00007~ggplot.wk046.Otu00007$visit)

treatedresp <- ggplot.wk046.Otu00007[ggplot.wk046.Otu00007$INDTRTGR=="Treated",]
treatedresp <- treatedresp[treatedresp$visit=="Screening",]
treatedrespY <- treatedresp[treatedresp$RelRSPwk22=="Yes",]
ggplot.wk046.treatedrespY <- ggplot.wk046.Otu00007[ggplot.wk046.Otu00007$USUBJID %in% treatedrespY$USUBJID,]
ggplot.wk046.treatedrespY <- ggplot.wk046.treatedrespY[, -c(4:6)]


treatedrespN <- treatedresp[treatedresp$RelRSPwk22=="No",]
ggplot.wk046.treatedrespN <- ggplot.wk046.Otu00007[ggplot.wk046.Otu00007$USUBJID %in% treatedrespN$USUBJID,]
ggplot.wk046.treatedrespN <- ggplot.wk046.treatedrespN[, -c(4:6)]


kruskal.test(ggplot.wk046.treatedrespY$Otu00007~ggplot.wk046.treatedrespY$visit)
kruskalmc(ggplot.wk046.treatedrespY$Otu00007~ggplot.wk046.treatedrespY$visit)
friedman.test(wk046.treatedrespY)
friedmc <- friedmanmc(wk046.treatedrespY)
friedmc
pairwise.wilcox.test(ggplot.wk046.treatedrespY$Otu00007, ggplot.wk046.treatedrespY$visit, p.adj="BH", exact=F, paired=T)

kruskal.test(ggplot.wk046.treatedrespN$Otu00007~ggplot.wk046.treatedrespN$visit)
kruskalmc(ggplot.wk046.treatedrespN$Otu00007~ggplot.wk046.treatedrespN$visit)
friedman.test(wk046.treatedrespN)
friedmc <- friedmanmc(wk046.treatedrespN)
friedmc
pairwise.wilcox.test(ggplot.wk046.treatedrespN$Otu00007, ggplot.wk046.treatedrespN$visit, p.adj="BH", exact=F, paired=T)



#Otu00007.wk046 <- Otu00007.wk046[,-1]
#mean.Otu00007.byvis <- apply(Otu00007.wk046[,-c(1:2)], 2, mean)
placeboresp <- wk0.all.Otu00007[wk0.all.Otu00007$INDTRTGR=="Placebo",]
#placeborespY <- placeborespY[placeborespY$visit=="Screening",]
placeborespY <- placeboresp[placeboresp$RelRSPwk22=="Yes",]
placeborespN <- placeboresp[placeboresp$RelRSPwk22=="No",]
wk046.placeborespY <- Otu00007.wk046[Otu00007.wk046$USUBJID %in% placeborespY$USUBJID,]
#wk046.placeborespY <- wk046.placeborespY[, -c(4:5)]
rownames(wk046.placeborespY) <- wk046.placeborespY$USUBJID
wk046.placeborespY <- as.matrix(wk046.placeborespY[,-c(1:4)])
mean.wk046.placeborespY.Otu00007.byvis <- apply(wk046.placeborespY, 2, mean)

wk046.placeborespN <- Otu00007.wk046[Otu00007.wk046$USUBJID %in% placeborespN$USUBJID,]
#wk046.placeborespN <- wk046.placeborespN[, -c(4:5)]
rownames(wk046.placeborespN) <- wk046.placeborespN$USUBJID
wk046.placeborespN <- as.matrix(wk046.placeborespN[,-c(1:4)])
mean.wk046.placeborespN.Otu00007.byvis <- apply(wk046.placeborespN, 2, mean)

ggplot.wk04.Otu00007<-rbind(wk0.Otu00007, wk4.Otu00007)
ggplot.wk046.Otu00007<-rbind(ggplot.wk04.Otu00007, wk6.Otu00007)
placeboresp <- ggplot.wk046.Otu00007[ggplot.wk046.Otu00007$INDTRTGR=="Placebo",]
placeboresp <- placeboresp[placeboresp$visit=="Screening",]
placeborespY <- placeboresp[placeboresp$RelRSPwk22=="Yes",]
ggplot.wk046.placeborespY <- ggplot.wk046.Otu00007[ggplot.wk046.Otu00007$USUBJID %in% placeborespY$USUBJID,]
ggplot.wk046.placeborespY <- ggplot.wk046.placeborespY[, -c(4:6)]


placeborespN <- placeboresp[placeboresp$RelRSPwk22=="No",]
ggplot.wk046.placeborespN <- ggplot.wk046.Otu00007[ggplot.wk046.Otu00007$USUBJID %in% placeborespN$USUBJID,]
ggplot.wk046.placeborespN <- ggplot.wk046.placeborespN[, -c(4:6)]


kruskal.test(ggplot.wk046.placeborespY$Otu00007~ggplot.wk046.Otu00007$visit)
kruskalmc(ggplot.wk046.Otu00007$Otu00007~ggplot.wk046.Otu00007$visit)
friedman.test(wk046.placeborespY)
friedmc <- friedmanmc(wk046.placeborespY)
friedmc
pairwise.wilcox.test(ggplot.wk046.placeborespY$Otu00007, ggplot.wk046.placeborespY$visit, p.adj="BH", exact=F, paired=T)

kruskal.test(ggplot.wk046.placeborespN$Otu00007~ggplot.wk046.Otu00007$visit)
kruskalmc(ggplot.wk046.Otu00007$Otu00007~ggplot.wk046.Otu00007$visit)
friedman.test(wk046.placeborespN)
friedmc <- friedmanmc(wk046.placeborespN)
friedmc
pairwise.wilcox.test(ggplot.wk046.placeborespN$Otu00007, ggplot.wk046.placeborespN$visit, p.adj="BH", exact=F, paired=T)


ggplot(ggplot.wk046.treatedrespY, aes(visit, Otu00007))+
	geom_boxplot() + theme(legend.position="none")

ann_text <- data.frame(visit = 2, Otu00007 = 31,
											 INDTRTGR = "Treated", RelRSPwk22 = "Yes")

wk046.Otu00007XvisXindtrtXrelRSPwk22.plot <- ggplot(ggplot.wk046.Otu00007, aes(x=visit, y=Otu00007, fill=INDTRTGR)) +
	#stat_summary(fun.y=mean, geom="point", aes(fill = Otu00007), position = position_dodge(1)) +
	#stat_summary(fun.data = 'median_hilow', fun.args = (conf.int=0.5), position = position_dodge(1), geom='errorbar', aes(color = otu))+
	geom_boxplot(position=position_dodge(width = 1), alpha = .4) + guides(fill=FALSE) +
	ylab("Inverse Simpson") + xlab("Visit") + theme(legend.position="none") + 
	ggtitle("Change in Species Diversity over time \n by Induction Group and Week 22 Response") + 
	facet_grid(.~INDTRTGR + RelRSPwk22, labeller = label_bquote((x) + nrow(x))) +
	theme(plot.title = element_text(hjust = 0.5)) + geom_text(data = ann_text, label = "*", size=10)

#tiff("figures/wk046.Otu00007XvisitXindtrtXrelRSPwk22.tiff", height = 6, width = 10, units = "in", res = 300)
pdf("figures/wk046.Otu00007XvisitXindtrtXrelRSPwk22.pdf", height = 6, width = 10)
wk046.Otu00007XvisXindtrtXrelRSPwk22.plot
dev.off()


Otu00007.vist.aov<- aov(ggplot.wk046.Otu00007$Otu00007~ggplot.wk046.Otu00007$visit + Error(ggplot.wk046.Otu00007$USUBJID/ggplot.wk046.Otu00007$visit))
TukeyHSD(Otu00007.vist.aov)


friedman.test(Otu00007.wk046.trtd)
friedmanmc(Otu00007.wk046)
pairwise.wilcox.test(ggplot.wk046.Otu00007$Otu00007, ggplot.wk046.Otu00007$visit, p.adj="bonferroni", exact=F, paired=T)

ggplot(ggplot.wk046.Otu00007, aes(visit, Otu00007))+
	geom_boxplot() + theme(legend.position="none")


ggplot(ggplot.wk046.Otu00007, aes(x=visit, y=Otu00007, fill=INDTRTGR)) +
	#stat_summary(fun.y=mean, geom="point", aes(fill = Otu00007), position = position_dodge(1)) +
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
	
	
	Otu00007.vist.aov<- aov(ggplot.wk046.Otu00007$Otu00007~ggplot.wk046.Otu00007$visit + Error(ggplot.wk046.Otu00007$USUBJID/ggplot.wk046.Otu00007$visit))
	TukeyHSD(Otu00007.vist.aov)
	