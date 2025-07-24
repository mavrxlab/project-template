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

### Journal-Specific Formats

#### APA Format (Psychology)
```bash
quarto render manuscript.qmd --to apa-pdf
```
- APA 7th edition formatting
- Double-spaced manuscript style
- Proper heading hierarchy
- Psychology journal requirements

**Configuration**:
```yaml
format:
  apa-pdf:
    documentclass: apa7
    classoption: ["man"]
    linestretch: 2
    fontsize: 12pt
```

#### IEEE Format (Engineering/Computer Science)
```bash
quarto render manuscript.qmd --to ieee-pdf
```
- IEEE conference/journal formatting
- Two-column layout
- Technical paper standards
- Engineering publication style

**Configuration**:
```yaml
format:
  ieee-pdf:
    documentclass: IEEEtran
    classoption: ["conference"]
    fontsize: 10pt
    geometry: margin=0.75in
```

#### Nature Format (Life Sciences)
```bash
quarto render manuscript.qmd --to nature-pdf
```
- Nature journal formatting
- Compact layout
- Life sciences standards
- High-impact journal style

**Configuration**:
```yaml
format:
  nature-pdf:
    documentclass: article
    fontsize: 10pt
    geometry: margin=0.75in
    csl: assets/nature.csl
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
csl: assets/apa.csl  # Change to your preferred style
```

Or specify for specific formats:

```yaml
format:
  pdf:
    csl: assets/ieee.csl
  html:
    csl: assets/apa.csl
```

### Adding New Citation Styles

1. **Download CSL file**: From [Citation Style Language](https://citationstyles.org/)
2. **Place in assets/**: Add to your template's assets directory
3. **Reference in config**: Update `_quarto.yml` to use the new style

## Format Selection by Field

### Psychology Research
```yaml
format:
  apa-pdf:
    documentclass: apa7
    classoption: ["man"]
    csl: assets/apa.csl
```

### Computer Science
```yaml
format:
  ieee-pdf:
    documentclass: IEEEtran
    classoption: ["conference"]
    csl: assets/ieee.csl
```

### Medical Research
```yaml
format:
  jama-pdf:
    documentclass: article
    fontsize: 10pt
    csl: assets/jama.csl
    geometry: margin=0.75in
```

### Life Sciences
```yaml
format:
  nature-pdf:
    documentclass: article
    fontsize: 10pt
    csl: assets/nature.csl
    compact-title: true
```

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
    csl: assets/nature.csl
  html:
    csl: assets/apa.csl
  docx:
    csl: assets/chicago-author-date.csl
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
- **IEEE template**: May require specific LaTeX distribution
- **APA format**: Needs apa7 LaTeX class
- **Custom formats**: Check all dependencies are installed

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