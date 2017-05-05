
trtd.screen_data <- screen_data[screen_data$TRTGR=="Treated",]
plac.screen_data <- screen_data[screen_data$TRTGR=="Placebo",]
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
trtd.screen_data_otus <- trtd.screen_data[, c("group", colnames(trtd.screen_data)[grep('Otu[0123456789]', colnames(trtd.screen_data))])]
plac.screen_data_otus <- plac.screen_data[, c("group", colnames(plac.screen_data)[grep('Otu[0123456789]', colnames(plac.screen_data))])]

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


rownames(trtd.screen_data_otus) <- trtd.screen_data_otus$group
trtd.screen_data_otunum <- trtd.screen_data_otus[,-1]
trtd.otu_numbers <- colnames(trtd.screen_data_otunum)
trtd.nseqs <- apply(trtd.screen_data_otus[,-1], 1, sum)

trtd.otu_phylum_overlap <- otu_phylum[otu_phylum$otu %in% colnames(trtd.screen_data_otus), ]
trtd.otu_class_overlap <- otu_class[otu_class$otu %in% colnames(trtd.screen_data_otus), ]
trtd.otu_order_overlap <- otu_order[otu_order$otu %in% colnames(trtd.screen_data_otus), ]
trtd.otu_family_overlap <- otu_family[otu_family$otu %in% colnames(trtd.screen_data_otus), ]

stopifnot(nrow(trtd.otu_phylum_overlap) == ncol(trtd.screen_data_otus[,-1]))
stopifnot(nrow(trtd.otu_class_overlap) == ncol(trtd.screen_data_otus[,-1]))
stopifnot(nrow(trtd.otu_order_overlap) == ncol(trtd.screen_data_otus[,-1]))
stopifnot(nrow(trtd.otu_family_overlap) == ncol(trtd.screen_data_otus[,-1]))

trtd.phylum_names <- unique(trtd.otu_phylum_overlap$phylum)
trtd.class_names <- unique(trtd.otu_class_overlap$class)
trtd.order_names <- unique(trtd.otu_order_overlap$order)
trtd.family_names <- unique(trtd.otu_family_overlap$family)


trtd.n_phyla <- length(trtd.phylum_names)
trtd.n_classes <- length(trtd.class_names)
trtd.n_orders <- length(trtd.order_names)
trtd.n_families <- length(trtd.family_names)



n_samp <- nrow(trtd.screen_data_otus)
all_trtd.phylum_shared <- data.frame(matrix(0, nrow=n_samp, ncol=n_phyla))
rownames(all_trtd.phylum_shared) <- rownames(trtd.screen_data_otus)
colnames(all_trtd.phylum_shared) <- phylum_names

for (phylum in trtd.phylum_names){
	trtd.phylum_otus <- trtd.otu_phylum_overlap[trtd.otu_phylum_overlap$phylum == phylum, 'otu']
	trtd.phylum_shared <- trtd.screen_data_otus[,trtd.phylum_otus]
	
	if(length(trtd.phylum_otus) > 1){
		#sum over rows (row sum), use 1, sum over columns 2
		trtd.phylum_count <- apply(trtd.phylum_shared, 1, sum)
	} else {
		trtd.phylum_count <- trtd.phylum_shared
	}
	
	all_trtd.phylum_shared[,phylum] <- trtd.phylum_count
}

trtd.nseqs <- apply(all_trtd.phylum_shared, 1, sum)

trtd.phylum_rel_abund <- all_trtd.phylum_shared / trtd.nseqs[1]*100


all_trtd.class_shared <- data.frame(matrix(0, nrow=n_samp, ncol=n_classes))
rownames(all_trtd.class_shared) <- trtd.screen_data_otus$group
colnames(all_trtd.class_shared) <- trtd.class_names

