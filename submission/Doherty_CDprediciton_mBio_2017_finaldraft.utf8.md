---
title: Fecal microbiota signatures are associated with response to Ustekinumab therapy
  among Crohn’s Disease patients
csl: mbio.csl
fontsize: 12pt
output:
  html_document: default
  md_document: default
  pdf_document:
    keep_tex: yes
    latex_engine: xelatex
header-includes:
- \usepackage{setspace}
- \doublespacing
- \usepackage{lineno}
- \linenumbers
- \renewcommand{\familydefault}{\sfdefault}
- \usepackage{graphicx}
geometry: margin=1.0in
bibliography: My_Library_copy.bib
---






































































































\vspace{35mm}
	
Running title: Microbiota of Ustekinumab-treated Crohn’s subjects.
	
\vspace{35mm}
Matthew K. Doherty${^1}$, Tao Ding${^1}$${^\alpha}$, Charlie Koumpouras${^1}$, Shannon E. Telesco${^2}$, Calixte Monast${^2}$, Anuk Das${^2}$, Carrie Brodmerkel${^2}$, and Patrick D. Schloss${^1}$${^\dagger}$

$\dagger$ To whom correspondence should be addressed: Patrick D. Schloss, pschloss@umich.edu

1\. Department of Microbiology and Immunology, University of Michigan, Ann Arbor, MI, USA

2\. Janssen Pharmaceutical Companies of Johnson ${\&}$ Johnson, Spring House, PA, USA


${\alpha}$ Currently at Department of Biology, New York University, New York, NY, USA.





\newpage








## Abstract
The fecal microbiota is a rich source of biomarkers that have previously been shown to be predictive of numerous disease states. Less well studied is the effect of immunomodulatory therapy on the microbiota and its role in response to therapy. This study explored associations between the fecal microbiota and therapeutic response of Ustekinumab (UST) treated Crohn’s disease (CD) patients. Using stool samples collected over the course of 22 weeks, the composition of these subjects' fecal bacterial communities was characterized by sequencing the 16S rRNA gene. Subjects in remission could be distinguished from those with active disease 6 weeks after treatment using Random Forest models trained on subjects' baseline microbiota and clinical data (AUC = 0.844, specificity = 0.831, sensitivity = 0.774). The most predictive OTUs that were ubiquitous among subjects were affiliated with *Faecalibacterium* and *Escherichia/Shigella*. Among subjects in remission 6 weeks after treatment, the median baseline community diversity was 1.7 times higher than treated subjects with active disease (p = 0.020). Their baseline community structures were also significantly different (p = 0.017). Two OTUs affiliated with *Faecalibacterium* (p = 0.003) and *Bacteroides* (p = 0.022) were significantly more abundant at baseline in subjects who were in remission 6 weeks after treatment than those with active CD. The diversity of UST treated clinical responders increased over the 22 weeks of the study, in contrast to nonresponsive subjects (p = 0.012). The observed baseline differences in fecal microbiota and changes due to therapeutic response support the potential for the microbiota as a response biomarker. (word count= 246/250, TextWrangler)

_Importance:_  CD is a global health concern, with increasing incidence and prevalence, causing large economic and health care impacts. Finding prognostic biomarkers that give clinicians the ability to identify patients more likely to respond to CD treatment at diagnosis will reduce the time that subjects spend taking drugs that will not be beneficial. OTUs associated with remission after treatment induction, especially *Faecalibacterium*, could be biomarkers for successful UST treatment of TNF-${\alpha}$ refractory CD patients. More broadly, these results suggest the fecal microbiota could be a useful non-invasive biomarker for directing or monitoring the treatment of gastrointestinal diseases. (word count =98/150, TextWrangler)


**Keywords: IBD, microbiome, biologics, prediction, biomarkers, remission, Stelara, machine learning**

\newpage

