# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a modular academic research template system that provides specialized, robust templates for different types of research projects. It replaces a single fragile template with focused templates for specific research needs.

## Essential Commands

### Interactive Template Selection (Recommended)
```r
source("tools/template-chooser.R")
template_chooser()  # Answer questions to get template recommendations

source("tools/project-initializer.R") 
interactive_setup()  # Guided project setup with automatic customization
```

### Direct Project Initialization
```r
source("tools/project-initializer.R")
initialize_project("project-name", "template-type")
```

Available template types: `simple-paper`, `empirical-study`, `grant-application`, `literature-review`, `conference-presentation`

### Manual Template Copy
```bash
cp -r templates/simple-paper/ ../my-new-paper/
cd ../my-new-paper/
```

### Working with Created Projects
- **Quarto rendering**: `quarto render` (builds entire project)
- **Single file**: `quarto render filename.qmd`
- **Preview mode**: `quarto preview` (live reload during development)
- **R analysis pipeline**: `Rscript R/99-build.R` (for empirical-study template)

## Architecture Overview

### Template System Design
The repository uses a **modular template approach** where each template is specialized for specific research types:

- **simple-paper/**: Minimal template for theoretical/conceptual papers
- **empirical-study/**: Full research infrastructure with IRB docs, data analysis pipeline
- **grant-application/**: Proposal writing with budget and timeline management
- **literature-review/**: Systematic review tools with PRISMA support
- **conference-presentation/**: Focused on slides and abstracts

### Shared Components
- **_shared/admin/**: Author tracking, publication management
- **_shared/scripts/**: Common R functions and utilities  
- **_shared/docs/**: Documentation standards and contribution guidelines

### Template Structure Patterns
All templates follow consistent patterns:
- **R project file** (.Rproj) for RStudio integration
- **_quarto.yml** configuration with academic output formats
- **Numbered R scripts** (00-setup.R, 10-analysis.R, etc.) for empirical templates
- **Proper path handling** using `here()` package throughout
- **Bibliography management** with .bib files and citation support

### Automation Tools
- **project-initializer.R**: Core automation that copies templates, customizes files, creates .Rproj files, initializes git repos, and creates directory structures
- **template-chooser.R**: Decision tree logic to recommend appropriate templates based on project requirements

## Key Template Characteristics

### simple-paper
- **Use case**: Theory papers, commentaries, book chapters
- **Structure**: paper.qmd, references.bib, basic R setup
- **Build**: `quarto render paper.qmd`

### empirical-study  
- **Use case**: Data collection studies requiring IRB approval
- **Structure**: Full research pipeline with numbered R scripts (00-99), ethics documentation, data management
- **Build**: `Rscript R/99-build.R` then `quarto render manuscript.qmd`
- **Pipeline**: 00-setup → 10-data-import → 20-data-cleaning → 30-descriptives → 40-analysis → 50-visualization → 99-build

### Other Templates
- **grant-application**: Proposal writing with budget/timeline tracking
- **literature-review**: PRISMA methodology with citation screening tools
- **conference-presentation**: Minimal overhead for slides and abstracts

## Development Workflow

### Creating New Projects
1. Run `template_chooser()` to identify the right template
2. Use `interactive_setup()` or `initialize_project()` for automated setup
3. Automated setup includes: file customization, git initialization, directory creation, .Rproj file generation

### Template Customization Process
The initializer automatically:
- Replaces placeholder text ("Your Project Title Here", "PROJECT_NAME") with actual project name
- Updates dates (YYYY-MM-DD) with current date
- Configures _quarto.yml with project title
- Creates appropriate directory structure for template type
- Sets up .gitignore with sensible defaults for R/Quarto projects

### R Integration Patterns
- **Path handling**: All templates use `here()` for reliable file paths
- **Package management**: Dependencies loaded in setup scripts
- **Data workflow**: Raw data (immutable) → processed data → analysis → outputs
- **Reproducibility**: Numbered scripts ensure consistent execution order

## Important Notes

### Template Selection Logic
The `template_chooser()` implements decision logic based on:
- Data collection requirements (Yes/No)
- IRB approval needs
- Statistical analysis complexity
- Project purpose (paper, grant, presentation, etc.)
- Timeline considerations

### Migration Strategy
For projects using older templates:
1. Assess current project type against available templates
2. Copy relevant components to new template structure  
3. Update file paths to work with new structure
4. Test builds to verify Quarto rendering and R scripts

### File Management
- **Raw data**: Place in data/raw/ and never modify
- **Git workflow**: Templates automatically initialize git repos with appropriate .gitignore
- **Outputs**: Generated figures/tables go in outputs/ directory
- **Documentation**: Each template includes detailed README with specific instructions

### Documentation Workflow
- **README source**: Edit `README.qmd` as the source of truth
- **README rendering**: Use `quarto render README.qmd` to generate `README.md` for GitHub
- **Internal tracking**: Use `TODO.qmd` for project updates, tasks, and development notes
- **Quarto best practices**: Always include blank lines between different markdown elements
- **GFM format**: README.qmd is configured with `format: gfm` for GitHub compatibility

### Code Standards
- Follow tidyverse style guide for R code
- Use relative paths and `here()` package
- Document all data cleaning and analysis steps
- Include proper citation management with .bib files
- Version control all source files, not generated outputs