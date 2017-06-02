#wk046_data

#change in adiv over time?
#first get the variables
#for week 0
wk0.all.adiv <- wk046_data[wk046_data$visit=="Screening", c("USUBJID", "visit", "INDTRTGR", "RelRSPwk6", "REMISSwk6",
																														"TRTGRINDMAN", "RelRSPwk22", "REMISSwk22", "invsimpson")]
wk0.adiv <- wk0.all.adiv
colnames(wk0.all.adiv)[9] <- "Week0adiv"
wk0.all.adiv <- subset(wk0.all.adiv, select=-c(visit))

#for week 4
wk4.all.adiv <- wk046_data[wk046_data$visit=="Week 4", c("USUBJID", "visit", "INDTRTGR", "RelRSPwk6", "REMISSwk6",
																												 "TRTGRINDMAN", "RelRSPwk22", "REMISSwk22", "invsimpson")]
wk4.adiv <- wk4.all.adiv
colnames(wk4.all.adiv)[9] <- "Week4adiv"
wk4.all.adiv <- subset(wk4.all.adiv, select=-c(visit))

#for week 6
wk6.all.adiv <- wk046_data[wk046_data$visit=="Week 6", c("USUBJID", "visit", "INDTRTGR", "RelRSPwk6", "REMISSwk6",
																												 "TRTGRINDMAN", "RelRSPwk22", "REMISSwk22", "invsimpson")]
wk6.adiv <- wk6.all.adiv
colnames(wk6.all.adiv)[9] <- "Week6adiv"
wk6.all.adiv <- subset(wk6.all.adiv, select=-c(visit))

#merge week 0 and week 4 invSimp data
adiv.wk04 <- merge(wk0.all.adiv, wk4.all.adiv)
#merge week 0 and week 4 AND WEEK 6 invSimp data
adiv.wk046 <- merge(adiv.wk04, wk6.all.adiv)
#set rownames to subject id
rownames(adiv.wk046) <- adiv.wk046$USUBJID

#remove all rows except those wiht invSimp data
adiv.wk046.mat <- adiv.wk046[,-c(1:7)]
#get the median for all by visit
median.adiv.byvis <- apply(adiv.wk046.mat, 2, median)


#Week 6
#get only subjects induced and maintained with UST
treatedresp <- wk0.all.adiv[wk0.all.adiv$INDTRTGR=="Treated",]

#get the responders
treatedresp6Y <- treatedresp[treatedresp$RelRSPwk6=="Yes",]

#get the non responders
treatedresp6N <- treatedresp[treatedresp$RelRSPwk6=="No",]

#get wk 0 4 and 6 data for treated responders
wk046.treatedresp6Y <- adiv.wk046[adiv.wk046$USUBJID %in% treatedresp6Y$USUBJID,]
n.wk046.treatedresp6Y <- nrow(wk046.treatedresp6Y)
#set as matrix with only invSimp data
wk046.treatedresp6Y <- as.matrix(subset(wk046.treatedresp6Y,select = -c(USUBJID, INDTRTGR, RelRSPwk6, REMISSwk6,
																																					TRTGRINDMAN, RelRSPwk22, REMISSwk22)))
#get the median by visit
median.wk046.treatedresp6Y.adiv.byvis <- apply(wk046.treatedresp6Y, 2, median)

#get wk 0 4 and 6 data for treated nonresponders
wk046.treatedresp6N <- adiv.wk046[adiv.wk046$USUBJID %in% treatedresp6N$USUBJID,]
n.wk046.treatedresp6N <- nrow(wk046.treatedresp6N)
#set rownames to subject ID
rownames(wk046.treatedresp6N) <- wk046.treatedresp6N$USUBJID

#set as matrix with only invSimp data
wk046.treatedresp6N <- as.matrix(subset(wk046.treatedresp6N,select = -c(USUBJID, INDTRTGR, RelRSPwk6, REMISSwk6,
																																					TRTGRINDMAN, RelRSPwk22, REMISSwk22)))

#get the median by visit
median.wk046.treatedresp6N.adiv.byvis <- apply(wk046.treatedresp6N, 2, median)

#make tables for ggplot(swtich to dyplr version and pipe at somepoint)
ggplot.wk04.adiv<-rbind(wk0.adiv, wk4.adiv)
ggplot.wk046.adiv<-rbind(ggplot.wk04.adiv, wk6.adiv)

#get subs induced and maintained with UST
treatedresp <- ggplot.wk046.adiv[ggplot.wk046.adiv$INDTRTGR=="Treated",]

#get dataframe of unique subject ids
treatedresp <- treatedresp[treatedresp$visit=="Screening",]

#get week 22 responders
treatedresp6Y <- treatedresp[treatedresp$RelRSPwk6=="Yes",]

#get wk 0 4 and 6 data for unique subject ids
ggplot.wk046.treatedresp6Y <- ggplot.wk046.adiv[ggplot.wk046.adiv$USUBJID %in% treatedresp6Y$USUBJID,]

#get df with subject id, visit, treatment group, and invSimp
ggplot.wk046.treatedresp6Y <- ggplot.wk046.treatedresp6Y[, -c(4:8)]

