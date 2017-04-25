#wk046_data

#change in adiv over time?
wk0.all.adiv <- wk046_data[wk046_data$visit=="Screening", c("USUBJID", "visit", "invsimpson", "INDTRTGR", "RelRSPwk22", "TRTGRINDMAN" )]
wk0.adiv <- wk0.all.adiv
colnames(wk0.all.adiv)[3] <- "Week0adiv"
wk0.all.adiv <- subset(wk0.all.adiv, select=-c(visit))

wk4.all.adiv <- wk046_data[wk046_data$visit=="Week 4", c("USUBJID","visit", "invsimpson", "INDTRTGR", "RelRSPwk22", "TRTGRINDMAN")]
wk4.adiv <- wk4.all.adiv
colnames(wk4.all.adiv)[3] <- "Week4adiv"
wk4.all.adiv <- subset(wk4.all.adiv, select=-c(visit))

wk6.all.adiv <- wk046_data[wk046_data$visit=="Week 6", c("USUBJID","visit", "invsimpson", "INDTRTGR", "RelRSPwk22", "TRTGRINDMAN")]
wk6.adiv <- wk6.all.adiv
colnames(wk6.all.adiv)[3] <- "Week6adiv"
wk6.all.adiv <- subset(wk6.all.adiv, select=-c(visit))

adiv.wk04 <- merge(wk0.all.adiv, wk4.all.adiv)
adiv.wk046 <- merge(adiv.wk04, wk6.all.adiv)
rownames(adiv.wk046) <- adiv.wk046$USUBJID
#adiv.wk046.trtd

adiv.wk046.mat <- adiv.wk046[,-c(1:4)]
mean.adiv.byvis <- apply(adiv.wk046.mat, 2, mean)


#adiv.wk046 <- adiv.wk046[,-1]
#mean.adiv.byvis <- apply(adiv.wk046[,-c(1:2)], 2, mean)
treatedresp <- wk0.all.adiv[wk0.all.adiv$INDTRTGR=="Treated",]
#treatedrespY <- treatedrespY[treatedrespY$visit=="Screening",]
treatedrespY <- treatedresp[treatedresp$RelRSPwk22=="Yes",]
treatedrespN <- treatedresp[treatedresp$RelRSPwk22=="No",]
wk046.treatedrespY <- adiv.wk046[adiv.wk046$USUBJID %in% treatedrespY$USUBJID,]
#wk046.treatedrespY <- wk046.treatedrespY[, -c(1:3)]
#rownames(wk046.treatedrespY) <- wk046.treatedrespY$USUBJID
wk046.treatedrespY <- as.matrix(subset(wk046.treatedrespY,select = -c(USUBJID, INDTRTGR, RelRSPwk22, TRTGRINDMAN)))
mean.wk046.treatedrespY.adiv.byvis <- apply(wk046.treatedrespY, 2, mean)

wk046.treatedrespN <- adiv.wk046[adiv.wk046$USUBJID %in% treatedrespN$USUBJID,]
#wk046.treatedrespN <- wk046.treatedrespN[, -c(4:5)]
rownames(wk046.treatedrespN) <- wk046.treatedrespN$USUBJID
wk046.treatedrespN <- as.matrix(subset(wk046.treatedrespN,select = -c(USUBJID, INDTRTGR, RelRSPwk22, TRTGRINDMAN)))
mean.wk046.treatedrespN.adiv.byvis <- apply(wk046.treatedrespN, 2, mean)


ggplot.wk04.adiv<-rbind(wk0.adiv, wk4.adiv)
ggplot.wk046.adiv<-rbind(ggplot.wk04.adiv, wk6.adiv)
# kruskal.test(ggplot.wk046.adiv$invsimpson~ggplot.wk046.adiv$visit)
# kruskalmc(ggplot.wk046.adiv$invsimpson~ggplot.wk046.adiv$visit)

