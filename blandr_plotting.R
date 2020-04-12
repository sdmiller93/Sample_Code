# create blandr plots for the sflompro and nanolc data

library(blandr)

data <- read.delim("~/Desktop/data_simplified.tsv", sep = "\t", as.is = TRUE, header = TRUE)


# for 128C #############################################################
Sflom <- data$sflom_128C
Nano <- data$nano_128C

blandr.draw(data$sflom_128C, data$nano_128C, method1name = "sFlomPro",
  method2name = "NanoLC",
  plotTitle = "Bland-Altman plot: 128C sFlomPro v NanoLC",
  sig.level = 0.95, LoA.mode = 1, annotate = TRUE, ciDisplay = TRUE,
  ciShading = TRUE, normalLow = FALSE, normalHigh = FALSE,
  lowest_y_axis = FALSE, highest_y_axis = FALSE, point_size = 0.8,
  overlapping = FALSE, plotter = "ggplot", x.plot.mode = "means",
  y.plot.mode = "difference", plotProportionalBias = FALSE,
  plotProportionalBias.se = TRUE, assume.differences.are.normal = TRUE)
  
quartz.save(file = "~/Desktop/128C.pdf", type = "pdf")
  
stats_results <- blandr.statistics(Sflom, Nano, sig.level = 0.95, LoA.mode = 1)

write.table(stats_results, file = "~/Desktop/128Cblandr_stats.tsv", row.names = FALSE, col.names = TRUE, append = FALSE, sep = "\t")

# for 129C #############################################################
Sflom <- data$sflom_129C
Nano <- data$nano_129C

blandr.draw(data$sflom_129C, data$nano_129C, method1name = "sFlomPro",
  method2name = "NanoLC",
  plotTitle = "Bland-Altman plot: 129C sFlomPro v NanoLC",
  sig.level = 0.95, LoA.mode = 1, annotate = TRUE, ciDisplay = TRUE,
  ciShading = TRUE, normalLow = FALSE, normalHigh = FALSE,
  lowest_y_axis = FALSE, highest_y_axis = FALSE, point_size = 0.8,
  overlapping = FALSE, plotter = "ggplot", x.plot.mode = "means",
  y.plot.mode = "difference", plotProportionalBias = FALSE,
  plotProportionalBias.se = TRUE, assume.differences.are.normal = TRUE)
 
quartz.save(file = "~/Desktop/129C.pdf", type = "pdf")
  
stats_results <- blandr.statistics(Sflom, Nano, sig.level = 0.95, LoA.mode = 1)

write.table(stats_results, file = "~/Desktop/129Cblandr_stats.tsv", row.names = FALSE, col.names = TRUE, append = FALSE, sep = "\t")

# for 129N #############################################################
Sflom <- data$sflom_129N
Nano <- data$nano_129N

blandr.draw(data$sflom_129N, data$nano_129N, method1name = "sFlomPro",
  method2name = "NanoLC",
  plotTitle = "Bland-Altman plot: 129N sFlomPro v NanoLC",
  sig.level = 0.95, LoA.mode = 1, annotate = TRUE, ciDisplay = TRUE,
  ciShading = TRUE, normalLow = FALSE, normalHigh = FALSE,
  lowest_y_axis = FALSE, highest_y_axis = FALSE, point_size = 0.8,
  overlapping = FALSE, plotter = "ggplot", x.plot.mode = "means",
  y.plot.mode = "difference", plotProportionalBias = FALSE,
  plotProportionalBias.se = TRUE, assume.differences.are.normal = TRUE)

quartz.save(file = "~/Desktop/129N.pdf", type = "pdf")
  
stats_results <- blandr.statistics(Sflom, Nano, sig.level = 0.95, LoA.mode = 1)

write.table(stats_results, file = "~/Desktop/129Nblandr_stats.tsv", row.names = FALSE, col.names = TRUE, append = FALSE, sep = "\t")

# for 130C #############################################################
Sflom <- data$sflom_130C
Nano <- data$nano_130C

blandr.draw(data$sflom_130C, data$nano_130C, method1name = "sFlomPro",
  method2name = "NanoLC",
  plotTitle = "Bland-Altman plot: 130C sFlomPro v NanoLC",
  sig.level = 0.95, LoA.mode = 1, annotate = TRUE, ciDisplay = TRUE,
  ciShading = TRUE, normalLow = FALSE, normalHigh = FALSE,
  lowest_y_axis = FALSE, highest_y_axis = FALSE, point_size = 0.8,
  overlapping = FALSE, plotter = "ggplot", x.plot.mode = "means",
  y.plot.mode = "difference", plotProportionalBias = FALSE,
  plotProportionalBias.se = TRUE, assume.differences.are.normal = TRUE)

quartz.save(file = "~/Desktop/130C.pdf", type = "pdf")
  
stats_results <- blandr.statistics(Sflom, Nano, sig.level = 0.95, LoA.mode = 1)

write.table(stats_results, file = "~/Desktop/130Cblandr_stats.tsv", row.names = FALSE, col.names = TRUE, append = FALSE, sep = "\t")

# for 130N #############################################################
Sflom <- data$sflom_130N
Nano <- data$nano_130N

blandr.draw(data$sflom_130N, data$nano_130N, method1name = "sFlomPro",
  method2name = "NanoLC",
  plotTitle = "Bland-Altman plot: 130N sFlomPro v NanoLC",
  sig.level = 0.95, LoA.mode = 1, annotate = TRUE, ciDisplay = TRUE,
  ciShading = TRUE, normalLow = FALSE, normalHigh = FALSE,
  lowest_y_axis = FALSE, highest_y_axis = FALSE, point_size = 0.8,
  overlapping = FALSE, plotter = "ggplot", x.plot.mode = "means",
  y.plot.mode = "difference", plotProportionalBias = FALSE,
  plotProportionalBias.se = TRUE, assume.differences.are.normal = TRUE)
  
  
quartz.save(file = "~/Desktop/130N.pdf", type = "pdf")


stats_results <- blandr.statistics(Sflom, Nano, sig.level = 0.95, LoA.mode = 1)

write.table(stats_results, file = "~/Desktop/130Nblandr_stats.tsv", row.names = FALSE, col.names = TRUE, append = FALSE, sep = "\t")
