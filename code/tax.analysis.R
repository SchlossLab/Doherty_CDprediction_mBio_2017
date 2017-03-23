source('../code/tax.analysis.setup.R')


total_mean_rabund <- apply(phylum_rel_abund, 2, mean)
#mean_phylum <- aggregate(phylum_rel_abund, by=list(screen_data$REMISSwk6), mean)


decreasing_order <- order(total_mean_rabund, decreasing=T)
phylum_rel_abund <- phylum_rel_abund[,decreasing_order]
mean_rel_abund <- aggregate(phylum_rel_abund, by=list(screen_data$TRT_REMwk6), mean)

mean_phylum <- aggregate(phylum_rel_abund, by=list(screen_data$TRTGR, screen_data$REMISSwk6), mean)
mean_phylum$TRTGRrem <- paste(mean_phylum$Group.1, mean_phylum$Group.2)
mean_phylum_matrix <- subset(mean_phylum, select=-c(TRTGRrem))
mean_phylum_matrix <- as.matrix(t(subset(mean_phylum_matrix, select=-c(1:2))))
colnames(mean_phylum_matrix) <- mean_phylum$TRTGRrem

median_phylum <- aggregate(phylum_rel_abund, by=list(screen_data$TRTGR, screen_data$REMISSwk6), median)
median_phylum$TRTGRrem <- paste(median_phylum$Group.1, median_phylum$Group.2)
median_phylum_matrix <- subset(median_phylum, select=-c(TRTGRrem))
median_phylum_matrix <- as.matrix(t(subset(median_phylum_matrix, select=-c(1:2))))
colnames(median_phylum_matrix) <- median_phylum$TRTGRrem



sd_phylum <- aggregate(phylum_rel_abund, by=list(screen_data$TRTGR, screen_data$REMISSwk6), sd)
sd_phylum$TRTGRrem <- paste(sd_phylum$Group.1, sd_phylum$Group.2)
sd_phylum_matrix <- subset(sd_phylum, select=-c(TRTGRrem))
sd_phylum_matrix <- as.matrix(t(subset(sd_phylum_matrix, select=-c(1:2))))
colnames(sd_phylum_matrix) <- sd_phylum$TRTGRrem

IQR_phylum <- aggregate(phylum_rel_abund, by=list(screen_data$TRTGR, screen_data$REMISSwk6), IQR)
IQR_phylum$TRTGRrem <- paste(IQR_phylum$Group.1, IQR_phylum$Group.2)
IQR_phylum_matrix <- subset(IQR_phylum, select=-c(TRTGRrem))
IQR_phylum_matrix <- as.matrix(t(subset(IQR_phylum_matrix, select=-c(1:2))))
colnames(IQR_phylum_matrix) <- IQR_phylum$TRTGRrem

stopifnot(screen_data$group == rownames(phylum_rel_abund))
abundant <- apply(mean_phylum_matrix, 1, mean) > 0.005

#abundant <- row.names(mean_phylum_matrix)[abundant]


mean_abundant_phylum_matrix <- mean_phylum_matrix[abundant, ]
sd_abundant_phylum_matrix <- sd_phylum_matrix[abundant, ]
median_abundant_phylum_matrix <- median_phylum_matrix[abundant, ]


#abundant_phyRelab_TRTGR_REMISSwk6_df <- phyRelab_TRTGR_REMISSwk6[,abundant]

#wilcox.test(phylum_rel_abund$Bacteroidetes~screen_data$REMISSwk6)


#phylum_p <- numeric() 
#for(phylum in phylum_names){
#	phylum_p[phylum] <- wilcox.test(phylum_rel_abund[,phylum] ~screen_data$REMISSwk6)$p.value
#}


#phylum_pMCT <- data.frame(Comparison = rownames(test), stringsAsFactors = T)

#phylum_pMCT$comparison <- rownames(test)
#for(phylum in phylum_names){
#	phylum_pMCT[phylum] <- kruskalmc(phylum_rel_abund[[phylum]]~screen_data$TRT_REMwk6)$dif.com[,3]
#	phylum_pMCT <- cbind(phylum_pMCT,phylum_pMCT[phylum])
#}

#kruskalmc(phylum_rel_abund$Bacteroidetes~screen_data$REMISSwk6)

#test<-kruskalmc(phylum_rel_abund$Bacteroidetes~screen_data$TRT_REMwk6)$dif.com



#phylum_adj_p <- p.adjust(phylum_p, method="BH") 
#phylum_adj_p < 0.05

