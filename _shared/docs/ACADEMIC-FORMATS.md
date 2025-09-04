# Academic Format Guide

This guide explains how to use different academic formats available in the template system.

## Overview

The templates include support for multiple academic output formats:

- **Standard formats**: HTML, PDF, DOCX
- **Journal-specific formats**: APA, IEEE, Nature, JAMA, etc.
- **Citation styles**: 7+ common academic citation formats
- **Custom formats**: Extensible system for institutional requirements

## Available Formats

### Standard Formats

#### HTML Output
```bash
quarto render manuscript.qmd --to html
```
- Interactive web-based output
- Code folding and tools
- Table of contents navigation
- Ideal for sharing and collaboration

#### PDF Output
```bash
quarto render manuscript.qmd --to pdf
```
- Print-ready academic papers
- LaTeX-based typesetting
- Professional formatting
- Journal submission ready

#### DOCX Output
```bash
quarto render manuscript.qmd --to docx
```
- Microsoft Word compatibility
- Track changes and comments
- Collaborative editing
- Reference document templates

### Academic-Style Formats

The templates provide basic academic-style formats. For full journal compliance, use the specialized extensions linked below.

#### APA Style (Psychology)
```bash
quarto render manuscript.qmd --to apa-style
```
- APA-style formatting with proper citation style
- Double-spaced manuscript layout
- Standard margins and typography
- **For full APA 7 compliance**: Use [apaquarto extension](https://github.com/wjschne/apaquarto)

**Configuration**:
```yaml
format:
  apa-style:
    format: pdf
    documentclass: article
    fontsize: 12pt
    linestretch: 2
    geometry: margin=1in
    csl: https://www.zotero.org/styles/apa
```

#### IEEE Style (Engineering/Computer Science)
```bash
quarto render manuscript.qmd --to ieee-style
```
- IEEE citation style with two-column layout
- Compact formatting for technical papers
- Standard article document class
- **For full IEEE compliance**: Use [quarto-ieee extension](https://github.com/Mellich/quarto-ieee)

**Configuration**:
```yaml
format:
  ieee-style:
    format: pdf
    documentclass: article
    fontsize: 10pt
    geometry: margin=0.75in
    columns: 2
    csl: https://www.zotero.org/styles/ieee
```

#### Nature Style (Life Sciences)
```bash
quarto render manuscript.qmd --to nature-style
```
- Nature journal citation style
- Compact layout suitable for life sciences
- Standard formatting with Nature-style references

**Configuration**:
```yaml
format:
  nature-style:
    format: pdf
    documentclass: article
    fontsize: 10pt
    geometry: margin=0.75in
    csl: https://www.zotero.org/styles/nature
```

## Citation Styles

### Available Styles

The templates include these citation styles:

- **apa.csl**: American Psychological Association
- **ieee.csl**: Institute of Electrical and Electronics Engineers
- **chicago-author-date.csl**: Chicago Manual of Style
- **nature.csl**: Nature journals
- **science.csl**: Science magazine
- **plos-one.csl**: PLOS journals
- **mla.csl**: Modern Language Association

### Using Citation Styles

In your `_quarto.yml`:

```yaml
bibliography: references.bib
# Use live Zotero Style Repository (with local backup)
csl: https://www.zotero.org/styles/apa  # Fallback: assets/apa.csl
```

Or specify for specific formats:

```yaml
format:
  pdf:
    csl: https://www.zotero.org/styles/ieee
  html:
    csl: https://www.zotero.org/styles/apa
```

### Adding New Citation Styles

The authoritative source for citation styles is the [Zotero Style Repository](https://www.zotero.org/styles) with thousands of journal-specific styles.

1. **Browse styles**: Visit https://www.zotero.org/styles
2. **Download CSL file**: Click on a style and download the `.csl` file
3. **Place in assets/**: Add to your template's `assets/` directory  
4. **Reference in config**: Update `_quarto.yml` to use the new style

**Automated download** for common styles:
```r
# Download/update common citation styles from Zotero Style Repository
source("tools/download-citation-styles.R")
```

**Note**: Templates include local backup copies of common citation styles. The download script updates these with the latest versions from the authoritative Zotero Style Repository.

## Format Selection by Field

### Psychology Research
```yaml
format:
  apa-style:
    format: pdf
    documentclass: article
    fontsize: 12pt
    linestretch: 2
    geometry: margin=1in
    csl: https://www.zotero.org/styles/apa
```

### Computer Science/Engineering
```yaml
format:
  ieee-style:
    format: pdf
    documentclass: article
    fontsize: 10pt
    geometry: margin=0.75in
    columns: 2
    csl: https://www.zotero.org/styles/ieee
```

### Life Sciences Research
```yaml
format:
  nature-style:
    format: pdf
    documentclass: article
    fontsize: 10pt
    geometry: margin=0.75in
    csl: https://www.zotero.org/styles/nature
```


## Using Specialized Quarto Extensions

For full journal compliance, consider these community-maintained extensions:

### APAquarto Extension
**For psychology and APA-style journals**

Install and use:
```bash
quarto add wjschne/apaquarto
```

Then in your document:
```yaml
format:
  apaquarto-pdf: default
  apaquarto-html: default
  apaquarto-docx: default
```

Features:
- Full APA 7th edition compliance
- Automatic title page formatting
- Proper running heads and page numbers
- APA-style tables and figures

### Quarto IEEE Extension
**For engineering and computer science journals**

Install and use:
```bash
quarto add Mellich/quarto-ieee
```

Then in your document:
```yaml
format: ieee-pdf
```

Features:
- True IEEE formatting
- Conference and journal variants
- Proper IEEE citation style
- Technical paper formatting

### Other Extensions
- **[quarto-tandf](https://github.com/quarto-journals/tandf)**: Taylor & Francis journals
- **[quarto-elsevier](https://github.com/quarto-journals/elsevier)**: Elsevier journals  
- **[quarto-jss](https://github.com/quarto-journals/jss)**: Journal of Statistical Software
- **[quarto-plos](https://github.com/quarto-journals/plos)**: PLOS journals

Browse more at: https://github.com/quarto-journals

## Custom Format Creation

### Creating Journal-Specific Formats

1. **Research requirements**: Check journal submission guidelines
2. **Create format variant**: Add to `_quarto.yml`
3. **Test with sample content**: Verify formatting meets requirements
4. **Document usage**: Add to template README

**Example - Custom Journal Format**:
```yaml
format:
  custom-journal:
    format: pdf
    documentclass: article
    fontsize: 11pt
    geometry: 
      - margin=1.25in
      - paper=letterpaper
    linestretch: 1.15
    csl: assets/custom-journal.csl
    template-partials:
      - "custom-title.tex"
```

### LaTeX Customization

For advanced PDF customization:

1. **Custom document class**: Create `.cls` file
2. **Template partials**: Customize specific sections
3. **Include files**: Add custom LaTeX packages

**Example**:
```yaml
format:
  pdf:
    documentclass: custom-article
    include-in-header:
      - "assets/custom-packages.tex"
    template-partials:
      - "assets/custom-title.tex"
```

## Multi-Format Workflows

### Simultaneous Output
Generate multiple formats at once:

```bash
quarto render manuscript.qmd
```

This creates all formats specified in `_quarto.yml`.

### Format-Specific Content

Use conditional content for different formats:

```markdown
::: {.content-visible when-format="pdf"}
This content only appears in PDF output.
:::

::: {.content-visible when-format="html"}
This content only appears in HTML output.
:::
```

### Format-Specific Citations

Different citation styles for different formats:

```yaml
format:
  pdf:
    csl: https://www.zotero.org/styles/nature
  html:
    csl: https://www.zotero.org/styles/apa
  docx:
    csl: https://www.zotero.org/styles/chicago-author-date
```

## Troubleshooting

### Common Issues

#### LaTeX Errors
- **Missing packages**: Install required LaTeX packages
- **Class not found**: Ensure document class is available
- **Compilation errors**: Check LaTeX syntax in custom templates

#### Citation Problems
- **Style not found**: Verify CSL file path
- **Missing bibliography**: Check bibliography file location
- **Formatting issues**: Validate CSL file integrity

#### Format-Specific Problems
- **Two-column layouts**: Use `columns: 2` in format configuration
- **Citation style issues**: Ensure CSL files are in correct `assets/` directory
- **Geometry problems**: Verify LaTeX geometry package is installed
- **For journal-specific formatting**: Consider using dedicated Quarto extensions (apaquarto, quarto-ieee, etc.)

### Getting Help

1. **Check Quarto documentation**: https://quarto.org/docs/
2. **LaTeX package documentation**: For PDF-specific issues
3. **Citation Style Language**: https://citationstyles.org/
4. **Template issues**: Open GitHub issues for template-specific problems

## Best Practices

### Format Selection
1. **Check journal requirements** before starting
2. **Test early** with sample content
3. **Use appropriate citation style** for field
4. **Consider collaboration needs** (DOCX for track changes)

### Maintenance
1. **Update citation styles** regularly
2. **Test formats** after Quarto updates
3. **Document custom modifications** clearly
4. **Version control** format configurations

### Performance
1. **Cache expensive computations** for multiple formats
2. **Use conditional execution** for format-specific code
3. **Optimize images** for different output types
4. **Consider build time** for complex formats

---

*For template-specific format information, see individual template README files.*