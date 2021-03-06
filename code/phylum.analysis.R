source('../code/tax.analysis.setup.R')

#phylum_rel_abund <- phylum_rel_abund*100
total_mean_rabund <- apply(phylum_rel_abund, 2, mean)
mean_phylum <- aggregate(phylum_rel_abund, by=list(screen_data$REMISSwk6), mean)


decreasing_order <- order(total_mean_rabund, decreasing=T)
phylum_rel_abund <- phylum_rel_abund[,decreasing_order]
mean_phylum_rel_abund <- aggregate(phylum_rel_abund, by=list(screen_data$REMISSwk6), mean)

mean_phylum <- aggregate(phylum_rel_abund, by=list(screen_data$REMISSwk6), mean)
#mean_phylum$REMISSwk6 <- paste(mean_phylum$Group.1, mean_phylum$Group.2)
mean_phylum_matrix <- subset(mean_phylum, select=-c(Group.1))
mean_phylum_matrix <- as.matrix(t(subset(mean_phylum_matrix))) #select=-c(1))))
colnames(mean_phylum_matrix) <- mean_phylum$Group.1

median_phylum <- aggregate(phylum_rel_abund, by=list(screen_data$REMISSwk6), median)
#median_phylum$REMISSwk6 <- median_phylum$Group.1
median_phylum_matrix <- subset(median_phylum, select=-c(Group.1))
median_phylum_matrix <- as.matrix(t(subset(median_phylum_matrix)))
colnames(median_phylum_matrix) <- median_phylum$REMISSwk6


# phylum_rel_abund.remWK6Y <- phylum_rel_abund[trtd.REMISSwk6.wilcox.test.data$REMISSwk6=="Yes",]
# median(phylum_rel_abund.remWK6Y$Fusobacteria)
# quantile(phylum_rel_abund.remWK6Y$Fusobacteria, type=2)
# phylum_rel_abund.remWK6N <- phylum_rel_abund[trtd.REMISSwk6.wilcox.test.data$REMISSwk6=="No",]
# median(phylum_rel_abund.remWK6N$Fusobacteria)
# quantile(phylum_rel_abund.remWK6N$Fusobacteria, type=2)

sd_phylum <- aggregate(phylum_rel_abund, by=list(screen_data$REMISSwk6), sd)
#sd_phylum$REMISSwk6 <- paste(sd_phylum$Group.1, sd_phylum$Group.2)
sd_phylum_matrix <- subset(sd_phylum, select=-c(Group.1))
sd_phylum_matrix <- as.matrix(t(subset(sd_phylum_matrix)))
colnames(sd_phylum_matrix) <- sd_phylum$Group.1

IQR_phylum <- aggregate(phylum_rel_abund, by=list(screen_data$REMISSwk6), IQR)
#IQR_phylum$REMISSwk6 <- paste(IQR_phylum$Group.1, IQR_phylum$Group.2)
IQR_phylum_matrix <- subset(IQR_phylum, select=-c(Group.1))
IQR_phylum_matrix <- as.matrix(t(subset(IQR_phylum_matrix)))
colnames(IQR_phylum_matrix) <- IQR_phylum$Group.1

stopifnot(screen_data$group == rownames(phylum_rel_abund))
abundant <- apply(mean_phylum_matrix, 1, mean) > 0.5

#abundant <- row.names(mean_phylum_matrix)[abundant]


mean_abundant_phylum_matrix <- mean_phylum_matrix[abundant, ]
sd_abundant_phylum_matrix <- sd_phylum_matrix[abundant, ]
median_abundant_phylum_matrix <- median_phylum_matrix[abundant, ]


#abundant_phyRelab_REMISSwk6_df <- phyRelab_REMISSwk6[,abundant]

#wilcox.test(phylum_rel_abund$Bacteroidetes~screen_data$REMISSwk6)


#phylum_p <- numeric() 
#for(phylum in phylum_names){
#	phylum_p[phylum] <- wilcox.test(phylum_rel_abund[,phylum] ~screen_data$REMISSwk6)$p.value
#}


#phylum_pMCT <- data.frame(Comparison = rownames(test), stringsAsFactors = T)

#phylum_pMCT$comparison <- rownames(test)
#for(phylum in phylum_names){
#	phylum_pMCT[phylum] <- kruskalmc(phylum_rel_abund[[phylum]]~screen_data$REMISSwk6)$dif.com[,3]
#	phylum_pMCT <- cbind(phylum_pMCT,phylum_pMCT[phylum])
#}

#kruskalmc(phylum_rel_abund$Bacteroidetes~screen_data$REMISSwk6)

#test<-kruskalmc(phylum_rel_abund$Bacteroidetes~screen_data$REMISSwk6)$dif.com



#phylum_adj_p <- p.adjust(phylum_p, method="BH") 
#phylum_adj_p < 0.05

REMISSwk6_kw_phylum_p <- numeric() 
for(phylum in phylum_names){
	REMISSwk6_kw_phylum_p[phylum] <- kruskal.test(phylum_rel_abund[,phylum] ~TRTGR_REMISSwk6$TRTGR_REMISSwk6)$p.value
}