#get week 22 NONresponders
treatedresp6N <- treatedresp[treatedresp$RelRSPwk6=="No",]
#get wk 0 4 and 6 data for unique subject ids
ggplot.wk046.treatedresp6N <- ggplot.wk046.adiv[ggplot.wk046.adiv$USUBJID %in% treatedresp6N$USUBJID,]
#get df with subject id, visit, treatment group, and invSimp
ggplot.wk046.treatedresp6N <- ggplot.wk046.treatedresp6N[, -c(4:8)]

#friedman test for significant chages in invSimp over the first 4 weeks in treated weel 22 responders
set.seed(32016)
wk046.treatedresp6Y.fried <- friedman.test(wk046.treatedresp6Y)

friedmc <- friedmanmc(wk046.treatedresp6Y)
friedmc
pairwise.wilcox.test(ggplot.wk046.treatedresp6Y$invsimpson, ggplot.wk046.treatedresp6Y$visit, p.adj="BH", exact=F, paired=T)

#friedman test for significant chages in invSimp over the first 4 weeks in treated weel 22 NONresponders
friedman.test(wk046.treatedresp6N)
friedmc <- friedmanmc(wk046.treatedresp6N)
friedmc
pairwise.wilcox.test(ggplot.wk046.treatedresp6N$invsimpson, ggplot.wk046.treatedresp6N$visit, p.adj="BH", exact=F, paired=T)

#get subs induced and maintained with placebo
placeboresp <- wk0.all.adiv[wk0.all.adiv$INDTRTGR=="Placebo",]

#get week 22 responders
placeboresp6Y <- placeboresp[placeboresp$RelRSPwk6=="Yes",]
#get week 22 NON responders
placeboresp6N <- placeboresp[placeboresp$RelRSPwk6=="No",]

#get wk 0 4 and 6 data for placebo responders
wk046.placeboresp6Y <- adiv.wk046[adiv.wk046$USUBJID %in% placeboresp6Y$USUBJID,]
n.wk046.placeboresp6Y <- nrow(wk046.placeboresp6Y)
rownames(wk046.placeboresp6Y) <- wk046.placeboresp6Y$USUBJID

#get only invSimp data
wk046.placeboresp6Y <- as.matrix(wk046.placeboresp6Y[,-c(1:7)])

#median invSimp by visit
median.wk046.placeboresp6Y.adiv.byvis <- apply(wk046.placeboresp6Y, 2, median)

#get wk 0 4 and 6 data for placebo nonresponders
wk046.placeboresp6N <- adiv.wk046[adiv.wk046$USUBJID %in% placeboresp6N$USUBJID,]
rownames(wk046.placeboresp6N) <- wk046.placeboresp6N$USUBJID
n.wk046.placeboresp6N <- nrow(wk046.placeboresp6N)
wk046.placeboresp6N <- as.matrix(wk046.placeboresp6N[,-c(1:7)])

#median invSimp by visit
median.wk046.placeboresp6N.adiv.byvis <- apply(wk046.placeboresp6N, 2, median)

#make tables for ggplot
ggplot.wk04.adiv<-rbind(wk0.adiv, wk4.adiv)
ggplot.wk046.adiv<-rbind(ggplot.wk04.adiv, wk6.adiv)

#get treatement group
placeboresp <- ggplot.wk046.adiv[ggplot.wk046.adiv$INDTRTGR=="Placebo",]
#gt unique list of subjectiDs
placeboresp <- placeboresp[placeboresp$visit=="Screening",]
#get placebo responders
placeboresp6Y <- placeboresp[placeboresp$RelRSPwk6=="Yes",]



#get all data for placebo responders
ggplot.wk046.placeboresp6Y <- ggplot.wk046.adiv[ggplot.wk046.adiv$USUBJID %in% placeboresp6Y$USUBJID,]
#get df with subject id, visit, treatment group, and invSimp
ggplot.wk046.placeboresp6Y <- ggplot.wk046.placeboresp6Y[, -c(4:8)]

#nonresponder data
placeboresp6N <- placeboresp[placeboresp$RelRSPwk6=="No",]
nrow(placeboresp6N)
#get all data for nonrespodners
ggplot.wk046.placeboresp6N <- ggplot.wk046.adiv[ggplot.wk046.adiv$USUBJID %in% placeboresp6N$USUBJID,]
#get df with subject id, visit, treatment group, and invSimp
ggplot.wk046.placeboresp6N <- ggplot.wk046.placeboresp6N[, -c(4:8)]


#friedman test for placebo responders
friedman.test(wk046.placeboresp6Y)
friedmc <- friedmanmc(wk046.placeboresp6Y)
friedmc
pairwise.wilcox.test(ggplot.wk046.placeboresp6Y$invsimpson, ggplot.wk046.placeboresp6Y$visit, p.adj="BH", exact=F, paired=T)

#friedman for nonresponders
friedman.test(wk046.placeboresp6N)
friedmc <- friedmanmc(wk046.placeboresp6N)
friedmc
pairwise.wilcox.test(ggplot.wk046.placeboresp6N$invsimpson, ggplot.wk046.placeboresp6N$visit, p.adj="BH", exact=F, paired=T)

