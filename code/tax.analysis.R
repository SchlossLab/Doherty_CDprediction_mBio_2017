

taxonomy <- read.table("../data/Jan400.an.cons.taxonomy", header=T, stringsAsFactors = F)

#taxonomy$simpTax <- gsub("(\\w+[()\\d+[)]]);(\\w+[()\\d+[)]]);(\\w+[()\\d+[)]]);(\\w+[()\\d+[)]]);(\\w+[()\\d+[)]]);(\\w+[()\\d+[)]]);", "\\2", taxonomy$Taxonomy)


taxonomy$phylum <- gsub("(\\w+)[(]\\d+[)];(\\w+)[(]\\d+[)];(\\w+)[(]\\d+[)];(\\w+)[(]\\d+[)];(\\w+)[(]\\d+[)];(\\w+/*\\w+)[(]\\d+[)];", "\\2", taxonomy$Taxonomy)

taxonomy$genus <- gsub("(\\w+)[(]\\d+[)];(\\w+)[(]\\d+[)];(\\w+)[(]\\d+[)];(\\w+)[(]\\d+[)];(\\w+)[(]\\d+[)];(\\w+/*\\w+)[(]\\d+[)];", "\\6", taxonomy$Taxonomy)

head(taxonomy)

tax_no_confidence <- gsub(pattern="\\(\\d*\\)", replacement="", x=taxonomy$Taxonomy)

no_unclassified <- gsub(pattern="unclassified;", replacement="", tax_no_confidence)
best_taxonomy <- gsub(pattern=".*;(.*);", replacement="\\1", no_unclassified)

otu_name <- best_taxonomy
names(otu_name) <- taxonomy$OTU

phylum <- gsub("Bacteria;([^;]*);.*", "\\1", tax_no_confidence)
otu_phylum <- data.frame(otu = taxonomy$OTU, phylum = phylum, stringsAsFactors=F)

screen_data_otus <- screen_data[, c("group", colnames(screen_data)[grep('Otu[0123456789]', colnames(screen_data))])]


otu_phylum_overlap <- otu_phylum[otu_phylum$otu %in% colnames(screen_data_otus), ]
stopifnot(nrow(otu_phylum_overlap) == ncol(screen_data_otus[,-1]))

phylum_names <- unique(otu_phylum_overlap$phylum)

otu_numbers <- colnames(screen_data_otus)
	
n_phyla <- length(phylum_names)
n_samp <- nrow(screen_data_otus)
all_phylum_shared <- data.frame(matrix(0, nrow=n_samp, ncol=n_phyla))
rownames(all_phylum_shared) <- screen_data_otus$group
colnames(all_phylum_shared) <- phylum_names




for (phylum in phylum_names){
	phylum_otus <- otu_phylum_overlap[otu_phylum_overlap$phylum == phylum, 'otu']
	phylum_shared <- screen_data_otus[,phylum_otus]
	
	if(length(phylum_otus) > 1){
		#sum over rows (row sum), use 1, sum over columns 2
		phylum_count <- apply(phylum_shared, 1, sum)
	} else {
		phylum_count <- phylum_shared
	}
	
	all_phylum_shared[,phylum] <- phylum_count
}

nseqs <- apply(all_phylum_shared, 1, sum)

phylum_rel_abund <- all_phylum_shared / nseqs[1]

total_mean_rabund <- apply(phylum_rel_abund, 2, mean)
#mean_phylum <- aggregate(phylum_rel_abund, by=list(screen_data$REMISSwk6), mean)

mean_rel_abund <- aggregate(phylum_rel_abund, by=list(screen_data$TRT_REMwk6), mean)
decreasing_order <- order(total_mean_rabund, decreasing=T)
phylum_rel_abund <- phylum_rel_abund[,decreasing_order]

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
mean_abundant_phylum_matrix <- mean_phylum_matrix[abundant, ]
sd_abundant_phylum_matrix <- sd_phylum_matrix[abundant, ]
median_abundant_phylum_matrix <- median_phylum_matrix[abundant, ]

phylum_p <- numeric() 
for(phylum in phylum_names){
	phylum_p[phylum] <- kruskal.test(phylum_rel_abund[,phylum] ~screen_data$REMISSwk6)$p.value
}


phylum_pMCT <- data.frame(Comparison = rownames(test), stringsAsFactors = T)

#phylum_pMCT$comparison <- rownames(test)
for(phylum in phylum_names){
	phylum_pMCT[phylum] <- kruskalmc(phylum_rel_abund[[phylum]]~screen_data$TRT_REMwk6)$dif.com[,3]
	phylum_pMCT <- cbind(phylum_pMCT,phylum_pMCT[phylum])
}

kruskalmc(phylum_rel_abund$Bacteroidetes~screen_data$REMISSwk6)

