#**Table 3: Summary of microbial associations with remission at baseline and following UST induction.**
tax<-read.table("../data/Jan400.simple.taxonomy.txt", header=T, sep='\t')

rem_otunum <- c(1, 7, 19, 53, 73, 124)
rem_taxa <- tax[rem_otunum,]
rem_otus <- as.character(ordered(rem_taxa$OTU))
rem_taxa<-data.frame(rem_otus)
colnames(rem_taxa) <- c('OTU')

rem_tax<-merge(rem_taxa, tax, by='OTU')
lab <- levels(rem_tax$tax)
rem_tax$Classification <- gsub("(OTU\\d+)", "(\\1)", rem_tax$Classification)

rem_tax<-rem_tax[match(rem_taxa$OTU, rem_tax$OTU),]
rem_name<-as.character(rem_tax$tax)
rem_numb<-rem_tax$Classification

rem_name<-as.character(rem_tax$tax)
rem_numb<-rem_tax$Classification
formatted <- lapply(1:nrow(rem_tax), function(i) bquote(paste(italic(.(rem_name[i]))~.(rem_numb[i]))))
dfor <- data.frame(matrix(unlist(formatted), nrow=6, byrow=T))

dfor

r1 <- c('paste(italic("Escherichia/Shigella")~"(OTU1)")', "lower relative abundance", "-")
r2 <- c('paste(bolditalic("Faecalibacterium")~bold("(OTU7)"))', "higher relative abundance", "higher relative abundance")
r3 <- c('paste(italic("Roseburia")~"(OTU12)")', "-", "higher relative abundance")
r4 <- c('paste(italic("Bacteroides")~"(OTU19)")', "higher relative abundance", "-")
r5 <- c('paste(italic("Ruminococcus")~"(OTU35)")', "higher relative abundance", "-")
r6 <- c('paste(italic("Ruminococcaceae")~"(OTU53)")', "-", "higher relative abundance")
r7 <- c('paste(italic("Clostridium XlVa")~"(OTU73)")', "-", "higher relative abundance")
r8 <- c('paste(italic("Blautia")~"(OTU124)")', "-", "higher relative abundance")
r9 <- c("alpha-Diversity", "higher", "-")

df <- data.frame(col1=character(), col2=character(), col3=character())
#colnames(df) <- c('Microbial Marker\nfor Remission', 'Association at Baseline', 'Association 6 weeks\npost UST treatment')

df<-rbind(r1, r2)

rows <- c("r3", "r4", "r5", "r6", "r7", "r8", "r9")
for (i in rows){
	df<-rbind(df, get(i))
}

colnames(df) <- c("Microbial Association\nwith Remission", "At Baseline", '6 weeks post\nUST treatment')
row.names(df) <- NULL
tt <- ttheme_default(core=list(fg_params=list(parse=T, fontface=c("plain", "bold", rep("plain", 7)))),
											colhead=list(fg_params=list(parse=T), rowhead=NULL))

grid.newpage()
grid.table(df, theme=tt)

# tiff("", width = 7, height = 4, units='in', res=300)
# grid.table(df, theme=tt)
# dev.off()

pdf("tables/table3_results_table.pdf", width = 8, height = 6)
grid.table(df, theme=tt)
dev.off()