RESPONSEwk6_kw_phylum_p <- numeric() 
for(phylum in phylum_names){
	RESPONSEwk6_kw_phylum_p[phylum] <- kruskal.test(phylum_rel_abund[,phylum] ~TRTGR_RESPONSEwk6$TRTGR_RESPONSEwk6)$p.value
}

REMISSwk6_kw_phylum_adj_p <- na.omit(p.adjust(REMISSwk6_kw_phylum_p, method="BH"))
sig_REMISSwk6_kw_phylum_adj_p <-REMISSwk6_kw_phylum_adj_p  < 0.05

RESPONSEwk6_kw_phylum_adj_p <- na.omit(p.adjust(RESPONSEwk6_kw_phylum_p, method="BH"))
sig_RESPONSEwk6_kw_phylum_adj_p <-RESPONSEwk6_kw_phylum_adj_p  < 0.05

REMISSwk22_kw_phylum_p <- numeric() 
for(phylum in phylum_names){
	REMISSwk22_kw_phylum_p[phylum] <- kruskal.test(phylum_rel_abund[,phylum] ~screen_data$TRTGRINDMAN_REMISSwk22)$p.value
}

RESPONSEwk22_kw_phylum_p <- numeric() 
for(phylum in phylum_names){
	RESPONSEwk22_kw_phylum_p[phylum] <- kruskal.test(phylum_rel_abund[,phylum] ~screen_data$TRTGRINDMAN_RESPONSEwk22)$p.value
}

REMISSwk22_kw_phylum_adj_p <- na.omit(p.adjust(REMISSwk22_kw_phylum_p, method="BH"))
sig_REMISSwk22_kw_phylum_adj_p <-REMISSwk22_kw_phylum_adj_p  < 0.05

RESPONSEwk22_kw_phylum_adj_p <- na.omit(p.adjust(RESPONSEwk22_kw_phylum_p, method="BH"))
sig_RESPONSEwk22_kw_phylum_adj_p <-RESPONSEwk22_kw_phylum_adj_p  < 0.05







cbind(data.frame(mean_abundant_phylum_matrix, Phylum = row.names(mean_abundant_phylum_matrix))) %>%
	gather(treatment, relabund, -Phylum) %>% ggplot(aes(x=treatment, y=relabund, fill=Phylum)) +
	geom_bar(position = "dodge", stat="identity") + ylab("Relative Abundance (%)") + xlab("Week 6 Remission") +
	theme(legend.text = element_text(face = "italic"))

#phyRelab_RESPONSEwk6 <- phyRelab_RESPONSEwk6*100
phyRabRESPONSEwk6_ggplot <- gather(phyRelab_RESPONSEwk6, phylum, relabund, one_of(row.names(mean_phylum_matrix)[abundant]))
rank <- c("Firmicutes","Bacteroidetes","Proteobacteria","Actinobacteria","Verrucomicrobia","Fusobacteria")
phyRabRESPONSEwk6_ggplot$phylum <- factor(phyRabRESPONSEwk6_ggplot$phylum, levels = rank, labels= rank)  #order the subset dataset by the median abundances
phyRabRESPONSEwk6_ggplot <- phyRabRESPONSEwk6_ggplot[order(phyRabRESPONSEwk6_ggplot$phylum),]
phyRabRESPONSEwk6_ggplot <- gather(phyRelab_RESPONSEwk6, phylum, relabund, one_of(row.names(mean_phylum_matrix)[abundant]))
phyRabRESPONSEwk6_ggplot$phylum <- factor(phyRabRESPONSEwk6_ggplot$phylum, levels = rank, labels= rank)  #order the subset dataset by the median abundances
phyRabRESPONSEwk6_ggplot <- phyRabRESPONSEwk6_ggplot[order(phyRabRESPONSEwk6_ggplot$phylum),]


#phyRelab_REMISSwk6 <- phyRelab_REMISSwk6*100
phyRabREMISSwk6_ggplot <- gather(phyRelab_REMISSwk6, phylum, relabund, one_of(row.names(mean_phylum_matrix)[abundant]))
rank <- c("Firmicutes","Bacteroidetes","Proteobacteria","Actinobacteria","Verrucomicrobia","Fusobacteria")
phyRabREMISSwk6_ggplot$phylum <- factor(phyRabREMISSwk6_ggplot$phylum, levels = rank, labels= rank)  #order the subset dataset by the median abundances
phyRabREMISSwk6_ggplot <- phyRabREMISSwk6_ggplot[order(phyRabREMISSwk6_ggplot$phylum),]
phyRabREMISSwk6_ggplot <- gather(phyRelab_REMISSwk6, phylum, relabund, one_of(row.names(mean_phylum_matrix)[abundant]))
phyRabREMISSwk6_ggplot$phylum <- factor(phyRabREMISSwk6_ggplot$phylum, levels = rank, labels= rank)  #order the subset dataset by the median abundances
phyRabREMISSwk6_ggplot <- phyRabREMISSwk6_ggplot[order(phyRabREMISSwk6_ggplot$phylum),]