for (class in trtd.class_names){
	trtd.class_otus <- trtd.otu_class_overlap[trtd.otu_class_overlap$class == class, 'otu']
	trtd.class_shared <- trtd.screen_data_otus[,trtd.class_otus]
	
	if(length(trtd.class_otus) > 1){
		#sum over rows (row sum), use 1, sum over columns 2
		trtd.class_count <- apply(trtd.class_shared, 1, sum)
	} else {
		trtd.class_count <- trtd.class_shared
	}
	
	all_trtd.class_shared[,class] <- trtd.class_count
}

trtd.nseqs <- apply(all_trtd.class_shared, 1, sum)

trtd.class_rel_abund <- all_trtd.class_shared / trtd.nseqs[1]*100

all_trtd.order_shared <- data.frame(matrix(0, nrow=n_samp, ncol=n_orders))
rownames(all_trtd.order_shared) <- trtd.screen_data_otus$group
colnames(all_trtd.order_shared) <- trtd.order_names

for (order in trtd.order_names){
	trtd.order_otus <- trtd.otu_order_overlap[trtd.otu_order_overlap$order == order, 'otu']
	trtd.order_shared <- trtd.screen_data_otus[,trtd.order_otus]
	
	if(length(trtd.order_otus) > 1){
		#sum over rows (row sum), use 1, sum over columns 2
		trtd.order_count <- apply(trtd.order_shared, 1, sum)
	} else {
		trtd.order_count <- trtd.order_shared
	}
	
	all_trtd.order_shared[,order] <- trtd.order_count
}

trtd.nseqs <- apply(all_trtd.order_shared, 1, sum)

trtd.order_rel_abund <- all_trtd.order_shared / trtd.nseqs[1] *100

all_trtd.family_shared <- data.frame(matrix(0, nrow=n_samp, ncol=n_families))
rownames(all_trtd.family_shared) <- trtd.screen_data_otus$group
colnames(all_trtd.family_shared) <- trtd.family_names
for (family in trtd.family_names){
	trtd.family_otus <- trtd.otu_family_overlap[trtd.otu_family_overlap$family == family, 'otu']
	trtd.family_shared <- trtd.screen_data_otus[,trtd.family_otus]
	
	if(length(trtd.family_otus) > 1){
		#sum over rows (row sum), use 1, sum over columns 2
		trtd.family_count <- apply(trtd.family_shared, 1, sum)
	} else {
		trtd.family_count <- trtd.family_shared
	}
	
	all_trtd.family_shared[,family] <- trtd.family_count
}

trtd.nseqs <- apply(all_trtd.family_shared, 1, sum)

trtd.family_rel_abund <- all_trtd.family_shared / trtd.nseqs[1]



trtd.otu_rel_abund <- trtd.screen_data_otus[,-1] / trtd.nseqs[1]*100


trtgr <- subset(screen_data, select = c(group, TRTGR))
REMISSwk6 <- subset(screen_data, select = c(group, REMISSwk6))
RelRSPwk6 <- subset(screen_data, select = c(group, RelRSPwk6))
TRTGR_REMISSwk6 <- subset(screen_data, select = c(group, TRTGR_REMISSwk6))
TRTGR_RelRSPwk6 <- subset(screen_data, select = c(group, TRTGR_RelRSPwk6))

trtd.phyRelab_REMISSwk6 <- merge(REMISSwk6, trtd.phylum_rel_abund, by.y = "row.names", by.x="group")
trtd.claRelab_REMISSwk6 <- merge(REMISSwk6, trtd.class_rel_abund, by.y = "row.names", by.x="group")
trtd.ordRelab_REMISSwk6 <- merge(REMISSwk6, trtd.order_rel_abund, by.y = "row.names", by.x="group")
trtd.famRelab_REMISSwk6 <- merge(REMISSwk6, trtd.family_rel_abund, by.y = "row.names", by.x="group")
trtd.otu_relab_REMISSwk6 <- merge(REMISSwk6, trtd.otu_rel_abund, by.y = "row.names", by.x="group")


