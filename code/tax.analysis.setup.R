

taxonomy <- read.table("../data/Jan400.an.cons.taxonomy", header=T, stringsAsFactors = F)

#taxonomy$simpTax <- gsub("(\\w+[()\\d+[)]]);(\\w+[()\\d+[)]]);(\\w+[()\\d+[)]]);(\\w+[()\\d+[)]]);(\\w+[()\\d+[)]]);(\\w+[()\\d+[)]]);", "\\2", taxonomy$Taxonomy)


taxonomy$phylum <- gsub("(\\w+)[(]\\d+[)];(\\w+)[(]\\d+[)];(\\w+)[(]\\d+[)];(\\w+)[(]\\d+[)];(\\w+)[(]\\d+[)];(\\w+/*\\w+)[(]\\d+[)];", "\\2", taxonomy$Taxonomy)
taxonomy$class <- gsub("(\\w+)[(]\\d+[)];(\\w+)[(]\\d+[)];(\\w+)[(]\\d+[)];(\\w+)[(]\\d+[)];(\\w+)[(]\\d+[)];(\\w+/*\\w+)[(]\\d+[)];", "\\3", taxonomy$Taxonomy)
taxonomy$order <- gsub("(\\w+)[(]\\d+[)];(\\w+)[(]\\d+[)];(\\w+)[(]\\d+[)];(\\w+)[(]\\d+[)];(\\w+)[(]\\d+[)];(\\w+/*\\w+)[(]\\d+[)];", "\\4", taxonomy$Taxonomy)
taxonomy$family <- gsub("(\\w+)[(]\\d+[)];(\\w+)[(]\\d+[)];(\\w+)[(]\\d+[)];(\\w+)[(]\\d+[)];(\\w+)[(]\\d+[)];(\\w+/*\\w+)[(]\\d+[)];", "\\5", taxonomy$Taxonomy)
taxonomy$genus <- gsub("(\\w+)[(]\\d+[)];(\\w+)[(]\\d+[)];(\\w+)[(]\\d+[)];(\\w+)[(]\\d+[)];(\\w+)[(]\\d+[)];(\\w+/*\\w+)[(]\\d+[)];", "\\6", taxonomy$Taxonomy)

head(taxonomy)

tax_no_confidence <- gsub(pattern="\\(\\d*\\)", replacement="", x=taxonomy$Taxonomy)

no_unclassified <- gsub(pattern="unclassified;", replacement="", tax_no_confidence)


best_taxonomy <- gsub(pattern=".*;(.*);", replacement="\\1", no_unclassified)

otu_name <- best_taxonomy
names(otu_name) <- taxonomy$OTU

phylum <- gsub("Bacteria;([^;]*);([^;]*);([^;]*);([^;]*);([^;]*).*", "\\1", tax_no_confidence)
class <- gsub("Bacteria;([^;]*);([^;]*);([^;]*);([^;]*);([^;]*).*", "\\2", tax_no_confidence)
order <- gsub("Bacteria;([^;]*);([^;]*);([^;]*);([^;]*);([^;]*).*", "\\3", tax_no_confidence)
family <- gsub("Bacteria;([^;]*);([^;]*);([^;]*);([^;]*);([^;]*).*", "\\4", tax_no_confidence)


otu_phylum <- data.frame(otu = taxonomy$OTU, phylum = phylum, stringsAsFactors=F)
otu_class <- data.frame(otu = taxonomy$OTU, class = class, stringsAsFactors=F)
otu_order <- data.frame(otu = taxonomy$OTU, order = order, stringsAsFactors=F)
otu_family <- data.frame(otu = taxonomy$OTU, family = family, stringsAsFactors=F)

screen_data_otus <- screen_data[, c("group", colnames(screen_data)[grep('Otu[0123456789]', colnames(screen_data))])]
rownames(screen_data_otus) <- screen_data_otus$group
screen_data_otunum <- screen_data_otus[,-1]
otu_numbers <- colnames(screen_data_otunum)
nseqs <- apply(screen_data_otus[,-1], 1, sum)

otu_phylum_overlap <- otu_phylum[otu_phylum$otu %in% colnames(screen_data_otus), ]
otu_class_overlap <- otu_class[otu_class$otu %in% colnames(screen_data_otus), ]
otu_order_overlap <- otu_order[otu_order$otu %in% colnames(screen_data_otus), ]
otu_family_overlap <- otu_family[otu_family$otu %in% colnames(screen_data_otus), ]

stopifnot(nrow(otu_phylum_overlap) == ncol(screen_data_otus[,-1]))
stopifnot(nrow(otu_class_overlap) == ncol(screen_data_otus[,-1]))
stopifnot(nrow(otu_order_overlap) == ncol(screen_data_otus[,-1]))
stopifnot(nrow(otu_family_overlap) == ncol(screen_data_otus[,-1]))

