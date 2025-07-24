# Simple Paper Template

For theoretical, conceptual, or commentary papers that don't require data collection or complex analysis.

## When to Use This Template

- **Theory papers**: Conceptual contributions without empirical data
- **Commentary pieces**: Responses to existing work
- **Literature syntheses**: Non-systematic literature reviews  
- **Position papers**: Argumentative pieces on specific topics
- **Book chapters**: Academic writing for edited volumes

## What's Included

```
simple-paper/
├── project.Rproj              # R project file
├── paper.qmd                  # Main manuscript
├── references.bib             # Bibliography
├── _quarto.yml               # Quarto configuration
├── R/
│   ├── setup.R               # Basic R setup and functions
│   └── citations.R           # Citation management helpers
└── media/                    # Images, figures, etc.
```

## What's NOT Included

- IRB documentation (not needed for theoretical work)
- Data collection instruments
- Complex statistical analysis pipelines
- Pre-registration templates
- Grant application materials

## Setup Instructions

1. **Copy template**: `cp -r templates/simple-paper/ your-project-name/`
2. **Update project info**: Edit `paper.qmd` with your title and details
3. **Set up references**: Add citations to `references.bib`
4. **Configure Quarto**: Modify `_quarto.yml` for your target journal format

## Writing Workflow

1. **Draft in Quarto**: Write in `paper.qmd` using markdown syntax
2. **Add citations**: Use `@citationkey` format, manage in `references.bib`
3. **Include figures**: Place in `media/` folder, reference with `![](media/figure.png)`
4. **Render output**: Use `quarto render` to generate PDF/HTML/DOCX

## Common Customizations

### Target Journal Formats
- **APA Style**: Add `apaquarto` extension for psychology journals
- **IEEE Style**: Include IEEE citation style and template
- **Academic Formats**: Use journal-specific Quarto extensions

### Citation Styles
- Update `_quarto.yml` with appropriate `.csl` file
- Common styles included: APA, IEEE, Chicago, Nature

## Tips for Success

- **Keep it simple**: Resist the urge to add unnecessary complexity
- **Focus on argument**: Structure around clear thesis and supporting points
- **Use version control**: Commit frequently as you write
- **Get feedback early**: Share drafts with colleagues before final submission

## Extending the Template

If your project grows beyond a simple paper:
- **Add data analysis**: Copy components from `empirical-study` template
- **Include presentations**: Add elements from `conference-presentation` template
- **Seek funding**: Incorporate `grant-application` template components