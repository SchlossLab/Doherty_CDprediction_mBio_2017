source('../code/tax.analysis.setup.R')

total_mean_rabund <- apply(class_rel_abund, 2, mean)
mean_rel_abund <- aggregate(class_rel_abund, by=list(screen_data$REMISSwk6), mean)
#decreasing_order <- order(total_mean_rabund, decreasing=T)
#class_rel_abund <- class_rel_abund[,decreasing_order]

mean_class_trtRemWk6 <- aggregate(class_rel_abund, by=list(screen_data$TRTGR, screen_data$REMISSwk6), mean)
mean_class_trtRemWk6$TRTGRrem <- paste(mean_class_trtRemWk6$Group.1, mean_class_trtRemWk6$Group.2)
mean_class_trtRemWk6_matrix <- subset(mean_class_trtRemWk6, select=-c(TRTGRrem))
mean_class_trtRemWk6_matrix <- as.matrix(t(subset(mean_class_trtRemWk6_matrix, select=-c(1:2))))
colnames(mean_class_trtRemWk6_matrix) <- mean_class_trtRemWk6$TRTGRrem

mean_class <- aggregate(class_rel_abund, by=list(screen_data$REMISSwk6), mean)
mean_class_matrix <- subset(mean_class, select=-c(Group.1))
mean_class_matrix <- as.matrix(t(subset(mean_class_matrix)))
colnames(mean_class_matrix) <- mean_class$Group.1

median_class_trtRemWk6 <- aggregate(class_rel_abund, by=list(screen_data$TRTGR, screen_data$REMISSwk6), median)
median_class_trtRemWk6$TRTGRrem <- paste(median_class_trtRemWk6$Group.1, median_class_trtRemWk6$Group.2)
median_class_trtRemWk6_matrix <- subset(median_class_trtRemWk6, select=-c(TRTGRrem))
median_class_trtRemWk6_matrix <- as.matrix(t(subset(median_class_trtRemWk6_matrix, select=-c(1:2))))
colnames(median_class_trtRemWk6_matrix) <- median_class_trtRemWk6$TRTGRrem

median_class <- aggregate(class_rel_abund, by=list(screen_data$REMISSwk6), median)
median_class_matrix <- subset(median_class, select=-c(Group.1))
median_class_matrix <- as.matrix(t(median_class_matrix))
colnames(median_class_matrix) <- median_class$Group.1


sd_class <- aggregate(class_rel_abund, by=list(screen_data$TRTGR, screen_data$REMISSwk6), sd)
sd_class$TRTGRrem <- paste(sd_class$Group.1, sd_class$Group.2)
sd_class_matrix <- subset(sd_class, select=-c(TRTGRrem))
sd_class_matrix <- as.matrix(t(subset(sd_class_matrix, select=-c(1:2))))
colnames(sd_class_matrix) <- sd_class$TRTGRrem

IQR_class <- aggregate(class_rel_abund, by=list(screen_data$TRTGR, screen_data$REMISSwk6), IQR)
IQR_class$TRTGRrem <- paste(IQR_class$Group.1, IQR_class$Group.2)
IQR_class_matrix <- subset(IQR_class, select=-c(TRTGRrem))
IQR_class_matrix <- as.matrix(t(subset(IQR_class_matrix, select=-c(1:2))))
colnames(IQR_class_matrix) <- IQR_class$TRTGRrem

stopifnot(screen_data$group == rownames(class_rel_abund))

#abundant <- apply(mean_class_matrix, 1, mean) > 0.005
mean_abundant_class_matrix <- mean_class_matrix[abundant, ]
sd_abundant_class_matrix <- sd_class_matrix[abundant, ]
median_abundant_class_matrix <- median_class_matrix[abundant, ]




class_p <- numeric() 
for(class in class_names){
	class_p[class] <- wilcox.test(class_rel_abund[,class] ~screen_data$REMISSwk6)$p.value
}


class_pMCT <- data.frame(Comparison = rownames(test), stringsAsFactors = T)




class_p_trtremwk6 <- numeric() 
for(class in class_names){
	class_p[class] <- kruskal.test(class_rel_abund[,class] ~screen_data$TRT_REMwk6)$p.value
}


class_pMCT <- data.frame(Comparison = rownames(test), stringsAsFactors = T)

#class_pMCT$comparison <- rownames(test)
for(class in class_names){
	class_pMCT[class] <- kruskalmc(class_rel_abund[[class]]~screen_data$TRT_REMwk6)$dif.com[,3]
	class_pMCT <- cbind(class_pMCT,class_pMCT[class])
}

class_adj_p <- na.omit(p.adjust(class_p, method="BH"))
sig_class_adj_p<-class_adj_p < 0.05

class_p < 0.05

cbind(data.frame(mean_abundant_class_matrix, class = row.names(mean_abundant_class_matrix))) %>%
	gather(treatment, relabund, -class) %>% ggplot(aes(x=treatment, y=relabund, fill=class)) +
	geom_bar(position = "dodge", stat="identity")


classRabTRTwk6rem_ggplot <- gather(classRelab_trtgrRem6, class, relabund, one_of(row.names(mean_class_matrix)[abundant]))
rank <- c("Firmicutes","Bacteroidetes","Proteobacteria","Actinobacteria","Verrucomicrobia","Fusobacteria")
classRabTRTwk6rem_ggplot$class <- factor(classRabTRTwk6rem_ggplot$class, levels = rank, labels= rank)  #order the subset dataset by the median abundances
classRabTRTwk6rem_ggplot <- classRabTRTwk6rem_ggplot[order(classRabTRTwk6rem_ggplot$class),]


class_figure <- ggplot(classRabTRTwk6rem_ggplot, aes(x=TRT_REMwk6, y=relabund, fill=class)) +
	#stat_summary(fun.y=median, geom="point", aes(fill = class), position = position_dodge(1)) +
	#stat_summary(fun.data = 'median_hilow', fun.args = (conf.int=0.5), position = position_dodge(1), geom='errorbar', aes(color = class))+
	geom_boxplot(aes(col=class), position=position_dodge(width = 1), alpha = .4)

class_figure

summary(classRabTRTwk6rem_ggplot$class)


str(classRabTRTwk6rem_ggplot$class)