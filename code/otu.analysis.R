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

#screen_data.trtd_groups <- screen_data[screen_data$visit=="Screening", c("group", "TRTGR")]
screen_data.trtd <- screen_data[screen_data$TRTGR=="Treated",]
screen_data.trtd_groups <- screen_data.trtd[, c("group", "TRTGR")]
screen_data.trtd_Otus <- screen_data.trtd[, c("group", "TRTGR", "REMISSwk6")]
screen.trtd_otu_rel_abund <- merge(screen_data.trtd_groups, otu_rel_abund, by.x = "group", by.y = "row.names")
rownames(screen.trtd_otu_rel_abund) <- screen.trtd_otu_rel_abund$group
screen.trtd_otu_rel_abund <- screen.trtd_otu_rel_abund[,-c(1:2)]

screen.trtd_rel_abund_Otus <- merge(screen_data.trtd_Otus, otu_rel_abund, by.x = "group", by.y = "row.names")
rownames(screen.trtd_rel_abund_Otus) <- screen.trtd_rel_abund_Otus$group
screen.trtd_rel_abund_Otus <- screen.trtd_rel_abund_Otus[,-c(1:2)]
screen.trtd_rel_abund_Otus <- subset(screen.trtd_rel_abund_Otus, select = c("REMISSwk6", "Otu00001", "Otu00007"))
trtd.REMwk6.YES.relabund <- screen.trtd_rel_abund_Otus[screen.trtd_rel_abund_Otus$REMISSwk6=="Yes",]
trtd.REMwk6.NO.relabund <- screen.trtd_rel_abund_Otus[screen.trtd_rel_abund_Otus$REMISSwk6=="No",]

median(trtd.REMwk6.YES.relabund$Otu00001)
quantile(trtd.REMwk6.YES.relabund$Otu00001, type = 2)
quantile(trtd.REMwk6.NO.relabund$Otu00001, type = 2)
quantile(trtd.REMwk6.YES.relabund$Otu00007, type = 2)
quantile(trtd.REMwk6.NO.relabund$Otu00007, type = 2)
trtd.REMwk6.YES.relabund$Otu00001

otu_rel_abund.trtd_sum <- apply(screen.trtd_otu_rel_abund, 2, sum)
otu_rel_abund.trtd <- otu_rel_abund.trtd_sum > (2/3000*100)
otu_rel_abund.trtd <- screen.trtd_otu_rel_abund[, otu_rel_abund.trtd]
otu_numbers <- colnames(otu_rel_abund.trtd)

mean_trtd.otu_trtRemWk6 <- aggregate(otu_rel_abund, by=list(screen_data$TRTGR, screen_data$REMISSwk6), mean)
mean_trtd.otu_trtRemWk6$TRTGRrem <- paste(mean_trtd.otu_trtRemWk6$Group.1, mean_trtd.otu_trtRemWk6$Group.2)
mean_trtd.otu_trtRemWk6_matrix <- subset(mean_trtd.otu_trtRemWk6, select=-c(TRTGRrem))
mean_trtd.otu_trtRemWk6_matrix <- as.matrix(t(subset(mean_trtd.otu_trtRemWk6_matrix, select=-c(1:2))))
colnames(mean_trtd.otu_trtRemWk6_matrix) <- mean_trtd.otu_trtRemWk6$TRTGRrem

median_trtd.otu_trtRemWk6 <- aggregate(otu_rel_abund, by=list(screen_data$TRTGR, screen_data$REMISSwk6), median)
median_trtd.otu_trtRemWk6$TRTGRrem <- paste(median_trtd.otu_trtRemWk6$Group.1, median_trtd.otu_trtRemWk6$Group.2)
median_trtd.otu_trtRemWk6_matrix <- subset(median_trtd.otu_trtRemWk6, select=-c(TRTGRrem))
median_trtd.otu_trtRemWk6_matrix <- as.matrix(t(subset(median_trtd.otu_trtRemWk6_matrix, select=-c(1:2))))
colnames(median_trtd.otu_trtRemWk6_matrix) <- median_trtd.otu_trtRemWk6$TRTGRrem