###Introduction
The microbiome has been correlated with a variety of diseases and has shown promise as a predictive tool for disease outcome for gingivitis [@Huang_gingivitis_2014], cardiovascular disease [@Wang_cvdrisk_2016], *Clostridium difficile* infection [@Schubert_cdiff_2015; @Seekatz_cdiff_2016], and colorectal cancer [@zackular_CRC_2014; @baxter_FIT_2016]. Additionally, the microbiome has been shown to alter the efficacy of vaginal microbicides in African women [@Klatt_microbicide_2017], as well as cardiac drugs [@Haiser_cardiac_2013] and cancer treatments [@Sivan_cancer_2015; @Vetizou_cancer_2015] in murine models of disease. These results demonstrate that it is possible to use biomarkers from within the microbiome to predict response to therapeutics. In relation to inflammatory bowel disease (IBD), previous studies have shown that the bacterial gut microbiota correlates with disease severity in new-onset, pediatric Crohn’s disease (CD) patients [@gevers_pedsCD_2014; @wang_pedsCD_2016]. Additionally, recent studies suggest the gut microbiota could be used to predict clinical response to treatment in individuals with IBD [@Ananthakrishnan_IBD_2017; @Shaw_response_2016]. It remains to be determined, however, whether the composition of the fecal gut microbiota can predict and monitor response to CD therapy. Considering the involvement of the immune system and previous evidence for involvement of the microbiome, we hypothesize that response to immunological CD therapy can be predicted using microbiome data.

CD is a global health concern causing large economic and health care impacts [@ananthakrishnan_epidemiology_2015; @floyd_economicburden_2015]. The disease is characterized by patches of ulceration and inflammation along the entire gastrointestinal tract, with most cases involving the ileum and colon. Currently, individuals with CD are treated based on disease location and risk of complications using escalating immunosuppressive treatment, and/or surgery, with the goal of achieving and sustaining remission [@randall_CDbiologics_2015; @wils_ust_2015]. Faster induction of remission following diagnosis reduces the risk of irreversible intestinal damage and disability [@wils_ust_2015; @colombel_deepremission_2015; @baert_mucosalhealing_2010]. Ideally, clinicians would be able to determine personalized treatment options for CD patients at diagnosis that would result in faster achievement of remission [@Lichtenstein_biomarkers_2010]. Therefore, recent research has been focused on identifying noninvasive biomarkers to monitor CD severity and predict therapeutic response [@Chang_biomarkers_2015; @Boon_biomarkers_2015; @Falvey_biomarkers_2015]. 

The precise etiology of CD remains unknown, but host genetics, environmental exposure, and the gut microbiome appear to be involved [@ananthakrishnan_epidemiology_2015; @sartor_IBDpath_2006]. Individuals with CD have reduced microbial diversity in their guts, compared to healthy individuals, with a lower relative abundance of *Firmicutes* and an increased relative abundance of *Enterobacteraciae* and *Bacteroides* [@wright_CDmicrobiome_2015; @manichanh_diversityCD_2006; @hansen_pedsIBD_2012; @haberman_pedsCD_2014; @gevers_pedsCD_2014]. Additionally, genome-wide association studies of individuals with CD identified several susceptibility loci including loci involved in the IL-23 signaling pathway, which could impact the gut microbiota composition and function [@randall_CDbiologics_2015; @wright_CDmicrobiome_2015; @Riol-Blanco_IL23microbiome_2010; @Round_IL23microbiome_2009; @Eken_IL23CD_2014; @Shih_IL23Th17_2014]. If the fecal microbiota can be used to monitor disease severity and predict response to specific treatment modalities, then clinicians could use it as a noninvasive tool for prescribing therapies that result in faster remission [@tedjo_CDactivity_2016]. 

The FDA recently approved Ustekinumab (UST), a monoclonal antibody directed against the shared p40 subunit of IL-12 and IL-23, for the treatment of CD [Feagan_UST_2016; @wils_ust_2015; @sandborn_ust_2012; @sandborn_ust_2008; @kopylov_ust_2014]. Given the potential impact of IL-23 on the microbiota [@Riol-Blanco_IL23microbiome_2010; @Round_IL23microbiome_2009; @Eken_IL23CD_2014; @Shih_IL23Th17_2014], we hypothesized that response to UST could be influenced by differences in subjects’ gut microbiota and that UST treatment may alter the fecal microbiota. The effects of biologic treatment of IBD on the microbiota are not yet well described, but are hypothesized to be indirect, as these drugs act on host factors [@randall_CDbiologics_2015]. We analyzed the fecal microbiota of subjects who participated in a double-blinded, placebo-controlled Phase II clinical trial that demonstrated the safety and efficacy of UST for treating CD [@sandborn_ust_2012]. The original study found that UST induction treatment had an increased rate of response as well as increased rates of response and remission with UST maintenance therapy, compared to placebo. We quantified the association between the fecal microbiota and disease severity, tested whether clinical responders had a microbiota that was distinct from non-responders, and determined whether the fecal microbiota changed in subjects treated with UST using 16S rRNA gene sequence data from these subjects' stool samples.  Our study demonstrates that these associations may be useful in predicting and monitoring UST treatment outcome and suggest the fecal microbiota may be a broadly useful source of biomarkers for predicting response to treatment.

