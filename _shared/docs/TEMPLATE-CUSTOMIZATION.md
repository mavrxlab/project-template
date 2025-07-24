# Template Customization Guide

This guide explains how to customize templates for specific research needs, domains, or institutional requirements.

## Overview

The modular template system is designed to be flexible and extensible. You can customize templates at different levels:

1. **Individual project customization**: Modify templates for specific projects
2. **Institutional customization**: Adapt templates for organizational standards
3. **Domain-specific variants**: Create specialized versions for research fields
4. **New template creation**: Build entirely new template types

## Individual Project Customization

### Basic Customization

When using `initialize_project()`, several customizations happen automatically:

- Project name replacement in all files
- Date updates in YAML headers
- .Rproj file creation with project name
- Git repository initialization

### Manual Customization Steps

After project creation, common customizations include:

#### 1. Update Author Information

Edit YAML headers in main documents:

```yaml
author: 
  - name: "Your Name"
    orcid: "0000-0002-1825-0097"  # Your actual ORCID
    email: "you@yourinstitution.edu"
    affiliations:
      - name: "Your Institution"
        department: "Your Department"
```

#### 2. Configure Output Formats

Modify `_quarto.yml` for your target journals or requirements:

```yaml
format:
  pdf:
    documentclass: article
    geometry: margin=1in
    cite-method: biblatex
  docx:
    reference-doc: your-template.docx
  html:
    theme: cosmo
    toc: true
```

#### 3. Bibliography Setup

- Replace placeholder citations in `references.bib`
- Update bibliography style in `_quarto.yml`
- Add domain-specific citation types

#### 4. Customize R Setup

Edit `R/setup.R` (or equivalent) to include:

- Domain-specific packages
- Custom functions
- Data loading configurations
- Plot themes and styling

## Institutional Customization

### Creating Institutional Variants

To create variants for your institution:

1. **Copy base template**:
   ```bash
   cp -r templates/simple-paper/ templates/institution-paper/
   ```

2. **Update branding and formatting**:
   - Add institutional logo to figures
   - Update color schemes and themes
   - Include required acknowledgments
   - Add institutional citation formats

3. **Modify project initializer**:
   ```r
   # Add to available_templates in project-initializer.R
   available_templates <- c("simple-paper", "empirical-study", ..., "institution-paper")
   ```

### Institutional Formatting Examples

#### University Branding

```yaml
# In _quarto.yml
format:
  pdf:
    include-in-header: 
      - "assets/university-header.tex"
    geometry: 
      - margin=1in
      - letterhead
```

#### Required Acknowledgments

```markdown
## Acknowledgments

This research was conducted at [Institution Name] under the supervision of the [Department/Center Name]. We acknowledge support from [Funding Sources].

*Institutional Review Board Approval*: This study was approved by the [Institution] IRB (Protocol #[NUMBER]).
```

#### Custom Citation Styles

Create institutional `.csl` files for specific formatting requirements:

```yaml
# In _quarto.yml
bibliography: references.bib
csl: assets/institution-style.csl
```

## Domain-Specific Customization

### Psychology Research Template

Key customizations for psychology:

```yaml
# _quarto.yml additions
format:
  pdf:
    documentclass: apa7
    cite-method: biblatex
  html:
    css: apa-web.css
```

```r
# R/setup.R additions
library(psych)      # Psychometric analysis
library(lavaan)     # Structural equation modeling
library(apaTables)  # APA-formatted tables
library(papaja)     # APA manuscripts in R
```

### Medical Research Template

Key customizations for medical research:

```yaml
# Enhanced ethics section
ethics:
  clinical_trial_number: "NCT########"
  irb_protocol: "IRB-#####-##"
  funding_source: "NIH Grant #R01-######"
```

```r
# R/setup.R additions
library(survival)   # Survival analysis
library(meta)       # Meta-analysis
library(forestplot) # Forest plots
library(Hmisc)      # Medical statistics
```

### Computer Science Template

Key customizations for CS research:

```yaml
format:
  pdf:
    documentclass: IEEEtran
    cite-method: natbib
  html:
    code-line-numbers: true
    highlight-style: github
```

## Advanced Customization

### Custom Document Classes

Create custom LaTeX document classes:

1. **Create class file**: `assets/custom-article.cls`
2. **Reference in Quarto**:
   ```yaml
   format:
     pdf:
       documentclass: custom-article
       classoption: [12pt, letterpaper]
   ```

### Custom Quarto Extensions