trtd.phyRelab_RelRSPwk6 <- merge(RelRSPwk6, trtd.phylum_rel_abund, by.y = "row.names", by.x="group")
trtd.claRelab_RelRSPwk6 <- merge(RelRSPwk6, trtd.class_rel_abund, by.y = "row.names", by.x="group")
trtd.ordRelab_RelRSPwk6 <- merge(RelRSPwk6, trtd.order_rel_abund, by.y = "row.names", by.x="group")
trtd.famRelab_RelRSPwk6 <- merge(RelRSPwk6, trtd.family_rel_abund, by.y = "row.names", by.x="group")
trtd.otuRelab_RelRSPwk6 <- merge(RelRSPwk6, trtd.otu_rel_abund, by.y = "row.names", by.x="group")

trtd.phyRelab_TRTGR_REMISSwk6 <- merge(TRTGR_REMISSwk6, trtd.phylum_rel_abund, by.y = "row.names", by.x="group")
trtd.claRelab_TRTGR_REMISSwk6 <- merge(TRTGR_REMISSwk6, trtd.class_rel_abund, by.y = "row.names", by.x="group")
ordRelab_TRTGR_REMISSwk6 <- merge(TRTGR_REMISSwk6, trtd.order_rel_abund, by.y = "row.names", by.x="group")
trtd.famRelab_TRTGR_REMISSwk6 <- merge(TRTGR_REMISSwk6, trtd.family_rel_abund, by.y = "row.names", by.x="group")
trtd.otuRelab_TRTGR_REMISSwk6 <- merge(TRTGR_RelRSPwk6, trtd.otu_rel_abund, by.y = "row.names", by.x="group")

trtd.phyRelab_TRTGR_RelRSPwk6 <- merge(TRTGR_RelRSPwk6, trtd.phylum_rel_abund, by.y = "row.names", by.x="group")
trtd.claRelab_TRTGR_RelRSPwk6 <- merge(TRTGR_RelRSPwk6, trtd.class_rel_abund, by.y = "row.names", by.x="group")
trtd.ordRelab_TRTGR_RelRSPwk6 <- merge(TRTGR_RelRSPwk6, trtd.order_rel_abund, by.y = "row.names", by.x="group")
trtd.famRelab_TRTGR_RelRSPwk6 <- merge(TRTGR_RelRSPwk6, trtd.family_rel_abund, by.y = "row.names", by.x="group")
trtd.otuRelab_TRTGR_RelRSPwk6 <- merge(TRTGR_RelRSPwk6, trtd.otu_rel_abund, by.y = "row.names", by.x="group")

REMISSwk22 <- subset(screen_data, select = c(group, REMISSwk22))
RelRSPwk22 <- subset(screen_data, select = c(group, RelRSPwk22))
TRTGR_REMISSwk22 <- subset(screen_data, select = c(group, TRTGR_REMISSwk22))
TRTGR_RelRSPwk22 <- subset(screen_data, select = c(group, TRTGR_RelRSPwk22))

trtd.phyRelab_REMISSwk22 <- merge(REMISSwk22, trtd.phylum_rel_abund, by.y = "row.names", by.x="group")
trtd.claRelab_REMISSwk22 <- merge(REMISSwk22, trtd.class_rel_abund, by.y = "row.names", by.x="group")
trtd.ordRelab_REMISSwk22 <- merge(REMISSwk22, trtd.order_rel_abund, by.y = "row.names", by.x="group")
trtd.famRelab_REMISSwk22 <- merge(REMISSwk22, trtd.family_rel_abund, by.y = "row.names", by.x="group")
trtd.otu_relab_REMISSwk22 <- merge(REMISSwk22, trtd.otu_rel_abund, by.y = "row.names", by.x="group")