## Results

**Study design**

We characterized the fecal microbiota in a subset of anti-TNF-${\alpha}$ refractory CD patients, with moderate to severe CD, who took part in a randomized, double-blinded, placebo-controlled phase 2b clinical trial that demonstrated the efficacy of UST in treating CD [@sandborn_ust_2012].  Demographic and baseline disease characteristics of this subset are summarized in Table 1. Subjects were randomly assigned to a treatment group in the induction phase of the study and were re-randomized into maintenance therapy groups 8 weeks after induction based on their response (Figure 1A). In the current study, response was defined as a decrease in a subject's initial Crohn's Disease Activity Index (CDAI) greater than 100 points or remission. Remission was defined as a CDAI below 150 points. The CDAI is the standard instrument for evaluating clinical symptoms and disease activity in CD [@PB_CDAI_2016; @Best_CDAI_1976]. The CDAI weights patient reported stool frequency, abdominal pain, and general well being over a week, in combination with weight change, hematocrit, opiate usage for diarrhea, and the presence of abdominal masses or other complications to determine the disease severity score [@Best_CDAI_1976; @PB_CDAI_2016]. Subjects provided stool samples at baseline (screening) and at 4, 6, and 22 weeks after induction for analysis using 16S rRNA gene sequencing (Figure 1B). The number of subjects in each treatment group at the primary and secondary endpoints are summarized in Table 2 by their treatment outcome.

**Association of baseline microbial signatures with treatment remission**

We investigated whether the composition of the baseline fecal microbiota could predict therapeutic remission (CDAI < 150) 6 weeks after induction. To test this hypothesis, we generated Random Forest (RF) models to predict which subjects would be in remission 6 weeks after induction based on the relative abundance of the fecal microbiota at baseline, clinical metadata at baseline, and the combination of microbiota and clinical data. We determined the optimal model based the largest area under the curve (AUC) of the receiver operating characteristic (ROC) curve for the RF model [@baxter_FIT_2016; @calle_aucrf_2011]. Clinical data included components of the CDAI, biomarkers for inflammation, and subject metadata described further in the methods section. We trained these models using 232 baseline stool samples from subjects induced with UST; 31 of which acheived remission (Table 2). Clinical data alone resulted in an AUC of 0.616 (specificity = 0.801, sensitivity = 0.452) (Figure 2A). Using only fecal microbiota data the model had an AUC of 0.838 (specificity = 0.766, sensitivity = 0.806). Finally, when combining clinical metadata with the microbiota we achieved an AUC of 0.844 (specificity = 0.831, sensitivity = 0.774) for remission 6 weeks after induction. Prediction with clinical metadata alone did not perform as well as models using the baseline fecal microbiome (p = 0.001) or the combined model (p = 0.001); however, there was not a significant difference between the baseline fecal microbiota model and the combined model (p = 0.841). 

Optimal predictors were determined based on their mean decrease in accuracy (MDA) in the ability of the model to classify remission from active CD (Figure 2B). The majority of OTUs identified as optimal predictors in our model for remission had low abundance. However, two OTUs were differentially abundant for subjects in remission 6 weeks after induction. The relative abundance of *Escherichia/Shigella* (OTU1) was lower in subjects in remission 6 weeks after induction (median = 1.07%, IQR = 0.033-3.70) compared to subjects with active CD (median = 4.13%, IQR = 0.667-15.4).  Also, the relative abundance of *Faecalibacterium* (OTU7) was not only higher in subjects in remission 6 weeks after induction (median = 7.43%, IQR = 1.43-11.9) than subjects with active CD (median = 0.167%, IQR = 0-5.10), but it was also present prior to the start of treatment in every subject who was in remission 6 weeks after induction. 

**Association of baseline microbial signatures with treatment response**