#reset levels to responder and nonresponder
levels(ggplot.wk046.adiv$RelRSPwk6) <- c("Nonresponder", "Responder")
#location for asterisk in ggplot
ann_text <- data.frame(visit = 2, invsimpson = 31,
											 INDTRTGR = "Treated", RelRSPwk6 = "Responder")

#ggplot of invSimp by ind and main treament gruop and week 22 response

#for ddw
# wk046.adivXvisXindtrtXrelRSPwk6.plot <- ggplot(ggplot.wk046.adiv, aes(x=visit, y=invsimpson, fill=INDTRTGR)) +
# 	#stat_summary(fun.y=median, geom="point", aes(fill = invsimpson), position = position_dodge(1)) +
# 	#stat_summary(fun.data = 'median_hilow', fun.args = (conf.int=0.5), position = position_dodge(1), geom='errorbar', aes(color = otu))+
# 	geom_boxplot(position=position_dodge(width = 1), alpha = .4) + guides(fill=FALSE) +
# 	ylab("Inverse Simpson") + xlab("Stool Sample") + theme(legend.position="none") + 
# 	ggtitle("Change in Species Diversity over time by Induction Group and Week 22 Response") + 
# 	facet_grid(.~INDTRTGR + RelRSPwk6, labeller = label_bquote((x) + nrow(x))) +
# 	theme(plot.title = element_text(hjust = 0.5)) + geom_text(data = ann_text, label = "*", size=10)
# 
# pdf("figures/DDW_wk046.adivXvisitXindtrtXrelRSPwk6.pdf", height = 6, width = 10)
# wk046.adivXvisXindtrtXrelRSPwk6.plot
# dev.off()

wk046.adivXvisXindtrtXrelRSPwk6.plot <- ggplot(ggplot.wk046.adiv, aes(x=visit, y=invsimpson, fill=INDTRTGR)) +
	#stat_summary(fun.y=median, geom="point", aes(fill = invsimpson), position = position_dodge(1)) +
	#stat_summary(fun.data = 'median_hilow', fun.args = (conf.int=0.5), position = position_dodge(1), geom='errorbar', aes(color = otu))+
	geom_boxplot(position=position_dodge(width = 1), alpha = .4) + guides(fill=FALSE) +
	ylab("Inverse Simpson") + xlab("Stool Sample") + theme(legend.position="none") + 
	#ggtitle("Change in Species Diversity over time by Induction Group and Week 22 Response") + 
	facet_grid(.~INDTRTGR + RelRSPwk6, labeller = label_bquote((x) + nrow(x))) +
	theme(plot.title = element_text(hjust = 0.5)) + #geom_text(data = ann_text, label = "*", size=10)

#tiff("figures/wk046.adivXvisitXindtrtXrelRSPwk6.tiff", height = 6, width = 10, units = "in", res = 300)
pdf("figures/Figure4_wk046.adivXvisitXindtrtXrelRSPwk6.pdf", height = 6, width = 10)
wk046.adivXvisXindtrtXrelRSPwk6.plot
dev.off()


ann_text <- data.frame(visit = 2, invsimpson = 31)
trtrY.wk046.adivXvisXindtrtXrelRSPwk6.plot <- ggplot(ggplot.wk046.treatedresp6Y, aes(x=visit, y=invsimpson)) +
	#stat_summary(fun.y=median, geom="point", aes(fill = invsimpson), position = position_dodge(1)) +
	#stat_summary(fun.data = 'median_hilow', fun.args = (conf.int=0.5), position = position_dodge(1), geom='errorbar', aes(color = otu))+
	geom_boxplot(position=position_dodge(width = 1), alpha = .4) + #guides(fill=FALSE) +
	ylab("Inverse Simpson") + xlab("Stool Sample") + theme(legend.position="none") + 
	#ggtitle("Change in Species Diversity over time by Induction Group and Week 22 Response") + 
	#facet_grid(.~INDTRTGR + RelRSPwk6, labeller = label_bquote((x) + nrow(x))) +
	theme(plot.title = element_text(hjust = 0.5)) + geom_text(data = ann_text, label = "*", size=10)


#get only subjects induced and maintained with UST
treatedrem <- wk0.all.adiv[wk0.all.adiv$INDTRTGR=="Treated",]

#get the remitters
treatedrem6Y <- treatedrem[treatedrem$REMISSwk6=="Yes",]

#get the non remitters
treatedrem6N <- treatedrem[treatedrem$REMISSwk6=="No",]

#get wk 0 4 and 6 data for treated remitters
wk046.treatedrem6Y <- adiv.wk046[adiv.wk046$USUBJID %in% treatedrem6Y$USUBJID,]
n.wk046.treatedrem6Y <- nrow(wk046.treatedrem6Y)
#set as matrix with only invSimp data
wk046.treatedrem6Y <- as.matrix(subset(wk046.treatedrem6Y,select = -c(USUBJID, INDTRTGR, RelRSPwk6, REMISSwk6,
																																				TRTGRINDMAN, RelRSPwk22, REMISSwk22)))
#get the median by visit
median.wk046.treatedrem6Y.adiv.byvis <- apply(wk046.treatedrem6Y, 2, median)