trtd.phyRelab_RelRSPwk22 <- merge(RelRSPwk22, trtd.phylum_rel_abund, by.y = "row.names", by.x="group")
trtd.claRelab_RelRSPwk22 <- merge(RelRSPwk22, trtd.class_rel_abund, by.y = "row.names", by.x="group")
trtd.ordRelab_RelRSPwk22 <- merge(RelRSPwk22, trtd.order_rel_abund, by.y = "row.names", by.x="group")
trtd.famRelab_RelRSPwk22 <- merge(RelRSPwk22, trtd.family_rel_abund, by.y = "row.names", by.x="group")
trtd.otuRelab_RelRSPwk22 <- merge(RelRSPwk22, trtd.otu_rel_abund, by.y = "row.names", by.x="group")

trtd.phyRelab_TRTGR_REMISSwk22 <- merge(TRTGR_REMISSwk22, trtd.phylum_rel_abund, by.y = "row.names", by.x="group")
trtd.claRelab_TRTGR_REMISSwk22 <- merge(TRTGR_REMISSwk22, trtd.class_rel_abund, by.y = "row.names", by.x="group")
trtd.ordRelab_TRTGR_REMISSwk22 <- merge(TRTGR_REMISSwk22, trtd.order_rel_abund, by.y = "row.names", by.x="group")
trtd.famRelab_TRTGR_REMISSwk22 <- merge(TRTGR_REMISSwk22, trtd.family_rel_abund, by.y = "row.names", by.x="group")
trtd.otuRelab_TRTGR_REMISSwk22 <- merge(TRTGR_RelRSPwk22, trtd.otu_rel_abund, by.y = "row.names", by.x="group")

trtd.phyRelab_TRTGR_RelRSPwk22 <- merge(TRTGR_RelRSPwk22, trtd.phylum_rel_abund, by.y = "row.names", by.x="group")
trtd.claRelab_TRTGR_RelRSPwk22 <- merge(TRTGR_RelRSPwk22, trtd.class_rel_abund, by.y = "row.names", by.x="group")
trtd.ordRelab_TRTGR_RelRSPwk22 <- merge(TRTGR_RelRSPwk22, trtd.order_rel_abund, by.y = "row.names", by.x="group")
trtd.famRelab_TRTGR_RelRSPwk22 <- merge(TRTGR_RelRSPwk22, trtd.family_rel_abund, by.y = "row.names", by.x="group")
trtd.otuRelab_TRTGR_RelRSPwk22 <- merge(TRTGR_RelRSPwk22, trtd.otu_rel_abund, by.y = "row.names", by.x="group")



rownames(plac.screen_data_otus) <- plac.screen_data_otus$group
plac.screen_data_otunum <- plac.screen_data_otus[,-1]
plac.otu_numbers <- colnames(plac.screen_data_otunum)
plac.nseqs <- apply(plac.screen_data_otus[,-1], 1, sum)

plac.otu_phylum_overlap <- otu_phylum[otu_phylum$otu %in% colnames(plac.screen_data_otus), ]
plac.otu_class_overlap <- otu_class[otu_class$otu %in% colnames(plac.screen_data_otus), ]
plac.otu_order_overlap <- otu_order[otu_order$otu %in% colnames(plac.screen_data_otus), ]
plac.otu_family_overlap <- otu_family[otu_family$otu %in% colnames(plac.screen_data_otus), ]

stopifnot(nrow(plac.otu_phylum_overlap) == ncol(plac.screen_data_otus[,-1]))
stopifnot(nrow(plac.otu_class_overlap) == ncol(plac.screen_data_otus[,-1]))
stopifnot(nrow(plac.otu_order_overlap) == ncol(plac.screen_data_otus[,-1]))
stopifnot(nrow(plac.otu_family_overlap) == ncol(plac.screen_data_otus[,-1]))

plac.phylum_names <- unique(plac.otu_phylum_overlap$phylum)
plac.class_names <- unique(plac.otu_class_overlap$class)
plac.order_names <- unique(plac.otu_order_overlap$order)
plac.family_names <- unique(plac.otu_family_overlap$family)


