source('../code/phylum.analysis.R')

set.seed(32016)
ann_text <- data.frame(RelRSPwk6 = c("No", "Yes") , relabund = 95,
											 phylum = "Bacteroidetes")
phyRabRelRSPwk6_figure2 <- ggplot(trtd.phyRabRelRSPwk6_ggplot, aes(x=RelRSPwk6, y=relabund, fill=RelRSPwk6)) +
	geom_boxplot(position=position_dodge(width = 1), alpha = .4) +facet_grid(. ~ phylum) +
	ylab("Week 0 Relative Abundance (%)") + xlab("Week 6 Responder") + theme(legend.position="none") + theme(strip.text = element_text(face = "italic")) +
	#geom_text(data = ann_text, label = "*", size=10)

set.seed(32016)
phyRabREMISSwk6_figure2 <- ggplot(trtd.phyRabREMISSwk6_ggplot, aes(x=REMISSwk6, y=relabund, fill=REMISSwk6)) +
	geom_boxplot(position=position_dodge(width = 1), alpha = .4) +facet_grid(. ~ phylum) +
	ylab("Week 0 Relative Abundance (%)") + xlab("Week 6 Remitter") + theme(legend.position="none") + theme(strip.text = element_text(face = "italic"))

pdf("figures/Figure2_wk6phyla.pdf", height = 10, width = 12)
plot_grid(phyRabRelRSPwk6_figure2, phyRabREMISSwk6_figure2, labels = c("A", "B"), align = "v", nrow=2)
dev.off()

set.seed(32016)
phyRabRelRSPwk22_figure2 <- ggplot(trtd.phyRabRelRSPwk22_ggplot, aes(x=RelRSPwk22, y=relabund, fill=RelRSPwk22)) +
	geom_boxplot(position=position_dodge(width = 1), alpha = .4) +facet_grid(. ~ phylum) +
	ylab("Week 0 Relative Abundance (%)") + xlab("Week 22 Responder") + theme(legend.position="none") + theme(strip.text = element_text(face = "italic"))

set.seed(32016)
phyRabREMISSwk22_figure2 <- ggplot(trtd.phyRabREMISSwk22_ggplot, aes(x=REMISSwk22, y=relabund, fill=REMISSwk22)) +
	geom_boxplot(position=position_dodge(width = 1), alpha = .4) +facet_grid(. ~ phylum) +
	ylab("Week 0 Relative Abundance (%)") + xlab("Week 22 Remitter") + theme(legend.position="none") + theme(strip.text = element_text(face = "italic"))

pdf("figures/SF1_phylaWK22.pdf", height = 10, width = 12)
plot_grid(phyRabRelRSPwk22_figure2, phyRabREMISSwk22_figure2, labels = c("A", "B"), align = "v", nrow=2)
dev.off()

