source('../code/otu.analysis.R')

#significant otus
tax_mean_otu_RelRSPwk22_matrix <- merge(tax, mean_otu_RelRSPwk22_matrix, by.x = "OTU", by.y="row.names")
sig_RelRSPwk22_wilcox_otu_adj_p_otus <- rownames(mean_otu_RelRSPwk22_matrix)[sig_RelRSPwk22_wilcox_otu_adj_p]
mean_signif_RelRSPwk22_otu_matrix <- mean_otu_RelRSPwk22_matrix[sig_RelRSPwk22_wilcox_otu_adj_p_otus,]
tax_mean_signif_RelRSPwk22_otu_matrix <- merge(tax, mean_signif_RelRSPwk22_otu_matrix, by.x = "OTU", by.y="row.names")
tax_mean_signif_RelRSPwk22_otu_matrix$diff <- tax_mean_signif_RelRSPwk22_otu_matrix$No-tax_mean_signif_RelRSPwk22_otu_matrix$Yes
tax_mean_signif_RelRSPwk22_otu_matrix <-data.frame(tax_mean_signif_RelRSPwk22_otu_matrix[tax_mean_signif_RelRSPwk22_otu_matrix$diff!=0,])
tax_mean_signif_RelRSPwk22_otu_matrix <-tax_mean_signif_RelRSPwk22_otu_matrix[abs(tax_mean_signif_RelRSPwk22_otu_matrix$diff) >= 0.013,]
tax_mean_signif_RelRSPwk22_otu_matrix$Label <- factor(tax_mean_signif_RelRSPwk22_otu_matrix$Label, levels = as.character(tax_mean_signif_RelRSPwk22_otu_matrix$Label), labels= as.character(tax_mean_signif_RelRSPwk22_otu_matrix$Label))
tax_mean_signif_RelRSPwk22_otu_matrix$OTU <- factor(tax_mean_signif_RelRSPwk22_otu_matrix$OTU, levels = as.character(tax_mean_signif_RelRSPwk22_otu_matrix$OTU), labels= as.character(tax_mean_signif_RelRSPwk22_otu_matrix$OTU))


labeled_mean_signif_RelRSPwk22_otu_matrix <- subset(tax_mean_signif_RelRSPwk22_otu_matrix, select=c("diff", "Label", "No", "Yes"))
OTU_mean_signif_RelRSPwk22_otu_matrix <- subset(tax_mean_signif_RelRSPwk22_otu_matrix, select=c("diff", "OTU", "No", "Yes"))
rownames(labeled_mean_signif_RelRSPwk22_otu_matrix) <- labeled_mean_signif_RelRSPwk22_otu_matrix$Label
labeled_mean_signif_RelRSPwk22_otu_matrix <-labeled_mean_signif_RelRSPwk22_otu_matrix[abs(labeled_mean_signif_RelRSPwk22_otu_matrix$diff) >= 0.013,]
labeled_mean_signif_RelRSPwk22_otu_matrix <- labeled_mean_signif_RelRSPwk22_otu_matrix[,-c(1:2)]	
rownames(OTU_mean_signif_RelRSPwk22_otu_matrix) <- OTU_mean_signif_RelRSPwk22_otu_matrix$OTU
OTU_mean_signif_RelRSPwk22_otu_matrix <-OTU_mean_signif_RelRSPwk22_otu_matrix[abs(OTU_mean_signif_RelRSPwk22_otu_matrix$diff) >= 0.013,]
OTU_mean_signif_RelRSPwk22_otu_matrix <- OTU_mean_signif_RelRSPwk22_otu_matrix[,-c(1:2)]	

#decreasing_order <- order(total_mean_otu_rel_abund, decreasing=T)
#otu_rel_abund <- otu_rel_abund[,decreasing_order]

abund_mean_signif_RelRSPwk22_otu_matrix <- data.frame(labeled_mean_signif_RelRSPwk22_otu_matrix[labeled_mean_signif_RelRSPwk22_otu_matrix$Yes  > 0.001,])

Vabund_mean_signif_RelRSPwk22_otu_matrix <- data.frame(labeled_mean_signif_RelRSPwk22_otu_matrix[labeled_mean_signif_RelRSPwk22_otu_matrix$Yes > 1,])

Mabund_mean_signif_RelRSPwk22_otu_matrix <- data.frame(labeled_mean_signif_RelRSPwk22_otu_matrix[labeled_mean_signif_RelRSPwk22_otu_matrix$Yes  > 0.1,])
Mabund_mean_signif_RelRSPwk22_otu_matrix <- data.frame(Mabund_mean_signif_RelRSPwk22_otu_matrix[Mabund_mean_signif_RelRSPwk22_otu_matrix$Yes < 1,])