For complex customizations, create Quarto extensions:

```bash
quarto create extension your-extension-name
```

### Template Inheritance

Create template hierarchies:

```
templates/
├── base-research/          # Base template
├── quantitative-base/      # Extends base-research
│   ├── psychology-quant/   # Extends quantitative-base
│   └── economics-quant/    # Extends quantitative-base
└── qualitative-base/       # Extends base-research
    ├── anthropology/       # Extends qualitative-base
    └── education/          # Extends qualitative-base
```

## Creating New Templates

### Planning New Templates

Before creating a new template, consider:

1. **Target audience**: Who will use this template?
2. **Unique requirements**: What makes this different from existing templates?
3. **Common patterns**: What elements are shared with other templates?
4. **Maintenance burden**: Can you commit to maintaining this template?

### Template Creation Process

#### 1. Create Directory Structure

```bash
mkdir templates/new-template
cd templates/new-template
```

#### 2. Core Files

Every template needs:

- `README.md`: Comprehensive documentation
- `main-document.qmd`: Primary content file
- `references.bib`: Bibliography with examples
- `_quarto.yml`: Configuration
- `R/setup.R`: R configuration (if applicable)

#### 3. Template-Specific Features

Add domain-specific elements:

- Custom CSS/LaTeX styling
- Specialized R functions
- Domain-specific directory structure
- Required compliance documentation

#### 4. Update Automation

Modify `tools/project-initializer.R`:

```r
# Add to available_templates
available_templates <- c(..., "new-template")

# Add template-specific directories
if (template_type == "new-template") {
  dirs <- c(common_dirs, "domain-specific-dir1", "domain-specific-dir2")
}

# Add template-specific .gitignore patterns
"new-template" = c(
  "# New template outputs",
  "*.specific-extension",
  "domain-files/*.tmp"
)
```

#### 5. Update Template Chooser

Modify `tools/template-chooser.R`:

```r
# Add decision logic for new template
if (domain_specific_condition) {
  return(list(
    template = "new-template",
    rationale = "Description of when to use this template",
    alternatives = c("Alternative template suggestions")
  ))
}
```

#### 6. Testing

Use the validation system:

```r
source("tools/validate-templates.R")
test_template("new-template", tempdir())
```

### Example: Creating a Meta-Analysis Template

```bash
# Create directory
mkdir templates/meta-analysis

# Core files
touch templates/meta-analysis/README.md
touch templates/meta-analysis/meta-analysis.qmd
touch templates/meta-analysis/references.bib
touch templates/meta-analysis/_quarto.yml

# Specialized directories
mkdir -p templates/meta-analysis/R
mkdir -p templates/meta-analysis/data/{extracted,processed}
mkdir -p templates/meta-analysis/prisma
```

## Best Practices

### Design Principles

1. **Minimal viable template**: Start with the simplest version that works
2. **Clear documentation**: Every template element should be documented
3. **Consistent patterns**: Follow established conventions from other templates
4. **Maintainable code**: Write clear, commented code for future maintenance

### Testing and Validation

1. **Test with real projects**: Use templates for actual research projects
2. **Cross-platform testing**: Ensure templates work on Windows, macOS, and Linux
3. **Version compatibility**: Test with different R and Quarto versions
4. **User feedback**: Get input from template users

### Documentation Standards

1. **README structure**: Follow the established README pattern
2. **Code comments**: Document all R functions and complex logic
3. **Usage examples**: Provide concrete examples of customization
4. **Troubleshooting**: Include common issues and solutions

## Maintenance and Updates

### Version Control

- Use semantic versioning for template versions
- Document breaking changes clearly
- Provide migration guides for major updates

### Community Contributions

- Accept pull requests for template improvements
- Review contributions for quality and consistency
- Coordinate with other template maintainers

### Deprecation Policy

When retiring templates:

1. **Announce deprecation** with timeline
2. **Provide migration path** to replacement template
3. **Archive template** but keep accessible
4. **Update documentation** to reflect status

## Getting Help

### Resources

- **Template examples**: Study existing templates for patterns
- **Quarto documentation**: https://quarto.org/docs/
- **R package development**: For custom R functionality
- **LaTeX documentation**: For advanced PDF customization

### Community Support

- Open GitHub issues for template development questions
- Join discussions about template design decisions
- Share your custom templates with the community
- Contribute improvements back to the main repository

---

*This guide is a living document. Please contribute improvements and additions based on your customization experience.*