#phyRelab_RESPONSEwk22 <- phyRelab_RESPONSEwk22*100
phyRabRESPONSEwk22_ggplot <- gather(phyRelab_RESPONSEwk22, phylum, relabund, one_of(row.names(mean_phylum_matrix)[abundant]))
rank <- c("Firmicutes","Bacteroidetes","Proteobacteria","Actinobacteria","Verrucomicrobia","Fusobacteria")
phyRabRESPONSEwk22_ggplot$phylum <- factor(phyRabRESPONSEwk22_ggplot$phylum, levels = rank, labels= rank)  #order the subset dataset by the median abundances
phyRabRESPONSEwk22_ggplot <- phyRabRESPONSEwk22_ggplot[order(phyRabRESPONSEwk22_ggplot$phylum),]
phyRabRESPONSEwk22_ggplot <- gather(phyRelab_RESPONSEwk22, phylum, relabund, one_of(row.names(mean_phylum_matrix)[abundant]))
phyRabRESPONSEwk22_ggplot$phylum <- factor(phyRabRESPONSEwk22_ggplot$phylum, levels = rank, labels= rank)  #order the subset dataset by the median abundances
phyRabRESPONSEwk22_ggplot <- phyRabRESPONSEwk22_ggplot[order(phyRabRESPONSEwk22_ggplot$phylum),]


#phyRelab_REMISSwk22 <- phyRelab_REMISSwk22*100
phyRabREMISSwk22_ggplot <- gather(phyRelab_REMISSwk22, phylum, relabund, one_of(row.names(mean_phylum_matrix)[abundant]))
rank <- c("Firmicutes","Bacteroidetes","Proteobacteria","Actinobacteria","Verrucomicrobia","Fusobacteria")
phyRabREMISSwk22_ggplot$phylum <- factor(phyRabREMISSwk22_ggplot$phylum, levels = rank, labels= rank)  #order the subset dataset by the median abundances
phyRabREMISSwk22_ggplot <- phyRabREMISSwk22_ggplot[order(phyRabREMISSwk22_ggplot$phylum),]
phyRabREMISSwk22_ggplot <- gather(phyRelab_REMISSwk22, phylum, relabund, one_of(row.names(mean_phylum_matrix)[abundant]))
phyRabREMISSwk22_ggplot$phylum <- factor(phyRabREMISSwk22_ggplot$phylum, levels = rank, labels= rank)  #order the subset dataset by the median abundances
phyRabREMISSwk22_ggplot <- phyRabREMISSwk22_ggplot[order(phyRabREMISSwk22_ggplot$phylum),]







#trtd.phylum_rel_abund <- trtd.phylum_rel_abund*100
total_trtd.mean_rabund <- apply(trtd.phylum_rel_abund, 2, mean)
mean_trtd.phylum <- aggregate(trtd.phylum_rel_abund, by=list(trtd.screen_data$REMISSwk6), mean)


decreasing_order <- order(total_trtd.mean_rabund, decreasing=T)
trtd.phylum_rel_abund <- trtd.phylum_rel_abund[,decreasing_order]
mean_trtd.phylum_rel_abund <- aggregate(trtd.phylum_rel_abund, by=list(trtd.screen_data$REMISSwk6), mean)

mean_trtd.phylum <- aggregate(trtd.phylum_rel_abund, by=list(trtd.screen_data$REMISSwk6), mean)
#mean_trtd.phylum$REMISSwk6 <- paste(mean_trtd.phylum$Group.1, mean_trtd.phylum$Group.2)
mean_trtd.phylum_matrix <- subset(mean_trtd.phylum, select=-c(Group.1))
mean_trtd.phylum_matrix <- as.matrix(t(subset(mean_trtd.phylum_matrix))) #select=-c(1))))
colnames(mean_trtd.phylum_matrix) <- mean_trtd.phylum$Group.1

median_trtd.phylum <- aggregate(trtd.phylum_rel_abund, by=list(trtd.screen_data$REMISSwk6), median)
#median_trtd.phylum$REMISSwk6 <- median_trtd.phylum$Group.1
median_trtd.phylum_matrix <- subset(median_trtd.phylum, select=-c(Group.1))
median_trtd.phylum_matrix <- as.matrix(t(subset(median_trtd.phylum_matrix)))
colnames(median_trtd.phylum_matrix) <- median_trtd.phylum$Group.1



sd_trtd.phylum <- aggregate(trtd.phylum_rel_abund, by=list(trtd.screen_data$REMISSwk6), sd)
#sd_trtd.phylum$REMISSwk6 <- paste(sd_trtd.phylum$Group.1, sd_trtd.phylum$Group.2)
sd_trtd.phylum_matrix <- subset(sd_trtd.phylum, select=-c(Group.1))
sd_trtd.phylum_matrix <- as.matrix(t(subset(sd_trtd.phylum_matrix)))
colnames(sd_trtd.phylum_matrix) <- sd_trtd.phylum$Group.1