Labund_mean_signif_RelRSPwk22_otu_matrix <- data.frame(labeled_mean_signif_RelRSPwk22_otu_matrix[labeled_mean_signif_RelRSPwk22_otu_matrix$Yes > 0.001,])
Labund_mean_signif_RelRSPwk22_otu_matrix <- data.frame(Labund_mean_signif_RelRSPwk22_otu_matrix[Labund_mean_signif_RelRSPwk22_otu_matrix$Yes < 0.1,])

#significant
sig_RelRSPwk22_wilcox_otu_adj_p_otus <- rownames(abund_mean_signif_RelRSPwk22_otu_matrix)
#mean_signif_RelRSPwk22_otu_matrix <- mean_otu_RelRSPwk22_matrix[sig_RelRSPwk22_wilcox_otu_adj_p_otus,]

labs <- sapply(strsplit(as.character(row.names(labeled_mean_signif_RelRSPwk22_otu_matrix)), " "), 
							 function(x) {
							 	parse(text = paste0("italic('", x[1], "')~", x[2]))
							 })



cbind(data.frame(labeled_mean_signif_RelRSPwk22_otu_matrix, otu = row.names(labeled_mean_signif_RelRSPwk22_otu_matrix))) %>%
	gather(Response, relabund, -otu) %>% ggplot(aes(x=Response, y=relabund, fill=otu)) +
	geom_bar(position = "dodge",stat="identity") + scale_fill_discrete(labels=labs, breaks = levels(tax_mean_signif_RelRSPwk22_otu_matrix$Label)) +
	ylab("Relative Abundance (%)") + xlab("Week 22 Response")





cbind(data.frame(Vabund_mean_signif_RelRSPwk22_otu_matrix, otu = row.names(Vabund_mean_signif_RelRSPwk22_otu_matrix))) %>%
	gather(Response, relabund, -otu) %>% ggplot(aes(x=Response, y=relabund, fill=otu)) +
	geom_bar(position = "dodge",stat="identity") + 
	scale_fill_discrete(labels=labs, breaks = levels(tax_mean_signif_RelRSPwk22_otu_matrix$Label)) +
	ylab("Relative Abundance (%)") + xlab("Week 22 Response")


cbind(data.frame(Mabund_mean_signif_RelRSPwk22_otu_matrix, otu = row.names(Mabund_mean_signif_RelRSPwk22_otu_matrix))) %>%
	gather(Response, relabund, -otu) %>% ggplot(aes(x=Response, y=relabund, fill=otu)) +
	geom_bar(position = "dodge",stat="identity") + 
	scale_fill_discrete(labels=labs, breaks = levels(tax_mean_signif_RelRSPwk22_otu_matrix$Label)) +
	ylab("Relative Abundance (%)") + xlab("Week 22 Response")



cbind(data.frame(Labund_mean_signif_RelRSPwk22_otu_matrix, otu = row.names(Labund_mean_signif_RelRSPwk22_otu_matrix))) %>%
	gather(Response, relabund, -otu) %>% ggplot(aes(x=Response, y=relabund, fill=otu)) +
	geom_bar(position = "dodge",stat="identity") + 
	scale_fill_discrete(labels=labs, breaks = levels(tax_mean_signif_RelRSPwk22_otu_matrix$Label)) +
	ylab("Relative Abundance (%)") + xlab("Week 22 Response")



c1c2 <- otu_relab_RelRSPwk22[,c(1:2)]
restC <- otu_relab_RelRSPwk22[,-c(1:2)]
colnames(restC) <- tax_mean_otu_RelRSPwk22_matrix$Label
labeled_otu_relab_RelRSPwk22 <- cbind(c1c2, restC)
otuRabRelRSPwk22_ggplot <- gather(labeled_otu_relab_RelRSPwk22, otu, relabund, one_of(rownames(labeled_mean_signif_RelRSPwk22_otu_matrix)))

#phyRabTRTwk22rem_ggplot <- gather(phyRelab_TRTGR_RelRSPwk22, phylum, relabund, one_of(row.names(mean_phylum_matrix)[abundant]))
rank <- as.character(levels(tax_mean_signif_RelRSPwk22_otu_matrix$Label))
otuRabRelRSPwk22_ggplot$otu <- factor(otuRabRelRSPwk22_ggplot$otu, levels = rank, labels= rank)  #order the subset dataset by the median abundances
otuRabRelRSPwk22_ggplot <- otuRabRelRSPwk22_ggplot[order(otuRabRelRSPwk22_ggplot$otu),]
tail(colnames(otuRabRelRSPwk22_ggplot))

