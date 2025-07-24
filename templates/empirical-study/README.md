# Empirical Study Template

For research projects involving data collection, statistical analysis, and empirical findings.

## When to Use This Template

- **Survey studies**: Questionnaire-based research
- **Experimental designs**: Controlled experiments with participants
- **Observational studies**: Data collection from existing sources
- **Mixed methods research**: Combining quantitative and qualitative approaches
- **Longitudinal studies**: Multiple data collection points over time

## What's Included

```
empirical-study/
├── project.Rproj              # R project file
├── manuscript.qmd             # Main research paper
├── preregistration.qmd        # Pre-registration document (OSF-ready)
├── references.bib             # Bibliography
├── _quarto.yml               # Quarto configuration
├── R/
│   ├── 00-setup.R            # Project setup and libraries
│   ├── 10-data-import.R      # Data loading and initial processing
│   ├── 20-data-cleaning.R    # Data validation and cleaning
│   ├── 30-descriptives.R     # Descriptive statistics
│   ├── 40-analysis.R         # Main statistical analyses
│   ├── 50-visualization.R    # Plots and figures
│   ├── osf-integration.R     # Open Science Framework helpers
│   └── 99-build.R            # Master build script
├── data/
│   ├── raw/                  # Original, immutable data files
│   ├── processed/            # Cleaned, analysis-ready data
│   └── codebook.csv          # Variable definitions and coding
├── ethics/
│   ├── irb-protocol.qmd      # IRB application materials
│   ├── consent-forms/        # Informed consent documents
│   └── data-management.qmd   # Data handling procedures
├── instruments/
│   ├── survey.qmd            # Data collection instruments
│   └── validation/           # Instrument validation materials
└── outputs/
    ├── figures/              # Generated plots and visualizations
    ├── tables/               # Statistical output tables
    └── reports/              # Analysis reports and summaries
```

## What's Included (Ethics & Compliance)

- **IRB Protocol Templates**: Complete IRB application materials
- **Consent Form Templates**: Multiple consent form options
- **Data Management Plan**: GDPR/privacy compliance procedures
- **Pre-registration Support**: Templates for study pre-registration

## Setup Instructions

1. **Copy template**: `cp -r templates/empirical-study/ your-study-name/`
2. **Complete IRB process**: Use materials in `ethics/` folder
3. **Pre-register study**: Complete `preregistration.qmd` before data collection
4. **Configure data collection**: Set up instruments in `instruments/` folder
5. **Update R scripts**: Modify analysis pipeline in `R/` folder

## Research Workflow

### Phase 1: Planning & Ethics
1. **Develop research protocol**: Complete `ethics/irb-protocol.qmd`
2. **Create instruments**: Design surveys/measures in `instruments/`
3. **Pre-register**: Document hypotheses in `preregistration.qmd`
4. **OSF setup**: Create OSF project and upload pre-registration
5. **IRB approval**: Submit ethics documentation

### Phase 2: Data Collection
1. **Collect data**: Use instruments and protocols
2. **Store raw data**: Place original files in `data/raw/` (never modify)
3. **Document process**: Note any deviations or issues

### Phase 3: Analysis
1. **Import data**: Use `R/10-data-import.R`
2. **Clean data**: Validate and prepare with `R/20-data-cleaning.R`
3. **Analyze**: Run descriptive and inferential analyses
4. **Visualize**: Create figures with `R/50-visualization.R`
5. **Build all**: Execute `R/99-build.R` for complete analysis

### Phase 4: Writing & Submission
1. **Draft manuscript**: Write in `manuscript.qmd`
2. **Include outputs**: Reference tables and figures from `outputs/`
3. **Render document**: Use `quarto render` for journal formatting
4. **Submit**: Follow journal-specific requirements

## Data Management

### Security & Privacy
- **Raw data encryption**: Encrypt sensitive data files
- **Access controls**: Limit who can access participant data
- **Anonymization**: Remove identifying information early in pipeline
- **Backup procedures**: Regular, secure backups of all materials

### Reproducibility
- **Version control**: Use git for all analysis scripts
- **Computational environment**: Document R packages and versions
- **Clear documentation**: Comment all analysis decisions
- **Archived outputs**: Preserve final analysis results

## Open Science Framework (OSF) Integration

This template includes built-in support for OSF pre-registration and project management.

### Setting Up OSF Integration

1. **Install OSF package**: `install.packages("osfr")`
2. **Set up authentication**: Run `source("R/osf-integration.R")` then `setup_osf_auth()`
3. **Create OSF project**: `project <- create_osf_project("Your Study Title")`
4. **Upload pre-registration**: `upload_preregistration(project$id)`

### OSF Workflow

```r
# Load OSF functions
source("R/osf-integration.R")

# Quick start guide
osf_quick_start()

# Create project and structure
project <- create_osf_project("My Research Study")
create_study_structure(project$id)

# Upload pre-registration
upload_preregistration(project$id, "preregistration.qmd")

# Get citation for manuscript
get_osf_citation(project$id)
```

### Benefits of OSF Integration

- **Transparency**: Public pre-registration before data collection
- **Reproducibility**: Share materials, data, and analysis code
- **Collaboration**: Team access to project materials
- **DOI assignment**: Permanent identifiers for project components
- **Version control**: Track changes to study materials

## Common Customizations

### Statistical Methods
- **Power analysis**: Add scripts for sample size planning
- **Advanced modeling**: Include multilevel, structural equation, or Bayesian analyses
- **Specialized packages**: Add domain-specific R packages

### Data Types
- **Qualitative data**: Add scripts for text analysis and coding
- **Big data**: Include database connections and distributed computing
- **Time series**: Add longitudinal analysis capabilities

## Quality Assurance

### Pre-Analysis
- [ ] IRB approval obtained
- [ ] Pre-registration completed and uploaded to OSF
- [ ] OSF project created with appropriate folder structure
- [ ] Data collection instruments validated
- [ ] Analysis plan documented

### During Analysis
- [ ] Raw data backed up and secured
- [ ] Data cleaning steps documented
- [ ] Analysis scripts tested and reviewed
- [ ] Results reproduced independently

### Pre-Submission
- [ ] All analyses align with pre-registration
- [ ] Deviations from protocol documented
- [ ] Materials uploaded to OSF with DOIs
- [ ] Code and data availability statements complete
- [ ] OSF project citation included in manuscript
- [ ] Reproducibility verified

## Extending the Template

- **Multi-study projects**: Create separate folders for each study
- **Grant applications**: Add components from `grant-application` template
- **Presentations**: Include elements from `conference-presentation` template
- **Meta-analysis**: Extend with systematic review components