#get wk 0 4 and 6 data for treated nonremitters
wk046.treatedrem6N <- adiv.wk046[adiv.wk046$USUBJID %in% treatedrem6N$USUBJID,]
n.wk046.treatedrem6N <- nrow(wk046.treatedrem6N)
#set rownames to subject ID
rownames(wk046.treatedrem6N) <- wk046.treatedrem6N$USUBJID

#set as matrix with only invSimp data
wk046.treatedrem6N <- as.matrix(subset(wk046.treatedrem6N,select = -c(USUBJID, INDTRTGR, RelRSPwk6, REMISSwk6,
																																				TRTGRINDMAN, RelRSPwk22, REMISSwk22)))

#get the median by visit
median.wk046.treatedrem6N.adiv.byvis <- apply(wk046.treatedrem6N, 2, median)

#make tables for ggplot(swtich to dyplr version and pipe at somepoint)
ggplot.wk04.adiv<-rbind(wk0.adiv, wk4.adiv)
ggplot.wk046.adiv<-rbind(ggplot.wk04.adiv, wk6.adiv)

#get subs induced and maintained with UST
treatedrem <- ggplot.wk046.adiv[ggplot.wk046.adiv$INDTRTGR=="Treated",]

#get dataframe of unique subject ids
treatedrem <- treatedrem[treatedrem$visit=="Screening",]

#get week 22 remitters
treatedrem6Y <- treatedrem[treatedrem$REMISSwk6=="Yes",]

#get wk 0 4 and 6 data for unique subject ids
ggplot.wk046.treatedrem6Y <- ggplot.wk046.adiv[ggplot.wk046.adiv$USUBJID %in% treatedrem6Y$USUBJID,]

#get df with subject id, visit, treatment group, and invSimp
ggplot.wk046.treatedrem6Y <- ggplot.wk046.treatedrem6Y[, -c(4:8)]

#get week 22 NONremitters
treatedrem6N <- treatedrem[treatedrem$REMISSwk6=="No",]
#get wk 0 4 and 6 data for unique subject ids
ggplot.wk046.treatedrem6N <- ggplot.wk046.adiv[ggplot.wk046.adiv$USUBJID %in% treatedrem6N$USUBJID,]
#get df with subject id, visit, treatment group, and invSimp
ggplot.wk046.treatedrem6N <- ggplot.wk046.treatedrem6N[, -c(4:8)]

#friedman test for significant chages in invSimp over the first 4 weeks in treated weel 22 remitters
set.seed(32016)
wk046.treatedrem6Y.fried <- friedman.test(wk046.treatedrem6Y)

friedmc <- friedmanmc(wk046.treatedrem6Y)
friedmc
pairwise.wilcox.test(ggplot.wk046.treatedrem6Y$invsimpson, ggplot.wk046.treatedrem6Y$visit, p.adj="BH", exact=F, paired=T)

#friedman test for significant chages in invSimp over the first 4 weeks in treated weel 22 NONremitters
friedman.test(wk046.treatedrem6N)
friedmc <- friedmanmc(wk046.treatedrem6N)
friedmc
pairwise.wilcox.test(ggplot.wk046.treatedrem6N$invsimpson, ggplot.wk046.treatedrem6N$visit, p.adj="BH", exact=F, paired=T)

#get subs induced and maintained with placebo
placeborem <- wk0.all.adiv[wk0.all.adiv$INDTRTGR=="Placebo",]

#get week 22 remitters
placeborem6Y <- placeborem[placeborem$REMISSwk6=="Yes",]
#get week 22 NON remitters
placeborem6N <- placeborem[placeborem$REMISSwk6=="No",]

#get wk 0 4 and 6 data for placebo remitters
wk046.placeborem6Y <- adiv.wk046[adiv.wk046$USUBJID %in% placeborem6Y$USUBJID,]
n.wk046.placeborem6Y <- nrow(wk046.placeborem6Y)
rownames(wk046.placeborem6Y) <- wk046.placeborem6Y$USUBJID

#get only invSimp data
wk046.placeborem6Y <- as.matrix(wk046.placeborem6Y[,-c(1:7)])

#median invSimp by visit
median.wk046.placeborem6Y.adiv.byvis <- apply(wk046.placeborem6Y, 2, median)

#get wk 0 4 and 6 data for placebo nonremitters
wk046.placeborem6N <- adiv.wk046[adiv.wk046$USUBJID %in% placeborem6N$USUBJID,]
rownames(wk046.placeborem6N) <- wk046.placeborem6N$USUBJID
n.wk046.placeborem6N <- nrow(wk046.placeborem6N)
wk046.placeborem6N <- as.matrix(wk046.placeborem6N[,-c(1:7)])

#median invSimp by visit
median.wk046.placeborem6N.adiv.byvis <- apply(wk046.placeborem6N, 2, median)

#make tables for ggplot
ggplot.wk04.adiv<-rbind(wk0.adiv, wk4.adiv)
ggplot.wk046.adiv<-rbind(ggplot.wk04.adiv, wk6.adiv)

#get treatement group
placeborem <- ggplot.wk046.adiv[ggplot.wk046.adiv$INDTRTGR=="Placebo",]
#gt unique list of subjectiDs
placeborem <- placeborem[placeborem$visit=="Screening",]
#get placebo remitters
placeborem6Y <- placeborem[placeborem$REMISSwk6=="Yes",]