phylum_names <- unique(otu_phylum_overlap$phylum)
class_names <- unique(otu_class_overlap$class)
order_names <- unique(otu_order_overlap$order)
family_names <- unique(otu_family_overlap$family)

							 
n_phyla <- length(phylum_names)
n_classes <- length(class_names)
n_orders <- length(order_names)
n_families <- length(family_names)



n_samp <- nrow(screen_data_otus)
all_phylum_shared <- data.frame(matrix(0, nrow=n_samp, ncol=n_phyla))
rownames(all_phylum_shared) <- rownames(screen_data_otus)
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

phylum_rel_abund <- all_phylum_shared / nseqs[1]*100


all_class_shared <- data.frame(matrix(0, nrow=n_samp, ncol=n_classes))
rownames(all_class_shared) <- screen_data_otus$group
colnames(all_class_shared) <- class_names

for (class in class_names){
	class_otus <- otu_class_overlap[otu_class_overlap$class == class, 'otu']
	class_shared <- screen_data_otus[,class_otus]
	
	if(length(class_otus) > 1){
		#sum over rows (row sum), use 1, sum over columns 2
		class_count <- apply(class_shared, 1, sum)
	} else {
		class_count <- class_shared
	}
	
	all_class_shared[,class] <- class_count
}

nseqs <- apply(all_class_shared, 1, sum)

class_rel_abund <- all_class_shared / nseqs[1]*100

all_order_shared <- data.frame(matrix(0, nrow=n_samp, ncol=n_orders))
rownames(all_order_shared) <- screen_data_otus$group
colnames(all_order_shared) <- order_names

for (order in order_names){
	order_otus <- otu_order_overlap[otu_order_overlap$order == order, 'otu']
	order_shared <- screen_data_otus[,order_otus]
	
	if(length(order_otus) > 1){
		#sum over rows (row sum), use 1, sum over columns 2
		order_count <- apply(order_shared, 1, sum)
	} else {
		order_count <- order_shared
	}
	
	all_order_shared[,order] <- order_count
}

nseqs <- apply(all_order_shared, 1, sum)

order_rel_abund <- all_order_shared / nseqs[1] *100

all_family_shared <- data.frame(matrix(0, nrow=n_samp, ncol=n_families))
rownames(all_family_shared) <- screen_data_otus$group
colnames(all_family_shared) <- family_names
for (family in family_names){
	family_otus <- otu_family_overlap[otu_family_overlap$family == family, 'otu']
	family_shared <- screen_data_otus[,family_otus]
	
	if(length(family_otus) > 1){
		#sum over rows (row sum), use 1, sum over columns 2
		family_count <- apply(family_shared, 1, sum)
	} else {
		family_count <- family_shared
	}
	
	all_family_shared[,family] <- family_count
}

nseqs <- apply(all_family_shared, 1, sum)

family_rel_abund <- all_family_shared / nseqs[1]



otu_rel_abund <- screen_data_otus[,-1] / nseqs[1]*100


trtgr <- subset(screen_data, select = c(group, TRTGR))
REMISSwk6 <- subset(screen_data, select = c(group, REMISSwk6))
RelRSPwk6 <- subset(screen_data, select = c(group, RelRSPwk6))
TRTGR_REMISSwk6 <- subset(screen_data, select = c(group, TRTGR_REMISSwk6))
TRTGR_RelRSPwk6 <- subset(screen_data, select = c(group, TRTGR_RelRSPwk6))

phyRelab_REMISSwk6 <- merge(REMISSwk6, phylum_rel_abund, by.y = "row.names", by.x="group")
claRelab_REMISSwk6 <- merge(REMISSwk6, class_rel_abund, by.y = "row.names", by.x="group")
ordRelab_REMISSwk6 <- merge(REMISSwk6, order_rel_abund, by.y = "row.names", by.x="group")
famRelab_REMISSwk6 <- merge(REMISSwk6, family_rel_abund, by.y = "row.names", by.x="group")
otu_relab_REMISSwk6 <- merge(REMISSwk6, otu_rel_abund, by.y = "row.names", by.x="group")


phyRelab_RelRSPwk6 <- merge(RelRSPwk6, phylum_rel_abund, by.y = "row.names", by.x="group")
claRelab_RelRSPwk6 <- merge(RelRSPwk6, class_rel_abund, by.y = "row.names", by.x="group")
ordRelab_RelRSPwk6 <- merge(RelRSPwk6, order_rel_abund, by.y = "row.names", by.x="group")
famRelab_RelRSPwk6 <- merge(RelRSPwk6, family_rel_abund, by.y = "row.names", by.x="group")
otuRelab_RelRSPwk6 <- merge(RelRSPwk6, otu_rel_abund, by.y = "row.names", by.x="group")

