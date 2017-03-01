source('../code/tax.analysis.setup.R')

total_mean_rabund <- apply(order_rel_abund, 2, mean)
mean_rel_abund <- aggregate(order_rel_abund, by=list(screen_data$REMISSwk6), mean)
#decreasing_order <- order(total_mean_rabund, decreasing=T)
#order_rel_abund <- order_rel_abund[,decreasing_order]

mean_order_trtRemWk6 <- aggregate(order_rel_abund, by=list(screen_data$TRTGR, screen_data$REMISSwk6), mean)
mean_order_trtRemWk6$TRTGRrem <- paste(mean_order_trtRemWk6$Group.1, mean_order_trtRemWk6$Group.2)
mean_order_trtRemWk6_matrix <- subset(mean_order_trtRemWk6, select=-c(TRTGRrem))
mean_order_trtRemWk6_matrix <- as.matrix(t(subset(mean_order_trtRemWk6_matrix, select=-c(1:2))))
colnames(mean_order_trtRemWk6_matrix) <- mean_order_trtRemWk6$TRTGRrem

mean_order <- aggregate(order_rel_abund, by=list(screen_data$REMISSwk6), mean)
mean_order_matrix <- subset(mean_order, select=-c(Group.1))
mean_order_matrix <- as.matrix(t(subset(mean_order_matrix)))
colnames(mean_order_matrix) <- mean_order$Group.1

median_order_trtRemWk6 <- aggregate(order_rel_abund, by=list(screen_data$TRTGR, screen_data$REMISSwk6), median)
median_order_trtRemWk6$TRTGRrem <- paste(median_order_trtRemWk6$Group.1, median_order_trtRemWk6$Group.2)
median_order_trtRemWk6_matrix <- subset(median_order_trtRemWk6, select=-c(TRTGRrem))
median_order_trtRemWk6_matrix <- as.matrix(t(subset(median_order_trtRemWk6_matrix, select=-c(1:2))))
colnames(median_order_trtRemWk6_matrix) <- median_order_trtRemWk6$TRTGRrem

median_order <- aggregate(order_rel_abund, by=list(screen_data$REMISSwk6), median)
median_order_matrix <- subset(median_order, select=-c(Group.1))
median_order_matrix <- as.matrix(t(median_order_matrix))
colnames(median_order_matrix) <- median_order$Group.1


sd_order <- aggregate(order_rel_abund, by=list(screen_data$TRTGR, screen_data$REMISSwk6), sd)
sd_order$TRTGRrem <- paste(sd_order$Group.1, sd_order$Group.2)
sd_order_matrix <- subset(sd_order, select=-c(TRTGRrem))
sd_order_matrix <- as.matrix(t(subset(sd_order_matrix, select=-c(1:2))))
colnames(sd_order_matrix) <- sd_order$TRTGRrem

IQR_order <- aggregate(order_rel_abund, by=list(screen_data$TRTGR, screen_data$REMISSwk6), IQR)
IQR_order$TRTGRrem <- paste(IQR_order$Group.1, IQR_order$Group.2)
IQR_order_matrix <- subset(IQR_order, select=-c(TRTGRrem))
IQR_order_matrix <- as.matrix(t(subset(IQR_order_matrix, select=-c(1:2))))
colnames(IQR_order_matrix) <- IQR_order$TRTGRrem

stopifnot(screen_data$group == rownames(order_rel_abund))

#abundant <- apply(mean_order_matrix, 1, mean) > 0.005
mean_abundant_order_matrix <- mean_order_matrix[abundant, ]
sd_abundant_order_matrix <- sd_order_matrix[abundant, ]
median_abundant_order_matrix <- median_order_matrix[abundant, ]




order_p <- numeric() 
for(order in order_names){
	order_p[order] <- wilcox.test(order_rel_abund[,order] ~screen_data$REMISSwk6)$p.value
}


order_pMCT <- data.frame(Comparison = rownames(test), stringsAsFactors = T)




order_p_trtremwk6 <- numeric() 
for(order in order_names){
	order_p[order] <- kruskal.test(order_rel_abund[,order] ~screen_data$TRT_REMwk6)$p.value
}


order_pMCT <- data.frame(Comparison = rownames(test), stringsAsFactors = T)

#order_pMCT$comparison <- rownames(test)
for(order in order_names){
	order_pMCT[order] <- kruskalmc(order_rel_abund[[order]]~screen_data$TRT_REMwk6)$dif.com[,3]
	order_pMCT <- cbind(order_pMCT,order_pMCT[order])
}

order_adj_p <- na.omit(p.adjust(order_p, method="BH"))
sig_order_adj_p<-order_adj_p < 0.05

order_p < 0.05

cbind(data.frame(mean_abundant_order_matrix, order = row.names(mean_abundant_order_matrix))) %>%
	gather(treatment, relabund, -order) %>% ggplot(aes(x=treatment, y=relabund, fill=order)) +
	geom_bar(position = "dodge", stat="identity")


orderRabTRTwk6rem_ggplot <- gather(orderRelab_trtgrRem6, order, relabund, one_of(row.names(mean_order_matrix)[abundant]))
rank <- c("Firmicutes","Bacteroidetes","Proteobacteria","Actinobacteria","Verrucomicrobia","Fusobacteria")
orderRabTRTwk6rem_ggplot$order <- factor(orderRabTRTwk6rem_ggplot$order, levels = rank, labels= rank)  #order the subset dataset by the median abundances
orderRabTRTwk6rem_ggplot <- orderRabTRTwk6rem_ggplot[order(orderRabTRTwk6rem_ggplot$order),]


order_figure <- ggplot(orderRabTRTwk6rem_ggplot, aes(x=TRT_REMwk6, y=relabund, fill=order)) +
	#stat_summary(fun.y=median, geom="point", aes(fill = order), position = position_dodge(1)) +
	#stat_summary(fun.data = 'median_hilow', fun.args = (conf.int=0.5), position = position_dodge(1), geom='errorbar', aes(color = order))+
	geom_boxplot(aes(col=order), position=position_dodge(width = 1), alpha = .4)

order_figure

summary(orderRabTRTwk6rem_ggplot$order)


str(orderRabTRTwk6rem_ggplot$order)