#REMwk6_wilcox_phylum_p <- numeric() 
#for(phylum in phylum_names){
#	REMwk6_wilcox_phylum_p[phylum] <- wilcox.test(phylum_rel_abund[,phylum] ~screen_data$REMISSwk6)$p.value
#}

#RelRSPwk6_wilcox_phylum_p <- numeric() 
#for(phylum in phylum_names){
#	RelRSPwk6_wilcox_phylum_p[phylum] <- wilcox.test(phylum_rel_abund[,phylum] ~screen_data$RelRSPwk6)$p.value
#}

#REMISSwk6_wilcox_phylum_adj_p <- na.omit(p.adjust(REMwk6_wilcox_phylum_p, method="BH"))
#sig_REMISSwk6_wilcox_phylum_adj_p <-REMISSwk6_wilcox_phylum_adj_p  < 0.05

#RelRSPwk6_wilcox_phylum_adj_p <- na.omit(p.adjust(RelRSPwk6_wilcox_phylum_p, method="BH"))
#sig_RelRSPwk6_wilcox_phylum_adj_p <-RelRSPwk6_wilcox_phylum_adj_p  < 0.05

#REMISSwk22_wilcox_phylum_p <- numeric() 
#for(phylum in phylum_names){
#	REMwk22_wilcox_phylum_p[phylum] <- wilcox.test(phylum_rel_abund[,phylum] ~screen_data$REMISSwk22)$p.value
#}

#RelRSPwk22_wilcox_phylum_p <- numeric() 
#for(phylum in phylum_names){
#	RelRSPwk22_wilcox_phylum_p[phylum] <- wilcox.test(phylum_rel_abund[,phylum] ~screen_data$RelRSPwk22)$p.value
#}

#REMISSwk22_wilcox_phylum_adj_p <- na.omit(p.adjust(REMISSwk22_wilcox_phylum_p, method="BH"))
#sig_REMISSwk22_wilcox_phylum_adj_p <-REMISSwk22_wilcox_phylum_adj_p  < 0.05

#RelRSPwk22_wilcox_phylum_adj_p <- na.omit(p.adjust(RelRSPwk22_wilcox_phylum_p, method="BH"))
#sig_RelRSPwk22_wilcox_phylum_adj_p <-RelRSPwk22_wilcox_phylum_adj_p  < 0.05




#cbind(data.frame(mean_abundant_phylum_matrix, Phylum = row.names(mean_abundant_phylum_matrix))) %>%
				gather(treatment, relabund, -Phylum) %>% ggplot(aes(x=treatment, y=relabund, fill=Phylum)) +
#	geom_bar(position = "dodge", stat="identity")


#phyRabTRTwk6rem_ggplot <- gather(phyRelab_TRTGR_REMISSwk6, phylum, relabund, one_of(row.names(mean_phylum_matrix)[abundant]))
#rank <- c("Firmicutes","Bacteroidetes","Proteobacteria","Actinobacteria","Verrucomicrobia","Fusobacteria")
#phyRabTRTwk6rem_ggplot$phylum <- factor(phyRabTRTwk6rem_ggplot$phylum, levels = rank, labels= rank)  #order the subset dataset by the median abundances
#phyRabTRTwk6rem_ggplot <- phyRabTRTwk6rem_ggplot[order(phyRabTRTwk6rem_ggplot$phylum),]

#phyRabTRTwk6rem_ggplot <- gather(phyRelab_TRTGR_REMISSwk6, phylum, relabund, one_of(row.names(mean_phylum_matrix)[abundant]))
#phyRabTRTwk6rem_ggplot$phylum <- factor(phyRabTRTwk6rem_ggplot$phylum, levels = rank, labels= rank)  #order the subset dataset by the median abundances
#phyRabTRTwk6rem_ggplot <- phyRabTRTwk6rem_ggplot[order(phyRabTRTwk6rem_ggplot$phylum),]


#phylum_figure <- ggplot(phyRabTRTwk6rem_ggplot, aes(x=TRT_REMwk6, y=relabund, fill=phylum)) +
	#stat_summary(fun.y=median, geom="point", aes(fill = phylum), position = position_dodge(1)) +
	#stat_summary(fun.data = 'median_hilow', fun.args = (conf.int=0.5), position = position_dodge(1), geom='errorbar', aes(color = phylum))+
	geom_boxplot(aes(col=phylum), position=position_dodge(width = 1), alpha = .4)

#phylum_figure

#summary(phyRabTRTwk6rem_ggplot$phylum)
#

#str(phyRabTRTwk6rem_ggplot$phylum)