phyRelab_TRTGR_REMISSwk6 <- merge(TRTGR_REMISSwk6, phylum_rel_abund, by.y = "row.names", by.x="group")
claRelab_TRTGR_REMISSwk6 <- merge(TRTGR_REMISSwk6, class_rel_abund, by.y = "row.names", by.x="group")
ordRelab_TRTGR_REMISSwk6 <- merge(TRTGR_REMISSwk6, order_rel_abund, by.y = "row.names", by.x="group")
famRelab_TRTGR_REMISSwk6 <- merge(TRTGR_REMISSwk6, family_rel_abund, by.y = "row.names", by.x="group")
otuRelab_TRTGR_REMISSwk6 <- merge(TRTGR_RelRSPwk6, otu_rel_abund, by.y = "row.names", by.x="group")

phyRelab_TRTGR_RelRSPwk6 <- merge(TRTGR_RelRSPwk6, phylum_rel_abund, by.y = "row.names", by.x="group")
claRelab_TRTGR_RelRSPwk6 <- merge(TRTGR_RelRSPwk6, class_rel_abund, by.y = "row.names", by.x="group")
ordRelab_TRTGR_RelRSPwk6 <- merge(TRTGR_RelRSPwk6, order_rel_abund, by.y = "row.names", by.x="group")
famRelab_TRTGR_RelRSPwk6 <- merge(TRTGR_RelRSPwk6, family_rel_abund, by.y = "row.names", by.x="group")
otuRelab_TRTGR_RelRSPwk6 <- merge(TRTGR_RelRSPwk6, otu_rel_abund, by.y = "row.names", by.x="group")

REMISSwk22 <- subset(screen_data, select = c(group, REMISSwk22))
RelRSPwk22 <- subset(screen_data, select = c(group, RelRSPwk22))
TRTGR_REMISSwk22 <- subset(screen_data, select = c(group, TRTGR_REMISSwk22))
TRTGR_RelRSPwk22 <- subset(screen_data, select = c(group, TRTGR_RelRSPwk22))

phyRelab_REMISSwk22 <- merge(REMISSwk22, phylum_rel_abund, by.y = "row.names", by.x="group")
claRelab_REMISSwk22 <- merge(REMISSwk22, class_rel_abund, by.y = "row.names", by.x="group")
ordRelab_REMISSwk22 <- merge(REMISSwk22, order_rel_abund, by.y = "row.names", by.x="group")
famRelab_REMISSwk22 <- merge(REMISSwk22, family_rel_abund, by.y = "row.names", by.x="group")
otu_relab_REMISSwk22 <- merge(REMISSwk22, otu_rel_abund, by.y = "row.names", by.x="group")


phyRelab_RelRSPwk22 <- merge(RelRSPwk22, phylum_rel_abund, by.y = "row.names", by.x="group")
claRelab_RelRSPwk22 <- merge(RelRSPwk22, class_rel_abund, by.y = "row.names", by.x="group")
ordRelab_RelRSPwk22 <- merge(RelRSPwk22, order_rel_abund, by.y = "row.names", by.x="group")
famRelab_RelRSPwk22 <- merge(RelRSPwk22, family_rel_abund, by.y = "row.names", by.x="group")
otuRelab_RelRSPwk22 <- merge(RelRSPwk22, otu_rel_abund, by.y = "row.names", by.x="group")

phyRelab_TRTGR_REMISSwk22 <- merge(TRTGR_REMISSwk22, phylum_rel_abund, by.y = "row.names", by.x="group")
claRelab_TRTGR_REMISSwk22 <- merge(TRTGR_REMISSwk22, class_rel_abund, by.y = "row.names", by.x="group")
ordRelab_TRTGR_REMISSwk22 <- merge(TRTGR_REMISSwk22, order_rel_abund, by.y = "row.names", by.x="group")
famRelab_TRTGR_REMISSwk22 <- merge(TRTGR_REMISSwk22, family_rel_abund, by.y = "row.names", by.x="group")
otuRelab_TRTGR_REMISSwk22 <- merge(TRTGR_RelRSPwk22, otu_rel_abund, by.y = "row.names", by.x="group")

phyRelab_TRTGR_RelRSPwk22 <- merge(TRTGR_RelRSPwk22, phylum_rel_abund, by.y = "row.names", by.x="group")
claRelab_TRTGR_RelRSPwk22 <- merge(TRTGR_RelRSPwk22, class_rel_abund, by.y = "row.names", by.x="group")
ordRelab_TRTGR_RelRSPwk22 <- merge(TRTGR_RelRSPwk22, order_rel_abund, by.y = "row.names", by.x="group")
famRelab_TRTGR_RelRSPwk22 <- merge(TRTGR_RelRSPwk22, family_rel_abund, by.y = "row.names", by.x="group")
otuRelab_TRTGR_RelRSPwk22 <- merge(TRTGR_RelRSPwk22, otu_rel_abund, by.y = "row.names", by.x="group")

