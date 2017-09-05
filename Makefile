#!bash

#makefile for Doherty_CDprediciton_mBio_2017

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

# Set local variables
REFS = data/references
FIGS = submission/figures
TABLES = submission/tables
MOTHUR = data/mothur/
FINAL = submission
CODE = code
METADATA = data/metadata
GZ_FILES = $(wildcard data/raw/*.fastq.gz)


# utility function to print various variables. For example, running the
# following at the command line:
#
#	make print-BAM
#
# will generate:
#	BAM=data/raw_june/V1V3_0001.bam data/raw_june/V1V3_0002.bam ...
print-%:
	@echo '$*=$($*)'

#################################################################################
#																				#
# Part 1: Run data through mothur 												 #
#																				 #
#	Process fastq.gz data through the generation of files that will be used in the  #
# overall analysis.																 #
#																				 #
##################################################################################

#make.contigs
#make /nfs/turbo/schloss-lab/mkdohert/maketest/data/mothur/Jan400.trim.contigs.fasta
.PHONY : make.contigs
make.contigs : $(GZ_FILES) $(MOTHUR)/Jan400.files
	bash $(CODE)/Jan400.make.contigs.batch

#or run this if using UMich flux computing
.PHONY : qsub_make.contigs
qsub_make.contigs : $(GZ_FILES) $(MOTHUR)/Jan400.files
	qsub run_mothur_MiSeq_SOP_make.contigs.PBS

#precluster
#make data/mothur/Jan400.trim.contigs.good.unique.good.filter.unique.precluster.fasta
##$(MOTHUR)/Jan400.trim.contigs.good.unique.good.filter.unique.precluster.fasta :
.PHONY : precluster
precluster : $(MOTHUR)/Jan400.trim.contigs.fasta\
$(MOTHUR)/Jan400.contigs.groups\
$(MOTHUR)/Jan400.trim.contigs.summary
	bash $(CODE)/Jan400.pre.cluster.batch

#or run this if using UMich flux computing
.PHONY : qsub_precluster
qsub_precluster : $(MOTHUR)/Jan400.trim.contigs.fasta\
$(MOTHUR)/Jan400.contigs.groups\
$(MOTHUR)/Jan400.trim.contigs.summary
	qsub run_mothur_MiSeq_SOP_pre.clust.PBS


#uchime
#make data/mothur/Jan400.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.fasta
#$(MOTHUR)/Jan400.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.fasta :
.PHONY : uchime
uchime : $(MOTHUR)/Jan400.trim.contigs.good.unique.good.filter.unique.precluster.fasta\
$(MOTHUR)/Jan400.trim.contigs.good.unique.good.filter.unique.precluster.count_table
	bash $(CODE)/Jan400.uchime.batch

#or run this if using UMich flux computing
.PHONY : qsub_uchime
qsub_uchime : $(MOTHUR)/Jan400.trim.contigs.good.unique.good.filter.unique.precluster.fasta\
$(MOTHUR)/Jan400.trim.contigs.good.unique.good.filter.unique.precluster.count_table
	qsub run_mothur_MiSeq_SOP_uchime_rm.lin.PBS
	
#cluster.split
#make data/mothur/Jan400.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.an.unique_list.list
#$(MOTHUR)/Jan400.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.an.unique_list.list :
.PHONY : cluster.split
cluster.split : $(MOTHUR)/Jan400.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.fasta\
$(MOTHUR)/Jan400.trim.contigs.good.unique.good.filter.unique.precluster.denovo.uchime.pick.pick.count_table\
$(MOTHUR)/Jan400.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.pick.taxonomy
	bash $(CODE)/Jan400.cluster.split.batch

#or run this if using UMich flux computing
.PHONY : qsub_cluster.split
qsub_cluster.split : $(MOTHUR)/Jan400.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.fasta\
$(MOTHUR)/Jan400.trim.contigs.good.unique.good.filter.unique.precluster.denovo.uchime.pick.pick.count_table\
$(MOTHUR)/Jan400.trim.contigs.good.unique.good.filter.unique.precluster.pick.pds.wang.pick.taxonomy
	qsub run_mothur_MiSeq_SOP_cluster.split.PBS

#makeshared
#make data/mothur/Jan400.an.shared
#$(MOTHUR)/Jan400.an.shared :
.PHONY : shared
shared : $(MOTHUR)/Jan400.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.an.unique_list.list\
$(MOTHUR)/Jan400.trim.contigs.good.unique.good.filter.unique.precluster.denovo.uchime.pick.pick.count_table\
$(MOTHUR)/Jan400.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.fasta
	bash $(CODE)/Jan400.make.shared.batch

#or run this if using UMich flux computing
.PHONY : qsub_shared
qsub_shared : $(MOTHUR)/Jan400.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.an.unique_list.list\
$(MOTHUR)/Jan400.trim.contigs.good.unique.good.filter.unique.precluster.denovo.uchime.pick.pick.count_table\
$(MOTHUR)/Jan400.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.fasta
	qsub run_mothur_MiSeq_SOP_make.shared.PBS

#error rates
.PHONY : error.rates
error : $(MOTHUR)/Jan400.count_table\
$(MOTHUR)/Jan400.fasta
	bash $(CODE)/errorrates.batch

#or run this if using UMich flux computing
.PHONY : qsub_error.rates
qsub_error.rates : $(MOTHUR)/Jan400.count_table\
$(MOTHUR)/Jan400.fasta
	qsub run_mothur_MiSeq_SOP_error_rate.PBS



#################################################################################
#
#	Part 2:																			#
# Metadata Processing, General Analysis, Building Figures and Tables										#
#																				#
#																				#
#################################################################################

# This modifies the meta data files by adding necessary categories (e.g. lesion)
# for files that will be used for all downstream analysis.

#remove NAs and make files for analysis
#acconos file was make by using na.omit on the metadata file in R and then copying the group to a text file called accnos
#this removes groups from analysis with NA in the metadata.

.PHONY : analysis_files
analysis_files : $(CODE)/analysis_files.batch\
$(MOTHUR)/Jan400.an.shared
	bash $(CODE)/analysis_files.batch

.PHONY : qsub_analysis_files
qsub_analysis_files : $(CODE)/analysis_files.batch\
$(MOTHUR)/Jan400.an.shared
	qsub run_analysis_files.PBS

.PHONY : Figure_2	
Figure_2 : $(CODE)/R_packages_setup.R\
$(CODE)/APmd.setup.R 
	R -e "source('code/Figure2_prediction.R')"
	
.PHONY : Figure_3
Figure_3 : $(CODE)/R_packages_setup.R\
$(CODE)/APmd.setup.R\
$(CODE)/tax.analysis.setup.R\
$(CODE)/tax.analysis.R\
$(CODE)/otu.analysis.R
	R -e "source('code/FIgure3_REMISSwk6.sig.otu.figure.R')"

#figure4 may require running the R code directly. Not sure what/where the bug is as the code works when run in R,
# but does not produce pdf/tiff when sourced
.PHONY : Figure_4
Figure_4 : $(CODE)/R_packages_setup.R\
$(CODE)/APmd.setup.R
	R -e "source('code/Figure4_alltp.adivXvisitXtrtgrXRESPONSEwk22.R')"
	
.PHONY : Figure_5
Figure_5 : $(CODE)/R_packages_setup.R\
$(CODE)/APmd.setup.R
	R -e "source('code/Figure5_responseREMwk6Xwk6.R')"

#like figure4, SF_1 may require running the R code directly. Not sure what/where the bug is as the code works when run in R,
# but does not produce pdf/tiff when sourced	
.PHONY : SF_1 
SF_1 : $(CODE)/R_packages_setup.R\
$(CODE)/APmd.setup.R\
$(CODE)/tax.analysis.setup.R\
$(CODE)/tax.analysis.R\
$(CODE)/phylum.analysis.R
	R -e "source('code/SF1_week6phyla.R')"

.PHONY : Table_1_ST_1	
Table_1_ST_1 : $(CODE)/R_packages_setup.R\
$(CODE)/APmd.setup.R
	R -e "source('code/makeTable1&SuppTbl1.R')"
	
.PHONY : Table_2
Table_2 : $(CODE)/R_packages_setup.R\
$(CODE)/APmd.setup.R
	R -e "source('code/makeTable2diversity.R')"
	
	
	
#####################################################################################
#																					#
# Part 3: Pull it all together 														#
#																					#
# Render the manuscript 															#
#																					#
#####################################################################################


write.paper : $(FINAL)/Doherty_CDprediciton_mBio_2017_finaldraft.Rmd
	R -e "source('code/Run_render_paper.R')"

