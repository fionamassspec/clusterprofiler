if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("clusterProfiler",force=TRUE)
BiocManager::install("DOSE",force=TRUE)

library(clusterProfiler)
library(DOSE)
library(forcats)
library(ggplot2)

data<-read.csv(file="H:/flat.csv")

mytheme <- theme(panel.border=element_blank(),
                 panel.grid.major=element_line(linetype='dotted', colour='#808080'),
                 panel.grid.major.y=element_blank(),
                 panel.grid.minor=element_blank(),
                 axis.line.x = element_line())
g1 <- ggplot(data, showCategory = 10,
             aes(richFactor, fct_reorder(Description, richFactor))) +
  geom_segment(aes(xend=0, yend = Description)) +
  geom_point(aes(color=p.adjust, size = Count)) +
  scale_color_gradientn(colours=c("#f7ca64", "#46bac2", "#7e62a3"),
                        trans = "log10",
                        guide=guide_colorbar(reverse=TRUE, order=1)) +
  scale_size_continuous(range=c(5, 60))  +
  theme_dose(12) +
  mytheme +
  xlim(0, 0.45) +
  guides(size = guide_legend(override.aes=list(shape=1))) +
  xlab("Rich Factor") +
  ylab(NULL) +
  ggtitle("Biological Processes")

# Save the plot as a PDF file
ggsave("plot.pdf", plot = g1)