#get all data for placebo remitters
ggplot.wk046.placeborem6Y <- ggplot.wk046.adiv[ggplot.wk046.adiv$USUBJID %in% placeborem6Y$USUBJID,]
#get df with subject id, visit, treatment group, and invSimp
ggplot.wk046.placeborem6Y <- ggplot.wk046.placeborem6Y[, -c(4:8)]

#nonremonder data
placeborem6N <- placeborem[placeborem$REMISSwk6=="No",]
nrow(placeborem6N)
#get all data for nonremodners
ggplot.wk046.placeborem6N <- ggplot.wk046.adiv[ggplot.wk046.adiv$USUBJID %in% placeborem6N$USUBJID,]
#get df with subject id, visit, treatment group, and invSimp
ggplot.wk046.placeborem6N <- ggplot.wk046.placeborem6N[, -c(4:8)]


#friedman test for placebo remitters
friedman.test(wk046.placeborem6Y)
friedmc <- friedmanmc(wk046.placeborem6Y)
friedmc
pairwise.wilcox.test(ggplot.wk046.placeborem6Y$invsimpson, ggplot.wk046.placeborem6Y$visit, p.adj="BH", exact=F, paired=T)

#friedman for nonremitters
friedman.test(wk046.placeborem6N)
friedmc <- friedmanmc(wk046.placeborem6N)
friedmc
pairwise.wilcox.test(ggplot.wk046.placeborem6N$invsimpson, ggplot.wk046.placeborem6N$visit, p.adj="BH", exact=F, paired=T)







#week 22 response
#get only subjects induced and maintained with UST
treatedresp <- wk0.all.adiv[wk0.all.adiv$TRTGRINDMAN=="Treated_Treated",]

#get the responders
treatedresp22Y <- treatedresp[treatedresp$RelRSPwk22=="Yes",]

#get the non responders
treatedresp22N <- treatedresp[treatedresp$RelRSPwk22=="No",]

#get wk 0 4 and 6 data for treated responders
wk046.treatedresp22Y <- adiv.wk046[adiv.wk046$USUBJID %in% treatedresp22Y$USUBJID,]
n.wk046.treatedresp22Y <- nrow(wk046.treatedresp22Y)
#set as matrix with only invSimp data
wk046.treatedresp22Y <- as.matrix(subset(wk046.treatedresp22Y,select = -c(USUBJID, INDTRTGR, RelRSPwk6, REMISSwk6,
																																					TRTGRINDMAN, RelRSPwk22, REMISSwk22)))
#get the median by visit
median.wk046.treatedresp22Y.adiv.byvis <- apply(wk046.treatedresp22Y, 2, median)

#get wk 0 4 and 6 data for treated nonresponders
wk046.treatedresp22N <- adiv.wk046[adiv.wk046$USUBJID %in% treatedresp22N$USUBJID,]
n.wk046.treatedresp22N <- nrow(wk046.treatedresp22N)
#set rownames to subject ID
rownames(wk046.treatedresp22N) <- wk046.treatedresp22N$USUBJID

#set as matrix with only invSimp data
wk046.treatedresp22N <- as.matrix(subset(wk046.treatedresp22N,select = -c(USUBJID, INDTRTGR, RelRSPwk6, REMISSwk6,
																																					TRTGRINDMAN, RelRSPwk22, REMISSwk22)))

#get the median by visit
median.wk046.treatedresp22N.adiv.byvis <- apply(wk046.treatedresp22N, 2, median)

#make tables for ggplot(swtich to dyplr version and pipe at somepoint)
ggplot.wk04.adiv<-rbind(wk0.adiv, wk4.adiv)
ggplot.wk046.adiv<-rbind(ggplot.wk04.adiv, wk6.adiv)

#get subs induced and maintained with UST
treatedresp <- ggplot.wk046.adiv[ggplot.wk046.adiv$TRTGRINDMAN=="Treated_Treated",]

#get dataframe of unique subject ids
treatedresp <- treatedresp[treatedresp$visit=="Screening",]

#get week 22 responders
treatedresp22Y <- treatedresp[treatedresp$RelRSPwk22=="Yes",]

#get wk 0 4 and 6 data for unique subject ids
ggplot.wk046.treatedresp22Y <- ggplot.wk046.adiv[ggplot.wk046.adiv$USUBJID %in% treatedresp22Y$USUBJID,]

#get df with subject id, visit, treatment group, and invSimp
ggplot.wk046.treatedresp22Y <- ggplot.wk046.treatedresp22Y[, -c(4:8)]

#get week 22 NONresponders
treatedresp22N <- treatedresp[treatedresp$RelRSPwk22=="No",]
#get wk 0 4 and 6 data for unique subject ids
ggplot.wk046.treatedresp22N <- ggplot.wk046.adiv[ggplot.wk046.adiv$USUBJID %in% treatedresp22N$USUBJID,]
#get df with subject id, visit, treatment group, and invSimp
ggplot.wk046.treatedresp22N <- ggplot.wk046.treatedresp22N[, -c(4:8)]

#friedman test for significant chages in invSimp over the first 4 weeks in treated weel 22 responders
set.seed(32016)
wk046.treatedresp22Y.fried <- friedman.test(wk046.treatedresp22Y)

