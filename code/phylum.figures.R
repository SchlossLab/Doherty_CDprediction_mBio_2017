source('../code/phylum.analysis.R')

set.seed(32016)
phyRabRelRSPwk6_figure <- ggplot(phyRabRelRSPwk6_ggplot, aes(x=RelRSPwk6, y=relabund, fill=phylum)) +
	#stat_summary(fun.y=median, geom="point", aes(fill = phylum), position = position_dodge(1)) +
	#stat_summary(fun.data = 'median_hilow', fun.args = (conf.int=0.5), position = position_dodge(1), geom='errorbar', aes(color = phylum))+
	geom_boxplot(aes(col=phylum), position=position_dodge(width = 1), alpha = .4) +
	theme(legend.text = element_text(face = "italic")) + ylab("Relative Abundance (%)") + xlab("Week 6 Responder")

set.seed(32016)
ann_text <- data.frame(RelRSPwk6 = c("No", "Yes") , relabund = 95,
											 phylum = "Bacteroidetes")
phyRabRelRSPwk6_figure2 <- ggplot(phyRabRelRSPwk6_ggplot, aes(x=RelRSPwk6, y=relabund, fill=RelRSPwk6)) +
	#stat_summary(fun.y=median, geom="point", aes(fill = phylum), position = position_dodge(1)) +
	#stat_summary(fun.data = 'median_hilow', fun.args = (conf.int=0.5), position = position_dodge(1), geom='errorbar', aes(color = phylum))+
	geom_boxplot(position=position_dodge(width = 1), alpha = .4) +facet_grid(. ~ phylum) +
	ylab("Relative Abundance (%)") + xlab("Week 6 Responder") + theme(legend.position="none") + theme(strip.text = element_text(face = "italic")) +
	geom_text(data = ann_text, label = "*", size=10)

#tiff('figures/ggplot.phylum.figure.byRelRSPwk6.tiff', height = 8, width = 12, units = "in", res = 300)
pdf('figures/ggplot.phylum.figure.byRelRSPwk6.pdf', height = 8, width = 12)
phyRabRelRSPwk6_figure
dev.off()

#tiff('figures/ggplot.phylum.figure.facetbyotuRelRSPwk6.tiff', height = 8, width = 12, units = "in", res = 300)
pdf('figures/ggplot.phylum.figure.facetbyotuRelRSPwk6.pdf', height = 8, width = 12)
phyRabRelRSPwk6_figure2
dev.off()



set.seed(32016)
phyRabREMISSwk6_figure <- ggplot(phyRabREMISSwk6_ggplot, aes(x=REMISSwk6, y=relabund, fill=phylum)) +
	#stat_summary(fun.y=median, geom="point", aes(fill = phylum), position = position_dodge(1)) +
	#stat_summary(fun.data = 'median_hilow', fun.args = (conf.int=0.5), position = position_dodge(1), geom='errorbar', aes(color = phylum))+
	geom_boxplot(aes(col=phylum), position=position_dodge(width = 1), alpha = .4) +
	theme(legend.text = element_text(face = "italic")) + ylab("Relative Abundance (%)") + xlab("Week 6 Remitter")

set.seed(32016)
phyRabREMISSwk6_figure2 <- ggplot(phyRabREMISSwk6_ggplot, aes(x=REMISSwk6, y=relabund, fill=REMISSwk6)) +
	#stat_summary(fun.y=median, geom="point", aes(fill = phylum), position = position_dodge(1)) +
	#stat_summary(fun.data = 'median_hilow', fun.args = (conf.int=0.5), position = position_dodge(1), geom='errorbar', aes(color = phylum))+
	geom_boxplot(position=position_dodge(width = 1), alpha = .4) +facet_grid(. ~ phylum) +
	ylab("Relative Abundance (%)") + xlab("Week 6 Remitter") + theme(legend.position="none") + theme(strip.text = element_text(face = "italic"))

#tiff('figures/ggplot.phylum.figure.byREMISSwk6.tiff', height = 8, width = 12, units = "in", res = 300)
pdf('figures/ggplot.phylum.figure.byREMISSwk6.pdf', height = 8, width = 12)
phyRabREMISSwk6_figure
dev.off()

#tiff('figures/ggplot.phylum.figure.facetbyotuREMISSwk6.tiff', height = 8, width = 12, units = "in", res = 300)
pdf('figures/ggplot.phylum.figure.facetbyotuREMISSwk6.pdf', height = 8, width = 12)
phyRabREMISSwk6_figure2
dev.off()

