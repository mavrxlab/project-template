# Conference Presentation Template

For standalone presentations, conference talks, and academic presentations with minimal project overhead.

## When to Use This Template

- **Conference presentations**: Academic conference talks
- **Workshop presentations**: Shorter focused presentations  
- **Invited talks**: Guest lectures and seminars
- **Poster presentations**: Academic poster sessions
- **Webinar presentations**: Online presentations

## What's Included

```
conference-presentation/
├── project.Rproj              # R project file
├── slides.qmd                 # Main presentation slides
├── abstract.qmd               # Conference abstract
├── poster.qmd                 # Poster layout (optional)
├── _quarto.yml               # Quarto configuration
├── R/
│   ├── setup.R               # Basic setup for any R code
│   └── plots.R               # Presentation-specific visualizations
├── media/                    # Images, logos, figures
└── handouts/                 # Supporting materials for audience
```

## Setup Instructions

1. **Copy template**: `cp -r templates/conference-presentation/ your-talk-name/`
2. **Choose format**: Select slides, poster, or both in `_quarto.yml`
3. **Customize theme**: Adjust presentation theme and branding
4. **Add content**: Develop slides and supporting materials

## Presentation Workflow

### Phase 1: Abstract and Proposal
1. **Write abstract**: Complete `abstract.qmd` for submission
2. **Submit proposal**: Follow conference submission guidelines
3. **Plan presentation**: Outline key messages and structure

### Phase 2: Content Development
1. **Create slides**: Develop `slides.qmd` with clear narrative
2. **Add visuals**: Include figures, plots, and media in `media/`
3. **Prepare handouts**: Create supporting materials if needed
4. **Practice delivery**: Rehearse timing and transitions

### Phase 3: Final Preparation
1. **Test technology**: Verify slides work on target systems
2. **Prepare backup**: Export to PDF and have offline versions
3. **Create handouts**: Prepare materials for audience
4. **Final review**: Check for typos and flow

## Output Formats

### Slides
- **RevealJS**: Modern web-based presentations
- **Beamer**: LaTeX-based PDF slides
- **PowerPoint**: Standard PPTX format

### Posters
- **HTML**: Interactive web posters
- **PDF**: Print-ready poster layouts

## Common Customizations

### Presentation Themes
- **Institutional branding**: Add university colors and logos
- **Conference themes**: Match conference visual identity
- **Custom styling**: Create unique presentation designs

### Interactive Elements
- **Live polling**: Integrate audience response systems
- **QR codes**: Link to resources and follow-up materials
- **Interactive plots**: Use plotly or similar for dynamic content

## Tips for Success

### Content Strategy
- **One main message**: Focus on single key takeaway
- **Tell a story**: Structure as narrative with clear arc
- **Visual hierarchy**: Use consistent formatting and emphasis

### Delivery Preparation
- **Time management**: Practice to fit allocated time slot
- **Audience engagement**: Plan interaction opportunities
- **Technical backup**: Always have offline fallback options

## Quality Checklist

- [ ] Abstract follows conference guidelines
- [ ] Slides are readable from back of room
- [ ] All media files are included and accessible
- [ ] Timing fits allocated presentation slot
- [ ] Backup formats prepared (PDF, PPTX)
- [ ] Contact information included for follow-up