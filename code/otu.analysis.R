source('../code/tax.analysis.setup.R')

total_mean_otu_rel_abund <- apply(otu_rel_abund, 2, mean)
#decreasing_order <- order(total_mean_rabund, decreasing=T)
#otu_rel_abund <- otu_rel_abund[,decreasing_order]
# screen_data_groups <- screen_data[screen_data$visit=="Screening", c("group", "TRTGR")]
# screen_data_groups <- screen_data_groups[screen_data_groups$TRTGR=="Treated",]
# screen_otu_rel_abund <- merge(screen_data_groups, otu_rel_abund, by.x = "group", by.y = "row.names")
# rownames(screen_otu_rel_abund) <- screen_otu_rel_abund$group
# screen_otu_rel_abund <- screen_otu_rel_abund[,-c(1:2)]
# otu_rel_abund_sum <- apply(screen_otu_rel_abund, 2, sum)
# otu_rel_abund_t <- otu_rel_abund_sum > (2/3000*100)
# otu_rel_abund <- screen_otu_rel_abund[, otu_rel_abund_t]

#otu_rel_abund.trtd <- screen_data[screen_data$TRTGR=="Treated",]

screen_data.trtd_groups <- screen_data[screen_data$visit=="Screening", c("group", "TRTGR")]
screen_data.trtd <- screen_data[screen_data$TRTGR=="Treated",]
screen_data.trtd_groups <- screen_data.trtd[, c("group", "TRTGR")]

screen.trtd_otu_rel_abund <- merge(screen_data.trtd_groups, otu_rel_abund, by.x = "group", by.y = "row.names")
rownames(screen.trtd_otu_rel_abund) <- screen.trtd_otu_rel_abund$group
screen.trtd_otu_rel_abund <- screen.trtd_otu_rel_abund[,-c(1:2)]
otu_rel_abund.trtd_sum <- apply(screen.trtd_otu_rel_abund, 2, sum)
otu_rel_abund.trtd <- otu_rel_abund.trtd_sum > (2/3000*100)
otu_rel_abund.trtd <- screen.trtd_otu_rel_abund[, otu_rel_abund.trtd]
otu_numbers <- colnames(otu_rel_abund.trtd)

mean_otu_trtRemWk6 <- aggregate(otu_rel_abund, by=list(screen_data$TRTGR, screen_data$REMISSwk6), mean)
mean_otu_trtRemWk6$TRTGRrem <- paste(mean_otu_trtRemWk6$Group.1, mean_otu_trtRemWk6$Group.2)
mean_otu_trtRemWk6_matrix <- subset(mean_otu_trtRemWk6, select=-c(TRTGRrem))
mean_otu_trtRemWk6_matrix <- as.matrix(t(subset(mean_otu_trtRemWk6_matrix, select=-c(1:2))))
colnames(mean_otu_trtRemWk6_matrix) <- mean_otu_trtRemWk6$TRTGRrem

median_otu_trtRemWk6 <- aggregate(otu_rel_abund, by=list(screen_data$TRTGR, screen_data$REMISSwk6), median)
median_otu_trtRemWk6$TRTGRrem <- paste(median_otu_trtRemWk6$Group.1, median_otu_trtRemWk6$Group.2)
median_otu_trtRemWk6_matrix <- subset(median_otu_trtRemWk6, select=-c(TRTGRrem))
median_otu_trtRemWk6_matrix <- as.matrix(t(subset(median_otu_trtRemWk6_matrix, select=-c(1:2))))
colnames(median_otu_trtRemWk6_matrix) <- median_otu_trtRemWk6$TRTGRrem

mean_otu_RelRSPwk6 <- aggregate(otu_rel_abund.trtd, by=list(screen_data.trtd$RelRSPwk6), mean)
mean_otu_RelRSPwk6_matrix <- subset(mean_otu_RelRSPwk6, select=-c(Group.1))
mean_otu_RelRSPwk6_matrix <- as.matrix(t(subset(mean_otu_RelRSPwk6_matrix)))
colnames(mean_otu_RelRSPwk6_matrix) <- mean_otu_RelRSPwk6$Group.1

median_otu_RelRSPwk6 <- aggregate(otu_rel_abund.trtd, by=list(screen_data.trtd$RelRSPwk6), median)
median_otu_RelRSPwk6_matrix <- subset(median_otu_RelRSPwk6, select=-c(Group.1))
median_otu_RelRSPwk6_matrix <- as.matrix(t(median_otu_RelRSPwk6_matrix))
colnames(median_otu_RelRSPwk6_matrix) <- median_otu_RelRSPwk6$Group.1

