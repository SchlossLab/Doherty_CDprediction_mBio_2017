source('../code/tax.analysis.setup.R')

total_mean_rabund <- apply(family_rel_abund, 2, mean)
mean_rel_abund <- aggregate(family_rel_abund, by=list(screen_data$REMISSwk6), mean)
#decreasing_order <- order(total_mean_rabund, decreasing=T)
#family_rel_abund <- family_rel_abund[,decreasing_order]

mean_family_trtRemWk6 <- aggregate(family_rel_abund, by=list(screen_data$TRTGR, screen_data$REMISSwk6), mean)
mean_family_trtRemWk6$TRTGRrem <- paste(mean_family_trtRemWk6$Group.1, mean_family_trtRemWk6$Group.2)
mean_family_trtRemWk6_matrix <- subset(mean_family_trtRemWk6, select=-c(TRTGRrem))
mean_family_trtRemWk6_matrix <- as.matrix(t(subset(mean_family_trtRemWk6_matrix, select=-c(1:2))))
colnames(mean_family_trtRemWk6_matrix) <- mean_family_trtRemWk6$TRTGRrem

mean_family <- aggregate(family_rel_abund, by=list(screen_data$REMISSwk6), mean)
mean_family_matrix <- subset(mean_family, select=-c(Group.1))
mean_family_matrix <- as.matrix(t(subset(mean_family_matrix)))
colnames(mean_family_matrix) <- mean_family$Group.1

median_family_trtRemWk6 <- aggregate(family_rel_abund, by=list(screen_data$TRTGR, screen_data$REMISSwk6), median)
median_family_trtRemWk6$TRTGRrem <- paste(median_family_trtRemWk6$Group.1, median_family_trtRemWk6$Group.2)
median_family_trtRemWk6_matrix <- subset(median_family_trtRemWk6, select=-c(TRTGRrem))
median_family_trtRemWk6_matrix <- as.matrix(t(subset(median_family_trtRemWk6_matrix, select=-c(1:2))))
colnames(median_family_trtRemWk6_matrix) <- median_family_trtRemWk6$TRTGRrem

median_family <- aggregate(family_rel_abund, by=list(screen_data$REMISSwk6), median)
median_family_matrix <- subset(median_family, select=-c(Group.1))
median_family_matrix <- as.matrix(t(median_family_matrix))
colnames(median_family_matrix) <- median_family$Group.1


sd_family <- aggregate(family_rel_abund, by=list(screen_data$TRTGR, screen_data$REMISSwk6), sd)
sd_family$TRTGRrem <- paste(sd_family$Group.1, sd_family$Group.2)
sd_family_matrix <- subset(sd_family, select=-c(TRTGRrem))
sd_family_matrix <- as.matrix(t(subset(sd_family_matrix, select=-c(1:2))))
colnames(sd_family_matrix) <- sd_family$TRTGRrem

IQR_family <- aggregate(family_rel_abund, by=list(screen_data$TRTGR, screen_data$REMISSwk6), IQR)
IQR_family$TRTGRrem <- paste(IQR_family$Group.1, IQR_family$Group.2)
IQR_family_matrix <- subset(IQR_family, select=-c(TRTGRrem))
IQR_family_matrix <- as.matrix(t(subset(IQR_family_matrix, select=-c(1:2))))
colnames(IQR_family_matrix) <- IQR_family$TRTGRrem

stopifnot(screen_data$group == rownames(family_rel_abund))

#abundant <- apply(mean_family_matrix, 1, mean) > 0.005
mean_abundant_family_matrix <- mean_family_matrix[abundant, ]
sd_abundant_family_matrix <- sd_family_matrix[abundant, ]
median_abundant_family_matrix <- median_family_matrix[abundant, ]




family_p <- numeric() 
for(family in family_names){
	family_p[family] <- wilcox.test(family_rel_abund[,family] ~screen_data$REMISSwk6)$p.value
}


#family_pMCT <- data.frame(Comparison = rownames(test), stringsAsFactors = T)




#family_p_trtremwk6 <- numeric() 
#for(family in family_names){
	#family_p[family] <- kruskal.test(family_rel_abund[,family] ~screen_data$TRT_REMwk6)$p.value
#}

#kruskalmc(family_rel_abund[,1]~screen_data$REMISSwk6)

#test<-kruskalmc(otu_rel_abund[,1]~screen_data$TRT_REMwk6)

#family_pMCT <- data.frame(Comparison = rownames(test), stringsAsFactors = T)

#family_pMCT$comparison <- rownames(test)
#for(family in family_names){
#	family_pMCT[family] <- kruskalmc(family_rel_abund[[family]]~screen_data$TRT_REMwk6)$dif.com[,3]
#	family_pMCT <- cbind(family_pMCT,family_pMCT[family])
#}

family_adj_p <- na.omit(p.adjust(family_p, method="BH"))
sig_family_adj_p<-family_adj_p < 0.05