IQR_trtd.phylum <- aggregate(trtd.phylum_rel_abund, by=list(trtd.screen_data$REMISSwk6), IQR)
#IQR_trtd.phylum$REMISSwk6 <- paste(IQR_trtd.phylum$Group.1, IQR_trtd.phylum$Group.2)
IQR_trtd.phylum_matrix <- subset(IQR_trtd.phylum, select=-c(Group.1))
IQR_trtd.phylum_matrix <- as.matrix(t(subset(IQR_trtd.phylum_matrix)))
colnames(IQR_trtd.phylum_matrix) <- IQR_trtd.phylum$Group.1

stopifnot(trtd.screen_data$group == rownames(trtd.phylum_rel_abund))
abundant <- apply(mean_trtd.phylum_matrix, 1, mean) > 0.5

#abundant <- row.names(mean_trtd.phylum_matrix)[abundant]


mean_abundant_trtd.phylum_matrix <- mean_trtd.phylum_matrix[abundant, ]
sd_abundant_trtd.phylum_matrix <- sd_trtd.phylum_matrix[abundant, ]
median_abundant_trtd.phylum_matrix <- median_trtd.phylum_matrix[abundant, ]


#abundant_phyRelab_REMISSwk6_df <- phyRelab_REMISSwk6[,abundant]

#wilcox.test(trtd.phylum_rel_abund$Bacteroidetes~trtd.screen_data$REMISSwk6)


#trtd.phylum_p <- numeric() 
#for(trtd.phylum in trtd.phylum_names){
#	trtd.phylum_p[trtd.phylum] <- wilcox.test(trtd.phylum_rel_abund[,trtd.phylum] ~trtd.screen_data$REMISSwk6)$p.value
#}


#trtd.phylum_pMCT <- data.frame(Comparison = rownames(test), stringsAsFactors = T)

#trtd.phylum_pMCT$comparison <- rownames(test)
#for(trtd.phylum in trtd.phylum_names){
#	trtd.phylum_pMCT[trtd.phylum] <- kruskalmc(trtd.phylum_rel_abund[[trtd.phylum]]~trtd.screen_data$REMISSwk6)$dif.com[,3]
#	trtd.phylum_pMCT <- cbind(trtd.phylum_pMCT,trtd.phylum_pMCT[trtd.phylum])
#}

#kruskalmc(trtd.phylum_rel_abund$Bacteroidetes~trtd.screen_data$REMISSwk6)

#test<-kruskalmc(trtd.phylum_rel_abund$Bacteroidetes~trtd.screen_data$REMISSwk6)$dif.com



#trtd.phylum_adj_p <- p.adjust(trtd.phylum_p, method="BH") 
#trtd.phylum_adj_p < 0.05

REMISSwk6_wilcox_trtd.phylum_p <- numeric() 
for(phylum in trtd.phylum_names){
	REMISSwk6_wilcox_trtd.phylum_p[phylum] <- wilcox.test(trtd.phylum_rel_abund[,phylum] ~trtd.screen_data$REMISSwk6)$p.value
}

RESPONSEwk6_wilcox_trtd.phylum_p <- numeric() 
for(phylum in trtd.phylum_names){
	RESPONSEwk6_wilcox_trtd.phylum_p[phylum] <- wilcox.test(trtd.phylum_rel_abund[,phylum] ~trtd.screen_data$RESPONSEwk6)$p.value
}

REMISSwk6_wilcox_trtd.phylum_adj_p <- na.omit(p.adjust(REMISSwk6_wilcox_trtd.phylum_p, method="BH"))
sig_REMISSwk6_wilcox_trtd.phylum_adj_p <-REMISSwk6_wilcox_trtd.phylum_adj_p  < 0.05

RESPONSEwk6_wilcox_trtd.phylum_adj_p <- na.omit(p.adjust(RESPONSEwk6_wilcox_trtd.phylum_p, method="BH"))
sig_RESPONSEwk6_wilcox_trtd.phylum_adj_p <-RESPONSEwk6_wilcox_trtd.phylum_adj_p  < 0.05

REMISSwk22_wilcox_trtd.phylum_p <- numeric() 
for(phylum in trtd.phylum_names){
	REMISSwk22_wilcox_trtd.phylum_p[phylum] <- wilcox.test(trtd.phylum_rel_abund[,phylum] ~trtd.screen_data$REMISSwk22)$p.value
}

RESPONSEwk22_wilcox_trtd.phylum_p <- numeric() 
for(phylum in trtd.phylum_names){
	RESPONSEwk22_wilcox_trtd.phylum_p[phylum] <- wilcox.test(trtd.phylum_rel_abund[,phylum] ~trtd.screen_data$RESPONSEwk22)$p.value
}

REMISSwk22_wilcox_trtd.phylum_adj_p <- na.omit(p.adjust(REMISSwk22_wilcox_trtd.phylum_p, method="BH"))
sig_REMISSwk22_wilcox_trtd.phylum_adj_p <-REMISSwk22_wilcox_trtd.phylum_adj_p  < 0.05