We also hypothesized that the composition of the baseline fecal microbiota could predict therapeutic response (CDAI decrease ≥ 100 or remission) 6 weeks after induction. To test this hypothesis, we again used RF models to classify responders from non-responders 6 weeks after induction (Table 2). Clinical data alone resulted in an AUC of 0.651 (specificity = 0.545, sensitivity = 0.724) (Figure 2C). Using only microbiota data, the model predicted response with an AUC of 0.762 (specificity = 0.558, sensitivity = 0.882). When combining clinical metadata with the microbiome, the model predicted response with an AUC of 0.733 (specificity = 0.724, sensitivity = 0.684). 

The microbiota model was significantly better able to predict response than the metadata alone (p = 0.017), whereas this was not true for the combined model (p = 0.069). Additionally, the combined model and the fecal microbiota model were not significantly different in their ability to predict response (p = 0.263). Optimal predictors were again determined based on their MDA in the ability of the model to classify response (Figure 2D). Also, our baseline combined model was significantly better at classifying remission compared to response (p = 0.036), whereas this was not true for the fecal microbiota model (p = 0.117).

**Comparison of baseline microbiota based on clinical outcome**

As our RF models identified OTUs abundant across our cohort that were important in classification of outcome, we further investigated differences in the baseline microbiota that could serve as potential biomarkers for successful UST treatment. We compared the baseline microbiota of all 306 subjects who provided a baseline sample based on treatment group and treatment outcome 6 weeks after induction to asses diversity measures (Table 2). There was no significant difference in diversity based on response 6 weeks after induction, however the baseline ${\beta}$-diversity was significantly different by response (p = 0.018). No phyla were significantly different by treatment and response (Fig. S1) and no OTUs were significantly different based on UST response or among subjects receiving placebo for induction, regardless of response and remission status. 

Subjects in remission 6 weeks after induction with UST had significantly higher baseline ${\alpha}$-diversity based on the inverse Simpson diversity index than subjects with active CD (respective median values = 11.6 (IQR = 4.84-13.4), 6.95 (IQR = 4.25-11.8), p = 0.020). The baseline community structure was also significantly different based on remission status in subjects 6 weeks after induction (p = 0.017). Finally, 2 OTUs were significantly more abundant in subjects in remission 6 weeks after induction compared to subjects with active CD: *Bacteroides* (OTU19) (p = 0.022) and *Faecalibacterium* (OTU7) (p = 0.003) (Figure 3).  

**Variation in the baseline microbiota is associated with variation in clinical phenotypes**

Based on the associations we identified between baseline microbial diversity and response, we hypothesized that there were associations between the microbiota and clinical variables at baseline that could support the use of the microbiota as a non-invasive biomarker for disease activity [@tedjo_CDactivity_2016]. To test this hypothesis, we compared the baseline microbiota with clinical data at baseline for all 306 samples provided at baseline (Supplemental Table 1). We observed small, but significant correlations for lower ${\alpha}$-diversity correlating with higher CDAI (${\rho}$ = -0.161, p = 0.014), higher frequency of loose stools per week (${\rho}$ = -0.193, p = 0.003), and longer disease duration (${\rho}$ = -0.225, p = 0.001). Corticosteroid use was associated with 1.45 times higher ${\alpha}$-diversity (p = 0.001). No significant associations were observed between ${\alpha}$-diversity and CRP, fecal calprotectin, or fecal lactoferrin. However, the ${\beta}$-diversity was significantly different based on CRP (p = 0.033), fecal calprotectin (p = 0.006), and fecal lactoferrin (p = 0.004). The ${\beta}$-diversity was also significantly different based on weekly loose stool frequency (p= 0.024), age (p = 0.033), the tissue affected (p = 0.004), corticosteroid use (p =0.010), and disease duration (p = 0.004). No significant differences in ${\alpha}$ or ${\beta}$ diversity were observed for BMI, weight, or sex.

**The diversity of the microbiota changes following UST therapy**

We tested whether treatment with UST altered the microbiota by performing a Friedman test comparing ${\alpha}$-diversity, based on the inverse Simpson diversity index, at each time point within each treatment group based on the subject's response 22 weeks after induction. We included 48 subjects induced and maintained with UST (18 responders, 30 non-responders) and 14 subjects induced and maintained with placebo (8 responders, 6 non-responders), who provided samples at every time point (Figure 1). We saw no significant difference in the ${\alpha}$-diversity over time in subjects who did not respond 22 weeks after induction, regardless of treatment, and in subjects who responded to placebo (Figure 4). However, the median ${\alpha}$-diversity of responders 22 weeks after UST induction significantly changed over time (p = 0.012) having increased from baseline (median = 6.65, IQR = 4.60 - 9.24) to 4 weeks after UST induction(median = 9.33, IQR = 6.54 - 16.7), decreased from 4 to 6 weeks after induction (median = 8.42, IQR = 4.93 - 17.5), and was significantly higher than baseline (p < 0.05) at 22 weeks after induction (median = 10.7, IQR = 
5.49 - 14.6).

