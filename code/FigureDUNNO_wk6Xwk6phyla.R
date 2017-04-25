source('../code/phylum.analysis.R')

set.seed(32016)
ann_text <- data.frame(RelRSPwk6 = c("No", "Yes") , relabund = 95,
											 phylum = "Proteobacteria")
phyRabRelRSPwk6_figure2 <- ggplot(phyRabRelRSPwk6_ggplot, aes(x=RelRSPwk6, y=relabund, fill=RelRSPwk6)) +
	geom_boxplot(position=position_dodge(width = 1), alpha = .4) +facet_grid(. ~ phylum) +
	ylab("Week 6 Relative Abundance (%)") + xlab("Week 6 Responder") + theme(legend.position="none") + theme(strip.text = element_text(face = "italic")) +
	geom_text(data = ann_text, label = "*", size=10) + geom_text(data = ann_text, label = "*", size=9, color = "red")

set.seed(32016)
ann_text <- data.frame(REMISSwk6 = c("No", "Yes") , relabund = 95,
											 phylum = "Proteobacteria")
phyRabREMISSwk6_figure2 <- ggplot(phyRabREMISSwk6_ggplot, aes(x=REMISSwk6, y=relabund, fill=REMISSwk6)) +
	geom_boxplot(position=position_dodge(width = 1), alpha = .4) +facet_grid(. ~ phylum) +
	ylab("Week 6 Relative Abundance (%)") + xlab("Week 6 Remitter") + theme(legend.position="none") + theme(strip.text = element_text(face = "italic")) +
	geom_text(data = ann_text, label = "*", size=10) + geom_text(data = ann_text, label = "*", size=9, color = "red") 

pdf("figures/FigureDUNNO_wk6Xwk6phyla.pdf", height = 10, width = 12)
plot_grid(phyRabRelRSPwk6_figure2, phyRabREMISSwk6_figure2, labels = c("A", "B"), align = "v", nrow=2)
dev.off()