#family_p < 0.05

#significant
sig_family_adj_p_familys <- rownames(mean_family_matrix)[sig_family_adj_p]
mean_signif_family_matrix <- data.frame(mean_family_matrix[sig_family_adj_p_familys,])
#mean_signif_family_matrix <- merge(tax, mean_signif_family_matrix, by.x = "family", by.y="row.names")
mean_signif_family_matrix$diff <- mean_signif_family_matrix$No*100-mean_signif_family_matrix$Yes*100
mean_signif_family_matrix <-mean_signif_family_matrix[mean_signif_family_matrix$diff!=0,]
#mean_signif_family_matrix <- subset(mean_signif_family_matrix, select=c("diff", "family", "No", "Yes"))
#rownames(mean_signif_family_matrix) <- mean_signif_family_matrix$family
#mean_signif_family_matrix <-mean_signif_family_matrix[(-1*mean_signif_family_matrix$diff) >= 0.01,]
mean_signif_family_matrix <- mean_signif_family_matrix[,-3]	

#phylum_pMCT$comparison <- rownames(test)
#for(family in family_names){
#	family_pMCT[family] <- kruskalmc(family_rel_abund[,family]~screen_data$TRT_REMwk6)$dif.com[,3]
#	family_pMCT <- cbind(family_pMCT,family_pMCT[family])
#}

#family_names
#colnames(family_rel_abund)

#kruskalmc(family_rel_abund$Bacteroidetes~screen_data$REMISSwk6)

mean_rel_abund <- aggregate(family_rel_abund, by=list(screen_data$TRT_REMwk6), mean)
decreasing_order <- order(total_mean_rabund, decreasing=T)
family_rel_abund <- family_rel_abund[,decreasing_order]

abund_mean_signif_family <- data.frame(mean_signif_family_matrix[mean_signif_family_matrix$Yes  > 0.00001,])
#abund_mean_signif_family <- abund_mean_signif_family[abund_mean_signif_family$No == T,]
#abund_mean_signif_family <- abund_mean_signif_family[abund_mean_signif_family$Yes == T,]
#abund_mean_signif_familyNames <- rownames(abund_mean_signif_family)
#abund_mean_signif_family_matrix <- mean_signif_family_matrix[abund_mean_signif_familyNames,]

Vabund_mean_signif_family <- data.frame(mean_signif_family_matrix[mean_signif_family_matrix$Yes > 0.01,])
#Vabund_mean_signif_family <- Vabund_mean_signif_family[Vabund_mean_signif_family$No == T,]
#Vabund_mean_signif_family <- Vabund_mean_signif_family[Vabund_mean_signif_family$Yes == T,]
#Vabund_mean_signif_familyNames <- rownames(Vabund_mean_signif_family)
#Vabund_mean_signif_family_matrix <- mean_signif_family_matrix[Vabund_mean_signif_familyNames,]

Mabund_mean_signif_family_matrix <- data.frame(mean_signif_family_matrix[mean_signif_family_matrix$Yes  > 0.001,])
Mabund_mean_signif_family_matrix <- data.frame(Mabund_mean_signif_family_matrix[Mabund_mean_signif_family_matrix$Yes < 0.01,])

#Mabund_mean_signif_family <- Mabund_mean_signif_family_matrix[Mabund_mean_signif_family_matrix$No == T,]
#Mabund_mean_signif_family <- Mabund_mean_signif_family[Mabund_mean_signif_family$Yes == T,]
#Mabund_mean_signif_familyNames <- rownames(Mabund_mean_signif_family)
#Mabund_mean_signif_family_matrix <- mean_signif_family_matrix[Mabund_mean_signif_familyNames,]

Labund_mean_signif_family_matrix <- data.frame(mean_signif_family_matrix[mean_signif_family_matrix$Yes > 0.00001,])
Labund_mean_signif_family_matrix <- data.frame(Labund_mean_signif_family_matrix[Labund_mean_signif_family_matrix$Yes < 0.001,])

#Labund_mean_signif_family <- Labund_mean_signif_family_matrix[Labund_mean_signif_family_matrix$No == T,]
#Labund_mean_signif_family <- Labund_mean_signif_family[Labund_mean_signif_family$Yes == T,]
#Labund_mean_signif_familyNames <- rownames(Labund_mean_signif_family)
#Labund_mean_signif_family_matrix <- mean_signif_family_matrix[Labund_mean_signif_familyNames,]

#significant
sig_family_adj_p_familys <- rownames(abund_mean_signif_family_matrix)
mean_signif_family_matrix <- mean_family_matrix[sig_family_adj_p_familys,]

cbind(data.frame(mean_signif_family_matrix, family = row.names(mean_signif_family_matrix))) %>%
	gather(response, relabund, -family) %>% ggplot(aes(x=response, y=relabund, fill=family)) +
	geom_bar(position = "dodge",stat="identity")  + scale_color_hue(labels = formatted)