**The microbiota after induction can distinguish between treatment outcomes**

Having demonstrated the microbiome changes in subjects who responded to UST treatment, we hypothesized that the microbiota could be used to monitor response to UST therapy by classifying subjects based on disease activity [@tedjo_CDactivity_2016]. We again constructed RF classification models to distinguish between subjects by UST treatment outcome based on their fecal microbiota 6 weeks after induction [@baxter_FIT_2016; @calle_aucrf_2011]. The study design resulted in only 75 week twenty-two stool samples from subjects induced and maintained with UST, so we focused our analysis on the 220 week 6 stool samples from subjects induced with UST. We were again better able to distinguish subjects in remission from subjects with active CD compared to responders from non-responders (p = 0.005; Figure 5A). Our model could classify response 6 weeks after induction using week 6 stool samples from subjects treated with UST with an AUC of 0.72 (sensitivity = 0.563, specificity = 0.812). For classifying subjects in remission from subjects with active CD 6 weeks after UST induction using week 6 stool samples, the model had an AUC of 0.866 (sensitivity = 0.833, specificity = 0.832). OTUs that were important for these classifications again included *Faecalibacterium* (OTU7), as well as *Blautia* (OTU124), *Clostridium XIVa* (OTU73), *Ruminococcaceae* (OTU53), and *Roseburia* (OTU12). These all had higher median relative abundance in subjects in remission 6 weeks after induction than those with active disease (Figure 5B).

## Discussion

We sought to determine whether fecal microbiota can be used to identify patients who will respond to UST therapy and to gain a more detailed understanding of how UST treatment may affect the microbiota. We demonstrated that the microbiota could identify patients more likely to achieve remission following UST therapy, compared to clinical metadata alone, in this unique cohort, though this will need to be validated in future studies with independent cohorts. We also found the fecal microbiota to be associated with CD severity metrics and treatment outcomes. Finally, we found that the microbiota of treated responders changed over time. These results helped further our understanding of the interaction between the human gut microbiota and CD in adult subjects with moderate-to-severe CD refractory to anti-TNF-${\alpha}$ therapies.

The development of predictive models for disease or treatment outcome is anticipated to have a significant impact on clinical decision-making in health care [@Vogenberg_progmods_2009]. These models will help clinicians decide on the correct course of disease treatment or interventions for disease prevention with their patients. Additionally, patients will benefit with more individualized care that will potentially reduce adverse effects and result in faster recovery, reduce expenses from ineffective therapies, or increase quality of life by preventing disease in patients with high risk.

Our predictive model revealed potential microbial biomarkers for successful UST therapy and allowed us to generate hypotheses about the biology of CD as it relates to the microbiome and UST response. *Faecalibacterium* frequently occurred in our models. It is associated with health, comprising up to 5% of the relative abundance in healthy individuals, and is generally rare in CD patients [@wright_CDmicrobiome_2015; @hansen_pedsIBD_2012; @naftali_tissinvol_2016; @sartor_microbesIBD_2016]. Each subject in remission 6 weeks after UST induction had measurable *Faecalibacterium* present at baseline. This supports the hypothesis that *Faecalibacterium* impacts CD pathogenesis. It may even be beneficial to administer *Faecalibacterium* as a probiotic during therapy. *Escherichia/Shigella* also occurred frequently in our models. This OTU is associated with inflammation and has been shown to be associated with CD [@sartor_microbesIBD_2016]. Many other taxa observed in our analysis had low abundance or were absent in the majority of subjects. However, in many cases these taxa are related and may serve similar ecologic and metabolic roles in the gut environment. We hypothesize that these microbes may have genes that perform similar metabolic functions. Performing metagenomics on stool samples in future studies, especially in patients who achieve remission, could reveal these functions, which could be further developed into a clinically useful predictive tool.

We were better able to predict whether a subject would achieve clinical remission rather than clinical response, as determined by CDAI score. We hypothesize that this was due to the relative nature of the response criteria compared to the threshold used to determine remission status. While the field appears to be moving away from CDAI and towards more objectively quantifiable patient reported outcomes and endoscopic verification of mucosal healing [@colombel_deepremission_2015; PRO ref], research is ongoing to discover less invasive and objectively quantifiable biomarkers [biomarkers refs].

