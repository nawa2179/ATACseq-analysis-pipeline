
library(tidyverse)
table_count = read.csv2('C:/Users/Public/Documents/ATAC_seq_EOMES/Analyse_Deseq2_3/count_all_region_3.csv')
colnames(table_count) = c('region', colnames(table_count)[-ncol(table_count)])
table_count %>% 
	column_to_rownames(., 'region') %>% 
	iwalk(.x = ., .f = function(column, name) {
		name = sub('(.*)_(.*)', '\\1', name) %>% paste(., 'txt', sep = '.')
		df = as.data.frame(column, row.names = table_count$region)
		write.table(df, file = name, quote = F, sep = '\t', row.names = TRUE, col.names = FALSE)
	})

