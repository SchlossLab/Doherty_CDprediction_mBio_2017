alltime_data <- alltime_data[alltime_data$TRTGRINDMAN != "Treated_Placebo",]

summary(alltime_data[, c("USUBJID", "visit", "invsimpson", "INDTRTGR", "TRTGRINDMAN", "RelRSPwk22")])

#change in adiv over time?
wk0.all.adiv <- alltime_data[alltime_data$visit=="Screening", c("USUBJID", "visit", "invsimpson", "INDTRTGR", "TRTGRINDMAN", "RelRSPwk22")]
wk0.adiv <- wk0.all.adiv
colnames(wk0.all.adiv)[3] <- "Week0adiv"
wk0.all.adiv <- subset(wk0.all.adiv, select=-c(visit))

wk4.all.adiv <- alltime_data[alltime_data$visit=="Week 4", c("USUBJID","visit", "invsimpson", "INDTRTGR", "TRTGRINDMAN", "RelRSPwk22")]
wk4.adiv <- wk4.all.adiv
colnames(wk4.all.adiv)[3] <- "Week4adiv"
wk4.all.adiv <- subset(wk4.all.adiv, select=-c(visit))

wk6.all.adiv <- alltime_data[alltime_data$visit=="Week 6", c("USUBJID","visit", "invsimpson", "INDTRTGR", "TRTGRINDMAN", "RelRSPwk22")]
wk6.adiv <- wk6.all.adiv
colnames(wk6.all.adiv)[3] <- "Week6adiv"
wk6.all.adiv <- subset(wk6.all.adiv, select=-c(visit))

wk22.all.adiv <- alltime_data[alltime_data$visit=="Week 22", c("USUBJID","visit", "invsimpson", "INDTRTGR", "TRTGRINDMAN", "RelRSPwk22")]
wk22.adiv <- wk22.all.adiv
colnames(wk22.all.adiv)[3] <- "Week22adiv"
wk22.all.adiv <- subset(wk22.all.adiv, select=-c(visit))

adiv.wk04 <- merge(wk0.all.adiv, wk4.all.adiv)
adiv.wk046 <- merge(adiv.wk04, wk6.all.adiv)
adiv.alltp <- merge(adiv.wk046, wk22.all.adiv)

#adiv.alltp <- adiv.alltp[,-1]
#mean.adiv.byvis <- apply(adiv.alltp[,-c(1:2)], 2, mean)
treatedresp <- wk0.all.adiv[wk0.all.adiv$TRTGRINDMAN=="Treated_Treated",]
#treatedrespY <- treatedrespY[treatedrespY$visit=="Screening",]
treatedrespY <- treatedresp[treatedresp$RelRSPwk22=="Yes",]
treatedrespN <- treatedresp[treatedresp$RelRSPwk22=="No",]
alltp.treatedrespY <- adiv.alltp[adiv.alltp$USUBJID %in% treatedrespY$USUBJID,]
n.alltp.treatedrespY <- nrow(alltp.treatedrespY)
rownames(alltp.treatedrespY) <- alltp.treatedrespY$USUBJID
alltp.treatedrespY <- as.matrix(subset(alltp.treatedrespY,select = -c(USUBJID, INDTRTGR, RelRSPwk22, TRTGRINDMAN)))
mean.adiv.byvis <- apply(alltp.treatedrespY, 2, mean)

alltp.treatedrespN <- adiv.alltp[adiv.alltp$USUBJID %in% treatedrespN$USUBJID,]
n.alltp.treatedrespN <- nrow(alltp.treatedrespN)
rownames(alltp.treatedrespN) <- alltp.treatedrespN$USUBJID
alltp.treatedrespN <- as.matrix(subset(alltp.treatedrespN,select = -c(USUBJID, INDTRTGR, RelRSPwk22, TRTGRINDMAN)))
mean.adiv.byvis <- apply(alltp.treatedrespN, 2, mean)

ggplot.wk04.adiv<-rbind(wk0.adiv, wk4.adiv)
ggplot.wk046.adiv<-rbind(ggplot.wk04.adiv, wk6.adiv)
ggplot.alltp.adiv<-rbind(ggplot.wk046.adiv, wk22.adiv)
treatedresp <- ggplot.alltp.adiv[ggplot.alltp.adiv$INDTRTGR=="Treated",]
treatedresp <- treatedresp[treatedresp$visit=="Screening",]
treatedrespY <- treatedresp[treatedresp$RelRSPwk22=="Yes",]
ggplot.alltp.treatedrespY <- ggplot.alltp.adiv[ggplot.alltp.adiv$USUBJID %in% treatedrespY$USUBJID,]
ggplot.alltp.treatedrespY <- ggplot.alltp.treatedrespY[, -c(4:6)]


treatedrespN <- treatedresp[treatedresp$RelRSPwk22=="No",]
ggplot.alltp.treatedrespN <- ggplot.alltp.adiv[ggplot.alltp.adiv$USUBJID %in% treatedrespN$USUBJID,]
ggplot.alltp.treatedrespN <- ggplot.alltp.treatedrespN[, -c(4:6)]



fried.trtdrespY <- friedman.test(alltp.treatedrespY)
fried.trtdrespY$p.value
friedmc.trtdrespY <- friedmanmc(alltp.treatedrespY)
friedmc.trtdrespY.pval <- friedmc.trtdrespY$dif.com
friedmc.trtdrespY.pval <- friedmc.trtdrespY.pval[friedmc.trtdrespY.pval$difference=="TRUE",]
pairwise.wilcox.test(ggplot.alltp.treatedrespY$invsimpson, ggplot.alltp.treatedrespY$visit, p.adj="BH", exact=F, paired=T)


