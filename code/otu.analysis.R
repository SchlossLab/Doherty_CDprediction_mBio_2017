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

rownames(screen_data_otus) <- screen_data_otus$group
screen_data_otus <- screen_data_otus[,-1]

otu_phylum_overlap <- otu_phylum[otu_phylum$otu %in% colnames(screen_data_otus), ]
stopifnot(nrow(otu_phylum_overlap) == ncol(screen_data_otus))

phylum_names <- unique(otu_phylum_overlap$phylum)

otu_numbers <- colnames(screen_data_otus)

nseqs <- apply(screen_data_otus, 1, sum)

otu_rel_abund <- screen_data_otus / nseqs[1]

totalotu_mean_rabund <- apply(otu_rel_abund, 2, mean)

abundant <- apply(mean_otu_matrix, 1, mean) > 0.005


mean_rel_abund <- aggregate(otu_rel_abund, by=list(screen_data$TRT_REMwk6), mean)
#decreasing_order <- order(total_mean_rabund, decreasing=T)
#otu_rel_abund <- otu_rel_abund[,decreasing_order]

mean_otu <- aggregate(otu_rel_abund, by=list(screen_data$TRTGR, screen_data$REMISSwk6), mean)
mean_otu$TRTGRrem <- paste(mean_otu$Group.1, mean_otu$Group.2)
mean_otu_matrix <- subset(mean_otu, select=-c(TRTGRrem))
mean_otu_matrix <- as.matrix(t(subset(mean_otu_matrix, select=-c(1:2))))
colnames(mean_otu_matrix) <- mean_otu$TRTGRrem

median_otu <- aggregate(otu_rel_abund, by=list(screen_data$TRTGR, screen_data$REMISSwk6), median)
median_otu$TRTGRrem <- paste(median_otu$Group.1, median_otu$Group.2)
median_otu_matrix <- subset(median_otu, select=-c(TRTGRrem))
median_otu_matrix <- as.matrix(t(subset(median_otu_matrix, select=-c(1:2))))
colnames(median_otu_matrix) <- median_otu$TRTGRrem



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

abundant <- apply(mean_otu_matrix, 1, mean) > 0.005
mean_abundant_otu_matrix <- mean_otu_matrix[abundant, ]
sd_abundant_otu_matrix <- sd_otu_matrix[abundant, ]
median_abundant_otu_matrix <- median_otu_matrix[abundant, ]




otu_p <- numeric() 
for(otu in otu_numbers){
	otu_p[otu] <- kruskal.test(otu_rel_abund[,otu] ~screen_data$REMISSwk6)$p.value
}

ktt<-kruskal.test(otu_rel_abund$Otu00001 ~ screen_data$REMISSwk6)$p.value

test<-kruskalmc(screen_data$Otu00001~screen_data$TRT_REMwk6)$dif.com
OTU_pMCT <- data.frame(Comparison = rownames(test), stringsAsFactors = T)




otu_p <- numeric() 
for(otu in otu_names){
	otu_p[otu] <- kruskal.test(otu_rel_abund[,otu] ~screen_data$REMISSwk6)$p.value
}


otu_pMCT <- data.frame(Comparison = rownames(test), stringsAsFactors = T)

#otu_pMCT$comparison <- rownames(test)
for(otu in otu_names){
	otu_pMCT[otu] <- kruskalmc(otu_rel_abund[[otu]]~screen_data$TRT_REMwk6)$dif.com[,3]
	otu_pMCT <- cbind(otu_pMCT,otu_pMCT[otu])
}

kruskalmc(otu_rel_abund$Bacteroidetes~screen_data$REMISSwk6)

test<-kruskalmc(otu_rel_abund$Bacteroidetes~screen_data$TRT_REMwk6)$dif.com



otu_adj_p <- p.adjust(otu_p, method="BH") 
otu_adj_p < 0.05




#phylum_pMCT$comparison <- rownames(test)
for(otu in otu_numbers){
	otu_pMCT[otu] <- kruskalmc(otu_rel_abund[,otu]~screen_data$TRT_REMwk6)$dif.com[,3]
	otu_pMCT <- cbind(otu_pMCT,otu_pMCT[otu])
}

otu_numbers
colnames(otu_rel_abund)

kruskalmc(otu_rel_abund$Bacteroidetes~screen_data$REMISSwk6)

mean_rel_abund <- aggregate(otu_rel_abund, by=list(screen_data$TRT_REMwk6), mean)
decreasing_order <- order(total_mean_rabund, decreasing=T)
otu_rel_abund <- otu_rel_abund[,decreasing_order]