mean_trtd.otu_RESPONSEwk6 <- aggregate(otu_rel_abund.trtd, by=list(screen_data.trtd$RESPONSEwk6), mean)
mean_trtd.otu_RESPONSEwk6_matrix <- subset(mean_trtd.otu_RESPONSEwk6, select=-c(Group.1))
mean_trtd.otu_RESPONSEwk6_matrix <- as.matrix(t(subset(mean_trtd.otu_RESPONSEwk6_matrix)))
colnames(mean_trtd.otu_RESPONSEwk6_matrix) <- mean_trtd.otu_RESPONSEwk6$Group.1

median_trtd.otu_RESPONSEwk6 <- aggregate(otu_rel_abund.trtd, by=list(screen_data.trtd$RESPONSEwk6), median)
median_trtd.otu_RESPONSEwk6_matrix <- subset(median_trtd.otu_RESPONSEwk6, select=-c(Group.1))
median_trtd.otu_RESPONSEwk6_matrix <- as.matrix(t(median_trtd.otu_RESPONSEwk6_matrix))
colnames(median_trtd.otu_RESPONSEwk6_matrix) <- median_trtd.otu_RESPONSEwk6$Group.1

mean_trtd.otu_REMISSwk6 <- aggregate(otu_rel_abund.trtd, by=list(screen_data.trtd$REMISSwk6), mean)
mean_trtd.otu_REMISSwk6_matrix <- subset(mean_trtd.otu_REMISSwk6, select=-c(Group.1))
mean_trtd.otu_REMISSwk6_matrix <- as.matrix(t(subset(mean_trtd.otu_REMISSwk6_matrix)))
colnames(mean_trtd.otu_REMISSwk6_matrix) <- mean_trtd.otu_REMISSwk6$Group.1

median_trtd.otu_REMISSwk6 <- aggregate(otu_rel_abund.trtd, by=list(screen_data.trtd$REMISSwk6), median)
median_trtd.otu_REMISSwk6_matrix <- subset(median_trtd.otu_REMISSwk6, select=-c(Group.1))
median_trtd.otu_REMISSwk6_matrix <- as.matrix(t(median_trtd.otu_REMISSwk6_matrix))
colnames(median_trtd.otu_REMISSwk6_matrix) <- median_trtd.otu_REMISSwk6$Group.1


sd_trtd.otu <- aggregate(otu_rel_abund.trtd, by=list(screen_data.trtd$TRTGR, screen_data.trtd$REMISSwk6), sd)
sd_trtd.otu$TRTGRrem <- paste(sd_trtd.otu$Group.1, sd_trtd.otu$Group.2)
sd_trtd.otu_matrix <- subset(sd_trtd.otu, select=-c(TRTGRrem))
sd_trtd.otu_matrix <- as.matrix(t(subset(sd_trtd.otu_matrix, select=-c(1:2))))
colnames(sd_trtd.otu_matrix) <- sd_trtd.otu$TRTGRrem

IQR_trtd.otu <- aggregate(otu_rel_abund.trtd, by=list(screen_data.trtd$TRTGR, screen_data.trtd$REMISSwk6), IQR)
IQR_trtd.otu$TRTGRrem <- paste(IQR_trtd.otu$Group.1, IQR_trtd.otu$Group.2)
IQR_trtd.otu_matrix <- subset(IQR_trtd.otu, select=-c(TRTGRrem))
IQR_trtd.otu_matrix <- as.matrix(t(subset(IQR_trtd.otu_matrix, select=-c(1:2))))
colnames(IQR_trtd.otu_matrix) <- IQR_trtd.otu$TRTGRrem

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
	
trtd.otu_numbers <- colnames(otu_rel_abund.trtd)
	
set.seed(32016)
REMwk6_wilcox_trtd.otu_p <- numeric() 
for(otu in trtd.otu_numbers){
	REMwk6_wilcox_trtd.otu_p[otu] <- wilcox.test(otu_rel_abund.trtd[,otu] ~screen_data.trtd$REMISSwk6)$p.value
}