friedmc <- friedmanmc(wk046.treatedresp22Y)
friedmc
pairwise.wilcox.test(ggplot.wk046.treatedresp22Y$invsimpson, ggplot.wk046.treatedresp22Y$visit, p.adj="BH", exact=F, paired=T)

#friedman test for significant chages in invSimp over the first 4 weeks in treated weel 22 NONresponders
friedman.test(wk046.treatedresp22N)
friedmc <- friedmanmc(wk046.treatedresp22N)
friedmc
pairwise.wilcox.test(ggplot.wk046.treatedresp22N$invsimpson, ggplot.wk046.treatedresp22N$visit, p.adj="BH", exact=F, paired=T)

#get subs induced and maintained with placebo
placeboresp <- wk0.all.adiv[wk0.all.adiv$TRTGRINDMAN=="Placebo_Placebo",]

#get week 22 responders
placeboresp22Y <- placeboresp[placeboresp$RelRSPwk22=="Yes",]
#get week 22 NON responders
placeboresp22N <- placeboresp[placeboresp$RelRSPwk22=="No",]

#get wk 0 4 and 6 data for placebo responders
wk046.placeboresp22Y <- adiv.wk046[adiv.wk046$USUBJID %in% placeboresp22Y$USUBJID,]
n.wk046.placeboresp22Y <- nrow(wk046.placeboresp22Y)
rownames(wk046.placeboresp22Y) <- wk046.placeboresp22Y$USUBJID

#get only invSimp data
wk046.placeboresp22Y <- as.matrix(wk046.placeboresp22Y[,-c(1:7)])

#median invSimp by visit
median.wk046.placeboresp22Y.adiv.byvis <- apply(wk046.placeboresp22Y, 2, median)

#get wk 0 4 and 6 data for placebo nonresponders
wk046.placeboresp22N <- adiv.wk046[adiv.wk046$USUBJID %in% placeboresp22N$USUBJID,]
rownames(wk046.placeboresp22N) <- wk046.placeboresp22N$USUBJID
n.wk046.placeboresp22N <- nrow(wk046.placeboresp22N)
wk046.placeboresp22N <- as.matrix(wk046.placeboresp22N[,-c(1:7)])

#median invSimp by visit
median.wk046.placeboresp22N.adiv.byvis <- apply(wk046.placeboresp22N, 2, median)

#make tables for ggplot
ggplot.wk04.adiv<-rbind(wk0.adiv, wk4.adiv)
ggplot.wk046.adiv<-rbind(ggplot.wk04.adiv, wk6.adiv)

#get treatement group
placeboresp <- ggplot.wk046.adiv[ggplot.wk046.adiv$TRTGRINDMAN=="Placebo_Placebo",]
#gt unique list of subjectiDs
placeboresp <- placeboresp[placeboresp$visit=="Screening",]
#get placebo responders
placeboresp22Y <- placeboresp[placeboresp$RelRSPwk22=="Yes",]



#get all data for placebo responders
ggplot.wk046.placeboresp22Y <- ggplot.wk046.adiv[ggplot.wk046.adiv$USUBJID %in% placeboresp22Y$USUBJID,]
#get df with subject id, visit, treatment group, and invSimp
ggplot.wk046.placeboresp22Y <- ggplot.wk046.placeboresp22Y[, -c(4:8)]

#nonresponder data
placeboresp22N <- placeboresp[placeboresp$RelRSPwk22=="No",]
nrow(placeboresp22N)
#get all data for nonrespodners
ggplot.wk046.placeboresp22N <- ggplot.wk046.adiv[ggplot.wk046.adiv$USUBJID %in% placeboresp22N$USUBJID,]
#get df with subject id, visit, treatment group, and invSimp
ggplot.wk046.placeboresp22N <- ggplot.wk046.placeboresp22N[, -c(4:8)]


#friedman test for placebo responders
friedman.test(wk046.placeboresp22Y)
friedmc <- friedmanmc(wk046.placeboresp22Y)
friedmc
pairwise.wilcox.test(ggplot.wk046.placeboresp22Y$invsimpson, ggplot.wk046.placeboresp22Y$visit, p.adj="BH", exact=F, paired=T)

#friedman for nonresponders
friedman.test(wk046.placeboresp22N)
friedmc <- friedmanmc(wk046.placeboresp22N)
friedmc
pairwise.wilcox.test(ggplot.wk046.placeboresp22N$invsimpson, ggplot.wk046.placeboresp22N$visit, p.adj="BH", exact=F, paired=T)

#reset levels to responder and nonresponder
levels(ggplot.wk046.adiv$RelRSPwk22) <- c("Nonresponder", "Responder")
#location for asterisk in ggplot
ann_text <- data.frame(visit = 2, invsimpson = 31,
											 INDTRTGR = "Treated", RelRSPwk22 = "Responder")

#ggplot of invSimp by ind and main treament gruop and week 22 response

