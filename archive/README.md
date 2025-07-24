# Original Template Archive

This directory contains the original template structure that has been replaced by the modular template system.

## What's Here

- **1-Project_Management/**: Original 4-part organizational structure
- **R/**: Original numbered R analysis scripts (00-init.R through 99-build.R)
- **admin/**: Original admin and project management files
- **analysis/**: Original analysis workflow structure
- **data/**: Original data directory structure
- **docs/**: Original documentation including IRB templates
- **papers/**: Original paper template
- **presentations/**: Original presentation template

## Why This Was Replaced

The original template had several issues:

1. **One-size-fits-all approach**: Every project got IRB documentation even when unnecessary
2. **Complex R workflow**: 12 numbered scripts were overkill for simple papers
3. **Mixed organizational paradigms**: Inconsistent naming and structure
4. **Fragile build system**: Hard-coded script names in build files
5. **Difficult customization**: Hard to adapt for different project types

## Migration Notes

If you have existing projects using this structure:

1. **Continue using it**: Existing projects don't need to change
2. **Migrate selectively**: Copy relevant parts to new template structure
3. **Use for reference**: Original templates can guide customization of new templates

## Historical Context

This template was based on:
- Nikola Vukovic's organized folder structure principles
- MA{VR}X Lab research workflow requirements
- Academic research best practices circa 2023-2024

The new modular system builds on these foundations while addressing usability and flexibility concerns.