set.seed(32016)
RESPONSEwk6_wilcox_trtd.otu_p <- numeric() 
for(otu in trtd.otu_numbers){
	RESPONSEwk6_wilcox_trtd.otu_p[otu] <- wilcox.test(otu_rel_abund.trtd[,otu] ~screen_data.trtd$RESPONSEwk6)$p.value
}


REMISSwk6_wilcox_trtd.otu_adj_p <- na.omit(p.adjust(REMwk6_wilcox_trtd.otu_p, method="BH"))
sig_REMISSwk6_wilcox_trtd.otu_adj_p <-REMISSwk6_wilcox_trtd.otu_adj_p  < 0.05
sig_REMISSwk6_wilcox_trtd.otu_adj_p_otus <- rownames(median_trtd.otu_REMISSwk6_matrix)[sig_REMISSwk6_wilcox_trtd.otu_adj_p]

RESPONSEwk6_wilcox_trtd.otu_adj_p <- na.omit(p.adjust(RESPONSEwk6_wilcox_trtd.otu_p, method="BH"))
sig_RESPONSEwk6_wilcox_trtd.otu_adj_p <-RESPONSEwk6_wilcox_trtd.otu_adj_p  < 0.05
sig_RESPONSEwk6_wilcox_trtd.otu_adj_p_otus <- rownames(median_trtd.otu_RESPONSEwk6_matrix)[sig_RESPONSEwk6_wilcox_trtd.otu_adj_p]


trtd.REMISSwk6.Otu7p <- signif(REMISSwk6_wilcox_trtd.otu_adj_p["Otu00007"], 2)
trtd.REMISSwk6.Otu19p <- signif(REMISSwk6_wilcox_trtd.otu_adj_p["Otu00019"], 2)


screen_data.trtdtrtd_groups <- screen_data[screen_data$visit=="Screening", c("group", "TRTGRINDMAN")]
screen_data.trtdtrtd <- screen_data[screen_data$TRTGRINDMAN=="Treated_Treated",]
screen_data.trtdtrtd_groups <- screen_data.trtdtrtd[, c("group", "TRTGRINDMAN")]
rownames(screen_data.trtdtrtd) <- screen_data.trtdtrtd$group
screen_data.trtdtrtd <- screen_data.trtdtrtd[,-1]
#stopifnot(rownames(screen_data.trtdtrtd) == rownames(screen.trtdtrtd_trtd.otu_rel_abund))

screen.trtdtrtd_otu_rel_abund <- merge(screen_data.trtdtrtd_groups, otu_rel_abund.trtd, by.x = "group", by.y = "row.names")
rownames(screen.trtdtrtd_otu_rel_abund) <- screen.trtdtrtd_otu_rel_abund$group
screen.trtdtrtd_otu_rel_abund <- screen.trtdtrtd_otu_rel_abund[,-c(1:2)]
otu_rel_abund.trtdtrtd_sum <- apply(screen.trtdtrtd_otu_rel_abund, 2, sum)
otu_rel_abund.trtdtrtd <- otu_rel_abund.trtdtrtd_sum > (2/3000*100)
otu_rel_abund.trtdtrtd <- screen.trtdtrtd_otu_rel_abund[, otu_rel_abund.trtdtrtd]
trtd.otu_numbers <- colnames(otu_rel_abund.trtdtrtd)

stopifnot(rownames(screen_data.trtdtrtd) == rownames(otu_rel_abund.trtdtrtd))

mean_trtd.otu_RESPONSEwk22 <- aggregate(otu_rel_abund.trtdtrtd, by=list(screen_data.trtdtrtd$RESPONSEwk22), mean)
mean_trtd.otu_RESPONSEwk22_matrix <- subset(mean_trtd.otu_RESPONSEwk22, select=-c(Group.1))
mean_trtd.otu_RESPONSEwk22_matrix <- as.matrix(t(subset(mean_trtd.otu_RESPONSEwk22_matrix)))
colnames(mean_trtd.otu_RESPONSEwk22_matrix) <- mean_trtd.otu_RESPONSEwk22$Group.1