set.seed(32016)
phyRabRelRSPwk22_figure <- ggplot(phyRabRelRSPwk22_ggplot, aes(x=RelRSPwk22, y=relabund, fill=phylum)) +
	#stat_summary(fun.y=median, geom="point", aes(fill = phylum), position = position_dodge(1)) +
	#stat_summary(fun.data = 'median_hilow', fun.args = (conf.int=0.5), position = position_dodge(1), geom='errorbar', aes(color = phylum))+
	geom_boxplot(aes(col=phylum), position=position_dodge(width = 1), alpha = .4) +
	theme(legend.text = element_text(face = "italic")) + ylab("Relative Abundance (%)") + xlab("Week 6 Responder")

set.seed(32016)
phyRabRelRSPwk22_figure2 <- ggplot(phyRabRelRSPwk22_ggplot, aes(x=RelRSPwk22, y=relabund, fill=RelRSPwk22)) +
	#stat_summary(fun.y=median, geom="point", aes(fill = phylum), position = position_dodge(1)) +
	#stat_summary(fun.data = 'median_hilow', fun.args = (conf.int=0.5), position = position_dodge(1), geom='errorbar', aes(color = phylum))+
	geom_boxplot(position=position_dodge(width = 1), alpha = .4) +facet_grid(. ~ phylum) +
	ylab("Relative Abundance (%)") + xlab("Week 22 Responder") + theme(legend.position="none") + theme(strip.text = element_text(face = "italic"))

#tiff('figures/ggplot.phylum.figure.byRelRSPwk22.tiff', height = 8, width = 12, units = "in", res = 300)
#pdf('figures/ggplot.phylum.figure.byRelRSPwk22.pdf', height = 8, width = 12)
#phyRabRelRSPwk22_figure
#dev.off()

#tiff('figures/ggplot.phylum.figure.facetbyotuRelRSPwk22.tiff', height = 8, width = 12, units = "in", res = 300)
#pdf('figures/ggplot.phylum.figure.facetbyotuRelRSPwk22.pdf', height = 8, width = 12)
phyRabRelRSPwk22_figure2
dev.off()

set.seed(32016)
phyRabREMISSwk22_figure <- ggplot(phyRabREMISSwk22_ggplot, aes(x=REMISSwk22, y=relabund, fill=phylum)) +
	#stat_summary(fun.y=median, geom="point", aes(fill = phylum), position = position_dodge(1)) +
	#stat_summary(fun.data = 'median_hilow', fun.args = (conf.int=0.5), position = position_dodge(1), geom='errorbar', aes(color = phylum))+
	geom_boxplot(aes(col=phylum), position=position_dodge(width = 1), alpha = .4) +
	theme(legend.text = element_text(face = "italic")) + ylab("Relative Abundance (%)") + xlab("Week 6 Remitter")

set.seed(32016)
phyRabREMISSwk22_figure2 <- ggplot(phyRabREMISSwk22_ggplot, aes(x=REMISSwk22, y=relabund, fill=REMISSwk22)) +
	#stat_summary(fun.y=median, geom="point", aes(fill = phylum), position = position_dodge(1)) +
	#stat_summary(fun.data = 'median_hilow', fun.args = (conf.int=0.5), position = position_dodge(1), geom='errorbar', aes(color = phylum))+
	geom_boxplot(position=position_dodge(width = 1), alpha = .4) +facet_grid(. ~ phylum) +
	ylab("Relative Abundance (%)") + xlab("Week 22 Remitter") + theme(legend.position="none") + theme(strip.text = element_text(face = "italic"))

#tiff('figures/ggplot.phylum.figure.byREMISSwk22.tiff', height = 8, width = 12, units = "in", res = 300)
pdf('figures/ggplot.phylum.figure.byREMISSwk22.pdf', height = 8, width = 12)
phyRabREMISSwk22_figure
dev.off()

#tiff('figures/ggplot.phylum.figure.facetbyotuREMISSwk22.tiff', height = 8, width = 12, units = "in", res = 300)
pdf('figures/ggplot.phylum.figure.facetbyotuREMISSwk22.pdf', height = 8, width = 12)
phyRabREMISSwk22_figure2
dev.off()
#ummary(phyRabREMISSwk6_ggplot$phylum)

pdf("figures/Figure1.pdf", height = 10, width = 12)
plot_grid(phyRabRelRSPwk6_figure2, phyRabREMISSwk6_figure2, labels = c("A", "B"), align = "v", nrow=2)
dev.off()

pdf("figures/SF1.pdf", height = 10, width = 12)
plot_grid(phyRabRelRSPwk22_figure2, phyRabREMISSwk22_figure2, labels = c("A", "B"), align = "v", nrow=2)
dev.off()
#str(phyRabREMISSwk6_ggplot$phylum)