test<-kruskalmc(phylum_rel_abund$Bacteroidetes~screen_data$TRT_REMwk6)$dif.com



phylum_adj_p <- p.adjust(phylum_p, method="BH") 
phylum_adj_p < 0.05

#stripcharts
ab_relabund <- phylum_rel_abund[,abundant]
layout(1)
plot(NA, ylim = c(0,1), xlim=c(1,30), ylab = "Relative Abundance (%)", xlab = "", axes = F)
start <- 2
for(phylum in colnames(ab_relabund)){
	stripchart(ab_relabund[,phylum] ~ screen_data$TRT_REMwk6,
						 vertical = T,
						 method='jitter', jitter= 0.3,
						 col=alpha(c("blue", "red"), 0.25), pch=c(21, 21, 24, 24),
						 axes=F, at=start:(start+3), add = T)
	segments(x0= (start:(start+3))-0.5,y0=median_abundant_phylum_matrix[phylum,] ,x1=(start:(start+3))+0.5 ,y1=median_abundant_phylum_matrix[phylum,] ,lwd=2)
	start <- start + 5
}
#segments(mean(yes_abunds[,i]),index-0.7,mean(yes_abunds[,i]),index, lwd=3)
#axis(1, las=2, crt=45, labels=colnames(ab_relabund)[1:5], at=c(2,6,10, 14,18), tick=F, cex.axis=0.5, line=-1)
text(x=c(3, 8, 13, 18, 23, 28)-0.5, y=-0.4, srt = 45, adj= 0, xpd = TRUE,
		 labels = paste(colnames(ab_relabund[1:6])), cex=1, font=3)
axis(2, las=2)
box()
legend(x=13, y=1, legend=c("No", "Yes","No", "Yes"), pch=c(21, 21, 24, 24), col=c("blue", "red"))


bp <- barplot(t(mean_abundant_phylum_matrix), beside=T, col=c("blue", "red"), ylab="Relative Abundance", ylim=c(0,0.9))

arrows(x0=bp, y0=t(mean_abundant_phylum_matrix), y1=t(mean_abundant_phylum_matrix+sd_abundant_phylum_matrix), angle=90, length=0.1)
box()
barplot(mean_phylum_matrix, beside=F, col=rainbow(n=nrow(mean_phylum_matrix)), ylab="Relative Abundance")
box()

barplot(mean_abundant_phylum_matrix,
				beside=T,
				col=c("red", "orange", "yellow", "green", "blue", "violet"),
				names.arg=colnames(mean_abundant_phylum_matrix),
				legend=T, 
				ylab="Relative Abundance")

box()

cbind(data.frame(mean_abundant_phylum_matrix, phylum = row.names(mean_abundant_phylum_matrix)) 
			%>% gather(treatment, relabund, -phylum)) %>%  ggplot(aes(x=treatment))



barplot(median_abundant_phylum_matrix, beside=T, col=c("red", "orange", "yellow", "green", "blue", "violet"), names.arg=colnames(median_abundant_phylum_matrix), legend=T, ylab="Relative Abundance")
box()

summary(mean_abundant_phylum_matrix)
barplot(t(median_abundant_phylum_matrix), beside=T, col=c("blue", "red"), ylab="Relative Abundance")
box()


plot(NA, ylim=c(0,1), xlim=c(1,30), ylab="Relative Abundance", xlab="", axes=F)
boxplot(phylum_rel_abund[,1]~screen_data$TRT_REMwk6, at=1:4, names=F, add=T, axes=F, col=c("blue", "red"))
boxplot(phylum_rel_abund[,2]~screen_data$TRT_REMwk6, at=6:9, names=F, add=T, axes=F, col=c("blue", "red"))
boxplot(phylum_rel_abund[,3]~screen_data$TRT_REMwk6, at=11:14, names=F, add=T, axes=F, col=c("blue", "red"))
boxplot(phylum_rel_abund[,4]~screen_data$TRT_REMwk6, at=16:19, names=F, add=T, axes=F, col=c("blue", "red"))
boxplot(phylum_rel_abund[,5]~screen_data$TRT_REMwk6, at=21:24, names=F, add=T, axes=F, col=c("blue", "red"))
boxplot(phylum_rel_abund[,6]~screen_data$TRT_REMwk6, at=26:29, names=F, add=T, axes=F, col=c("blue", "red"))
axis(1, labels=colnames(phylum_rel_abund)[1:6], at=c(2,7,12,17,22, 27), tick=F, cex.axis=0.5, line=-1)
axis(2, las=2)
box()

text(x=6, y=0.8, label="*", cex=4)
segments(x0=5, x1=7, y0=0.9, y1=0.9, lwd=2)


