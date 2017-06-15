source('../code/otu.analysis.R')

#significant otus
tax_median_otu_REMISSwk6_matrix <- merge(tax, median_trtd.otu_REMISSwk6_matrix, by.x = "OTU", by.y="row.names")
sig_REMISSwk6_wilcox_trtd.otu_adj_p_otus <- rownames(median_trtd.otu_REMISSwk6_matrix)[sig_REMISSwk6_wilcox_trtd.otu_adj_p]
median_signif_REMISSwk6_trtd.otu_matrix <- median_trtd.otu_REMISSwk6_matrix[sig_REMISSwk6_wilcox_trtd.otu_adj_p_otus,]
tax_median_signif_REMISSwk6_trtd.otu_matrix <- merge(tax, median_signif_REMISSwk6_trtd.otu_matrix, by.x = "OTU", by.y="row.names")
tax_median_signif_REMISSwk6_trtd.otu_matrix$diff <- tax_median_signif_REMISSwk6_trtd.otu_matrix$No-tax_median_signif_REMISSwk6_trtd.otu_matrix$Yes
tax_median_signif_REMISSwk6_trtd.otu_matrix <-data.frame(tax_median_signif_REMISSwk6_trtd.otu_matrix[tax_median_signif_REMISSwk6_trtd.otu_matrix$diff!=0,])
tax_median_signif_REMISSwk6_trtd.otu_matrix <-tax_median_signif_REMISSwk6_trtd.otu_matrix[abs(tax_median_signif_REMISSwk6_trtd.otu_matrix$diff) >= 0.013,]
tax_median_signif_REMISSwk6_trtd.otu_matrix$Label <- factor(tax_median_signif_REMISSwk6_trtd.otu_matrix$Label, levels = as.character(tax_median_signif_REMISSwk6_trtd.otu_matrix$Label), labels= as.character(tax_median_signif_REMISSwk6_trtd.otu_matrix$Label))
tax_median_signif_REMISSwk6_trtd.otu_matrix$OTU <- factor(tax_median_signif_REMISSwk6_trtd.otu_matrix$OTU, levels = as.character(tax_median_signif_REMISSwk6_trtd.otu_matrix$OTU), labels= as.character(tax_median_signif_REMISSwk6_trtd.otu_matrix$OTU))

tax<-read.table("../data/Jan400.simple.taxonomy.txt", header=T, sep='\t')
 

#Abundance stripchart of sig dif otus by REMISSwk6
oturf_otus  <- as.character(ordered(tax_median_signif_REMISSwk6_trtd.otu_matrix$OTU))
no_abunds <- trtd.screen_data[trtd.screen_data$REMISSwk6=='No', oturf_otus]/10000 + 1e-5
no_abunds <-na.omit(no_abunds)
yes_abunds <- trtd.screen_data[trtd.screen_data$REMISSwk6=='Yes', oturf_otus]/10000 + 1e-5
yes_abunds<- na.omit(yes_abunds)

#tiff('figures/basesigOTUabund.REMISSwk6.tiff', height = 6, width = 8, units = "in", res = 300)
pdf('figures/Figure3_basesigOTUabund.REMISSwk6.pdf', height = 6, width = 8)
layout(1)
par(mar=c(4, 12, 2, 1))
plot(1, type="n", ylim=c(0,length(oturf_otus )*2), xlim=c(1e-5,3), log="x", ylab="", xlab="Week 0 Relative Abundance (%)", xaxt="n", yaxt="n")
set.seed(32016)
index <- 1
for(i in oturf_otus){
	stripchart(at=index-0.35, jitter(yes_abunds[,i], amount=1e-6), pch=21, bg=alpha("royalblue1", alpha=0.5), method="jitter", jitter=0.2, add=T, cex=1, lwd=0.5)
	stripchart(at=index+0.35, jitter(no_abunds[,i], amount=1e-6), pch=21, bg=alpha("orange", alpha=0.5), method="jitter", jitter=0.2, add=T, cex=1, lwd=0.5)
	segments(median(yes_abunds[,i]),index-0.7,median(yes_abunds[,i]),index-0.1, lwd=6, col = "black", lty = "solid")
	segments(median(no_abunds[,i]),index+0.7,median(no_abunds[,i]),index+0.1, lwd=6, col = "black", lty = "solid")
	index <- index + 2
}
rf_tax<-data.frame(oturf_otus)
colnames(rf_tax) <- c('OTU')

oturf_tax<-merge(rf_tax, tax, by='OTU')
lab <- levels(oturf_tax$tax)
oturf_tax$Classification <- gsub("(OTU\\d+)", "(\\1)", oturf_tax$Classification)

oturf_tax<-oturf_tax[match(rf_tax$OTU, oturf_tax$OTU),]
oturf_name<-as.character(oturf_tax$tax)
oturf_numb<-oturf_tax$Classification
formatted <- lapply(1:nrow(oturf_tax), function(i) bquote(paste(italic(.(oturf_name[i])), .(oturf_numb[i]), sep=" ")))

axis(2, at=seq(1,index-2,2), labels=do.call(expression, formatted), font =3, las=1, line=0, tick=F, cex.axis=1)
axis(1, at=c(1e-5, 1e-4, 1e-3, 1e-2, 1e-1, 1e0), label=c("0", "0.01", "0.1", "1", "10", "100"))
legend('topright', legend=c("Week 6 Active CD", "Week 6 Remission"), pch=c(21, 21), pt.bg=c("orange","royalblue1"), cex=1)
dev.off()