median_trtd.otu_RESPONSEwk22 <- aggregate(otu_rel_abund.trtdtrtd, by=list(screen_data.trtdtrtd$RESPONSEwk22), median)
median_trtd.otu_RESPONSEwk22_matrix <- subset(median_trtd.otu_RESPONSEwk22, select=-c(Group.1))
median_trtd.otu_RESPONSEwk22_matrix <- as.matrix(t(median_trtd.otu_RESPONSEwk22_matrix))
colnames(median_trtd.otu_RESPONSEwk22_matrix) <- median_trtd.otu_RESPONSEwk22$Group.1

mean_trtd.otu_REMISSwk22 <- aggregate(otu_rel_abund.trtdtrtd, by=list(screen_data.trtdtrtd$REMISSwk22), mean)
mean_trtd.otu_REMISSwk22_matrix <- subset(mean_trtd.otu_REMISSwk22, select=-c(Group.1))
mean_trtd.otu_REMISSwk22_matrix <- as.matrix(t(subset(mean_trtd.otu_REMISSwk22_matrix)))
colnames(mean_trtd.otu_REMISSwk22_matrix) <- mean_trtd.otu_REMISSwk22$Group.1

median_trtd.otu_REMISSwk22 <- aggregate(otu_rel_abund.trtdtrtd, by=list(screen_data.trtdtrtd$REMISSwk22), median)
median_trtd.otu_REMISSwk22_matrix <- subset(median_trtd.otu_REMISSwk22, select=-c(Group.1))
median_trtd.otu_REMISSwk22_matrix <- as.matrix(t(median_trtd.otu_REMISSwk22_matrix))
colnames(median_trtd.otu_REMISSwk22_matrix) <- median_trtd.otu_REMISSwk22$Group.1


set.seed(32016)
REMwk22_wilcox_trtd.otu_p <- numeric() 
for(otu in trtd.otu_numbers){
	REMwk22_wilcox_trtd.otu_p[otu] <- wilcox.test(otu_rel_abund.trtdtrtd[,otu] ~screen_data.trtdtrtd$REMISSwk22)$p.value
}

set.seed(32016)
RESPONSEwk22_wilcox_trtd.otu_p <- numeric() 
for(otu in trtd.otu_numbers){
	RESPONSEwk22_wilcox_trtd.otu_p[otu] <- wilcox.test(otu_rel_abund.trtdtrtd[,otu] ~screen_data.trtdtrtd$RESPONSEwk22)$p.value
}

REMISSwk22_wilcox_trtd.otu_adj_p <- na.omit(p.adjust(REMwk22_wilcox_trtd.otu_p, method="BH"))
sig_REMISSwk22_wilcox_trtd.otu_adj_p <-REMISSwk22_wilcox_trtd.otu_adj_p  < 0.05
sig_REMISSwk22_wilcox_trtd.otu_adj_p_otus <- rownames(mean_trtd.otu_REMISSwk22_matrix)[sig_REMISSwk22_wilcox_trtd.otu_adj_p]

RESPONSEwk22_wilcox_trtd.otu_adj_p <- na.omit(p.adjust(RESPONSEwk22_wilcox_trtd.otu_p, method="BH"))
sig_RESPONSEwk22_wilcox_trtd.otu_adj_p <-RESPONSEwk22_wilcox_trtd.otu_adj_p  < 0.05
sig_RESPONSEwk22_wilcox_trtd.otu_adj_p_otus <- rownames(mean_trtd.otu_RESPONSEwk22_matrix)[sig_RESPONSEwk22_wilcox_trtd.otu_adj_p]



screen_data.plac_groups <- screen_data[screen_data$visit=="Screening", c("group", "TRTGR")]
screen_data.plac <- screen_data[screen_data$TRTGR=="Placebo",]
screen_data.plac_groups <- screen_data.plac[, c("group", "TRTGR")]

