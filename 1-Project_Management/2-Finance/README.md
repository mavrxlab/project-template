# NSFrmarkdown
An R Markdown template for NSF proposals. This is currently being updated for recent changes in the NSF PAPPG: https://beta.nsf.gov/policies/pappg/23-1/ch-2-proposal-preparation

- Biosketches are now in spreadsheet template form.
- Pending and Current Support uses a template.
- Collaborators also uses a template.
- For letters of commitment, a Word file is included here for emailing. Just update the content with your name and project title.
- Added a `Schedule.Rmd` file. Just add the date of your solicitation deadline and it will give you a generic back-casted schedule.

## Steps

- Download the repository, and open the `.Rproj` file.
- Edit the `.Rmd` files for each of the sections of the grant. If you knit the document, a `.pdf` will be compiled into the doc folder.
    - Note that some documents are also set to create a Word file. This is useful for tracking changes with an editor or reviewer, for example, if they're not into using Git and Rmarkdown.
- You can compile all of the .Rmd files at once by using the build tab, and clicking build website.

*Tip*: put a copy of this entire repository (you can delete `.gitignore`) in a sub-folder of your Project Template. Work on the contents *only* by opening this `.Rproj` file.

## Tweaking the style

The style folder contains `nsf2.cls` and  `preamble.tex`. Both of which have been edited for 2023.

### Section numbering

Turn section numbering within a document on or off by setting `number_sections: true` or `number_sections: false` in the YAML. The style of section-numbering is controlled using the titlesec latex package in `nsf2.cls` (style folder). **Section** IDs (ie, the Project Description as Section D) have been removed as page numbers are no longer required. They are added automatically when submitting to Research.gov.

**Based on https://github.com/CrumpLab/NSFrmarkdown**
