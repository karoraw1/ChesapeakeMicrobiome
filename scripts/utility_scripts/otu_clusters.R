library(MASS)
library(parallel)
library(pvclust)

setwd(getcwd())
transect_data_f = "transect_mdata_colset_1.tsv"
tran_df <- read.delim(transect_data_f, row.names=1)
select_samples <- rownames(tran_df[!is.na(tran_df$CHLA),])

tsv.data <- read.delim("final_rarefied_table.tsv", row.names=1)
tsv.data = tsv.data[select_samples, ]
tsv.data2 = (tsv.data + 0.1)/rowSums(tsv.data + 0.1)
tsv.data3 = t(t(tsv.data2)/rowSums(t(tsv.data2)))

dim(tsv.data3)


cl_inst <- makeCluster(4, type = "PSOCK")

res.pv <- pvclust(tsv.data3, method.hclust = "complete", method.dist = "euclidean", 
                  parallel=cl_inst, iseed = 1, nboot=1000, r=seq(.5,1.4,by=.15))

save(res.pv, file="otuclusters2.RData")

res.pv <- pvclust(tsv.data3, method.hclust = "ward.D2", method.dist = "euclidean", 
                  parallel=cl_inst, iseed = 1, nboot=1000, r=seq(.5,1.4,by=.15))

save(res.pv, file="otuclusters3.RData")

stopCluster(cl_inst)

# save the data