#stripcharts
#tiff('figures/phylum.stripchart.tiff', height = 8, width = 12, units = "in", res = 300)
pdf('figures/phylum.stripchart.pdf', height = 8, width = 12)
ab_relabund <- phylum_rel_abund[,abundant]
layout(1)
plot(NA, ylim = c(0,100), xlim=c(1,30), ylab = "Relative Abundance (%)", xlab = "", axes = F)
start <- 2
for(phylum in colnames(ab_relabund)){
	stripchart(ab_relabund[,phylum] ~ screen_data$TRTGR_REMISSwk6,
						 vertical = T,
						 method='jitter', jitter= 0.3,
						 col=alpha(c("blue", "red"), 0.4), pch=c(21, 21, 24, 24),
						 axes=F, at=start:(start+3), add = T)
	segments(x0= (start:(start+3))-0.5,y0=median_abundant_phylum_matrix[phylum,] ,x1=(start:(start+3))+0.5 ,y1=median_abundant_phylum_matrix[phylum,] ,lwd=2)
	start <- start + 5
}
#segments(mean(yes_abunds[,i]),index-0.7,mean(yes_abunds[,i]),index, lwd=3)
#axis(1, las=2, crt=45, labels=colnames(ab_relabund)[1:5], at=c(2,6,10, 14,18), tick=F, cex.axis=0.5, line=-1)
text(x=c(3, 8, 13, 18, 23, 28)-1, y=-20, srt = 45, adj= 0, xpd = TRUE,
		 labels = paste(colnames(ab_relabund[1:6])), cex=1, font=3)
axis(2, las=2)
box()
legend(x=25, y=95, legend=levels(screen_data$TRTGR_REMISSwk6), pch=c(21, 21, 24, 24), col=c("blue", "red"))
dev.off()

tiff('figures/rainbow.phylum.barplot.tiff')
barplot(mean_abundant_phylum_matrix,
				beside=T,
				col=c("red", "orange", "yellow", "green", "blue", "violet"),
				names.arg=colnames(mean_abundant_phylum_matrix),
				legend=T, 
				ylab="Relative Abundance (%)", xlab= "Remitter Week 6")

box()
dev.off()

#summary(phyRelab_trtgrRem6$Actinobacteria)

#barplot(median_abundant_phylum_matrix, beside=T, col=c("red", "orange", "yellow", "green", "blue", "violet"), names.arg=colnames(median_abundant_phylum_matrix), legend=T, ylab="Relative Abundance")
#box()

#summary(mean_abundant_phylum_matrix)
#barplot(t(median_abundant_phylum_matrix), beside=T, col=c("blue", "red"), ylab="Relative Abundance")
#box()

tiff('figures/phylumXREMISSwk6.boxplot.tiff', height = 10, width = 10, res=300, units = "in")
set.seed(32016)
plot(NA, ylim=c(0,100), xlim=c(1,19), ylab="Relative Abundance", xlab="", axes=F)
boxplot(phylum_rel_abund[,1]~screen_data$REMISSwk6, at=2:3, names=F, add=T, axes=F, col=c("blue", "red"))
boxplot(phylum_rel_abund[,2]~screen_data$REMISSwk6, at=5:6, names=F, add=T, axes=F, col=c("blue", "red"))
boxplot(phylum_rel_abund[,3]~screen_data$REMISSwk6, at=8:9, names=F, add=T, axes=F, col=c("blue", "red"))
boxplot(phylum_rel_abund[,4]~screen_data$REMISSwk6, at=11:12, names=F, add=T, axes=F, col=c("blue", "red"))
boxplot(phylum_rel_abund[,5]~screen_data$REMISSwk6, at=14:15, names=F, add=T, axes=F, col=c("blue", "red"))
boxplot(phylum_rel_abund[,6]~screen_data$REMISSwk6, at=17:18, names=F, add=T, axes=F, col=c("blue", "red"))
axis(1, labels=colnames(phylum_rel_abund)[1:6], at=c(1,4,7,10,13,16)+1.5, tick=F, cex.axis=1, line=-1, font = 3)
axis(2, las=2)
legend(x=16, y=95, legend=c("Nonremitter", "Remitter"), pch = 15, col=c("blue", "red"), title = "Week 6")
box()
dev.off()

