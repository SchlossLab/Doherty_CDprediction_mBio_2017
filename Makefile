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
# Part 1: Get the references 													#
#																				#
# We will need several reference files to complete the analyses including the   #
# SILVA reference alignment and RDP reference taxonomy.                         #
#																				#
#################################################################################

# We want the latest greatest reference alignment and the SILVA reference
# alignment is the best reference alignment on the market. This version is from
# v123 and described at http://blog.mothur.org/2015/12/03/SILVA-v123-reference-files/
# We will use the SEED v. 123, which contain 12,083 bacterial sequences. This
# also contains the reference taxonomy. We will limit the databases to only
# include bacterial sequences.

#make data/refs/silva.v4.align
$(REFS)/silva.v4.align :
	wget -N http://mothur.org/w/images/1/15/Silva.seed_v123.tgz
	tar xvzf Silva.seed_v123.tgz silva.seed_v123.align silva.seed_v123.tax
	/Applications/mothur/mothur "#get.lineage(fasta=silva.seed_v123.align, taxonomy=silva.seed_v123.tax, taxon=Bacteria);degap.seqs(fasta=silva.seed_v123.pick.align, processors=8)"
	mv silva.seed_v123.pick.align $(REFS)/silva.seed.align
	rm Silva.seed_v123.tgz silva.seed_v123.*
	/Applications/mothur/mothur "#pcr.seqs(fasta=$(REFS)/silva.seed.align, start=11894, end=25319, keepdots=F, processors=8)"
	mv $(REFS)/silva.seed.pcr.align $(REFS)/silva.v4.align

# Next, we want the RDP reference taxonomy. The current version is v10 and we
# use a "special" pds version of the database files, which are described at
# http://blog.mothur.org/2014/10/28/RDP-v10-reference-files/

$(REFS)/trainset14_032015.% :
	wget -N http://mothur.org/w/images/8/88/Trainset14_032015.pds.tgz
	tar xvzf Trainset14_032015.pds.tgz trainset14_032015.pds/trainset14_032015.pds.*
	mv trainset14_032015.pds/* $(REFS)/
	rmdir trainset14_032015.pds
	rm Trainset14_032015.pds.tgz

##################################################################################
#																				 #
# Part 2: Run data through mothur 												 #
#																				 #
#	Process fastq data through the generation of files that will be used in the  #
# overall analysis.																 #
#																				 #
##################################################################################

# This runs the download of needed fastq files and runs sequence processing
# using the mothur program.  It runs up to the cluster.split step.  The
# majority of the processing can be found on www.mothur.org under the MiSeq
# SOP.

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
.PHONY : error
error : $(MOTHUR)/Jan400.trim.contigs.good.unique.good.filter.unique.precluster.denovo.uchime.pick.pick.count_table\
$(MOTHUR)/Jan400.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.fasta
	bash $(CODE)/errorrates.batch

#or run this if using UMich flux computing
.PHONY : qsub_error
qsub_error : $(MOTHUR)/Jan400.trim.contigs.good.unique.good.filter.unique.precluster.denovo.uchime.pick.pick.count_table\
$(MOTHUR)/Jan400.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.fasta
	qsub run_mothur_MiSeq_SOP_error_rate.PBS



#################################################################################
#																				#
# Metadata Processing, General Analysis, Building Figures and Tables										#
#																				#
#																				#
#################################################################################

# This modifies the meta data files by adding necessary categories (e.g. lesion)
# for files that will be used for all downstream analysis.

#remove NAs and make files for analysis
#acconos file was make by using na.omit on the metadata file in R and then copying the group to a text file called accnos
#this removes groups from analysis with NA in the metadata.

.PHONY : na.omit_files
na.omit_files : $(CODE)/analysis_files.batch\
$(MOTHUR)/Jan400.final.shared
	bash $(CODE)/analysis_files.batch



	
$(FIGS)/Figure_2 : $(CODE)/R_packages_setup.R\
$(CODE)/APmd.setup.R 
	R -e "source('code/Figure2_prediction.R')"
	

Figure_3 : $(CODE)/R_packages_setup.R\
$(CODE)/APmd.setup.R\
$(CODE)/tax.analysis.setup.R\
$(CODE)/tax.analysis.R\
$(CODE)/otu.analysis.R\
	R -e "source('code/FIgure3_REMISSwk6.sig.otu.figure.R')"
	
Figure_4 : $(CODE)/R_packages_setup.R\
$(CODE)/APmd.setup.R
	R -e "source('code/Figure4_alltp.adivXvisitXtrtgrXrelRSPwk22.R')"
	
Figure_5 : $(CODE)/R_packages_setup.R\
$(CODE)/APmd.setup.R
	R -e "source('code/Figure5_responseREMwk6Xwk6.R')"
	
SF_1 : $(CODE)/R_packages_setup.R\
$(CODE)/APmd.setup.R\
$(CODE)/tax.analysis.setup.R\
$(CODE)/tax.analysis.R\
$(CODE)/phylum.analysis.R
	R -e "source('code/SF1_week6phyla.R')"
	
Table_1 : $(CODE)/R_packages_setup.R\
$(CODE)/APmd.setup.R
	R -e "source('code/Table1_baseline_metadata.R')"
	
Table_2 : $(CODE)/R_packages_setup.R\
$(CODE)/APmd.setup.R
	R -e "source('code/table1.cohortdiv.R')"
	
ST_1 : $(CODE)/R_packages_setup.R\
$(CODE)/APmd.setup.R
	R -e "source('code/table2diversity.R')"
	
	
	
#####################################################################################
#																					#
# Part 5: Pull it all together 														#
#																					#
# Render the manuscript 															#
#																					#
#####################################################################################


write.paper : $(FINAL)/Doherty_CDprediciton_mBio_2017_finaldraft.Rmd
	R -e "source('code/Run_render_paper.R')"