tiff('figures/RelRSPwk22byotu.tiff')
ggplot(otuRabRelRSPwk22_ggplot, aes(x=RelRSPwk22, y=relabund, fill=otu)) +
	stat_summary(fun.y=median, geom="point", aes(fill = otu), position = position_dodge(1)) +
	#stat_summary(fun.data = 'median_hilow', fun.args = (conf.int=0.5), position = position_dodge(1), geom='errorbar', aes(color = otu))+
	geom_jitter(aes(col=otu), position=position_dodge(width = 1), alpha = .4)
dev.off()
#######

tiff('figures/RelRSPwk22facetotu.tiff', width = 14, height= 5, units="in", res = 300)
ggplot(otuRabRelRSPwk22_ggplot, aes(x=RelRSPwk22, y=relabund, fill=RelRSPwk22)) + facet_grid(. ~ otu) +
	#stat_summary(fun.y=median, geom="point", aes(fill = otu), position = position_dodge(1)) +
	#stat_summary(fun.data = 'median_hilow', fun.args = (conf.int=0.5), position = position_dodge(1), geom='errorbar', aes(color = otu))+
	geom_boxplot(position=position_dodge(width = 1), alpha = .4) + scale_y_log10() + guides(fill=FALSE) + theme(strip.text = element_text(face = "italic")) +
	ylab("Relative Abundance (%)") + xlab("Week 22 Response") + theme(legend.position="none")

dev.off()

#######plot attempt
tax<-read.table("../data/Jan400.simple.taxonomy.txt", header=T, sep='\t')


#Abundance stripchart of sig dif otus by RelRSPwk22
oturf_otus  <- as.character(ordered(tax_mean_signif_RelRSPwk22_otu_matrix$OTU))
#oturf_otus <- oturf_otus[1:10]
#oturf_otus
no_abunds <- screen_data[screen_data$RelRSPwk22=='No', oturf_otus]/10000 + 1e-5
no_abunds <-na.omit(no_abunds)
yes_abunds <- screen_data[screen_data$RelRSPwk22=='Yes', oturf_otus]/10000 + 1e-5
yes_abunds<- na.omit(yes_abunds)

#tiff('figures/basesigOTUabund.tiff')
#layout(1)
par(mar=c(4, 12, 2, 1))
plot(1, type="n", ylim=c(0,length(oturf_otus )*2), xlim=c(1e-5,3), log="x", ylab="", xlab="Relative Abundance (%)", xaxt="n", yaxt="n")
#title('Abundance of Top OTUs from Microbiome Model')
set.seed(32016)
index <- 1
for(i in oturf_otus){
	stripchart(at=index-0.35, jitter(yes_abunds[,i], amount=1e-6), pch=21, bg=alpha("royalblue1", alpha=0.25), method="jitter", jitter=0.2, add=T, cex=1, lwd=0.5)
	stripchart(at=index+0.35, jitter(no_abunds[,i], amount=1e-6), pch=21, bg=alpha("orange", alpha=0.25), method="jitter", jitter=0.2, add=T, cex=1, lwd=0.5)
	segments(median(yes_abunds[,i]),index-0.7,median(yes_abunds[,i]),index, lwd=3)
	segments(median(no_abunds[,i]),index+0.7,median(no_abunds[,i]),index, lwd=3)
	index <- index + 2
}
#oturf_otus
rf_tax<-data.frame(oturf_otus)
colnames(rf_tax) <- c('OTU')

oturf_tax<-merge(rf_tax, tax, by='OTU')
lab <- levels(oturf_tax$tax)
oturf_tax$Classification <- gsub("(OTU\\d+)", "(\\1)", oturf_tax$Classification)

oturf_tax<-oturf_tax[match(rf_tax$OTU, oturf_tax$OTU),]
oturf_name<-as.character(oturf_tax$tax)
oturf_numb<-oturf_tax$Classification
#oturf_tax <- gsub("_", " ", oturf_tax)
formatted <- lapply(1:nrow(oturf_tax), function(i) bquote(paste(italic(.(oturf_name[i])), .(oturf_numb[i]), sep=" ")))

axis(2, at=seq(1,index-2,2), labels=do.call(expression, formatted), font =3, las=1, line=0, tick=F, cex.axis=0.8)
axis(1, at=c(1e-5, 1e-4, 1e-3, 1e-2, 1e-1), label=c("0", "0.01", "0.1", "1", "10"))
legend('topright', legend=c("Response Week 22 No", "Response Week 22 Yes"), pch=c(21, 21), pt.bg=c("orange","royalblue1"), cex=0.7)
#mtext('B', at=1e-8, side=3, line=0.1, font=2, cex=2)
#dev.off()