RESPONSEwk22_wilcox_trtd.phylum_adj_p <- na.omit(p.adjust(RESPONSEwk22_wilcox_trtd.phylum_p, method="BH"))
sig_RESPONSEwk22_wilcox_trtd.phylum_adj_p <-RESPONSEwk22_wilcox_trtd.phylum_adj_p  < 0.05







cbind(data.frame(mean_abundant_trtd.phylum_matrix, Phylum = row.names(mean_abundant_trtd.phylum_matrix))) %>%
	gather(treatment, relabund, -Phylum) %>% ggplot(aes(x=treatment, y=relabund, fill=Phylum)) +
	geom_bar(position = "dodge", stat="identity") + ylab("Relative Abundance (%)") + xlab("Week 6 Remission") +
	theme(legend.text = element_text(face = "italic"))

#phyRelab_RESPONSEwk6 <- phyRelab_RESPONSEwk6*100
trtd.phyRabRESPONSEwk6_ggplot <- gather(phyRelab_RESPONSEwk6, phylum, relabund, one_of(row.names(mean_trtd.phylum_matrix)[abundant]))
rank <- c("Firmicutes","Bacteroidetes","Proteobacteria","Actinobacteria","Verrucomicrobia","Fusobacteria")
trtd.phyRabRESPONSEwk6_ggplot$phylum <- factor(trtd.phyRabRESPONSEwk6_ggplot$phylum, levels = rank, labels= rank)  #order the subset dataset by the median abundances
trtd.phyRabRESPONSEwk6_ggplot <- trtd.phyRabRESPONSEwk6_ggplot[order(trtd.phyRabRESPONSEwk6_ggplot$phylum),]
trtd.phyRabRESPONSEwk6_ggplot <- gather(phyRelab_RESPONSEwk6, phylum, relabund, one_of(row.names(mean_trtd.phylum_matrix)[abundant]))
trtd.phyRabRESPONSEwk6_ggplot$phylum <- factor(trtd.phyRabRESPONSEwk6_ggplot$phylum, levels = rank, labels= rank)  #order the subset dataset by the median abundances
trtd.phyRabRESPONSEwk6_ggplot <- trtd.phyRabRESPONSEwk6_ggplot[order(trtd.phyRabRESPONSEwk6_ggplot$phylum),]


#phyRelab_REMISSwk6 <- phyRelab_REMISSwk6*100
trtd.phyRabREMISSwk6_ggplot <- gather(phyRelab_REMISSwk6, phylum, relabund, one_of(row.names(mean_trtd.phylum_matrix)[abundant]))
rank <- c("Firmicutes","Bacteroidetes","Proteobacteria","Actinobacteria","Verrucomicrobia","Fusobacteria")
trtd.phyRabREMISSwk6_ggplot$phylum <- factor(trtd.phyRabREMISSwk6_ggplot$phylum, levels = rank, labels= rank)  #order the subset dataset by the median abundances
trtd.phyRabREMISSwk6_ggplot <- trtd.phyRabREMISSwk6_ggplot[order(trtd.phyRabREMISSwk6_ggplot$phylum),]
trtd.phyRabREMISSwk6_ggplot <- gather(phyRelab_REMISSwk6, phylum, relabund, one_of(row.names(mean_trtd.phylum_matrix)[abundant]))
trtd.phyRabREMISSwk6_ggplot$phylum <- factor(trtd.phyRabREMISSwk6_ggplot$phylum, levels = rank, labels= rank)  #order the subset dataset by the median abundances
trtd.phyRabREMISSwk6_ggplot <- trtd.phyRabREMISSwk6_ggplot[order(trtd.phyRabREMISSwk6_ggplot$phylum),]


#phyRelab_RESPONSEwk22 <- phyRelab_RESPONSEwk22*100
trtd.phyRabRESPONSEwk22_ggplot <- gather(phyRelab_RESPONSEwk22, phylum, relabund, one_of(row.names(mean_trtd.phylum_matrix)[abundant]))
rank <- c("Firmicutes","Bacteroidetes","Proteobacteria","Actinobacteria","Verrucomicrobia","Fusobacteria")
trtd.phyRabRESPONSEwk22_ggplot$phylum <- factor(trtd.phyRabRESPONSEwk22_ggplot$phylum, levels = rank, labels= rank)  #order the subset dataset by the median abundances
trtd.phyRabRESPONSEwk22_ggplot <- trtd.phyRabRESPONSEwk22_ggplot[order(trtd.phyRabRESPONSEwk22_ggplot$phylum),]
trtd.phyRabRESPONSEwk22_ggplot <- gather(phyRelab_RESPONSEwk22, phylum, relabund, one_of(row.names(mean_trtd.phylum_matrix)[abundant]))
trtd.phyRabRESPONSEwk22_ggplot$phylum <- factor(trtd.phyRabRESPONSEwk22_ggplot$phylum, levels = rank, labels= rank)  #order the subset dataset by the median abundances
trtd.phyRabRESPONSEwk22_ggplot <- trtd.phyRabRESPONSEwk22_ggplot[order(trtd.phyRabRESPONSEwk22_ggplot$phylum),]