We identified several associations between the microbiota and clinical variables that could impact how CD is monitored and treated in the future. Serum CRP, fecal calprotectin, and fecal lactoferrin are widely used as biomarkers to measure inflammation and CD severity. We found that the microbial community structure was different among subjects based on these markers. These results support the hypothesis that the fecal microbiota could function as a biomarker for measuring disease activity in patients, especially in concert with established inflammatory biomarkers [@tedjo_CDactivity_2016; @boon_fmarkers_2015; @chang_monitoring_2015]. We also found that higher CDAI scores were associated with lower microbial diversity. This is consistent with other studies on the microbiota in individuals with CD compared to healthy individuals and studies looking at active disease compared to remission [@gevers_pedsCD_2014; @papa_pedsIBD_2012; @tedjo_CDactivity_2016]. However, the CDAI sub score of weekly stool frequency may have driven these differences (Supplementary Table 1), which is consistent with previous studies [@vandeputte_stoolcon_2016]. We also observed differences in the microbial community structure based on disease localization, which is consistent with a study by Naftali et al [@naftali_tissinvol_2016]. Our study also found that corticosteroid use impacts the composition of the human fecal microbiota, which is consistent with observations in mouse models [@huang_cort_2015]. We also observed that longer disease duration is associated with a reduction in fecal microbial diversity. We hypothesize that prolonged disease duration and the associated inflammation results in the observed decrease in diversity.

Further research into fecal microbiota as a source of biomarkers for predicting therapeutic response could eventually allow for the screening of patients with stool samples at diagnosis to better inform treatment decisions for a wide range of diseases. For CD specifically, using the microbiota to predict response to specific treatment modalities could result in more personalized treatment and faster achievement of remission, thereby increasing patients’ quality of life and reducing economic and health care impacts for CD patients. Our results showing that the ${\alpha}$-diversity of clinical UST responders increased over time, in contrast to non-responsive patients, and our ability to classify patients in remission from those with active disease following UST treatment are again consistent with other studies suggesting the microbiota could be a useful biomarker for predicting or monitoring response to treatment [@tedjo_CDactivity_2016]. These predictive biomarkers will need to be validated using independent cohorts in future studies. Additionally, the positive and negative associations between the microbiota and CD allow us to predict the types of mechanisms most likely to alter the microbiota in order to increase the likelihood of achieveing a therapeutic response or to monitor disease severity. Prior to the initiation of therapy, patients could have their fecal microbiome analyzed. Then the microbial community data could be used to direct the modification of a patient's microbiota prior to or during treatment with the goal of improving treatment outcomes. Since it has been shown experimentally that the microbiome can alter the efficacy of treatments for a variety of diseases [@Klatt_microbicide_2017; @Haiser_cardiac_2013; @Sivan_cancer_2015; @Vetizou_cancer_2015], if fecal microbiota can be validated as biomarkers to non-invasively predict response to therapy, then patients and clinicians will be able to more rapidly ascertain effective therapies that result in increased patient quality of life.
 



\newpage

###Methods

####Study Design and Sample Collection

Previously, a randomized, double-blinded, placebo-controlled phase II clinical study of approximately 500 subjects assessed the safety and efficacy of UST for treating anti-TNF-${\alpha}$ refractory, moderate to severe CD subjects [@sandborn_ust_2012] (Figure 1). Institutional review board approval was acquired at each participating study center and subjects provided written informed consent [@sandborn_ust_2012]. Subject data was de-identified for our study. Participants provided a stool sample prior to the initiation of the study and were then divided into treatment groups. Additional stool samples were provided 4 weeks after induction. At 6 weeks after induction an additional stool sample was collected, subjects were scored for their response to UST based on CDAI, and then divided into groups receiving either subcutaneous injection of UST or placebo at weeks 8 and 16 as maintenance therapy. Clinical response was defined as a reduction from baseline CDAI score of 100 or more points or as remission in subjects with a baseline CDAI score between 220 to 248 points [@sandborn_ust_2012]. Remission was defined as a CDAI below the threshold of 150. Finally, at 22 weeks subjects provided an additional stool sample and were then scored using CDAI for their response to therapy. Frozen fecal samples were shipped to the University of Michigan and stored at -80°C prior to DNA extraction.