cbind(data.frame(Vabund_mean_signif_family_matrix, family = row.names(Vabund_mean_signif_family_matrix))) %>%
	gather(response, relabund, -family) %>% ggplot(aes(x=response, y=relabund, fill=family)) +
	geom_bar(position = "dodge",stat="identity") + scale_color_hue(labels = formatted)

cbind(data.frame(Mabund_mean_signif_family_matrix, family = row.names(Mabund_mean_signif_family_matrix))) %>%
	gather(response, relabund, -family) %>% ggplot(aes(x=response, y=relabund, fill=family)) +
	geom_bar(position = "dodge",stat="identity")

cbind(data.frame(Labund_mean_signif_family_matrix, family = row.names(Labund_mean_signif_family_matrix))) %>%
	gather(response, relabund, -family) %>% ggplot(aes(x=response, y=relabund, fill=family)) +
	geom_bar(position = "dodge",stat="identity")

familyRabwk6rem_ggplot <- gather(family_relab_RemWk6, family, relabund, one_of(rownames(mean_signif_family_matrix)))

tail(colnames(familyRabwk6rem_ggplot))

ggplot(familyRabwk6rem_ggplot, aes(x=family, y=relabund, fill=REMISSwk6)) +
	#stat_summary(fun.y=median, geom="point", aes(fill = family), position = position_dodge(1)) +
	#stat_summary(fun.data = 'median_hilow', fun.args = (conf.int=0.5), position = position_dodge(1), geom='errorbar', aes(color = family))+
	geom_boxplot(aes(col=family), position=position_dodge(width = 1), alpha = .4)


#######plot attempt
tax<-read.table("../data/Jan400.simple.taxonomy.txt", header=T, sep='\t')


#Abundance stripchart of sig dif familys by REMISSwk6
familyrf_familys  <- as.character(ordered(sig_family_adj_p_familys))
#familyrf_familys <- familyrf_familys[1:10]
#familyrf_familys
no_abunds <- screen_data[screen_data$REMISSwk6=='No', familyrf_familys]/10000 + 1e-5
no_abunds <-na.omit(no_abunds)
yes_abunds <- screen_data[screen_data$REMISSwk6=='Yes', familyrf_familys]/10000 + 1e-5
yes_abunds<- na.omit(yes_abunds)

#pdf('figures/familyrelRSPwk6abunds.pdf', height=6, width=8)
#layout(1)
par(mar=c(4, 12, 2, 1))
plot(1, type="n", ylim=c(0,length(familyrf_familys )*2), xlim=c(1e-5,3), log="x", ylab="", xlab="Relative Abundance (%)", xaxt="n", yaxt="n")
#title('Abundance of Top familys from Microbiome Model')
set.seed(32016)
index <- 1
for(i in sig_family_adj_p_familys){
	stripchart(at=index-0.35, jitter(yes_abunds[,i], amount=1e-6), pch=21, bg=alpha("royalblue1", alpha=0.25), method="jitter", jitter=0.2, add=T, cex=1, lwd=0.5)
	stripchart(at=index+0.35, jitter(no_abunds[,i], amount=1e-6), pch=21, bg=alpha("orange", alpha=0.25), method="jitter", jitter=0.2, add=T, cex=1, lwd=0.5)
	segments(median(yes_abunds[,i]),index-0.7,median(yes_abunds[,i]),index, lwd=3)
	segments(median(no_abunds[,i]),index+0.7,median(no_abunds[,i]),index, lwd=3)
	index <- index + 2
}
#familyrf_familys
rf_tax<-data.frame(familyrf_familys)
colnames(rf_tax) <- c('family')

familyrf_tax<-merge(rf_tax, tax, by='family')
familyrf_tax$Classification <- gsub("(family\\d+)", "(\\1)", familyrf_tax$Classification)

familyrf_tax<-familyrf_tax[match(rf_tax$family, familyrf_tax$family),]
familyrf_name<-as.character(familyrf_tax$tax)
familyrf_numb<-familyrf_tax$Classification
#familyrf_tax <- gsub("_", " ", familyrf_tax)
formatted <- lapply(1:nrow(familyrf_tax), function(i) bquote(paste(italic(.(familyrf_name[i])), .(familyrf_numb[i]), sep=" ")))

axis(2, at=seq(1,index-2,2), labels=do.call(expression, formatted), font =3, las=1, line=0, tick=F, cex.axis=0.8)
axis(1, at=c(1e-5, 1e-4, 1e-3, 1e-2, 1e-1), label=c("0", "0.01", "0.1", "1", "10"))
legend('topright', legend=c("Response Week 6 No", "Response Week 6 Yes"), pch=c(21, 21), pt.bg=c("orange","royalblue1"), cex=0.7)
mtext('B', at=1e-8, side=3, line=0.1, font=2, cex=2)

