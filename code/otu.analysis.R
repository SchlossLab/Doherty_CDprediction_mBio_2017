source('../code/tax.analysis.setup.R')

total_mean_otu_rel_abund <- apply(otu_rel_abund, 2, mean)
#decreasing_order <- order(total_mean_rabund, decreasing=T)
#otu_rel_abund <- otu_rel_abund[,decreasing_order]

mean_otu_trtRemWk6 <- aggregate(otu_rel_abund, by=list(screen_data$TRTGR, screen_data$REMISSwk6), mean)
mean_otu_trtRemWk6$TRTGRrem <- paste(mean_otu_trtRemWk6$Group.1, mean_otu_trtRemWk6$Group.2)
mean_otu_trtRemWk6_matrix <- subset(mean_otu_trtRemWk6, select=-c(TRTGRrem))
mean_otu_trtRemWk6_matrix <- as.matrix(t(subset(mean_otu_trtRemWk6_matrix, select=-c(1:2))))
colnames(mean_otu_trtRemWk6_matrix) <- mean_otu_trtRemWk6$TRTGRrem

mean_otu <- aggregate(otu_rel_abund, by=list(screen_data$REMISSwk6), mean)
mean_otu_matrix <- subset(mean_otu, select=-c(Group.1))
mean_otu_matrix <- as.matrix(t(subset(mean_otu_matrix)))
colnames(mean_otu_matrix) <- mean_otu$Group.1

median_otu_trtRemWk6 <- aggregate(otu_rel_abund, by=list(screen_data$TRTGR, screen_data$REMISSwk6), median)
median_otu_trtRemWk6$TRTGRrem <- paste(median_otu_trtRemWk6$Group.1, median_otu_trtRemWk6$Group.2)
median_otu_trtRemWk6_matrix <- subset(median_otu_trtRemWk6, select=-c(TRTGRrem))
median_otu_trtRemWk6_matrix <- as.matrix(t(subset(median_otu_trtRemWk6_matrix, select=-c(1:2))))
colnames(median_otu_trtRemWk6_matrix) <- median_otu_trtRemWk6$TRTGRrem

median_otu <- aggregate(otu_rel_abund, by=list(screen_data$REMISSwk6), median)
median_otu_matrix <- subset(median_otu, select=-c(Group.1))
median_otu_matrix <- as.matrix(t(median_otu_matrix))
colnames(median_otu_matrix) <- median_otu$Group.1


sd_otu <- aggregate(otu_rel_abund, by=list(screen_data$TRTGR, screen_data$REMISSwk6), sd)
sd_otu$TRTGRrem <- paste(sd_otu$Group.1, sd_otu$Group.2)
sd_otu_matrix <- subset(sd_otu, select=-c(TRTGRrem))
sd_otu_matrix <- as.matrix(t(subset(sd_otu_matrix, select=-c(1:2))))
colnames(sd_otu_matrix) <- sd_otu$TRTGRrem

IQR_otu <- aggregate(otu_rel_abund, by=list(screen_data$TRTGR, screen_data$REMISSwk6), IQR)
IQR_otu$TRTGRrem <- paste(IQR_otu$Group.1, IQR_otu$Group.2)
IQR_otu_matrix <- subset(IQR_otu, select=-c(TRTGRrem))
IQR_otu_matrix <- as.matrix(t(subset(IQR_otu_matrix, select=-c(1:2))))
colnames(IQR_otu_matrix) <- IQR_otu$TRTGRrem

stopifnot(screen_data$group == rownames(otu_rel_abund))

#abundant <- apply(mean_otu_matrix, 1, mean) > 0.005
#mean_abundant_otu_matrix <- mean_otu_matrix[abundant, ]
#sd_abundant_otu_matrix <- sd_otu_matrix[abundant, ]
#median_abundant_otu_matrix <- median_otu_matrix[abundant, ]


#y <- numeric() 
#wilcox_otubyx <- function(x){
#	for(otu in otu_numbers){
#	y[otu] <- wilcox.test(otu_rel_abund[,otu] ~x)$p.value
#	}
#}
	
	
set.seed(32016)
REMwk6_wilcox_otu_p <- numeric() 
for(otu in otu_numbers){
	REMwk6_wilcox_otu_p[otu] <- wilcox.test(otu_rel_abund[,otu] ~screen_data$REMISSwk6)$p.value
}

set.seed(32016)
RelRSPwk6_wilcox_otu_p <- numeric() 
for(otu in otu_numbers){
	RelRSPwk6_wilcox_otu_p[otu] <- wilcox.test(otu_rel_abund[,otu] ~screen_data$RelRSPwk6)$p.value
}


REMISSwk6_wilcox_otu_adj_p <- na.omit(p.adjust(REMwk6_wilcox_otu_p, method="BH"))
sig_REMISSwk6_wilcox_otu_adj_p <-REMISSwk6_wilcox_otu_adj_p  < 0.05

RelRSPwk6_wilcox_otu_adj_p <- na.omit(p.adjust(RelRSPwk6_wilcox_otu_p, method="BH"))
sig_RelRSPwk6_wilcox_otu_adj_p <-RelRSPwk6_wilcox_otu_adj_p  < 0.05

set.seed(32016)
REMwk22_wilcox_otu_p <- numeric() 
for(otu in otu_numbers){
	REMwk22_wilcox_otu_p[otu] <- wilcox.test(otu_rel_abund[,otu] ~screen_data$REMISSwk22)$p.value
}

set.seed(32016)
RelRSPwk22_wilcox_otu_p <- numeric() 
for(otu in otu_numbers){
	RelRSPwk22_wilcox_otu_p[otu] <- wilcox.test(otu_rel_abund[,otu] ~screen_data$RelRSPwk22)$p.value
}

REMISSwk22_wilcox_otu_adj_p <- na.omit(p.adjust(REMwk22_wilcox_otu_p, method="BH"))
sig_REMISSwk22_wilcox_otu_adj_p <-REMISSwk22_wilcox_otu_adj_p  < 0.05

RelRSPwk22_wilcox_otu_adj_p <- na.omit(p.adjust(RelRSPwk22_wilcox_otu_p, method="BH"))
sig_RelRSPwk22_wilcox_otu_adj_p <-RelRSPwk22_wilcox_otu_adj_p  < 0.05
