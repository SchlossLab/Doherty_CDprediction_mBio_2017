#makefile for my paper
##########################################################################################

#files
#/mnt/EXT/Schloss-data/Janssen/Janssen_data/~
#run_mothur_MiSeq_SOP_make.contigs.PBS,
#run_mothur_MiSeq_SOP_pre.clust.PBS,
#run_mothur_MiSeq_SOP_uchime_rm.lin.PBS,
#run_mothur_MiSeq_SOP_cluster.split.PBS,
#run_mothur_MiSeq_SOP_make.shared.PBS
#Jan400_~make.contigs, pre.clust, uchime, cluster.split, make.shared~_batch

#Doherty_CDprediciton_mBio_2017_finaldraft.Rmd
	#adivXvisit.facetTRTGR+RelRSPwk22.R
	#alltp.adivXvisitXtrtgrXrelRSPwk22.R
	#APmd.setup.R
	#Figure2_prediction.R
	#FIgure3_REMISSwk6.sig.otu.figure.R
	#Figure4_alltp.adivXvisitXtrtgrXrelRSPwk22.R
	#Figure5_responseREMwk6Xwk6.R
	#knitr_settings.R
	#otu.analysis.R
	#phylum.analysis.R
	#R_packages_setup.R
	#README.md
	#SF1_responseREMwk6Xwk6.R
	#SF1_week6phyla.R
	#Supptable1.cohortdiv.R
	#Table1_baseline_metadata.R
	#table1.cohortdiv.R
	#table2diversity.R
	#tax.analysis.R
	#tax.analysis.setup.R

##########################################################################################


#psuedocoded for make

#run first mothur batch - make contigs
qsub run_mothur_MiSeq_SOP_make.contigs.PBS

#run precluster
qsub run_mothur_MiSeq_SOP_pre.clust.PBS

#run next
qsub run_mothur_MiSeq_SOP_uchime_rm.lin.PBS

#
qsub run_mothur_MiSeq_SOP_cluster.split.PBS

#generate shared
qsub run_mothur_MiSeq_SOP_make.shared.PBS

#render paper Rmd to pdf with R code dependencies
R 