treatedresp <- ggplot.wk046.adiv[ggplot.wk046.adiv$INDTRTGR=="Treated",]
treatedresp <- treatedresp[treatedresp$visit=="Screening",]
treatedrespY <- treatedresp[treatedresp$RelRSPwk22=="Yes",]
ggplot.wk046.treatedrespY <- ggplot.wk046.adiv[ggplot.wk046.adiv$USUBJID %in% treatedrespY$USUBJID,]
ggplot.wk046.treatedrespY <- ggplot.wk046.treatedrespY[, -c(4:6)]


treatedrespN <- treatedresp[treatedresp$RelRSPwk22=="No",]
ggplot.wk046.treatedrespN <- ggplot.wk046.adiv[ggplot.wk046.adiv$USUBJID %in% treatedrespN$USUBJID,]
ggplot.wk046.treatedrespN <- ggplot.wk046.treatedrespN[, -c(4:6)]


#kruskal.test(ggplot.wk046.treatedrespY$invsimpson~ggplot.wk046.treatedrespY$visit)
#kruskalmc(ggplot.wk046.treatedrespY$invsimpson~ggplot.wk046.treatedrespY$visit)
set.seed(32016)
wk046.treatedrespY.fried <- friedman.test(wk046.treatedrespY)

friedmc <- friedmanmc(wk046.treatedrespY)
friedmc
pairwise.wilcox.test(ggplot.wk046.treatedrespY$invsimpson, ggplot.wk046.treatedrespY$visit, p.adj="BH", exact=F, paired=T)

#kruskal.test(ggplot.wk046.treatedrespN$invsimpson~ggplot.wk046.treatedrespN$visit)
#kruskalmc(ggplot.wk046.treatedrespN$invsimpson~ggplot.wk046.treatedrespN$visit)
friedman.test(wk046.treatedrespN)
friedmc <- friedmanmc(wk046.treatedrespN)
friedmc
pairwise.wilcox.test(ggplot.wk046.treatedrespN$invsimpson, ggplot.wk046.treatedrespN$visit, p.adj="BH", exact=F, paired=T)



#adiv.wk046 <- adiv.wk046[,-1]
#mean.adiv.byvis <- apply(adiv.wk046[,-c(1:2)], 2, mean)
placeboresp <- wk0.all.adiv[wk0.all.adiv$INDTRTGR=="Placebo",]
#placeborespY <- placeborespY[placeborespY$visit=="Screening",]
placeborespY <- placeboresp[placeboresp$RelRSPwk22=="Yes",]
placeborespN <- placeboresp[placeboresp$RelRSPwk22=="No",]
wk046.placeborespY <- adiv.wk046[adiv.wk046$USUBJID %in% placeborespY$USUBJID,]
#wk046.placeborespY <- wk046.placeborespY[, -c(4:5)]
rownames(wk046.placeborespY) <- wk046.placeborespY$USUBJID
wk046.placeborespY <- as.matrix(wk046.placeborespY[,-c(1:4)])
mean.wk046.placeborespY.adiv.byvis <- apply(wk046.placeborespY, 2, mean)

wk046.placeborespN <- adiv.wk046[adiv.wk046$USUBJID %in% placeborespN$USUBJID,]
#wk046.placeborespN <- wk046.placeborespN[, -c(4:5)]
rownames(wk046.placeborespN) <- wk046.placeborespN$USUBJID
wk046.placeborespN <- as.matrix(wk046.placeborespN[,-c(1:4)])
mean.wk046.placeborespN.adiv.byvis <- apply(wk046.placeborespN, 2, mean)