#for ddw
# wk046.adivXvisXindtrtXrelRSPwk22.plot <- ggplot(ggplot.wk046.adiv, aes(x=visit, y=invsimpson, fill=INDTRTGR)) +
# 	#stat_summary(fun.y=median, geom="point", aes(fill = invsimpson), position = position_dodge(1)) +
# 	#stat_summary(fun.data = 'median_hilow', fun.args = (conf.int=0.5), position = position_dodge(1), geom='errorbar', aes(color = otu))+
# 	geom_boxplot(position=position_dodge(width = 1), alpha = .4) + guides(fill=FALSE) +
# 	ylab("Inverse Simpson") + xlab("Stool Sample") + theme(legend.position="none") + 
# 	ggtitle("Change in Species Diversity over time by Induction Group and Week 22 Response") + 
# 	facet_grid(.~INDTRTGR + RelRSPwk22, labeller = label_bquote((x) + nrow(x))) +
# 	theme(plot.title = element_text(hjust = 0.5)) + geom_text(data = ann_text, label = "*", size=10)
# 
# pdf("figures/DDW_wk046.adivXvisitXindtrtXrelRSPwk22.pdf", height = 6, width = 10)
# wk046.adivXvisXindtrtXrelRSPwk22.plot
# dev.off()

wk046.adivXvisXindtrtXrelRSPwk22.plot <- ggplot(ggplot.wk046.adiv, aes(x=visit, y=invsimpson, fill=INDTRTGR)) +
	#stat_summary(fun.y=median, geom="point", aes(fill = invsimpson), position = position_dodge(1)) +
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
trtrY.wk046.adivXvisXindtrtXrelRSPwk22.plot <- ggplot(ggplot.wk046.treatedresp22Y, aes(x=visit, y=invsimpson)) +
	#stat_summary(fun.y=median, geom="point", aes(fill = invsimpson), position = position_dodge(1)) +
	#stat_summary(fun.data = 'median_hilow', fun.args = (conf.int=0.5), position = position_dodge(1), geom='errorbar', aes(color = otu))+
	geom_boxplot(position=position_dodge(width = 1), alpha = .4) + #guides(fill=FALSE) +
	ylab("Inverse Simpson") + xlab("Stool Sample") + theme(legend.position="none") + 
	#ggtitle("Change in Species Diversity over time by Induction Group and Week 22 Response") + 
	#facet_grid(.~INDTRTGR + RelRSPwk22, labeller = label_bquote((x) + nrow(x))) +
	theme(plot.title = element_text(hjust = 0.5)) + geom_text(data = ann_text, label = "*", size=10)


#get only subjects induced and maintained with UST
treatedrem <- wk0.all.adiv[wk0.all.adiv$TRTGRINDMAN=="Treated_Treated",]

#get the remitters
treatedrem22Y <- treatedrem[treatedrem$REMISSwk22=="Yes",]

#get the non remitters
treatedrem22N <- treatedrem[treatedrem$REMISSwk22=="No",]

#get wk 0 4 and 6 data for treated remitters
wk046.treatedrem22Y <- adiv.wk046[adiv.wk046$USUBJID %in% treatedrem22Y$USUBJID,]
n.wk046.treatedrem22Y <- nrow(wk046.treatedrem22Y)
#set as matrix with only invSimp data
wk046.treatedrem22Y <- as.matrix(subset(wk046.treatedrem22Y,select = -c(USUBJID, INDTRTGR, RelRSPwk6, REMISSwk6,
																																					TRTGRINDMAN, RelRSPwk22, REMISSwk22)))
#get the median by visit
median.wk046.treatedrem22Y.adiv.byvis <- apply(wk046.treatedrem22Y, 2, median)

#get wk 0 4 and 6 data for treated nonremitters
wk046.treatedrem22N <- adiv.wk046[adiv.wk046$USUBJID %in% treatedrem22N$USUBJID,]
n.wk046.treatedrem22N <- nrow(wk046.treatedrem22N)
#set rownames to subject ID
rownames(wk046.treatedrem22N) <- wk046.treatedrem22N$USUBJID

#set as matrix with only invSimp data
wk046.treatedrem22N <- as.matrix(subset(wk046.treatedrem22N,select = -c(USUBJID, INDTRTGR, RelRSPwk6, REMISSwk6,
																																					TRTGRINDMAN, RelRSPwk22, REMISSwk22)))

#get the median by visit
median.wk046.treatedrem22N.adiv.byvis <- apply(wk046.treatedrem22N, 2, median)

#make tables for ggplot(swtich to dyplr version and pipe at somepoint)
ggplot.wk04.adiv<-rbind(wk0.adiv, wk4.adiv)
ggplot.wk046.adiv<-rbind(ggplot.wk04.adiv, wk6.adiv)

#get subs induced and maintained with UST
treatedrem <- ggplot.wk046.adiv[ggplot.wk046.adiv$TRTGRINDMAN=="Treated_Treated",]

#get dataframe of unique subject ids
treatedrem <- treatedrem[treatedrem$visit=="Screening",]

#get week 22 remitters
treatedrem22Y <- treatedrem[treatedrem$REMISSwk22=="Yes",]

#get wk 0 4 and 6 data for unique subject ids
ggplot.wk046.treatedrem22Y <- ggplot.wk046.adiv[ggplot.wk046.adiv$USUBJID %in% treatedrem22Y$USUBJID,]

