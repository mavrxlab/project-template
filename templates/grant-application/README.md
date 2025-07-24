# Grant Application Template

For funding proposals, project management, and grant reporting.

## When to Use This Template

- **Federal grants**: NSF, NIH, NEH, Department of Education, etc.
- **Foundation grants**: Private foundation funding
- **Internal funding**: University or institutional grants
- **Industry partnerships**: Corporate research collaborations
- **International funding**: Fulbright, bilateral research agreements

## What's Included

```
grant-application/
├── project.Rproj              # R project file
├── proposal.qmd               # Main grant proposal document
├── timeline.qmd               # Interactive timeline planner (NSF/NIH/Generic)
├── references.bib             # Bibliography for citations
├── _quarto.yml               # Quarto configuration
├── assets/                    # Citation styles and reference documents
│   ├── apa.csl               # APA citation style
│   ├── nature.csl            # Nature citation style
│   └── [other .csl files]    # Additional citation formats
├── admin/                     # Administrative documents
├── figures/                   # Generated figures and plots
├── tables/                    # Generated tables and data
└── archive/                   # Archived drafts and materials
```

## Grant Types & Customizations

### Federal Grants (NSF, NIH, etc.)
- **Standard sections**: Project summary, narrative, broader impacts
- **Compliance requirements**: Data management plans, human subjects
- **Formatting**: Agency-specific templates and requirements

### Foundation Grants
- **Simpler structure**: Often narrative-focused with less technical detail
- **Mission alignment**: Strong emphasis on foundation priorities
- **Relationship building**: Cultivation and stewardship components

### Internal/Seed Funding
- **Streamlined process**: Shorter applications, local requirements
- **Institutional priorities**: Alignment with university strategic goals
- **Quick turnaround**: Faster application and decision timelines

## Timeline Planning Tool

The `timeline.qmd` file provides an interactive grant timeline planner that automatically calculates deadlines working backwards from your submission date.

### Using the Timeline Planner

1. **Set your deadline**: Edit the `deadline` variable in the setup chunk:
   ```r
   deadline <- ymd("2025-01-15")  # Your submission deadline
   ```

2. **Choose your funding agency**: Select the appropriate timeline template:
   ```r
   funding_agency <- "NSF"  # Options: "NSF", "NIH", "Generic"
   ```

3. **Generate timeline**: Render the document to create your personalized timeline:
   ```bash
   quarto render timeline.qmd
   ```

### Timeline Features

- **Agency-specific templates**: NSF, NIH, and generic funding timelines
- **Automatic date calculation**: All deadlines calculated from your submission date
- **Priority levels**: Activities marked as Critical, High, Medium, or Low priority
- **Progress tracking**: Checkboxes and milestone tracking
- **Budget timeline**: Separate timeline for budget development activities

### Funding Agency Templates

#### NSF Timeline (21 weeks)
- Includes NSF-specific requirements like Broader Impacts and Data Management Plans
- Program Director consultation period
- Multiple review stages with faculty mentors

#### NIH Timeline (20 weeks) 
- NIH-specific sections like Specific Aims and Research Strategy
- Human subjects and vertebrate animals documentation
- eRA Commons submission process

#### Generic Timeline (18 weeks)
- Flexible template for any funding agency
- Standard grant application components
- Adaptable for foundation or internal funding

## Application Workflow

### Phase 1: Pre-Application
1. **Identify funding opportunities**: Research agencies and programs
2. **Build partnerships**: Identify collaborators and advisors
3. **Develop concept**: Create initial project outline
4. **Check eligibility**: Verify requirements and restrictions

### Phase 2: Proposal Development
1. **Create timeline**: Use `timeline.qmd` to generate your submission schedule
2. **Draft narrative**: Write main proposal in `proposal.qmd`
3. **Develop budget**: Plan budget components following timeline
4. **Gather support**: Collect letters and partnership agreements
5. **Internal review**: Get institutional feedback and approval

### Phase 3: Submission
1. **Format proposal**: Use agency-specific Quarto templates
2. **Quality check**: Verify all requirements met
3. **Submit application**: Through appropriate channels (grants.gov, etc.)
4. **Track status**: Monitor review process

### Phase 4: Award Management (if funded)
1. **Project kickoff**: Implement project management systems
2. **Regular reporting**: Use templates in `reporting/`
3. **Budget monitoring**: Track expenditures and compliance
4. **Final reporting**: Complete project summary and outcomes

## Budget Management

### Budget Development
- **Personnel costs**: Salary, benefits, effort allocation
- **Equipment**: Major and minor equipment categories
- **Travel**: Conference presentations, collaboration visits
- **Other costs**: Supplies, communications, participant incentives
- **Indirect costs**: F&A rates and calculations

### Cost Tracking
- **Monthly monitoring**: Regular budget vs. actual comparisons
- **Compliance checking**: Ensure allowable cost guidelines
- **Modification requests**: Process for budget changes
- **Final reconciliation**: Close-out procedures

## Collaboration Management

### Partner Coordination
- **Regular meetings**: Scheduled collaboration check-ins
- **Shared resources**: Access to data, materials, facilities
- **Communication protocols**: How teams will interact
- **Conflict resolution**: Procedures for addressing disagreements

### Advisory Structure
- **External advisors**: Industry or academic experts
- **Community representatives**: Stakeholder involvement
- **Student researchers**: Training and development opportunities
- **Evaluation committee**: Independent assessment of progress

## Reporting & Compliance

### Progress Reports
- **Quarterly updates**: Internal progress tracking
- **Annual reports**: Formal agency reporting
- **Milestone assessments**: Key deliverable evaluations
- **Publication tracking**: Outputs and dissemination

### Financial Reporting
- **Expenditure reports**: Regular financial status updates
- **Audit preparation**: Documentation for external reviews
- **Cost-share tracking**: Institutional contribution monitoring
- **Equipment inventory**: Asset management and reporting

## Quality Assurance

### Pre-Submission
- [ ] All required sections included
- [ ] Budget balances and justifies all costs
- [ ] Letters of support secured
- [ ] Institutional approvals obtained
- [ ] Formatting requirements met
- [ ] Page limits respected
- [ ] References complete and accurate

### Post-Award
- [ ] Project management systems established
- [ ] Reporting schedule created
- [ ] Budget monitoring procedures active
- [ ] Collaboration agreements signed
- [ ] IRB approvals current (if applicable)
- [ ] Data management plan implemented

## Common Customizations

### Agency-Specific Requirements
- **NSF**: Broader impacts, data management plans
- **NIH**: Human subjects, rigor and reproducibility
- **NEH**: Humanities methodology, public engagement
- **DOEd**: Educational impact, scalability

### Project Types
- **Equipment grants**: Major instrumentation proposals
- **Travel grants**: Conference or research visit funding
- **Training grants**: Student and postdoc support
- **Infrastructure**: Facility or program development

## Success Strategies

### Competitive Advantages
- **Clear significance**: Compelling problem statement
- **Strong methodology**: Rigorous and appropriate methods
- **Experienced team**: Demonstrated track record
- **Realistic timeline**: Achievable milestones and deliverables
- **Broader impact**: Clear benefits beyond immediate project

### Common Pitfalls
- **Overly ambitious scope**: Projects too large for timeline/budget
- **Weak evaluation plan**: Insufficient assessment methodology
- **Poor collaboration**: Unclear roles and responsibilities
- **Budget misalignment**: Costs don't match proposed activities
- **Compliance gaps**: Missing required elements or approvals