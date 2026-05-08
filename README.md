# 🌿 Sensory Cartography

An interactive HTML report for visualizing sensory evaluation data using Principal Component Analysis (PCA) and Hierarchical Clustering (HAC).

> **Live example**: The included demo is based on facial sunscreen products evaluated by an expert sensory panel.
---

## What it does

This project generates a **self-contained HTML file** that includes:

- An **interactive sensory map** — products positioned according to their sensory profiles, colored by cluster
- A **product gallery** — each product displayed with its photo, reference code, and cluster
- An **alternative view** — a second map combining Dimension 1 and Dimension 3
- Hover tooltips with cluster descriptions written by the analyst

---

## Requirements

### Software
- [R](https://cran.r-project.org/) (≥ 4.1)
- [RStudio](https://posit.co/download/rstudio-desktop/) (recommended)
- [Quarto](https://quarto.org/docs/get-started/) (≥ 1.3)

### R Packages
The following packages will be installed automatically if not already present:

```r
readr, dplyr, tidyr, FactoMineR, factoextra, ggplot2, plotly, RColorBrewer, htmltools, base64enc
```

The `analyses.R` file also uses:
```r
SensoMineR, agricolae
```

---

## Project Structure

```
your-project/
├── sensory_cartography_visualization.qmd   # Main Quarto document
├── analyses.R                         # PCA and HAC computations
├── cluster_descriptions.R             # Cluster labels and descriptions (to customize)
├── custom-style.css                   # Visual styling
├── your_data.csv                      # Your sensory means data
├── products_info.csv                  # Product metadata (name, photo path, code)
├── header-bg.jpg                      # Header background image
└── photos/                            # Product photos folder
```

---

## How to Use

### 1. Prepare your data

**Sensory means file** (`your_data.csv`):
- Rows = products (individuals)
- Columns = sensory attributes (variables)
- Values = panel means
- Format: CSV with `;` separator, row names in the first column

**Product info file** (`products_info.csv`):
- 3 columns: `produit` (product name), `photo` (relative path to image), `code_interne` (reference code)
- Format: CSV with `;` separator, row names in the first column

Example:
```
;photo;code_interne
Product A;photos/productA.jpg;REF001
Product B;photos/productB.jpg;REF002
```

### 2. Customize cluster descriptions

Open `cluster_descriptions.R` and fill in the title and description for each cluster identified in your analysis:

```r
cluster_descriptions <- list(
  "1" = list(
    titre = "Your cluster 1 title",
    description = "Describe the sensory profile of this group."
  ),
  "2" = list(
    titre = "Your cluster 2 title",
    description = "Describe the sensory profile of this group."
  )
  # Add as many clusters as needed
)
```

### 3. Update file paths

In `analyses.R`, update the data file name:
```r
moyennes <- read.csv2("your_data.csv", row.names = 1)
```

In `sensory_cartography_visualization.qmd`, update the product info file name:
```r
infos_produits <- read.csv2("products_info.csv", stringsAsFactors = FALSE, row.names = 1)
```

### 4. Set the number of clusters

In `analyses.R`, set the number of clusters after inspecting your dendrogram:
```r
nb_clusters <- 4  # adjust to your data
```

### 5. Render the HTML

Open `sensory_cartography_visualization.qmd` in RStudio and click **Render** — or run in the terminal:

```bash
quarto render sensory_cartography_visualization.qmd
```

The output file `index.html` will be generated in the same folder.

---

## Customization

| What | Where |
|---|---|
| Title, author, date | YAML header of the `.qmd` file |
| Axis descriptions | `### Description des axes` section in the `.qmd` |
| Visual theme | `custom-style.css` |
| Header image | Replace `header-bg.jpg` |
| Number of clusters | `nb_clusters` in `analyses.R` |

---

## Notes

- The HTML output embeds all resources including photos (via base64 encoding). This makes the file **fully portable** but potentially large depending on the number and size of product images.
- The example demo uses facial sunscreen products. All sensory data and product references in the demo are anonymized.
- This project is designed for **sensory science professionals** but the output HTML is readable by any audience.

---

## Author

**Emilie ALINE**
*Sensory Evaluation — Cosmetics*

---