#get df with subject id, visit, treatment group, and invSimp
ggplot.wk046.treatedrem22Y <- ggplot.wk046.treatedrem22Y[, -c(4:8)]

#get week 22 NONremitters
treatedrem22N <- treatedrem[treatedrem$REMISSwk22=="No",]
#get wk 0 4 and 6 data for unique subject ids
ggplot.wk046.treatedrem22N <- ggplot.wk046.adiv[ggplot.wk046.adiv$USUBJID %in% treatedrem22N$USUBJID,]
#get df with subject id, visit, treatment group, and invSimp
ggplot.wk046.treatedrem22N <- ggplot.wk046.treatedrem22N[, -c(4:8)]

#friedman test for significant chages in invSimp over the first 4 weeks in treated weel 22 remitters
set.seed(32016)
wk046.treatedrem22Y.fried <- friedman.test(wk046.treatedrem22Y)

friedmc <- friedmanmc(wk046.treatedrem22Y)
friedmc
pairwise.wilcox.test(ggplot.wk046.treatedrem22Y$invsimpson, ggplot.wk046.treatedrem22Y$visit, p.adj="BH", exact=F, paired=T)

#friedman test for significant chages in invSimp over the first 4 weeks in treated weel 22 NONremitters
friedman.test(wk046.treatedrem22N)
friedmc <- friedmanmc(wk046.treatedrem22N)
friedmc
pairwise.wilcox.test(ggplot.wk046.treatedrem22N$invsimpson, ggplot.wk046.treatedrem22N$visit, p.adj="BH", exact=F, paired=T)

#get subs induced and maintained with placebo
placeborem <- wk0.all.adiv[wk0.all.adiv$TRTGRINDMAN=="Placebo_Placebo",]

#get week 22 remitters
placeborem22Y <- placeborem[placeborem$REMISSwk22=="Yes",]
#get week 22 NON remitters
placeborem22N <- placeborem[placeborem$REMISSwk22=="No",]

#get wk 0 4 and 6 data for placebo remitters
wk046.placeborem22Y <- adiv.wk046[adiv.wk046$USUBJID %in% placeborem22Y$USUBJID,]
n.wk046.placeborem22Y <- nrow(wk046.placeborem22Y)
rownames(wk046.placeborem22Y) <- wk046.placeborem22Y$USUBJID

#get only invSimp data
wk046.placeborem22Y <- as.matrix(wk046.placeborem22Y[,-c(1:7)])

#median invSimp by visit
median.wk046.placeborem22Y.adiv.byvis <- apply(wk046.placeborem22Y, 2, median)

#get wk 0 4 and 6 data for placebo nonremitters
wk046.placeborem22N <- adiv.wk046[adiv.wk046$USUBJID %in% placeborem22N$USUBJID,]
rownames(wk046.placeborem22N) <- wk046.placeborem22N$USUBJID
n.wk046.placeborem22N <- nrow(wk046.placeborem22N)
wk046.placeborem22N <- as.matrix(wk046.placeborem22N[,-c(1:7)])

#median invSimp by visit
median.wk046.placeborem22N.adiv.byvis <- apply(wk046.placeborem22N, 2, median)

#make tables for ggplot
ggplot.wk04.adiv<-rbind(wk0.adiv, wk4.adiv)
ggplot.wk046.adiv<-rbind(ggplot.wk04.adiv, wk6.adiv)

#get treatement group
placeborem <- ggplot.wk046.adiv[ggplot.wk046.adiv$TRTGRINDMAN=="Placebo_Placebo",]
#gt unique list of subjectiDs
placeborem <- placeborem[placeborem$visit=="Screening",]
#get placebo remitters
placeborem22Y <- placeborem[placeborem$REMISSwk22=="Yes",]



#get all data for placebo remitters
ggplot.wk046.placeborem22Y <- ggplot.wk046.adiv[ggplot.wk046.adiv$USUBJID %in% placeborem22Y$USUBJID,]
#get df with subject id, visit, treatment group, and invSimp
ggplot.wk046.placeborem22Y <- ggplot.wk046.placeborem22Y[, -c(4:8)]

#nonremonder data
placeborem22N <- placeborem[placeborem$REMISSwk22=="No",]
nrow(placeborem22N)
#get all data for nonremodners
ggplot.wk046.placeborem22N <- ggplot.wk046.adiv[ggplot.wk046.adiv$USUBJID %in% placeborem22N$USUBJID,]
#get df with subject id, visit, treatment group, and invSimp
ggplot.wk046.placeborem22N <- ggplot.wk046.placeborem22N[, -c(4:8)]


#friedman test for placebo remitters
friedman.test(wk046.placeborem22Y)
friedmc <- friedmanmc(wk046.placeborem22Y)
friedmc
pairwise.wilcox.test(ggplot.wk046.placeborem22Y$invsimpson, ggplot.wk046.placeborem22Y$visit, p.adj="BH", exact=F, paired=T)

#friedman for nonremitters
friedman.test(wk046.placeborem22N)
friedmc <- friedmanmc(wk046.placeborem22N)
friedmc
pairwise.wilcox.test(ggplot.wk046.placeborem22N$invsimpson, ggplot.wk046.placeborem22N$visit, p.adj="BH", exact=F, paired=T)

	