ggplot.wk04.adiv<-rbind(wk0.adiv, wk4.adiv)
ggplot.wk046.adiv<-rbind(ggplot.wk04.adiv, wk6.adiv)
levels(ggplot.wk046.adiv$RelRSPwk22) <- c("Nonresponder", "Responder")
placeboresp <- ggplot.wk046.adiv[ggplot.wk046.adiv$INDTRTGR=="Placebo",]
placeboresp <- placeboresp[placeboresp$visit=="Screening",]
placeborespY <- placeboresp[placeboresp$RelRSPwk22=="Yes",]
ggplot.wk046.placeborespY <- ggplot.wk046.adiv[ggplot.wk046.adiv$USUBJID %in% placeborespY$USUBJID,]
ggplot.wk046.placeborespY <- ggplot.wk046.placeborespY[, -c(4:6)]


placeborespN <- placeboresp[placeboresp$RelRSPwk22=="No",]
ggplot.wk046.placeborespN <- ggplot.wk046.adiv[ggplot.wk046.adiv$USUBJID %in% placeborespN$USUBJID,]
ggplot.wk046.placeborespN <- ggplot.wk046.placeborespN[, -c(4:6)]


#kruskal.test(ggplot.wk046.placeborespY$invsimpson~ggplot.wk046.adiv$visit)
#kruskalmc(ggplot.wk046.adiv$invsimpson~ggplot.wk046.adiv$visit)
friedman.test(wk046.placeborespY)
friedmc <- friedmanmc(wk046.placeborespY)
friedmc
pairwise.wilcox.test(ggplot.wk046.placeborespY$invsimpson, ggplot.wk046.placeborespY$visit, p.adj="BH", exact=F, paired=T)

#kruskal.test(ggplot.wk046.placeborespN$invsimpson~ggplot.wk046.adiv$visit)
#kruskalmc(ggplot.wk046.adiv$invsimpson~ggplot.wk046.adiv$visit)
friedman.test(wk046.placeborespN)
friedmc <- friedmanmc(wk046.placeborespN)
friedmc
pairwise.wilcox.test(ggplot.wk046.placeborespN$invsimpson, ggplot.wk046.placeborespN$visit, p.adj="BH", exact=F, paired=T)


ggplot(ggplot.wk046.treatedrespY, aes(visit, invsimpson))+
	geom_boxplot() + theme(legend.position="none")

ann_text <- data.frame(visit = 2, invsimpson = 31,
											 INDTRTGR = "Treated", RelRSPwk22 = "Responder")

wk046.adivXvisXindtrtXrelRSPwk22.plot <- ggplot(ggplot.wk046.adiv, aes(x=visit, y=invsimpson, fill=INDTRTGR)) +
	#stat_summary(fun.y=mean, geom="point", aes(fill = invsimpson), position = position_dodge(1)) +
	#stat_summary(fun.data = 'median_hilow', fun.args = (conf.int=0.5), position = position_dodge(1), geom='errorbar', aes(color = otu))+
	geom_boxplot(position=position_dodge(width = 1), alpha = .4) + guides(fill=FALSE) +
	ylab("Inverse Simpson") + xlab("Stool Sample") + theme(legend.position="none") + 
	ggtitle("Change in Species Diversity over time by Induction Group and Week 22 Response") + 
	facet_grid(.~INDTRTGR + RelRSPwk22, labeller = label_bquote((x) + nrow(x))) +
	theme(plot.title = element_text(hjust = 0.5)) + geom_text(data = ann_text, label = "*", size=10)

pdf("figures/DDW_wk046.adivXvisitXindtrtXrelRSPwk22.pdf", height = 6, width = 10)
wk046.adivXvisXindtrtXrelRSPwk22.plot
dev.off()

wk046.adivXvisXindtrtXrelRSPwk22.plot <- ggplot(ggplot.wk046.adiv, aes(x=visit, y=invsimpson, fill=INDTRTGR)) +
	#stat_summary(fun.y=mean, geom="point", aes(fill = invsimpson), position = position_dodge(1)) +
	#stat_summary(fun.data = 'median_hilow', fun.args = (conf.int=0.5), position = position_dodge(1), geom='errorbar', aes(color = otu))+
	geom_boxplot(position=position_dodge(width = 1), alpha = .4) + guides(fill=FALSE) +
	ylab("Inverse Simpson") + xlab("Stool Sample") + theme(legend.position="none") + 
	#ggtitle("Change in Species Diversity over time by Induction Group and Week 22 Response") + 
	facet_grid(.~INDTRTGR + RelRSPwk22, labeller = label_bquote((x) + nrow(x))) +
	theme(plot.title = element_text(hjust = 0.5)) + geom_text(data = ann_text, label = "*", size=10)