####DNA extraction and 16S rRNA gene sequencing 

Microbial genomic DNA was extracted using the PowerSoil-htp 96 Well Soil DNA Isolation Kit (MoBio Laboratories) and an EPMotion 5075 pipetting system [@baxter_FIT_2016; @zackular_CRC_2014]. The V4 region of the 16S rRNA gene from each sample was amplified and sequenced using the Illumina MiSeq$\text{\texttrademark}$ platform [@chang_monitoring_2015]. Sequences were curated as described previously using the mothur software package (v.1.34.4) [@schloss_mothur_2009; @Kozich_MiSeqSOP_2013]. Briefly, we curated the sequences to reduce sequencing and PCR errors [@schloss_PCRartifacts_2011], aligned the resulting sequences to the SILVA 16S rRNA sequence database [@Quast_silva_2013], and used UCHIME to remove any chimeric sequences [@edgar_uchime_2011]. Sequences were clustered into operational taxonomic units (OTU) at a 97% similarity cutoff using the average neighbor algorithm [@schloss_OTUanalysis_2011]. All sequences were classified using a naive Bayesian classifier trained against the RDP training set (version 14) and OTUs were assigned a classification based on which taxonomy had the majority consensus of sequences within a given OTU [@wang_taxonomy_2007].  

Following sequence curation using the mothur software package [@schloss_mothur_2009], we obtained a median of 13,732 sequences per sample (IQR = 7,863-21,978). Parallel sequencing of a mock community had an error rate of 0.017%. To limit effects of uneven sampling, we rarefied the dataset to 3,000 sequences per sample. Samples from subjects that completed the clinical trial and had complete clinical metadata were included in our analysis. Of these samples, 306 were provided prior to treatment as well as 258 provided at week 4, 289 at week 6, and 205 at week 22 after treatment, for a total of 1,058 samples. All fastq files and the MIMARKS spreadsheet with de-identified clinical metadata are available at **SRA**. 

####Gut microbiota biomarker discovery and statistical analysis 

R v.3.3.2 (2016-10-31) and mothur were used to analyze the data [@R]. To assess ${\alpha}$-diversity, the inverse Simpson index was calculated for each sample in the dataset. Spearman correlation tests were performed to compare the inverse Simpson index and continuous clinical data. Wilcoxon rank sum tests were performed for pairwise comparisons and Kruskal-Wallis rank sum tests for comparisons with more than two groups [@sokal_biometrystats_1995; @magurran_measuring_2004]. To measure ${\beta}$-diversity, the distance between samples was calculated using the ${\theta}$YC metric, which takes into account the types of bacteria and their abundance to calculate the differences between the communities [@yue_thetaYC_2005]. These distance matrices were assessed for overlap between sets of communities using the non-parametric analysis of molecular variance (AMOVA) test as implemented in the adonis function from the vegan R package (v.2.4.3) [@oksanen_vegan_2016]. Changes in ${\alpha}$-diversity over time based on week 22 response was assessed using a Friedman test on subjects who provided a sample at each time point [@friedman_1937]. The Friedman test is a function in the stats R package (v.3.3.2). Multiple comparisons following a Friedman test were performed using the friedmanmc function in the pgirmess package (v.1.6.5) [@pgirmess]. Changes in ${\beta}$-diversity over time by treatment group and response were assessed using the adonis function in vegan stratified by subject. We used the relative abundance of each OTU, ${\alpha}$-diversity, age, sex, current medications, BMI, disease duration, disease location, fecal calprotectin, fecal lactoferrin, C-reactive protein, bowel stricture, and CDAI sub scores as input into our RF models constructed with the AUCRF R package (v.1.1) [@AUCRF], to identify phylotypes or clinical variables that distinguish between various treatment and response groups, as well as to predict or determine response outcome [@breiman_rf_2001, @calle_aucrf_2011]. Optimal predictors were determined based on their mean decrease in accuracy (MDA) of the model to classify subjects. Differentially abundant OTUs and phyla were selected through comparison of clinical groups using Kruskal-Wallis and Wilcox tests, where appropriate, to identify OTUs/phyla where there was a p-value less than 0.05 following a Benjamini-Hochberg correction for multiple comparisons [@Benjamini_Hochberg_1995].  Other R packages used in our analysis included ggplot2 v.2.2.1 [@ggplot2], dplyr v.0.5.0 [@dplyr], pROC v.1.9.1 [@pROC], knitr v.1.15.1 [@knitr2015], gridExtra v.2.2.1 [@gridExtra], devtools v.1.12.0 [@devtools], knitcitations v.1.0.7 [@knitcitations], scales v.0.4.1 [@scales], tidyr v.0.6.1 [@tidyr], Hmisc v.4.0.2 [@Hmisc], and cowplot v.0.7.0 [@cowplot]. A reproducible version of this analysis and manuscript are available at https://github.com/SchlossLab/Doherty_CDprediction_mBio_2017.