friedman.test(alltp.treatedrespN)
friedmc <- friedmanmc(alltp.treatedrespN)
friedmc
pairwise.wilcox.test(ggplot.alltp.treatedrespN$invsimpson, ggplot.alltp.treatedrespN$visit, p.adj="BH", exact=F, paired=T)



#adiv.alltp <- adiv.alltp[,-1]
#mean.adiv.byvis <- apply(adiv.alltp[,-c(1:2)], 2, mean)
placeboresp <- wk0.all.adiv[wk0.all.adiv$INDTRTGR=="Placebo",]
#placeborespY <- placeborespY[placeborespY$visit=="Screening",]
placeborespY <- placeboresp[placeboresp$RelRSPwk22=="Yes",]
placeborespN <- placeboresp[placeboresp$RelRSPwk22=="No",]
alltp.placeborespY <- adiv.alltp[adiv.alltp$USUBJID %in% placeborespY$USUBJID,]
#alltp.placeborespY <- alltp.placeborespY[, -c(4:5)]
rownames(alltp.placeborespY) <- alltp.placeborespY$USUBJID
alltp.placeborespY <- as.matrix(alltp.placeborespY[,-c(1:4)])
mean.adiv.byvis <- apply(alltp.placeborespY, 2, mean)

alltp.placeborespN <- adiv.alltp[adiv.alltp$USUBJID %in% placeborespN$USUBJID,]
#alltp.placeborespN <- alltp.placeborespN[, -c(4:5)]
rownames(alltp.placeborespN) <- alltp.placeborespN$USUBJID
alltp.placeborespN <- as.matrix(alltp.placeborespN[,-c(1:4)])
mean.adiv.byvis <- apply(alltp.placeborespN, 2, mean)

ggplot.wk04.adiv<-rbind(wk0.adiv, wk4.adiv)
ggplot.wk046.adiv<-rbind(ggplot.wk04.adiv, wk6.adiv)
ggplot.alltp.adiv<-rbind(ggplot.wk046.adiv, wk22.adiv)
placeboresp <- ggplot.alltp.adiv[ggplot.alltp.adiv$INDTRTGR=="Placebo",]
placeboresp <- placeboresp[placeboresp$visit=="Screening",]
placeborespY <- placeboresp[placeboresp$RelRSPwk22=="Yes",]
ggplot.alltp.placeborespY <- ggplot.alltp.adiv[ggplot.alltp.adiv$USUBJID %in% placeborespY$USUBJID,]
ggplot.alltp.placeborespY <- ggplot.alltp.placeborespY[, -c(4:5)]


placeborespN <- placeboresp[placeboresp$RelRSPwk22=="No",]
ggplot.alltp.placeborespN <- ggplot.alltp.adiv[ggplot.alltp.adiv$USUBJID %in% placeborespN$USUBJID,]
ggplot.alltp.placeborespN <- ggplot.alltp.placeborespN[, -c(4:5)]


friedman.test(alltp.placeborespY)
friedmc <- friedmanmc(alltp.placeborespY)
friedmc
pairwise.wilcox.test(ggplot.alltp.placeborespY$invsimpson, ggplot.alltp.placeborespY$visit, p.adj="BH", exact=F, paired=T)


friedman.test(alltp.placeborespN)
friedmc <- friedmanmc(alltp.placeborespN)
friedmc
pairwise.wilcox.test(ggplot.alltp.placeborespN$invsimpson, ggplot.alltp.placeborespN$visit, p.adj="BH", exact=F, paired=T)


ggplot(ggplot.alltp.treatedrespY, aes(visit, invsimpson))+
	geom_boxplot() + theme(legend.position="none")

ann_text <- data.frame(visit = 4, invsimpson = 31,
											 INDTRTGR = "Treated", RelRSPwk22 = "Yes")

alltp.adivXvisXindtrtXrelRSPwk22.plot <- ggplot(ggplot.alltp.adiv, aes(x=visit, y=invsimpson, fill=INDTRTGR)) +
	#stat_summary(fun.y=mean, geom="point", aes(fill = invsimpson), position = position_dodge(1)) +
	#stat_summary(fun.data = 'median_hilow', fun.args = (conf.int=0.5), position = position_dodge(1), geom='errorbar', aes(color = otu))+
	geom_boxplot(position=position_dodge(width = 1), alpha = .4) + guides(fill=FALSE) +
	ylab("Inverse Simpson") + xlab("Visit") + theme(legend.position="none") + 
	ggtitle("Change in alpha diversity by Treatment Group and Week 22 Response") + 
	facet_grid(.~INDTRTGR + RelRSPwk22, labeller = label_bquote((x) + nrow(x))) +
	theme(plot.title = element_text(hjust = 0.5)) + geom_text(data = ann_text, label = "*", size=10) +
	theme(axis.text = element_text(size = 10))

tiff("figures/alltp.adivXvisitXindtrtXrelRSPwk22.tiff", height = 6, width = 10, units = "in", res = 300)
alltp.adivXvisXindtrtXrelRSPwk22.plot
dev.off()

pdf("figures/alltp.adivXvisitXindtrtXrelRSPwk22.pdf", height = 6, width = 10)
alltp.adivXvisXindtrtXrelRSPwk22.plot
dev.off()

	