#phyRelab_REMISSwk22 <- phyRelab_REMISSwk22*100
trtd.phyRabREMISSwk22_ggplot <- gather(phyRelab_REMISSwk22, phylum, relabund, one_of(row.names(mean_trtd.phylum_matrix)[abundant]))
rank <- c("Firmicutes","Bacteroidetes","Proteobacteria","Actinobacteria","Verrucomicrobia","Fusobacteria")
trtd.phyRabREMISSwk22_ggplot$phylum <- factor(trtd.phyRabREMISSwk22_ggplot$phylum, levels = rank, labels= rank)  #order the subset dataset by the median abundances
trtd.phyRabREMISSwk22_ggplot <- trtd.phyRabREMISSwk22_ggplot[order(trtd.phyRabREMISSwk22_ggplot$phylum),]
trtd.phyRabREMISSwk22_ggplot <- gather(phyRelab_REMISSwk22, phylum, relabund, one_of(row.names(mean_trtd.phylum_matrix)[abundant]))
trtd.phyRabREMISSwk22_ggplot$phylum <- factor(trtd.phyRabREMISSwk22_ggplot$phylum, levels = rank, labels= rank)  #order the subset dataset by the median abundances
trtd.phyRabREMISSwk22_ggplot <- trtd.phyRabREMISSwk22_ggplot[order(trtd.phyRabREMISSwk22_ggplot$phylum),]





#plac.phylum_rel_abund <- plac.phylum_rel_abund*100
total_plac.mean_rabund <- apply(plac.phylum_rel_abund, 2, mean)
mean_plac.phylum <- aggregate(plac.phylum_rel_abund, by=list(plac.screen_data$REMISSwk6), mean)


decreasing_order <- order(total_plac.mean_rabund, decreasing=T)
plac.phylum_rel_abund <- plac.phylum_rel_abund[,decreasing_order]
mean_plac.phylum_rel_abund <- aggregate(plac.phylum_rel_abund, by=list(plac.screen_data$REMISSwk6), mean)

mean_plac.phylum <- aggregate(plac.phylum_rel_abund, by=list(plac.screen_data$REMISSwk6), mean)
#mean_plac.phylum$REMISSwk6 <- paste(mean_plac.phylum$Group.1, mean_plac.phylum$Group.2)
mean_plac.phylum_matrix <- subset(mean_plac.phylum, select=-c(Group.1))
mean_plac.phylum_matrix <- as.matrix(t(subset(mean_plac.phylum_matrix))) #select=-c(1))))
colnames(mean_plac.phylum_matrix) <- mean_plac.phylum$Group.1

median_plac.phylum <- aggregate(plac.phylum_rel_abund, by=list(plac.screen_data$REMISSwk6), median)
#median_plac.phylum$REMISSwk6 <- median_plac.phylum$Group.1
median_plac.phylum_matrix <- subset(median_plac.phylum, select=-c(Group.1))
median_plac.phylum_matrix <- as.matrix(t(subset(median_plac.phylum_matrix)))
colnames(median_plac.phylum_matrix) <- median_plac.phylum$REMISSwk6



sd_plac.phylum <- aggregate(plac.phylum_rel_abund, by=list(plac.screen_data$REMISSwk6), sd)
#sd_plac.phylum$REMISSwk6 <- paste(sd_plac.phylum$Group.1, sd_plac.phylum$Group.2)
sd_plac.phylum_matrix <- subset(sd_plac.phylum, select=-c(Group.1))
sd_plac.phylum_matrix <- as.matrix(t(subset(sd_plac.phylum_matrix)))
colnames(sd_plac.phylum_matrix) <- sd_plac.phylum$Group.1

IQR_plac.phylum <- aggregate(plac.phylum_rel_abund, by=list(plac.screen_data$REMISSwk6), IQR)
#IQR_plac.phylum$REMISSwk6 <- paste(IQR_plac.phylum$Group.1, IQR_plac.phylum$Group.2)
IQR_plac.phylum_matrix <- subset(IQR_plac.phylum, select=-c(Group.1))
IQR_plac.phylum_matrix <- as.matrix(t(subset(IQR_plac.phylum_matrix)))
colnames(IQR_plac.phylum_matrix) <- IQR_plac.phylum$Group.1

stopifnot(plac.screen_data$group == rownames(plac.phylum_rel_abund))
abundant <- apply(mean_plac.phylum_matrix, 1, mean) > 0.5

#abundant <- row.names(mean_plac.phylum_matrix)[abundant]


mean_abundant_plac.phylum_matrix <- mean_plac.phylum_matrix[abundant, ]
sd_abundant_plac.phylum_matrix <- sd_plac.phylum_matrix[abundant, ]
median_abundant_plac.phylum_matrix <- median_plac.phylum_matrix[abundant, ]