screen.plac_otu_rel_abund <- merge(screen_data.plac_groups, plac.otu_rel_abund, by.x = "group", by.y = "row.names")
rownames(screen.plac_otu_rel_abund) <- screen.plac_otu_rel_abund$group
screen.plac_otu_rel_abund <- screen.plac_otu_rel_abund[,-c(1:2)]
otu_rel_abund.plac_sum <- apply(screen.plac_otu_rel_abund, 2, sum)
otu_rel_abund.plac <- otu_rel_abund.plac_sum > (2/3000*100)
otu_rel_abund.plac <- screen.plac_otu_rel_abund[, otu_rel_abund.plac]
otu_numbers <- colnames(otu_rel_abund.plac)

mean_plac.otu_trtRemWk6 <- aggregate(plac.otu_rel_abund, by=list(screen_data.plac$TRTGR, screen_data.plac$REMISSwk6), mean)
mean_plac.otu_trtRemWk6$TRTGRrem <- paste(mean_plac.otu_trtRemWk6$Group.1, mean_plac.otu_trtRemWk6$Group.2)
mean_plac.otu_trtRemWk6_matrix <- subset(mean_plac.otu_trtRemWk6, select=-c(TRTGRrem))
mean_plac.otu_trtRemWk6_matrix <- as.matrix(t(subset(mean_plac.otu_trtRemWk6_matrix, select=-c(1:2))))
colnames(mean_plac.otu_trtRemWk6_matrix) <- mean_plac.otu_trtRemWk6$TRTGRrem

median_plac.otu_trtRemWk6 <- aggregate(plac.otu_rel_abund, by=list(screen_data.plac$TRTGR, screen_data.plac$REMISSwk6), median)
median_plac.otu_trtRemWk6$TRTGRrem <- paste(median_plac.otu_trtRemWk6$Group.1, median_plac.otu_trtRemWk6$Group.2)
median_plac.otu_trtRemWk6_matrix <- subset(median_plac.otu_trtRemWk6, select=-c(TRTGRrem))
median_plac.otu_trtRemWk6_matrix <- as.matrix(t(subset(median_plac.otu_trtRemWk6_matrix, select=-c(1:2))))
colnames(median_plac.otu_trtRemWk6_matrix) <- median_plac.otu_trtRemWk6$TRTGRrem

mean_plac.otu_RESPONSEwk6 <- aggregate(otu_rel_abund.plac, by=list(screen_data.plac$RESPONSEwk6), mean)
mean_plac.otu_RESPONSEwk6_matrix <- subset(mean_plac.otu_RESPONSEwk6, select=-c(Group.1))
mean_plac.otu_RESPONSEwk6_matrix <- as.matrix(t(subset(mean_plac.otu_RESPONSEwk6_matrix)))
colnames(mean_plac.otu_RESPONSEwk6_matrix) <- mean_plac.otu_RESPONSEwk6$Group.1

median_plac.otu_RESPONSEwk6 <- aggregate(otu_rel_abund.plac, by=list(screen_data.plac$RESPONSEwk6), median)
median_plac.otu_RESPONSEwk6_matrix <- subset(median_plac.otu_RESPONSEwk6, select=-c(Group.1))
median_plac.otu_RESPONSEwk6_matrix <- as.matrix(t(median_plac.otu_RESPONSEwk6_matrix))
colnames(median_plac.otu_RESPONSEwk6_matrix) <- median_plac.otu_RESPONSEwk6$Group.1

mean_plac.otu_REMISSwk6 <- aggregate(otu_rel_abund.plac, by=list(screen_data.plac$REMISSwk6), mean)
mean_plac.otu_REMISSwk6_matrix <- subset(mean_plac.otu_REMISSwk6, select=-c(Group.1))
mean_plac.otu_REMISSwk6_matrix <- as.matrix(t(subset(mean_plac.otu_REMISSwk6_matrix)))
colnames(mean_plac.otu_REMISSwk6_matrix) <- mean_plac.otu_REMISSwk6$Group.1

