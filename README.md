

# Project Template

![](presentations/media/banner.png)

![Last
updated](https://img.shields.io/github/last-commit/mavrxlab/project-template.png)

## Project Overview

This template organizes research projects that may produce multiple
papers or presentations. It’s designed for R/Quarto workflows and uses
the `here` package for robust file path handling.

|                 |                     |
|-----------------|---------------------|
| **Status**      | Active/Draft/Review |
| **Internal ID** | SP-XXX              |
| **Type**        | Research Project    |
| **Title**       | Your Project Title  |
| **Last Update** | YYYY-MM-DD          |

## Structure

    project/
    ├── .Rprofile
    ├── .lintr
    ├── .pre-commit-config.yaml
    ├── project.Rproj
    ├── R/
    │   ├── functions.R
    │   ├── init-project.R
    │   └── validate-data.R
    ├── admin/
    │   ├── grants/
    │   │   ├── template/
    │   │   └── README.md
    │   ├── proposals/
    │   └── reports/
    ├── analysis/
    │   ├── data-prep/
    │   ├── scripts/
    │   └── workflow.qmd
    ├── data/
    │   ├── raw/
    │   └── tidy/
    ├── docs/
    │   ├── CONTRIBUTING.md
    │   └── irb/
    ├── papers/
    │   └── template/
    ├── presentations/
    │   ├── conference-template/
    │   └── media/
    └── README.qmd

## Usage

1.  Clone this template
2.  Use `here::here()` for all file paths
3.  Keep raw data immutable, generate tidy data via scripts
4.  One manuscript per folder in papers/

## Codename

``` r
# Change "seed" text to get codename
#| eval: false # remove or set to true
#| echo: true
library(codename)
codename(seed = "MA{VR}X Lab Project Template repository", type = "ubuntu")
```

    Warning in char2seed(seed): probable complete loss of accuracy in modulus

    [1] "sapphire stoat"

## Authors

Update `admin/contributors.csv` with author information.