##Funding information.
Janssen Research and Development provided financial and technical support for this study. 

\newpage


## Tables
**Table 1: Summary of clinical metadata of cohort at baseline**


\includegraphics{tables/Table1_baseline_metadata.pdf}

\newpage

**Table 2: Summary of subjects in each treatment group by endpoint and outcome**

\includegraphics{tables/table2_resposne_treatN.pdf}

\newpage

**Supplemental Table 1: Diversity differences based on clinical metadata of cohort at baseline**


\includegraphics{tables/Supp.table1_cohortdiversity.png}

\newpage

## Figures

**Figure 1: Experimental design as adapted from Sandborn et al 2012.** (A) Participants were divided into treatment groups receiving placebo or UST by IV for induction. At week 8, subjects were divided into groups receiving either subcutaneous injection of UST or placebo at weeks 8 and 16 as maintenance therapy, based on response at week 6. Finally, at 22 weeks subjects were scored using CDAI for their response to therapy. (B) Stool sampling, treatment, and response evaluation time line. $\uparrow$, treatment administration; IV, intravenous; PE, primary endpoint; R, randomization; RR, re-randomization (only for subjects receiving UST induction therapy); SC, subcutaneous.





\includegraphics{figures/Figure1_expdesign.pdf}

\newpage



**Figure 2: Prediction of week 6 treatment outcome in subjects treated with UST, using baseline samples** Receiver operating characteristic (ROC) curves for (A) response and (C) remission using microbiota data (blue), clinical metadata (black), and a combined model (red). Top predictive OTUs for the microbiota model based on mean decrease in accuracy (MDA) for (B) response and (D) remission. Black bars represent the median relative abundance. 





\includegraphics{figures/Figure2_wk0Xwk6pred.pdf}

\newpage

**Supplemental Figure 1: Phyla from baseline stool samples in subjects treated with UST by week six outcome** The relative abundance of each phylum in UST treated subjects were compared based on (A) response and (B) remission status using a Wilcoxon rank sum test and to identify phyla where there was a p-value less than 0.05 following a Benjamini-Hochberg correction for multiple comparisons. No comparisons were significant. Whiskers represent the range and boxes represent the 25-75% interquartile range of the median (black bar).




\includegraphics{figures/SF1_wk6phyla.pdf}

\newpage

**Figure 3: Differential taxa in baseline stool samples from subjects treated with UST, based on week six remission status** The baseline relative abundance of each OTU was compared between subjects in remission and those with active CD 6 weeks after induction using a Wilcoxon rank sum test followed by a Benjamini-Hochberg correction for multiple comparisons. This identified 2 OTUs with significantly different relative abundance at baseline (p < 0.05). Black bars represent the median relative abundance.



\includegraphics{figures/Figure3_basesigOTUabund.REMISSwk6.pdf}

\newpage

**Figure 4: Change in alpha diversity over time by induction treatment and week 22 response status.** The ${\alpha}$-diversity of 48 subjects induced and maintained with UST and 14 subjects induced and maintained with placebo was assessed at each time point. Friedman test were performed within each treatment and responder group. Whiskers represent the range and boxes represent the 25-75% interquartile range of the median (black bar). * indicates week 22 is significantly different from baseline (p <0.05).



\includegraphics{figures/Figure4_alltp.adivXvisitXindtrtXrelRSPwk22.pdf}



\newpage

**Figure 5: Classification of week 6 response or remission status using week 6 stool samples from subjects treated with UST** (A) ROC curves for week 6 outcome based on the week 6 microbiota. (B) Predictive OTUs from week 6 stool for remission status at 6 weeks after induction, based on mean decrease in accuracy. Black bars represent the median relative abundance.



\includegraphics{figures/Figure5_wk6Xwk6.pdf}

\newpage

# References