median_plac.otu_REMISSwk6 <- aggregate(otu_rel_abund.plac, by=list(screen_data.plac$REMISSwk6), median)
median_plac.otu_REMISSwk6_matrix <- subset(median_plac.otu_REMISSwk6, select=-c(Group.1))
median_plac.otu_REMISSwk6_matrix <- as.matrix(t(median_plac.otu_REMISSwk6_matrix))
colnames(median_plac.otu_REMISSwk6_matrix) <- median_plac.otu_REMISSwk6$Group.1


sd_otu <- aggregate(otu_rel_abund.plac, by=list(screen_data.plac$TRTGR, screen_data.plac$REMISSwk6), sd)
sd_otu$TRTGRrem <- paste(sd_otu$Group.1, sd_otu$Group.2)
sd_plac.otu_matrix <- subset(sd_otu, select=-c(TRTGRrem))
sd_plac.otu_matrix <- as.matrix(t(subset(sd_plac.otu_matrix, select=-c(1:2))))
colnames(sd_plac.otu_matrix) <- sd_otu$TRTGRrem

IQR_otu <- aggregate(otu_rel_abund.plac, by=list(screen_data.plac$TRTGR, screen_data.plac$REMISSwk6), IQR)
IQR_otu$TRTGRrem <- paste(IQR_otu$Group.1, IQR_otu$Group.2)
IQR_plac.otu_matrix <- subset(IQR_otu, select=-c(TRTGRrem))
IQR_plac.otu_matrix <- as.matrix(t(subset(IQR_plac.otu_matrix, select=-c(1:2))))
colnames(IQR_plac.otu_matrix) <- IQR_otu$TRTGRrem

stopifnot(screen_data.plac$group == rownames(otu_rel_abund.plac))

#abundant <- apply(mean_otu_matrix, 1, mean) > 0.005
#mean_abundant_otu_matrix <- mean_otu_matrix[abundant, ]
#sd_abundant_otu_matrix <- sd_otu_matrix[abundant, ]
#median_abundant_otu_matrix <- median_otu_matrix[abundant, ]


#y <- numeric() 
#wilcox_otubyx <- function(x){
#	for(otu in otu_numbers){
#	y[otu] <- wilcox.test(otu_rel_abund.plac[,otu] ~x)$p.value
#	}
#}

plac.otu_numbers <- colnames(otu_rel_abund.plac)

set.seed(32016)
REMwk6_wilcox_plac.otu_p <- numeric() 
for(otu in plac.otu_numbers){
	REMwk6_wilcox_plac.otu_p[otu] <- wilcox.test(otu_rel_abund.plac[,otu] ~screen_data.plac$REMISSwk6)$p.value
}

set.seed(32016)
RESPONSEwk6_wilcox_plac.otu_p <- numeric() 
for(otu in plac.otu_numbers){
	RESPONSEwk6_wilcox_plac.otu_p[otu] <- wilcox.test(otu_rel_abund.plac[,otu] ~screen_data.plac$RESPONSEwk6)$p.value
}


REMISSwk6_wilcox_plac.otu_adj_p <- na.omit(p.adjust(REMwk6_wilcox_plac.otu_p, method="BH"))
sig_REMISSwk6_wilcox_plac.otu_adj_p <-REMISSwk6_wilcox_plac.otu_adj_p  < 0.05
sig_REMISSwk6_wilcox_plac.otu_adj_p_otus <- rownames(median_plac.otu_REMISSwk6_matrix)[sig_REMISSwk6_wilcox_plac.otu_adj_p]

RESPONSEwk6_wilcox_plac.otu_adj_p <- na.omit(p.adjust(RESPONSEwk6_wilcox_plac.otu_p, method="BH"))
sig_RESPONSEwk6_wilcox_plac.otu_adj_p <-RESPONSEwk6_wilcox_plac.otu_adj_p  < 0.05
sig_RESPONSEwk6_wilcox_plac.otu_adj_p_otus <- rownames(median_plac.otu_RESPONSEwk6_matrix)[sig_RESPONSEwk6_wilcox_plac.otu_adj_p]


