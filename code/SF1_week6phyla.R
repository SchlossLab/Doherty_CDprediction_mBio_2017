source('../code/R_packages_setup.R')
source('../code/APmd.setup.R')

screen_RESPwk22<-APmd_RSPwk22[APmd_RSPwk22$visit=="Screening",] #removes any group with NA in RESPONSEwk22

screen_data<-screen_RESPwk22				#na.omit(screen_RESPwk22)
summary(subset(screen_data, select=c(group, USUBJID, visit, TRTGR, TRTGRINDMAN, RESPONSEwk8)))

summary(subset(screen_data, select=c(group, USUBJID, visit, TRTGR, TRTGRINDMAN, RESPONSEwk8)))

summary(subset(screen_data, select=c(group, USUBJID, visit, TRTGR, TRTGRINDMAN, RESPONSEwk8)))


screen_data<-screen_data[screen_data$TRTGRINDMAN!="Placebo_Not",]
screen_data<-screen_data[screen_data$TRTGRINDMAN!="Treated_Not",]

summary(screen_data[,c("TRTGR", "TRTGRINDMAN", "visit", "RESPONSEwk6", "RelRSPwk6", "REMISSwk6")])


screen.trtd<-screen_data[screen_data$TRTGRINDMAN!="Placebo_Placebo",]
screen.trtd<-screen.trtd[screen.trtd$TRTGRINDMAN!="Placebo_Treated",]
summary(screen.trtd[,1:6])
screen.plac<-screen_data[screen_data$TRTGRINDMAN!="Treated_Placebo",]
screen.plac<-screen.plac[screen.plac$TRTGRINDMAN!="Treated_Treated",]
summary(screen.plac[,1:6])

nao.screen_data<-na.omit(screen_data)

nao.screen.trtd<-nao.screen_data[nao.screen_data$TRTGRINDMAN!="Placebo_Placebo",]
nao.screen.trtd<-nao.screen.trtd[nao.screen.trtd$TRTGRINDMAN!="Placebo_Treated",]
summary(nao.screen.trtd[,1:6])
nao.screen.plac<-nao.screen_data[nao.screen_data$TRTGRINDMAN!="Treated_Placebo",]
nao.screen.plac<-nao.screen.plac[nao.screen.plac$TRTGRINDMAN!="Treated_Treated",]
summary(nao.screen.plac[,1:6])


tax<- read.table('../data/Jan400.simple.taxonomy.txt', header=T, sep="\t")
nao.screen.all.distmat<-read.table("../data/Jan400.screening.all.na.omit.cmd.thetayc.0.03.square.ave.dist")
nao.screen.all.dist<-as.dist(nao.screen.all.distmat)
nao.screen.trtd.distmat<-read.table("../data/Jan400.screening.ust.na.omit.cmd.thetayc.0.03.square.ave.dist")
nao.screen.trtd.dist<-as.dist(nao.screen.trtd.distmat)
nao.screen.plac.distmat<-read.table("../data/Jan400.screening.plac.na.omit.cmd.thetayc.0.03.square.ave.dist")
nao.screen.plac.dist<-as.dist(nao.screen.plac.distmat)

trtd_trtd.data.distmat<-read.table("../data/Jan400.trtd_trtd.accnos.na.omit.cmd.thetayc.0.03.square.ave.dist")
trtd_trtd.data.dist<-as.dist(trtd_trtd.data.distmat)
trtd_plac.data.distmat<-read.table("../data/Jan400.trtd_plac.accnos.na.omit.cmd.thetayc.0.03.square.ave.dist")
trtd_plac.data.dist<-as.dist(trtd_plac.data.distmat)
plac_plac.data.distmat<-read.table("../data/Jan400.plac_plac.accnos.na.omit.cmd.thetayc.0.03.square.ave.dist")
plac_plac.data.dist<-as.dist(plac_plac.data.distmat)
plac_trtd.data.distmat<-read.table("../data/Jan400.plac_trtd.accnos.na.omit.cmd.thetayc.0.03.square.ave.dist")
plac_trtd.data.dist<-as.dist(plac_trtd.data.distmat)


source('../code/phylum.analysis.R')



set.seed(32016) 

ann_text <- data.frame(RESPONSEwk6 = c("No", "Yes") , relabund = 95,
											 phylum = "Bacteroidetes")
phyRabRESPONSEwk6_figure2 <- ggplot(trtd.phyRabRESPONSEwk6_ggplot, aes(x=RESPONSEwk6, y=relabund, fill=RESPONSEwk6)) +
	geom_boxplot(position=position_dodge(width = 1), alpha = .4, outlier.shape = NA) +facet_grid(. ~ phylum) +
	ylab("Week 0 Relative Abundance (%)") + xlab("Week 6 Response") + theme(legend.position="none") + theme(strip.text = element_text(face = "italic")) +
	stat_boxplot_custom(qs = c(0, 0.25, 0.5, 0.75, 1))	 #geom_text(data = ann_text, label = "*", size=10) 
	
set.seed(32016)
phyRabREMISSwk6_figure2 <- ggplot(trtd.phyRabREMISSwk6_ggplot, aes(x=REMISSwk6, y=relabund, fill=REMISSwk6)) +
	geom_boxplot(position=position_dodge(width = 1), alpha = .4, outlier.shape = NA) +facet_grid(. ~ phylum) +
	ylab("Week 0 Relative Abundance (%)") + xlab("Week 6 Remission") + theme(legend.position="none") +
	theme(strip.text = element_text(face = "italic")) + stat_boxplot_custom(qs = c(0, 0.25, 0.5, 0.75, 1))

pdf("figures/SF1_wk6phyla.pdf", height = 10, width = 12)
plot_grid(phyRabRESPONSEwk6_figure2, phyRabREMISSwk6_figure2, labels = c("A", "B"), align = "v", nrow=2)
dev.off()

tiff("figures/SF1_wk6phyla.pdf.tiff", height = 10, width = 12, units = "in", res = 300)
plot_grid(phyRabRESPONSEwk6_figure2, phyRabREMISSwk6_figure2, labels = c("A", "B"), align = "v", nrow=2)
dev.off()
