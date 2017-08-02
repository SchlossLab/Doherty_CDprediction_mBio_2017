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
mothurRV = Applications/mothur/mothur!!!!


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
#make data/process/mothur/WB/WBI.trim.contigs.fasta
$(MOTHUR)/WBI.trim.contigs.fasta :
	bash $(CODE)/WBI.make.contigs.batch
#	qsub run_mothur_MiSeq_SOP_make.contigs.PBS

#precluster
#make data/process/mothur/WB/WBI.trim.contigs.good.unique.good.filter.unique.precluster.fasta
$(MOTHUR)/WBI.trim.contigs.good.unique.good.filter.unique.precluster.fasta :
	bash $(CODE)/WBI.pre.cluster.batch
#	qsub run_mothur_MiSeq_SOP_pre.clust.PBS

#uchime
#make data/process/mothur/WB/WBI.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.fasta
$(MOTHUR)/WBI.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.fasta :
	bash $(CODE)/WBI.uchime.batch
#	qsub run_mothur_MiSeq_SOP_uchime_rm.lin.PBS
	
#cluster.split
#make data/process/mothur/WB/WBI.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.an.unique_list.list
$(MOTHUR)/WBI.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.an.unique_list.list :
	bash $(CODE)/WBI.cluster.split.batch
#	qsub run_mothur_MiSeq_SOP_cluster.split.PBS
	
#makeshared
#make data/process/mothur/WB/WBI.an.shared
$(MOTHUR)/WBI.an.shared :
	bash $(CODE)/WBI.make.shared.batch
#	qsub run_mothur_MiSeq_SOP_make.shared.PBS
	
#error rates
$(MOTHUR)/stability.trim.contigs.good.unique.good.filter.unique.precluster.pick.pick.pick.error.% :
	bash $(CODE)/errorrates.batch
#	qsub run_mothur_MiSeq_SOP_error_rate.PBS



#################################################################################
#																				#
# Metadata Processing and General Analysis 										#
#																				#
#																				#
#################################################################################

# This modifies the meta data files by adding necessary categories (e.g. lesion)
# for files that will be used for all downstream analysis.



#####################################################################################
#																					#
# Part 5: Pull it all together 														#
#																					#
# Render the manuscript 															#
#																					#
#####################################################################################


write.paper : $(FINAL)/manuscript.Rmd\
		$(FINAL)/supplement.Rmd\
		results/tables/Table1.Rmd results/tables/Table2.Rmd\
		$(TABLES)/mod_metadata/good_metaf_final.csv\
		$(FIGS)/Figure1.pdf $(FIGS)/Figure2.pdf\
		$(FIGS)/Figure3.pdf $(FIGS).Figure4.pdf\
		$(FIGS)/FigureS2.pdf\ $(FIGS)/FigureS3.pdf 
		$(FIGS)/FigureS4.pdf code/Run_render_paper.R
	R -e "source('code/Run_render_paper.R')"

write.revision1.paper : $(FINAL)/manuscript_R1.Rmd\
		$(FIGS)/FigureS1.pdf code/Run_render_revision1_paper.R
	R -e "source('code/Run_render_revision1_paper.R')"

write.r1.marked.up : $(FINAL)/manuscript.tex\
		$(FINAL)/manuscript_R1.tex
	latexdiff $(FINAL)/manuscript.tex $(FINAL)/manuscript_R1.tex > $(FINAL)/manuscript_R1_markedup.tex
	pdflatex -output-directory=$(FINAL) $(FINAL)/manuscript_R1_markedup.tex
	rm $(FINAL)/{manuscript,manuscript_R1,manuscript_R1_markedup}.tex
	rm $(FINAL)/manuscript_R1_markedup.{aux,log,out}
#render paper Rmd to pdf with R code dependencies
R 