tiff('figures/phylumXRelRSPwk6.boxplot.tiff', height = 10, width = 10, res=300, units = "in")
set.seed(32016)
plot(NA, ylim=c(0,100), xlim=c(1,19), ylab="Relative Abundance", xlab="", axes=F)
boxplot(phylum_rel_abund[,1]~screen_data$RelRSPwk6, at=2:3, names=F, add=T, axes=F, col=c("blue", "red"))
boxplot(phylum_rel_abund[,2]~screen_data$RelRSPwk6, at=5:6, names=F, add=T, axes=F, col=c("blue", "red"))
boxplot(phylum_rel_abund[,3]~screen_data$RelRSPwk6, at=8:9, names=F, add=T, axes=F, col=c("blue", "red"))
boxplot(phylum_rel_abund[,4]~screen_data$RelRSPwk6, at=11:12, names=F, add=T, axes=F, col=c("blue", "red"))
boxplot(phylum_rel_abund[,5]~screen_data$RelRSPwk6, at=14:15, names=F, add=T, axes=F, col=c("blue", "red"))
boxplot(phylum_rel_abund[,6]~screen_data$RelRSPwk6, at=17:18, names=F, add=T, axes=F, col=c("blue", "red"))
axis(1, labels=colnames(phylum_rel_abund)[1:6], at=c(1,4,7,10,13,16)+1.5, tick=F, cex.axis=1, line=-1, font = 3)
axis(2, las=2)
legend(x=16, y=95, legend=c("Non Responder", "Responder"), pch = 15, col=c("blue", "red"), title = "Week 6")
box()
dev.off()

tiff('figures/phylumXREMISSwk22.boxplot.tiff', height = 10, width = 10, res=300, units = "in")
set.seed(32016)
plot(NA, ylim=c(0,100), xlim=c(1,19), ylab="Relative Abundance", xlab="", axes=F)
boxplot(phylum_rel_abund[,1]~screen_data$REMISSwk22, at=2:3, names=F, add=T, axes=F, col=c("blue", "red"))
boxplot(phylum_rel_abund[,2]~screen_data$REMISSwk22, at=5:6, names=F, add=T, axes=F, col=c("blue", "red"))
boxplot(phylum_rel_abund[,3]~screen_data$REMISSwk22, at=8:9, names=F, add=T, axes=F, col=c("blue", "red"))
boxplot(phylum_rel_abund[,4]~screen_data$REMISSwk22, at=11:12, names=F, add=T, axes=F, col=c("blue", "red"))
boxplot(phylum_rel_abund[,5]~screen_data$REMISSwk22, at=14:15, names=F, add=T, axes=F, col=c("blue", "red"))
boxplot(phylum_rel_abund[,6]~screen_data$REMISSwk22, at=17:18, names=F, add=T, axes=F, col=c("blue", "red"))
axis(1, labels=colnames(phylum_rel_abund)[1:6], at=c(1,4,7,10,13,16)+1.5, tick=F, cex.axis=1, line=-1, font = 3)
axis(2, las=2)
legend(x=16, y=95, legend=c("Nonremitter", "Remitter"), pch = 15, col=c("blue", "red"), title = "Week 22")
box()
dev.off()

tiff('figures/phylumXRelRSPwk22.boxplot.tiff', height = 10, width = 10, res=300, units = "in")
set.seed(32016)
plot(NA, ylim=c(0,100), xlim=c(1,19), ylab="Relative Abundance", xlab="", axes=F)
boxplot(phylum_rel_abund[,1]~screen_data$RelRSPwk22, at=2:3, names=F, add=T, axes=F, col=c("blue", "red"))
boxplot(phylum_rel_abund[,2]~screen_data$RelRSPwk22, at=5:6, names=F, add=T, axes=F, col=c("blue", "red"))
boxplot(phylum_rel_abund[,3]~screen_data$RelRSPwk22, at=8:9, names=F, add=T, axes=F, col=c("blue", "red"))
boxplot(phylum_rel_abund[,4]~screen_data$RelRSPwk22, at=11:12, names=F, add=T, axes=F, col=c("blue", "red"))
boxplot(phylum_rel_abund[,5]~screen_data$RelRSPwk22, at=14:15, names=F, add=T, axes=F, col=c("blue", "red"))
boxplot(phylum_rel_abund[,6]~screen_data$RelRSPwk22, at=17:18, names=F, add=T, axes=F, col=c("blue", "red"))
axis(1, labels=colnames(phylum_rel_abund)[1:6], at=c(1,4,7,10,13,16)+1.5, tick=F, cex.axis=1, line=-1, font = 3)
axis(2, las=2)
legend(x=16, y=95, legend=c("Non Responder", "Responder"), pch = 15, col=c("blue", "red"), title = "Week 22")
box()
dev.off()