mean_otu_REMISSwk6 <- aggregate(otu_rel_abund.trtd, by=list(screen_data.trtd$REMISSwk6), mean)
mean_otu_REMISSwk6_matrix <- subset(mean_otu_REMISSwk6, select=-c(Group.1))
mean_otu_REMISSwk6_matrix <- as.matrix(t(subset(mean_otu_REMISSwk6_matrix)))
colnames(mean_otu_REMISSwk6_matrix) <- mean_otu_REMISSwk6$Group.1

median_otu_REMISSwk6 <- aggregate(otu_rel_abund.trtd, by=list(screen_data.trtd$REMISSwk6), median)
median_otu_REMISSwk6_matrix <- subset(median_otu_REMISSwk6, select=-c(Group.1))
median_otu_REMISSwk6_matrix <- as.matrix(t(median_otu_REMISSwk6_matrix))
colnames(median_otu_REMISSwk6_matrix) <- median_otu_REMISSwk6$Group.1


sd_otu <- aggregate(otu_rel_abund.trtd, by=list(screen_data.trtd$TRTGR, screen_data.trtd$REMISSwk6), sd)
sd_otu$TRTGRrem <- paste(sd_otu$Group.1, sd_otu$Group.2)
sd_otu_matrix <- subset(sd_otu, select=-c(TRTGRrem))
sd_otu_matrix <- as.matrix(t(subset(sd_otu_matrix, select=-c(1:2))))
colnames(sd_otu_matrix) <- sd_otu$TRTGRrem

IQR_otu <- aggregate(otu_rel_abund.trtd, by=list(screen_data.trtd$TRTGR, screen_data.trtd$REMISSwk6), IQR)
IQR_otu$TRTGRrem <- paste(IQR_otu$Group.1, IQR_otu$Group.2)
IQR_otu_matrix <- subset(IQR_otu, select=-c(TRTGRrem))
IQR_otu_matrix <- as.matrix(t(subset(IQR_otu_matrix, select=-c(1:2))))
colnames(IQR_otu_matrix) <- IQR_otu$TRTGRrem

stopifnot(screen_data.trtd$group == rownames(otu_rel_abund.trtd))

#abundant <- apply(mean_otu_matrix, 1, mean) > 0.005
#mean_abundant_otu_matrix <- mean_otu_matrix[abundant, ]
#sd_abundant_otu_matrix <- sd_otu_matrix[abundant, ]
#median_abundant_otu_matrix <- median_otu_matrix[abundant, ]


#y <- numeric() 
#wilcox_otubyx <- function(x){
#	for(otu in otu_numbers){
#	y[otu] <- wilcox.test(otu_rel_abund.trtd[,otu] ~x)$p.value
#	}
#}
	
otu_numbers <- colnames(otu_rel_abund.trtd)
	
set.seed(32016)
REMwk6_wilcox_otu_p <- numeric() 
for(otu in otu_numbers){
	REMwk6_wilcox_otu_p[otu] <- wilcox.test(otu_rel_abund.trtd[,otu] ~screen_data.trtd$REMISSwk6)$p.value
}

set.seed(32016)
RelRSPwk6_wilcox_otu_p <- numeric() 
for(otu in otu_numbers){
	RelRSPwk6_wilcox_otu_p[otu] <- wilcox.test(otu_rel_abund.trtd[,otu] ~screen_data.trtd$RelRSPwk6)$p.value
}


REMISSwk6_wilcox_otu_adj_p <- na.omit(p.adjust(REMwk6_wilcox_otu_p, method="BH"))
sig_REMISSwk6_wilcox_otu_adj_p <-REMISSwk6_wilcox_otu_adj_p  < 0.05
sig_REMISSwk6_wilcox_otu_adj_p_otus <- rownames(median_otu_REMISSwk6_matrix)[sig_REMISSwk6_wilcox_otu_adj_p]

RelRSPwk6_wilcox_otu_adj_p <- na.omit(p.adjust(RelRSPwk6_wilcox_otu_p, method="BH"))
sig_RelRSPwk6_wilcox_otu_adj_p <-RelRSPwk6_wilcox_otu_adj_p  < 0.05
sig_RelRSPwk6_wilcox_otu_adj_p_otus <- rownames(median_otu_RelRSPwk6_matrix)[sig_RelRSPwk6_wilcox_otu_adj_p]


screen_data.trtdtrtd_groups <- screen_data[screen_data$visit=="Screening", c("group", "TRTGRINDMAN")]
screen_data.trtdtrtd <- screen_data[screen_data$TRTGRINDMAN=="Treated_Treated",]
screen_data.trtdtrtd_groups <- screen_data.trtdtrtd[, c("group", "TRTGRINDMAN")]
rownames(screen_data.trtdtrtd) <- screen_data.trtdtrtd$group
screen_data.trtdtrtd <- screen_data.trtdtrtd[,-1]
#stopifnot(rownames(screen_data.trtdtrtd) == rownames(screen.trtdtrtd_otu_rel_abund))

