
############################################################# Script Deseq2 ###################################################################

setwd("C:/Users/Public/Documents/ATAC_seq_EOMES/Analyse_Deseq2_3") #Chargement du dossier de travail
dir <- getwd()

############################################################################
#################### DESeq2 from sample files ##############################
############################################################################


###### chargement des fonctions DESeq2 pour sample files
# ce module utilise le package openxls qui ne n?cessite pas java
source("DESeq2_FromSampleFiles_v1.16_openxlsx_v1.R")


###### creer la table des informations sur les echantillons
# a faire avec blocnotes ou excel -> .txt
# exemple: sampleinfo_ForSampleFiles.txt


###### cas : toutes les comparaisons possibles
# --- setting parameters - All

table="table.txt"  # sample info with association sample names & Condition

dir <- getwd()              # r?pertoire o? se trouvent les donn?es et les programmes R

pval <- 0.01                # seuil de filtrage sur p (si adjP actif alors p=adjp)
FC <- 1.5                     # seuil de filtrage sur FC (|FC| en ?chelle lineaire et non logFC)

analysis = "All"            # type d'analyse = "All" | "Ctrl"
# "ALL" : toutes les comparaisons possibles
# "Ctrl" : toutes les comparaisons par rapport ? un groupe d?fini dans CondCtrl
condCtrl= NULL              # condition de reference : non prise en compte si analysis = "All"

PreFilt = NULL                # pre-filtering : NULL | integer : keep only rows that have at least
#   PreFilt reads total (NULL per default : no pre-filtering)
Filt = T                    # HTS Filtering = TRUE | FALSE (FALSE per default)
# HTSFilter actif uniquement si NbCountMin = NULL
NbCountMin <- NULL          # min number of normalized counts in 100% samples (NULL per default)

paired <- TRUE                 # FALSE : analyse sur une condition
# TRUE : analyse sur deux conditions (par exemple avec appariement des donn?es)

correction="BH"     # correction des tests multiples : "bonferroni" | "fdr" | "none"

record = TRUE              # TRUE : enregistrement des r?sultats de l'analyse DESeq2 soit
# sans aucune filtrage (tous les r?sultats qqsoit Pvalue ou FC)
# plus avec filtrage par Pvalue (les r?sultats avec Padj < pval)
# plus avec filtrage sur Pvalue et FC : les r?sultats tq Padj < pval et |foldchange| > FC
# avec pval et FC : seuils de filtrage d?finis ci-dessus
# FALSE : enregistrements unqiuement des r?sultats filtr?s sur les seuils pval et FC

# --- un fichier log sera genere
log <- paste("EOMES_ATAC_All_FC1_BH0.05_", format(Sys.time(), '%Y%m%d_%Hh%M'), ".txt", sep="") 
sink(log, type="output")
cat(log, "\n")
cat(date(), "\n")

DESeq2_FromSampleFiles(table, dir, pval, FC, analysis=analysis,condCtrl=condCtrl, 
                       PreFilt=PreFilt, Filt=Filt, NbCountMin=NbCountMin, 
                       paired=paired, correction=correction, record=record)
cat("\n")
cat(date(), "\n")
sink()

