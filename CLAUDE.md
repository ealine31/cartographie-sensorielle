# CLAUDE.md - cartographie-sensorielle

## 📊 Vue d'ensemble

**cartographie-sensorielle** est un projet de cartographie interactive d'analyses sensorielles. Il génère une visualisation Plotly interactive à partir d'une analyse statistique multivariée (ACP + CAH).

Le projet est **indépendant du domaine** et peut s'adapter à tout contexte ayant besoin de:
- Une Analyse en Composantes Principales (ACP) sur des données
- Une Classification Ascendante Hiérarchique (CAH) pour créer des groupes
- Une cartographie interactive HTML auto-contenue et portable

**Auteur**: Emilie ALINE

---

## 🔴 RÈGLE PRIMORDIALE : Intégrité des paramètres statistiques

**Les paramètres et options des analyses statistiques ne doivent JAMAIS être modifiés.**

Ces paramètres ont été validés scientifiquement et constituent le fondement du modèle analytique. Les fichiers CAN be améliorés ou refactorisés, mais les choix analytiques doivent rester **exactement intacts**.

### Paramètres IMMUABLES

| Paramètre | Localisation | Valeur | Raison |
|-----------|--------------|--------|--------|
| **scale.unit** | `analyses.R` L.13-14 | `FALSE` | Données non normalisées (déjà prétraitées) |
| **ncp** (ACP) | `analyses.R` L.13-14 | `5` | Nombre de composantes principales extraites |
| **Méthode CAH** | `analyses.R` L.22 | `HCPC` | Classification hiérarchique avec FactoMineR |
| **Seuil HCPC** | `analyses.R` L.22 | `0.05` | Seuil probabiliste pour les clusters |
| **Nombre de clusters** | `analyses.R` L.22 | `4` | Nombre de groupes créés |
| **Enveloppes convexes** | `sensory_cartography_visualization.qmd` L.122-137 | geometry="convex" | Zones de clusters |

**SI vous devez modifier ces paramètres, documentez POURQUOI dans un commit message et dans une issue expliquant la validation scientifique.**

---

## 📁 Structure du projet

```
cartographie-sensorielle/
├── CLAUDE.md                                      ← Vous êtes ici
├── README.md                                      ← Documentation utilisateur
├── sensory_cartography_visualization.qmd          ← Rapport Quarto (CORE)
├── analyses.R                                     ← Analyses statistiques (CORE)
├── cluster_descriptions.R                         ← Descriptions textuelles (EDITABLES)
├── custom-style.css                               ← Styling visuel (EDITABLE)
├── header-bg.jpg                                  ← Image d'en-tête (EDITABLE)
├── index.html                                     ← Sortie rendue (AUTO-GÉNÉRÉ)
├── _quarto.yml                                    ← Config Quarto (CORE)
└── .git/                                          ← Historique Git
```

### Rôles des fichiers clés

#### 🔧 FICHIERS CORE (Contiennent les analyses)

**`analyses.R`**
- Réalise l'ACP (Analyse en Composantes Principales) sur les données
- Exécute la CAH via HCPC pour créer les clusters
- Exporte les résultats (coordonnées PCA, assignations de clusters)
- Lignes critiques : 13-14 (PCA), 22 (HCPC), 24-25 (exports)
- ⚠️ Ne pas modifier les paramètres statistiques

**`sensory_cartography_visualization.qmd`**
- Document Quarto qui intègre les résultats des analyses
- Crée la visualisation Plotly interactive
- Génère le rapport HTML final
- Lignes critiques : 91-95 (extraction données), 122-137 (enveloppes convexes), 159-200+ (Plotly)
- ⚠️ La logique Plotly peut évoluer, mais pas les calculs statistiques sous-jacents

**`_quarto.yml`**
- Configuration du rendu Quarto (format, dépendances)
- À modifier seulement pour changements techniques majeurs

#### ✏️ FICHIERS ÉDITABLES

**`cluster_descriptions.R`**
- **COMPLÈTEMENT ÉDITABLE** - Contient uniquement du texte
- Titres et descriptions des 4 clusters
- Utilisé pour enrichir les infobulles du graphique Plotly
- Aucun impact sur les analyses statistiques

**`custom-style.css`**
- **COMPLÈTEMENT ÉDITABLE** - Styling visuel
- Couleurs, fonts, mises en page
- N'affecte que l'apparence du rendu HTML

**`header-bg.jpg`**
- **REMPLAÇABLE** - Image d'en-tête
- Formats acceptés : JPG, PNG, SVG

#### 📝 FICHIERS AUTO-GÉNÉRÉS (Ne pas éditer directement)

**`index.html`**
- Généré automatiquement par `quarto render`
- Sortie finale portable en un seul fichier HTML
- À régénérer après modifications

---

## ✅ Ce qui peut être modifié

Vous CAN modifier :

### Code et structure
- ✅ Refactoriser `analyses.R` pour plus de clarté (tant que paramètres ne changent pas)
- ✅ Améliorer le code R (conventions de nommage, optimisations, etc.)
- ✅ Améliorer la logique Plotly dans le QMD
- ✅ Corriger les bugs tant qu'ils ne touchent pas aux paramètres

### Contenu textuel
- ✅ Modifier les titres, descriptions de clusters (`cluster_descriptions.R`)
- ✅ Modifier l'auteur, la date, le titre du rapport (en-têtes YAML du QMD)
- ✅ Corriger les textes explicatifs des axes

### Présentation
- ✅ Modifier les couleurs, fonts, styles (CSS)
- ✅ Changer l'image d'en-tête
- ✅ Modifier la palette de couleurs des clusters (ligne 74 du QMD)
- ✅ Réorganiser les sections du rapport

### Données
- ✅ Utiliser de nouvelles données CSV d'entrée (`moyennes_corrigees_V2.csv`, `products_info.csv`)
- ✅ Adapter le projet à un nouveau domaine d'application
- ✅ Créer de nouveaux dossiers de photos de produits

---

## ❌ Ce qui ne doit pas être touché

**NE MODIFIEZ PAS :**

- ❌ Les paramètres statistiques listés ci-dessus (scale.unit, ncp, seuil HCPC, nombre de clusters)
- ❌ Les variables d'extraction des résultats ACP/CAH (`analyses.R` L.16-17, 24-25)
- ❌ La méthode de calcul des enveloppes convexes (`sensory_cartography_visualization.qmd` L.122-137)
- ❌ Les appels aux fonctions FactoMineR (`PCA()`, `HCPC()`)

**SI vous pensez devoir les modifier**, créez d'abord une issue expliquant:
1. Pourquoi le paramètre doit changer
2. Quelle est la validation scientifique
3. Comment cela affecte les résultats

---

## 🔄 Workflow pour les contributions

### 1. Comprendre ce que vous modifiez
Avant de commencer, posez-vous :
- Modifiez-vous du **code** ou des **données/paramètres** ?
- Touchez-vous aux analyses statistiques (`analyses.R`) ?
