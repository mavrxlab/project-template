# Literature Review Template

For systematic reviews, scoping reviews, and meta-analyses following established methodologies.

## When to Use This Template

- **Systematic reviews**: Following PRISMA or PRISMA-ScR guidelines
- **Scoping reviews**: Mapping research landscapes
- **Meta-analyses**: Quantitative synthesis of research findings
- **Narrative reviews**: Structured literature syntheses

## What's Included

```
literature-review/
├── project.Rproj              # R project file
├── review.qmd                 # Main review document
├── protocol.qmd               # Review protocol/registration
├── references.bib             # Bibliography
├── _quarto.yml               # Quarto configuration
├── R/
│   ├── setup.R               # Basic setup and functions
│   ├── search-analysis.R     # Search result processing
│   └── screening.R           # Citation screening helpers
├── search-results/           # Database search exports
├── screening/                # Citation screening workflow
├── data-extraction/          # Extracted data and coding
└── quality-assessment/       # Study quality evaluations
```

## Setup Instructions

1. **Copy template**: `cp -r templates/literature-review/ your-review-name/`
2. **Develop protocol**: Complete `protocol.qmd` with methodology
3. **Configure searches**: Set up database searches and save results
4. **Set up screening**: Organize citation management workflow

## Review Workflow

### Phase 1: Protocol Development
1. **Define questions**: Establish clear research questions
2. **Develop protocol**: Document methodology in `protocol.qmd`
3. **Register protocol**: Submit to PROSPERO or equivalent

### Phase 2: Search and Screening
1. **Database searches**: Execute comprehensive search strategies
2. **Import results**: Save search exports to `search-results/`
3. **Screen citations**: Use systematic screening process
4. **Full-text assessment**: Evaluate eligible studies

### Phase 3: Data Extraction and Analysis
1. **Extract data**: Use standardized extraction forms
2. **Assess quality**: Apply quality assessment tools
3. **Synthesize findings**: Narrative or quantitative synthesis
4. **Write review**: Complete `review.qmd`

## Common Customizations

### Review Types
- **PRISMA systematic reviews**: Full methodology with quality assessment
- **PRISMA-ScR scoping reviews**: Mapping focus without quality assessment
- **Meta-analyses**: Add quantitative synthesis tools and forest plots

### Citation Management
- Integration with Zotero, Mendeley, or EndNote
- Automated duplicate detection and removal
- Screening workflow management

## Quality Assurance

- [ ] Protocol registered before screening begins
- [ ] Search strategy peer-reviewed
- [ ] Dual screening for inclusion/exclusion
- [ ] Data extraction validated
- [ ] Quality assessment completed independently
- [ ] Findings synthesis follows established guidelines