objNames <- c( "bioX", "pnas_bladder", "pnas_breast", "pnas_liver", "pnas_prostate")
fileNames <- list.files()
outFileNames <-c("glbx_bladder.txt", "glbx_breast.txt", "glbx_liver.txt", "glbx_prostate.txt", "glpnas_bladder.txt", "glpnas_breast.txt", "glpnas_liver.txt", "glpnas_prostate.txt")

dataList <- lapply(fileNames, function(x){read.delim(x, as.is = TRUE)})
dataList <- lapply(dataList, na.omit)
names(dataList) <- objNames

#subsetting bioX data to relevant cancer types
#name scheme is of the form <sourceAbbrev><status>_<cancerType> eg bx_bladder is unprocessed bioXpress bladder cancer data
rbx_bladder <- subset(dataList$bioX, dataList$bioX$TCGA.Cancer == "BLCA" & dataList$bioX$p_value <= 0.05)
rbx_breast <- subset(dataList$bioX, dataList$bioX$TCGA.Cancer == "BRCA" & dataList$bioX$p_value <= 0.05)
rbx_liver <- subset(dataList$bioX, dataList$bioX$TCGA.Cancer == "LIHC" & dataList$bioX$p_value <= 0.05)
rbx_prostate <- subset(dataList$bioX, dataList$bioX$TCGA.Cancer == "PRAD" & dataList$bioX$p_value <= 0.05)


#subsetting subsetting bx_cancerType data to PNAS gene lists
#bx_bladder <- subset(rbx_bladder, bx_bladder$Gene %in% dataList$pnas_bladder$Gene.Name)
#bx_breast <- subset(rbx_breast, bx_breast$Gene %in% dataList$pnas_breast$Gene.Name)
#bx_liver <- subset(rbx_liver, bx_liver$Gene %in% dataList$pnas_liver$Gene.Name)
#bx_prostate <- subset(rbx_prostate, bx_prostate$Gene %in% dataList$pnas_prostate$Gene.Name)

cpnas_bladder<- subset(dataList$pnas_bladder, (!(dataList$pnas_bladder$Gene.Name %in% rbx_bladder$Gene)))
cpnas_breast <- subset(dataList$pnas_breast, (!(dataList$pnas_breast$Gene.Name %in% rbx_breast$Gene)))
cpnas_liver <- subset(dataList$pnas_liver, (!(dataList$pnas_liver$Gene.Name %in% rbx_liver$Gene)))
cpnas_prostate <- subset(dataList$pnas_prostate, (!(dataList$pnas_prostate$Gene.Name %in% rbx_prostate$Gene)))


cpnas_bladder<- subset(dataList$pnas_bladder, cpnas_bladder$Gene.Name != '-')
cpnas_breast <- subset(dataList$pnas_breast, cpnas_bladder$Gene.Name != '-')
cpnas_liver <- subset(dataList$pnas_liver, cpnas_bladder$Gene.Name != '-')
cpnas_prostate <- subset(dataList$pnas_prostate, cpnas_bladder$Gene.Name != '-')

geneLists <-list(rbx_bladder$Gene, rbx_breast$Gene, rbx_liver$Gene, rbx_prostate$Gene, dataList$pnas_bladder$Gene.Name, dataList$pnas_breast$Gene.Name, dataList$pnas_liver$Gene.Name, dataList$pnas_prostate$Gene.Name)
lapply(1:8, function(x){write.table(geneLists[x], file=outFileNames[x], sep="\t", col.names = FALSE, row.names = FALSE)}) 
  

ul_bladder <- unique(unlist(list(geneLists[1], geneLists[5])))
ul_breast <- unique(unlist(list(geneLists[2], geneLists[6])))
ul_liver <- unique(unlist(list(geneLists[3], geneLists[7])))
ul_prostate <- unique(unlist(list(geneLists[4], geneLists[8])))

union_lists <- list(ul_bladder, ul_breast, ul_liver, ul_prostate)
names(union_lists) <- c("ul_bladder", "ul_breast", "ul_liver", "ul_prostate")

u_fileNames <- c("u_bladder.txt", "u_breast.txt", "u_liver.txt", "u_prostate.txt")

lapply(1:4, function(x){write.table(union_lists[x], file=u_fileNames[x], sep="\t", col.names = FALSE, row.names = FALSE)})