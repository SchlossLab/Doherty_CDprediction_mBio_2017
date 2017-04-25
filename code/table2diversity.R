#**Table 2: Diversity differenced bases on Response/Remission in treated subjects.**
	
colnames(all.RelRSPwk6) <- c('Status Week', 'Treated', "Placebo", 'Species Diversity (p-value)', 'Community Structure (p-value)')
table2<-rbind(all.RelRSPwk6, all.REMISSwk6)

divers<-c("all.RelRSPwk22", "all.REMISSwk22")

for (i in divers){
	table2<-rbind(table2, get(i))
}

table2_df <- data.frame(table2)
table2 <- colnames(table2)
adiv_p <- as.numeric(as.character(table2_df$Species.Diversity..p.value.))

table2_adiv_adj_p <- p.adjust(adiv_p, method="BH")
table2_df$Species.Diversity..p.value. <- as.factor(sprintf("%.3f", signif(table2_adiv_adj_p, 2)))

bdiv_p <- as.numeric(as.character(table2_df$Community.Structure..p.value.))

table2_bdiv_adj_p <- p.adjust(bdiv_p, method="BH")
table2_df$Community.Structure..p.value. <- as.factor(signif(table2_bdiv_adj_p, 2))

wk6remadivpval <- table2_df[2,4]
wk6RSPbdivpval <- table2_df[1,5]
wk6REMbdivpval <- table2_df[2,5]
wk22RSPbdivpval <- table2_df[3,5]
wk22REMBdivpval <- table2_df[4,5]

colnames(table2_df) <- c('Clinical Variable', 'Treated (n)', "Placebo (n)",'Species Diversity\n(p-value)', 'Community Structure\n(p-value)')
table2 <- table2_df
#table2 <- table2[,-2]
table2.N <- as.matrix(table2[,c(1:3)])
table2div <- as.matrix(table2[,-c(2:3)])
table2 <- as.matrix(table2)

table2wk6div <- table2div[-c(3:4),]



tiff('tables/table2diversity.tiff', height=4, width=10, units='in', res=300)
grid.table(table2div)
dev.off()

pdf(file='tables/table2diversity.pdf', height=4, width=6)
grid.table(table2div)
dev.off()

pdf(file='tables/table2week6diversity.pdf', height=4, width=6)
grid.table(table2wk6div)
dev.off()


pdf(file='tables/table2N.pdf', height=4, width=6)
grid.table(table2.N)
dev.off()