#abundant_phyRelab_REMISSwk6_df <- phyRelab_REMISSwk6[,abundant]

#wilcox.test(plac.phylum_rel_abund$Bacteroidetes~plac.screen_data$REMISSwk6)


#plac.phylum_p <- numeric() 
#for(plac.phylum in plac.phylum_names){
#	plac.phylum_p[plac.phylum] <- wilcox.test(plac.phylum_rel_abund[,plac.phylum] ~plac.screen_data$REMISSwk6)$p.value
#}


#plac.phylum_pMCT <- data.frame(Comparison = rownames(test), stringsAsFactors = T)

#plac.phylum_pMCT$comparison <- rownames(test)
#for(plac.phylum in plac.phylum_names){
#	plac.phylum_pMCT[plac.phylum] <- kruskalmc(plac.phylum_rel_abund[[plac.phylum]]~plac.screen_data$REMISSwk6)$dif.com[,3]
#	plac.phylum_pMCT <- cbind(plac.phylum_pMCT,plac.phylum_pMCT[plac.phylum])
#}

#kruskalmc(plac.phylum_rel_abund$Bacteroidetes~plac.screen_data$REMISSwk6)

#test<-kruskalmc(plac.phylum_rel_abund$Bacteroidetes~plac.screen_data$REMISSwk6)$dif.com



#plac.phylum_adj_p <- p.adjust(plac.phylum_p, method="BH") 
#plac.phylum_adj_p < 0.05

REMISSwk6_wilcox_plac.phylum_p <- numeric() 
for(phylum in plac.phylum_names){
	REMISSwk6_wilcox_plac.phylum_p[phylum] <- wilcox.test(plac.phylum_rel_abund[,phylum] ~plac.screen_data$REMISSwk6)$p.value
}

RESPONSEwk6_wilcox_plac.phylum_p <- numeric() 
for(phylum in plac.phylum_names){
	RESPONSEwk6_wilcox_plac.phylum_p[phylum] <- wilcox.test(plac.phylum_rel_abund[,phylum] ~plac.screen_data$RESPONSEwk6)$p.value
}

REMISSwk6_wilcox_plac.phylum_adj_p <- na.omit(p.adjust(REMISSwk6_wilcox_plac.phylum_p, method="BH"))
sig_REMISSwk6_wilcox_plac.phylum_adj_p <-REMISSwk6_wilcox_plac.phylum_adj_p  < 0.05

RESPONSEwk6_wilcox_plac.phylum_adj_p <- na.omit(p.adjust(RESPONSEwk6_wilcox_plac.phylum_p, method="BH"))
sig_RESPONSEwk6_wilcox_plac.phylum_adj_p <-RESPONSEwk6_wilcox_plac.phylum_adj_p  < 0.05

REMISSwk22_wilcox_plac.phylum_p <- numeric() 
for(phylum in plac.phylum_names){
	REMISSwk22_wilcox_plac.phylum_p[phylum] <- wilcox.test(plac.phylum_rel_abund[,phylum] ~plac.screen_data$REMISSwk22)$p.value
}

RESPONSEwk22_wilcox_plac.phylum_p <- numeric() 
for(phylum in plac.phylum_names){
	RESPONSEwk22_wilcox_plac.phylum_p[phylum] <- wilcox.test(plac.phylum_rel_abund[,phylum] ~plac.screen_data$RESPONSEwk22)$p.value
}

REMISSwk22_wilcox_plac.phylum_adj_p <- na.omit(p.adjust(REMISSwk22_wilcox_plac.phylum_p, method="BH"))
sig_REMISSwk22_wilcox_plac.phylum_adj_p <-REMISSwk22_wilcox_plac.phylum_adj_p  < 0.05

RESPONSEwk22_wilcox_plac.phylum_adj_p <- na.omit(p.adjust(RESPONSEwk22_wilcox_plac.phylum_p, method="BH"))
sig_RESPONSEwk22_wilcox_plac.phylum_adj_p <-RESPONSEwk22_wilcox_plac.phylum_adj_p  < 0.05







cbind(data.frame(mean_abundant_plac.phylum_matrix, Phylum = row.names(mean_abundant_plac.phylum_matrix))) %>%
	gather(treatment, relabund, -Phylum) %>% ggplot(aes(x=treatment, y=relabund, fill=Phylum)) +
	geom_bar(position = "dodge", stat="identity") + ylab("Relative Abundance (%)") + xlab("Week 6 Remission") +
	theme(legend.text = element_text(face = "italic"))