#tiff("figures/wk046.adivXvisitXindtrtXrelRSPwk22.tiff", height = 6, width = 10, units = "in", res = 300)
pdf("figures/Figure4_wk046.adivXvisitXindtrtXrelRSPwk22.pdf", height = 6, width = 10)
wk046.adivXvisXindtrtXrelRSPwk22.plot
dev.off()


ann_text <- data.frame(visit = 2, invsimpson = 31)
trtrY.wk046.adivXvisXindtrtXrelRSPwk22.plot <- ggplot(ggplot.wk046.treatedrespY, aes(x=visit, y=invsimpson)) +
	#stat_summary(fun.y=mean, geom="point", aes(fill = invsimpson), position = position_dodge(1)) +
	#stat_summary(fun.data = 'median_hilow', fun.args = (conf.int=0.5), position = position_dodge(1), geom='errorbar', aes(color = otu))+
	geom_boxplot(position=position_dodge(width = 1), alpha = .4) + #guides(fill=FALSE) +
	ylab("Inverse Simpson") + xlab("Stool Sample") + theme(legend.position="none") + 
	#ggtitle("Change in Species Diversity over time by Induction Group and Week 22 Response") + 
	#facet_grid(.~INDTRTGR + RelRSPwk22, labeller = label_bquote((x) + nrow(x))) +
	theme(plot.title = element_text(hjust = 0.5)) + geom_text(data = ann_text, label = "*", size=10)


#adiv.vist.aov<- aov(ggplot.wk046.adiv$invsimpson~ggplot.wk046.adiv$visit + Error(ggplot.wk046.adiv$USUBJID/ggplot.wk046.adiv$visit))
#TukeyHSD(adiv.vist.aov)


#friedman.test(adiv.wk046.trtd)
#friedmanmc(adiv.wk046)
#pairwise.wilcox.test(ggplot.wk046.adiv$invsimpson, ggplot.wk046.adiv$visit, p.adj="bonferroni", exact=F, paired=T)

#ggplot(ggplot.wk046.adiv, aes(visit, invsimpson))+
#	geom_boxplot() + theme(legend.position="none")


ggplot(ggplot.wk046.adiv, aes(x=visit, y=invsimpson, fill=INDTRTGR)) +
	#stat_summary(fun.y=mean, geom="point", aes(fill = invsimpson), position = position_dodge(1)) +
	#stat_summary(fun.data = 'median_hilow', fun.args = (conf.int=0.5), position = position_dodge(1), geom='errorbar', aes(color = otu))+
	geom_boxplot(position=position_dodge(width = 1), alpha = .4) + guides(fill=FALSE) +
	ylab("Inverse Simpson") + xlab("Visit") + theme(legend.position="none") + 
	ggtitle("Change in alpha diversity by Treatment Group and Week 22 Response") + 
	facet_grid(.~INDTRTGR + RelRSPwk22, labeller = label_bquote((x) + nrow(x))) +
	theme(plot.title = element_text(hjust = 0.5))
#geom_segment(
# aes(x=1,
# 		xend = 2,
# 		y = 31,
# 		yend = 31)
# ) +
	#geom_text(x=1.5, y= 33, label="*", size =10) 
	
	
#	adiv.vist.aov<- aov(ggplot.wk046.adiv$invsimpson~ggplot.wk046.adiv$visit + Error(ggplot.wk046.adiv$USUBJID/ggplot.wk046.adiv$visit))
#	TukeyHSD(adiv.vist.aov)
	