screen.trtdtrtd_otu_rel_abund <- merge(screen_data.trtdtrtd_groups, otu_rel_abund, by.x = "group", by.y = "row.names")
rownames(screen.trtdtrtd_otu_rel_abund) <- screen.trtdtrtd_otu_rel_abund$group
screen.trtdtrtd_otu_rel_abund <- screen.trtdtrtd_otu_rel_abund[,-c(1:2)]
otu_rel_abund.trtdtrtd_sum <- apply(screen.trtdtrtd_otu_rel_abund, 2, sum)
otu_rel_abund.trtdtrtd <- otu_rel_abund.trtdtrtd_sum > (2/3000*100)
otu_rel_abund.trtdtrtd <- screen.trtdtrtd_otu_rel_abund[, otu_rel_abund.trtdtrtd]
otu_numbers <- colnames(otu_rel_abund.trtdtrtd)

stopifnot(rownames(screen_data.trtdtrtd) == rownames(otu_rel_abund.trtdtrtd))

mean_otu_RelRSPwk22 <- aggregate(otu_rel_abund.trtdtrtd, by=list(screen_data.trtdtrtd$RelRSPwk22), mean)
mean_otu_RelRSPwk22_matrix <- subset(mean_otu_RelRSPwk22, select=-c(Group.1))
mean_otu_RelRSPwk22_matrix <- as.matrix(t(subset(mean_otu_RelRSPwk22_matrix)))
colnames(mean_otu_RelRSPwk22_matrix) <- mean_otu_RelRSPwk22$Group.1

median_otu_RelRSPwk22 <- aggregate(otu_rel_abund.trtdtrtd, by=list(screen_data.trtdtrtd$RelRSPwk22), median)
median_otu_RelRSPwk22_matrix <- subset(median_otu_RelRSPwk22, select=-c(Group.1))
median_otu_RelRSPwk22_matrix <- as.matrix(t(median_otu_RelRSPwk22_matrix))
colnames(median_otu_RelRSPwk22_matrix) <- median_otu_RelRSPwk22$Group.1

mean_otu_REMISSwk22 <- aggregate(otu_rel_abund.trtdtrtd, by=list(screen_data.trtdtrtd$REMISSwk22), mean)
mean_otu_REMISSwk22_matrix <- subset(mean_otu_REMISSwk22, select=-c(Group.1))
mean_otu_REMISSwk22_matrix <- as.matrix(t(subset(mean_otu_REMISSwk22_matrix)))
colnames(mean_otu_REMISSwk22_matrix) <- mean_otu_REMISSwk22$Group.1

median_otu_REMISSwk22 <- aggregate(otu_rel_abund.trtdtrtd, by=list(screen_data.trtdtrtd$REMISSwk22), median)
median_otu_REMISSwk22_matrix <- subset(median_otu_REMISSwk22, select=-c(Group.1))
median_otu_REMISSwk22_matrix <- as.matrix(t(median_otu_REMISSwk22_matrix))
colnames(median_otu_REMISSwk22_matrix) <- median_otu_REMISSwk22$Group.1


set.seed(32016)
REMwk22_wilcox_otu_p <- numeric() 
for(otu in otu_numbers){
	REMwk22_wilcox_otu_p[otu] <- wilcox.test(otu_rel_abund.trtdtrtd[,otu] ~screen_data.trtdtrtd$REMISSwk22)$p.value
}

set.seed(32016)
RelRSPwk22_wilcox_otu_p <- numeric() 
for(otu in otu_numbers){
	RelRSPwk22_wilcox_otu_p[otu] <- wilcox.test(otu_rel_abund.trtdtrtd[,otu] ~screen_data.trtdtrtd$RelRSPwk22)$p.value
}

REMISSwk22_wilcox_otu_adj_p <- na.omit(p.adjust(REMwk22_wilcox_otu_p, method="BH"))
sig_REMISSwk22_wilcox_otu_adj_p <-REMISSwk22_wilcox_otu_adj_p  < 0.05
sig_REMISSwk22_wilcox_otu_adj_p_otus <- rownames(mean_otu_REMISSwk22_matrix)[sig_REMISSwk22_wilcox_otu_adj_p]

RelRSPwk22_wilcox_otu_adj_p <- na.omit(p.adjust(RelRSPwk22_wilcox_otu_p, method="BH"))
sig_RelRSPwk22_wilcox_otu_adj_p <-RelRSPwk22_wilcox_otu_adj_p  < 0.05
sig_RelRSPwk22_wilcox_otu_adj_p_otus <- rownames(mean_otu_RelRSPwk22_matrix)[sig_RelRSPwk22_wilcox_otu_adj_p]