#phyRelab_RESPONSEwk6 <- phyRelab_RESPONSEwk6*100
plac.phyRabRESPONSEwk6_ggplot <- gather(phyRelab_RESPONSEwk6, phylum, relabund, one_of(row.names(mean_plac.phylum_matrix)[abundant]))
rank <- c("Firmicutes","Bacteroidetes","Proteobacteria","Actinobacteria","Verrucomicrobia","Fusobacteria")
plac.phyRabRESPONSEwk6_ggplot$phylum <- factor(plac.phyRabRESPONSEwk6_ggplot$phylum, levels = rank, labels= rank)  #order the subset dataset by the median abundances
plac.phyRabRESPONSEwk6_ggplot <- plac.phyRabRESPONSEwk6_ggplot[order(plac.phyRabRESPONSEwk6_ggplot$phylum),]
plac.phyRabRESPONSEwk6_ggplot <- gather(phyRelab_RESPONSEwk6, phylum, relabund, one_of(row.names(mean_plac.phylum_matrix)[abundant]))
plac.phyRabRESPONSEwk6_ggplot$phylum <- factor(plac.phyRabRESPONSEwk6_ggplot$phylum, levels = rank, labels= rank)  #order the subset dataset by the median abundances
plac.phyRabRESPONSEwk6_ggplot <- plac.phyRabRESPONSEwk6_ggplot[order(plac.phyRabRESPONSEwk6_ggplot$phylum),]


#phyRelab_REMISSwk6 <- phyRelab_REMISSwk6*100
plac.phyRabREMISSwk6_ggplot <- gather(phyRelab_REMISSwk6, phylum, relabund, one_of(row.names(mean_plac.phylum_matrix)[abundant]))
rank <- c("Firmicutes","Bacteroidetes","Proteobacteria","Actinobacteria","Verrucomicrobia","Fusobacteria")
plac.phyRabREMISSwk6_ggplot$phylum <- factor(plac.phyRabREMISSwk6_ggplot$phylum, levels = rank, labels= rank)  #order the subset dataset by the median abundances
plac.phyRabREMISSwk6_ggplot <- plac.phyRabREMISSwk6_ggplot[order(plac.phyRabREMISSwk6_ggplot$phylum),]
plac.phyRabREMISSwk6_ggplot <- gather(phyRelab_REMISSwk6, phylum, relabund, one_of(row.names(mean_plac.phylum_matrix)[abundant]))
plac.phyRabREMISSwk6_ggplot$phylum <- factor(plac.phyRabREMISSwk6_ggplot$phylum, levels = rank, labels= rank)  #order the subset dataset by the median abundances
plac.phyRabREMISSwk6_ggplot <- plac.phyRabREMISSwk6_ggplot[order(plac.phyRabREMISSwk6_ggplot$phylum),]


#phyRelab_RESPONSEwk22 <- phyRelab_RESPONSEwk22*100
plac.phyRabRESPONSEwk22_ggplot <- gather(phyRelab_RESPONSEwk22, phylum, relabund, one_of(row.names(mean_plac.phylum_matrix)[abundant]))
rank <- c("Firmicutes","Bacteroidetes","Proteobacteria","Actinobacteria","Verrucomicrobia","Fusobacteria")
plac.phyRabRESPONSEwk22_ggplot$phylum <- factor(plac.phyRabRESPONSEwk22_ggplot$phylum, levels = rank, labels= rank)  #order the subset dataset by the median abundances
plac.phyRabRESPONSEwk22_ggplot <- plac.phyRabRESPONSEwk22_ggplot[order(plac.phyRabRESPONSEwk22_ggplot$phylum),]
plac.phyRabRESPONSEwk22_ggplot <- gather(phyRelab_RESPONSEwk22, phylum, relabund, one_of(row.names(mean_plac.phylum_matrix)[abundant]))
plac.phyRabRESPONSEwk22_ggplot$phylum <- factor(plac.phyRabRESPONSEwk22_ggplot$phylum, levels = rank, labels= rank)  #order the subset dataset by the median abundances
plac.phyRabRESPONSEwk22_ggplot <- plac.phyRabRESPONSEwk22_ggplot[order(plac.phyRabRESPONSEwk22_ggplot$phylum),]


#phyRelab_REMISSwk22 <- phyRelab_REMISSwk22*100
plac.phyRabREMISSwk22_ggplot <- gather(phyRelab_REMISSwk22, phylum, relabund, one_of(row.names(mean_plac.phylum_matrix)[abundant]))
rank <- c("Firmicutes","Bacteroidetes","Proteobacteria","Actinobacteria","Verrucomicrobia","Fusobacteria")
plac.phyRabREMISSwk22_ggplot$phylum <- factor(plac.phyRabREMISSwk22_ggplot$phylum, levels = rank, labels= rank)  #order the subset dataset by the median abundances
plac.phyRabREMISSwk22_ggplot <- plac.phyRabREMISSwk22_ggplot[order(plac.phyRabREMISSwk22_ggplot$phylum),]
plac.phyRabREMISSwk22_ggplot <- gather(phyRelab_REMISSwk22, phylum, relabund, one_of(row.names(mean_plac.phylum_matrix)[abundant]))
plac.phyRabREMISSwk22_ggplot$phylum <- factor(plac.phyRabREMISSwk22_ggplot$phylum, levels = rank, labels= rank)  #order the subset dataset by the median abundances
plac.phyRabREMISSwk22_ggplot <- plac.phyRabREMISSwk22_ggplot[order(plac.phyRabREMISSwk22_ggplot$phylum),]