plac.n_phyla <- length(plac.phylum_names)
plac.n_classes <- length(plac.class_names)
plac.n_orders <- length(plac.order_names)
plac.n_families <- length(plac.family_names)



n_samp <- nrow(plac.screen_data_otus)
all_plac.phylum_shared <- data.frame(matrix(0, nrow=n_samp, ncol=n_phyla))
rownames(all_plac.phylum_shared) <- rownames(plac.screen_data_otus)
colnames(all_plac.phylum_shared) <- phylum_names

for (phylum in plac.phylum_names){
	plac.phylum_otus <- plac.otu_phylum_overlap[plac.otu_phylum_overlap$phylum == phylum, 'otu']
	plac.phylum_shared <- plac.screen_data_otus[,plac.phylum_otus]
	
	if(length(plac.phylum_otus) > 1){
		#sum over rows (row sum), use 1, sum over columns 2
		plac.phylum_count <- apply(plac.phylum_shared, 1, sum)
	} else {
		plac.phylum_count <- plac.phylum_shared
	}
	
	all_plac.phylum_shared[,phylum] <- plac.phylum_count
}

plac.nseqs <- apply(all_plac.phylum_shared, 1, sum)

plac.phylum_rel_abund <- all_plac.phylum_shared / plac.nseqs[1]*100


all_plac.class_shared <- data.frame(matrix(0, nrow=n_samp, ncol=n_classes))
rownames(all_plac.class_shared) <- plac.screen_data_otus$group
colnames(all_plac.class_shared) <- plac.class_names

for (class in plac.class_names){
	plac.class_otus <- plac.otu_class_overlap[plac.otu_class_overlap$class == class, 'otu']
	plac.class_shared <- plac.screen_data_otus[,plac.class_otus]
	
	if(length(plac.class_otus) > 1){
		#sum over rows (row sum), use 1, sum over columns 2
		plac.class_count <- apply(plac.class_shared, 1, sum)
	} else {
		plac.class_count <- plac.class_shared
	}
	
	all_plac.class_shared[,class] <- plac.class_count
}

plac.nseqs <- apply(all_plac.class_shared, 1, sum)

plac.class_rel_abund <- all_plac.class_shared / plac.nseqs[1]*100

all_plac.order_shared <- data.frame(matrix(0, nrow=n_samp, ncol=n_orders))
rownames(all_plac.order_shared) <- plac.screen_data_otus$group
colnames(all_plac.order_shared) <- plac.order_names

for (order in plac.order_names){
	plac.order_otus <- plac.otu_order_overlap[plac.otu_order_overlap$order == order, 'otu']
	plac.order_shared <- plac.screen_data_otus[,plac.order_otus]
	
	if(length(plac.order_otus) > 1){
		#sum over rows (row sum), use 1, sum over columns 2
		plac.order_count <- apply(plac.order_shared, 1, sum)
	} else {
		plac.order_count <- plac.order_shared
	}
	
	all_plac.order_shared[,order] <- plac.order_count
}

plac.nseqs <- apply(all_plac.order_shared, 1, sum)

plac.order_rel_abund <- all_plac.order_shared / plac.nseqs[1] *100

all_plac.family_shared <- data.frame(matrix(0, nrow=n_samp, ncol=n_families))
rownames(all_plac.family_shared) <- plac.screen_data_otus$group
colnames(all_plac.family_shared) <- plac.family_names
for (family in plac.family_names){
	plac.family_otus <- plac.otu_family_overlap[plac.otu_family_overlap$family == family, 'otu']
	plac.family_shared <- plac.screen_data_otus[,plac.family_otus]
	
	if(length(plac.family_otus) > 1){
		#sum over rows (row sum), use 1, sum over columns 2
		plac.family_count <- apply(plac.family_shared, 1, sum)
	} else {
		plac.family_count <- plac.family_shared
	}
	
	all_plac.family_shared[,family] <- plac.family_count
}

