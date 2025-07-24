# Contributing to the Modular Template System

Thank you for your interest in improving these academic research templates! This guide outlines how to contribute effectively to the modular template system.

## Quick Start for Contributors

1. **Fork the repository** and clone your fork locally
2. **Choose your contribution type**: Template improvement, new template, or system enhancement
3. **Follow the development workflow** outlined below
4. **Test your changes** using the validation tools
5. **Submit a pull request** with clear documentation

## Types of Contributions

### Template Improvements
- **Fix bugs** in existing templates
- **Enhance documentation** (README files, comments)
- **Add new features** to specific templates
- **Update dependencies** or configuration files

### New Templates
- **Propose new template types** for different research needs
- **Create specialized variants** of existing templates
- **Add domain-specific templates** (e.g., for specific fields)

### System Enhancements
- **Improve automation tools** (template-chooser.R, project-initializer.R)
- **Add testing infrastructure** or validation checks
- **Enhance documentation** and user guides

## Development Workflow

### Setting Up Your Environment

```bash
# Clone your fork
git clone https://github.com/yourusername/project-template.git
cd project-template

# Install required R packages
Rscript -e "install.packages(c('fs', 'here', 'cli', 'yaml'))"
```

### Making Changes

1. **Create a feature branch**:
   ```bash
   git checkout -b improve-empirical-template
   ```

2. **Make your changes** following the guidelines below

3. **Test your changes**:
   ```bash
   # Run validation tests
   Rscript tools/validate-templates.R
   
   # Test specific template if working on one
   Rscript -e "source('tools/validate-templates.R'); test_template('simple-paper', tempdir())"
   ```

4. **Update documentation** as needed

5. **Commit your changes**:
   ```bash
   git add .
   git commit -m "Improve empirical template structure"
   ```

## Template Development Guidelines

### File Structure Standards

All templates should follow consistent patterns:

```
template-name/
├── README.md              # Template-specific documentation
├── main-document.qmd      # Primary content file
├── references.bib         # Bibliography
├── _quarto.yml           # Quarto configuration
└── template-specific/    # Additional template files
```

### Required Files

Every template must include:
- **README.md**: Comprehensive setup and usage instructions
- **Main .qmd file**: Primary document with proper YAML header
- **references.bib**: Bibliography file with example citations
- **_quarto.yml**: Quarto configuration for the template

### Naming Conventions

- **Template directories**: Use kebab-case (e.g., `simple-paper`, `empirical-study`)
- **Main documents**: Use descriptive names (`paper.qmd`, `manuscript.qmd`, `proposal.qmd`)
- **Follow existing patterns** in the repository

### Documentation Requirements

#### Template README Files
Each template README should include:
- **When to use this template** section
- **What's included** (file structure)
- **Setup instructions** (step-by-step)
- **Workflow guidance** (how to use the template)
- **Common customizations** examples
- **Quality checklist** for users

#### Code Comments
- **R scripts**: Document all functions and complex logic
- **Quarto files**: Use comments to explain code chunks
- **Configuration files**: Explain non-obvious settings

### Testing Requirements

#### Before Submitting Changes

1. **Run validation tests**:
   ```bash
   Rscript tools/validate-templates.R
   ```

2. **Test template creation manually**:
   ```r
   source("tools/project-initializer.R")
   initialize_project("test-project", "your-template", tempdir())
   ```

3. **Check Quarto rendering** (if Quarto is available):
   ```bash
   cd your-test-project
   quarto render
   ```

#### Template-Specific Testing

For each template type, verify:
- **simple-paper**: Basic paper rendering and citation management
- **empirical-study**: R analysis pipeline and data management
- **grant-application**: Proposal structure and budget sections
- **literature-review**: PRISMA workflow and systematic review features
- **conference-presentation**: Slide rendering and presentation formats

## Code Style Guidelines

### R Code
- **Follow tidyverse style guide**: Use consistent naming and formatting
- **Use `here()` for paths**: Ensure robust file path handling
- **Document functions**: Include parameter descriptions and examples
- **Handle errors gracefully**: Provide clear error messages

### Quarto Documents
- **Follow Quarto best practices**: Include blank lines between elements
- **Use proper YAML headers**: Include all required metadata
- **Structure content clearly**: Use consistent heading hierarchy
- **Include example content**: Provide helpful placeholder text

### File Organization
- **Use relative paths**: Never hardcode absolute paths
- **Keep templates minimal**: Only include necessary files
- **Group related files**: Organize content logically
- **Include appropriate .gitignore**: Use template-specific patterns

## Automation Tools

### Template Chooser
When modifying `tools/template-chooser.R`:
- **Update decision logic** if adding new templates
- **Test recommendation accuracy** with various scenarios
- **Maintain clear question flow** for users

### Project Initializer
When modifying `tools/project-initializer.R`:
- **Test with all template types** after changes
- **Ensure directory creation works** correctly
- **Verify file customization** (name replacement, etc.)
- **Test git initialization** and .gitignore creation

## Submitting Pull Requests

### PR Description Template

```markdown
## Changes Made
- Brief description of what you changed

## Template(s) Affected
- List which templates are modified

## Testing Done
- [ ] Ran validation tests successfully
- [ ] Tested template creation manually
- [ ] Verified Quarto rendering (if applicable)
- [ ] Updated documentation

## Breaking Changes
- Describe any breaking changes (if any)

## Additional Notes
- Any other relevant information
```

### Review Process

1. **Automated checks**: Validation tests run automatically
2. **Code review**: Maintainers review changes for quality and consistency
3. **Testing feedback**: Request testing on different systems if needed
4. **Documentation review**: Ensure all documentation is clear and complete

## Getting Help

### Resources
- **Check existing issues**: Look for similar problems or requests
- **Review template examples**: Study existing templates for patterns
- **Read validation output**: Use error messages to debug issues

### Questions and Discussion
- **Open an issue**: For questions about contributing
- **Tag maintainers**: Use @mentions for specific expertise
- **Be specific**: Provide context and examples in your questions

## Recognition

Contributors are recognized in:
- **Git commit history**: All contributions are tracked
- **Release notes**: Major contributions highlighted
- **README acknowledgments**: Regular contributors mentioned

Thank you for helping improve these research templates!
