#Chargement des packages nécessaires
library(FactoMineR)
library(factoextra)
library(SensoMineR)
library(agricolae)
library(tidyverse)

#Importation du fichier de données en csv
moyennes <- read.csv2("moyennes_corrigees_V2.csv", row.names = 1)


# Réalisation de l'ACP ---------------------------------------------------------------------
res.pca <- PCA(moyennes, scale.unit = FALSE, ncp = 5, 
               ind.sup = NULL, quanti.sup = NULL, quali.sup = NULL, graph = FALSE) # ACP non norm?e (scale.unit = False)

var_expliquee <- res.pca$eig[, 2]   # ← ajout pour le Quarto
var_cumulee   <- res.pca$eig[, 3]   # ← ajout pour le Quarto

# Réalisation de la CAH ---------------------------------------------------------------------
nb_clusters <- 4  # ← tu choisis ici après avoir regardé le dendogramme

res.hcpc <- HCPC(res.pca, proba = 0.05, nb.clust = nb_clusters, graph = FALSE)

clusters   <- as.numeric(res.hcpc$data.clust$clust)  # ← ajout pour le Quarto
n_clusters <- length(unique(clusters))                # ← ajout pour le Quarto

# ════════════════════════════════════════════════════════════
# EXPLORATION - Ces lignes sont ignorées lors du source()
# Lance-les manuellement dans RStudio
# ════════════════════════════════════════════════════════════

if (interactive()) {
  
  # Ebouli des valeurs propres (choix du nb de dimensions)
  fviz_eig(res.pca, addlabels = TRUE, ylim = c(0, 100), 
         linecolor = "red", barfill = "#669999", barcolor = "black", 
         ggtheme = theme_bw(), ncp = 5, main = "Ebouli des valeurs propres")

  #Résumé de l'ACP
  summary(res.pca)

  # Interprétation des axes
  # Corrélation entre variables et dimensions
  dimdesc(res.pca) 
  
  # Qualité de représentation des variables (cos2)
  fviz_cos2(res.pca, choice = "var", axes = 1, top = 10, color = "black", fill = "#99CCCC", ggtheme = theme_bw()) 
  fviz_cos2(res.pca, choice = "var", axes = 2, top = 10, color = "black", fill = "#99CCCC", ggtheme = theme_bw()) 
  fviz_cos2(res.pca, choice = "var", axes = 3, top = 10, color = "black", fill = "#99CCCC", ggtheme = theme_bw()) 

  # Contribution des variables
  fviz_contrib(res.pca, choice = "var", axes = 1, top = 10, color = "black", fill = "#FFCCCC", ggtheme = theme_bw()) 
  fviz_contrib(res.pca, choice = "var", axes = 2, top = 10, color = "black", fill = "#FFCCCC", ggtheme = theme_bw()) 
  fviz_contrib(res.pca, choice = "var", axes = 3, top = 10, color = "black", fill = "#FFCCCC", ggtheme = theme_bw()) 


  # Graph individus et variables 
  plot.PCA(res.pca, axes = c(1, 2), choix = "var", habillage = "cos2", autoLab = c("yes"), select = "cos2 20") ## Représentation des 13 variables avec le plus haut cos2 sur les dim 1 et 2
  plot.PCA(res.pca, axes = c(1, 2), choix = "ind", habillage = "ind", autoLab = c("yes"))
  fviz_pca(res.pca, repel = TRUE) #biplot
  fviz_pca_ind(res.pca, col.ind="contrib", geom = c("point","text"),
             gradient.cols = c("grey", "#2E9FDF", "#FC4E07"),
             labelsize = 4)


  # Cluster plot
  fviz_cluster(res.hcpc, repel = TRUE, show.clust.cent = FALSE, palette = "Set2",
             ggtheme = theme_light(), axes = c(1, 3), ellipse.type = "convex",
             ellipse = TRUE, pointsize = 2, labelsize = 12)

  # Description clusters
  res.hcpc$desc.var
  res.hcpc$desc.ind
  res.hcpc$data.clust
}