screen_data.placplac_groups <- screen_data[screen_data$visit=="Screening", c("group", "TRTGRINDMAN")]
screen_data.placplac <- screen_data[screen_data$TRTGRINDMAN=="Placebo_Placebo",]
screen_data.placplac_groups <- screen_data.placplac[, c("group", "TRTGRINDMAN")]
rownames(screen_data.placplac) <- screen_data.placplac$group
screen_data.placplac <- screen_data.placplac[,-1]
#stopifnot(rownames(screen_data.placplac) == rownames(screen.placplac_plac.otu_rel_abund))

screen.placplac_otu_rel_abund <- merge(screen_data.placplac_groups, otu_rel_abund, by.x = "group", by.y = "row.names")
rownames(screen.placplac_otu_rel_abund) <- screen.placplac_otu_rel_abund$group
screen.placplac_otu_rel_abund <- screen.placplac_otu_rel_abund[,-c(1:2)]
otu_rel_abund.placplac_sum <- apply(screen.placplac_otu_rel_abund, 2, sum)
otu_rel_abund.placplac <- otu_rel_abund.placplac_sum > (2/3000*100)
otu_rel_abund.placplac <- screen.placplac_otu_rel_abund[, otu_rel_abund.placplac]
plac.otu_numbers <- colnames(otu_rel_abund.placplac)

stopifnot(rownames(screen_data.placplac) == rownames(otu_rel_abund.placplac))


median_plac.otu_RESPONSEwk22 <- aggregate(otu_rel_abund.placplac, by=list(screen_data.placplac$RESPONSEwk22), median)
median_plac.otu_RESPONSEwk22_matrix <- subset(median_plac.otu_RESPONSEwk22, select=-c(Group.1))
median_plac.otu_RESPONSEwk22_matrix <- as.matrix(t(median_plac.otu_RESPONSEwk22_matrix))
colnames(median_plac.otu_RESPONSEwk22_matrix) <- median_plac.otu_RESPONSEwk22$Group.1

median_plac.otu_REMISSwk22 <- aggregate(otu_rel_abund.placplac, by=list(screen_data.placplac$REMISSwk22), median)
median_plac.otu_REMISSwk22_matrix <- subset(median_plac.otu_REMISSwk22, select=-c(Group.1))
median_plac.otu_REMISSwk22_matrix <- as.matrix(t(median_plac.otu_REMISSwk22_matrix))
colnames(median_plac.otu_REMISSwk22_matrix) <- median_plac.otu_REMISSwk22$Group.1


set.seed(32016)
REMwk22_wilcox_plac.otu_p <- numeric() 
for(otu in plac.otu_numbers){
	REMwk22_wilcox_plac.otu_p[otu] <- wilcox.test(otu_rel_abund.placplac[,otu] ~screen_data.placplac$REMISSwk22)$p.value
}

set.seed(32016)
RESPONSEwk22_wilcox_plac.otu_p <- numeric() 
for(otu in plac.otu_numbers){
	RESPONSEwk22_wilcox_plac.otu_p[otu] <- wilcox.test(otu_rel_abund.placplac[,otu] ~screen_data.placplac$RESPONSEwk22)$p.value
}

REMISSwk22_wilcox_plac.otu_adj_p <- na.omit(p.adjust(REMwk22_wilcox_plac.otu_p, method="BH"))
sig_REMISSwk22_wilcox_plac.otu_adj_p <-REMISSwk22_wilcox_plac.otu_adj_p  < 0.05
sig_REMISSwk22_wilcox_plac.otu_adj_p_otus <- rownames(median_plac.otu_REMISSwk22_matrix)[sig_REMISSwk22_wilcox_plac.otu_adj_p]

RESPONSEwk22_wilcox_plac.otu_adj_p <- na.omit(p.adjust(RESPONSEwk22_wilcox_plac.otu_p, method="BH"))
sig_RESPONSEwk22_wilcox_plac.otu_adj_p <-RESPONSEwk22_wilcox_plac.otu_adj_p  < 0.05
sig_RESPONSEwk22_wilcox_plac.otu_adj_p_otus <- rownames(median_plac.otu_RESPONSEwk22_matrix)[sig_RESPONSEwk22_wilcox_plac.otu_adj_p]