plac.nseqs <- apply(all_plac.family_shared, 1, sum)

plac.family_rel_abund <- all_plac.family_shared / plac.nseqs[1]



plac.otu_rel_abund <- plac.screen_data_otus[,-1] / plac.nseqs[1]*100


trtgr <- subset(screen_data, select = c(group, TRTGR))
REMISSwk6 <- subset(screen_data, select = c(group, REMISSwk6))
RelRSPwk6 <- subset(screen_data, select = c(group, RelRSPwk6))
TRTGR_REMISSwk6 <- subset(screen_data, select = c(group, TRTGR_REMISSwk6))
TRTGR_RelRSPwk6 <- subset(screen_data, select = c(group, TRTGR_RelRSPwk6))

plac.phyRelab_REMISSwk6 <- merge(REMISSwk6, plac.phylum_rel_abund, by.y = "row.names", by.x="group")
plac.claRelab_REMISSwk6 <- merge(REMISSwk6, plac.class_rel_abund, by.y = "row.names", by.x="group")
plac.ordRelab_REMISSwk6 <- merge(REMISSwk6, plac.order_rel_abund, by.y = "row.names", by.x="group")
plac.famRelab_REMISSwk6 <- merge(REMISSwk6, plac.family_rel_abund, by.y = "row.names", by.x="group")
plac.otu_relab_REMISSwk6 <- merge(REMISSwk6, plac.otu_rel_abund, by.y = "row.names", by.x="group")


plac.phyRelab_RelRSPwk6 <- merge(RelRSPwk6, plac.phylum_rel_abund, by.y = "row.names", by.x="group")
plac.claRelab_RelRSPwk6 <- merge(RelRSPwk6, plac.class_rel_abund, by.y = "row.names", by.x="group")
plac.ordRelab_RelRSPwk6 <- merge(RelRSPwk6, plac.order_rel_abund, by.y = "row.names", by.x="group")
plac.famRelab_RelRSPwk6 <- merge(RelRSPwk6, plac.family_rel_abund, by.y = "row.names", by.x="group")
plac.otuRelab_RelRSPwk6 <- merge(RelRSPwk6, plac.otu_rel_abund, by.y = "row.names", by.x="group")

plac.phyRelab_TRTGR_REMISSwk6 <- merge(TRTGR_REMISSwk6, plac.phylum_rel_abund, by.y = "row.names", by.x="group")
plac.claRelab_TRTGR_REMISSwk6 <- merge(TRTGR_REMISSwk6, plac.class_rel_abund, by.y = "row.names", by.x="group")
ordRelab_TRTGR_REMISSwk6 <- merge(TRTGR_REMISSwk6, plac.order_rel_abund, by.y = "row.names", by.x="group")
plac.famRelab_TRTGR_REMISSwk6 <- merge(TRTGR_REMISSwk6, plac.family_rel_abund, by.y = "row.names", by.x="group")
plac.otuRelab_TRTGR_REMISSwk6 <- merge(TRTGR_RelRSPwk6, plac.otu_rel_abund, by.y = "row.names", by.x="group")

plac.phyRelab_TRTGR_RelRSPwk6 <- merge(TRTGR_RelRSPwk6, plac.phylum_rel_abund, by.y = "row.names", by.x="group")
plac.claRelab_TRTGR_RelRSPwk6 <- merge(TRTGR_RelRSPwk6, plac.class_rel_abund, by.y = "row.names", by.x="group")
plac.ordRelab_TRTGR_RelRSPwk6 <- merge(TRTGR_RelRSPwk6, plac.order_rel_abund, by.y = "row.names", by.x="group")
plac.famRelab_TRTGR_RelRSPwk6 <- merge(TRTGR_RelRSPwk6, plac.family_rel_abund, by.y = "row.names", by.x="group")
plac.otuRelab_TRTGR_RelRSPwk6 <- merge(TRTGR_RelRSPwk6, plac.otu_rel_abund, by.y = "row.names", by.x="group")

REMISSwk22 <- subset(screen_data, select = c(group, REMISSwk22))
RelRSPwk22 <- subset(screen_data, select = c(group, RelRSPwk22))
TRTGR_REMISSwk22 <- subset(screen_data, select = c(group, TRTGR_REMISSwk22))
TRTGR_RelRSPwk22 <- subset(screen_data, select = c(group, TRTGR_RelRSPwk22))

plac.phyRelab_REMISSwk22 <- merge(REMISSwk22, plac.phylum_rel_abund, by.y = "row.names", by.x="group")
plac.claRelab_REMISSwk22 <- merge(REMISSwk22, plac.class_rel_abund, by.y = "row.names", by.x="group")
plac.ordRelab_REMISSwk22 <- merge(REMISSwk22, plac.order_rel_abund, by.y = "row.names", by.x="group")
plac.famRelab_REMISSwk22 <- merge(REMISSwk22, plac.family_rel_abund, by.y = "row.names", by.x="group")
plac.otu_relab_REMISSwk22 <- merge(REMISSwk22, plac.otu_rel_abund, by.y = "row.names", by.x="group")


plac.phyRelab_RelRSPwk22 <- merge(RelRSPwk22, plac.phylum_rel_abund, by.y = "row.names", by.x="group")
plac.claRelab_RelRSPwk22 <- merge(RelRSPwk22, plac.class_rel_abund, by.y = "row.names", by.x="group")
plac.ordRelab_RelRSPwk22 <- merge(RelRSPwk22, plac.order_rel_abund, by.y = "row.names", by.x="group")
plac.famRelab_RelRSPwk22 <- merge(RelRSPwk22, plac.family_rel_abund, by.y = "row.names", by.x="group")
plac.otuRelab_RelRSPwk22 <- merge(RelRSPwk22, plac.otu_rel_abund, by.y = "row.names", by.x="group")

plac.phyRelab_TRTGR_REMISSwk22 <- merge(TRTGR_REMISSwk22, plac.phylum_rel_abund, by.y = "row.names", by.x="group")
plac.claRelab_TRTGR_REMISSwk22 <- merge(TRTGR_REMISSwk22, plac.class_rel_abund, by.y = "row.names", by.x="group")
plac.ordRelab_TRTGR_REMISSwk22 <- merge(TRTGR_REMISSwk22, plac.order_rel_abund, by.y = "row.names", by.x="group")
plac.famRelab_TRTGR_REMISSwk22 <- merge(TRTGR_REMISSwk22, plac.family_rel_abund, by.y = "row.names", by.x="group")
plac.otuRelab_TRTGR_REMISSwk22 <- merge(TRTGR_RelRSPwk22, plac.otu_rel_abund, by.y = "row.names", by.x="group")

plac.phyRelab_TRTGR_RelRSPwk22 <- merge(TRTGR_RelRSPwk22, plac.phylum_rel_abund, by.y = "row.names", by.x="group")
plac.claRelab_TRTGR_RelRSPwk22 <- merge(TRTGR_RelRSPwk22, plac.class_rel_abund, by.y = "row.names", by.x="group")
plac.ordRelab_TRTGR_RelRSPwk22 <- merge(TRTGR_RelRSPwk22, plac.order_rel_abund, by.y = "row.names", by.x="group")
plac.famRelab_TRTGR_RelRSPwk22 <- merge(TRTGR_RelRSPwk22, plac.family_rel_abund, by.y = "row.names", by.x="group")
plac.otuRelab_TRTGR_RelRSPwk22 <- merge(TRTGR_RelRSPwk22, plac.otu_rel_abund, by.y = "row.names", by.x="group")