# README

# Project Template

<img
src="https://img.shields.io/github/last-commit/mavrxlab/project-template.png"
class="quarto-discovered-preview-image" alt="Last updated" />

<!-- Only edit README.qmd, never README.md! Rendering README.qmd will produce README.md. Format: gfm stands for "Github-flavored markdown. -->

## Project Overview

This is a large repository meant to house any number of individual
studies and drafts that are all in some way connected. For example, in
the `1-Project_Management/2-Finance/` folder, there is a sub-project for
developing an NSF grant. As a variety of studies will often come of a
single grant, these are held in the `3-Studies` folder.

Note that you’re welcome to use a copy of this repository for *each*
individual study if you like. It is meant to be flexible. Not everything
need even be used. No grant? Skip the Finance folder, for example.

<!-- 
# This chunk is informational only and can be removed after forking.
# It displays the _INFO.qmd file contents in the README.
-->

## Template Information

Based on the template [Setting up an Organised Folder Structure for
Research Projects by Nikola
Vukovic](http://www.nikola.me/folder_structure.html) and tweaked by
[Ryan Straight](https://github.com/ryanstraight) with the [MA{VR}X
Lab](https://mavrxlab.org) in mind, specifically, as the focus is on
using R for data analysis, this template is simple enough to fit most
needs and has the media structure necessary for projects within the lab.

If you’d rather not use the R-based Quarto ecosystem for writing that’s
present in the template, that’s fine. The folder structure will still
serve you well.

A placeholder publication draft can be found in
`3-Studies/001-Study_1/`. It is a Quarto document that uses the [Hikmah
Quarto templates](https://github.com/andrewheiss/hikmah-academic-quarto)
template as it produces a nice APA-like document.

## Authors

1.  Update the `contributors_table_template.csv` file in
    `1-Project_Management/4-Administration/` with relevant authors and
    contributors.
2.  Upload the CSV in step 2 of the
    [tenzing](https://rollercoaster.shinyapps.io/tenzing/) Shiny app.
    (You can use the file provided as a demonstration if you like.)
3.  Choose the method of getting the author contributions that make
    sense for your publication outlet.

## Research Production

The resultant publications from this project go in
`4-Dissemination/2-Publications/` in subfolders for each individual
publication. This should be a considered an archival step.

## Folder and file structure

This is the default structure for a project. It’s very basic and you
should feel welcome to alter it to your liking. There is another README
in the `3-Study/2-Content/2-Media/` folder that explains the extensive
structure there. This structure is not meant to be in chronological
order, just organized.

1.  Project Management
    1.  Proposals (drafting proposal content, letters of support, and so
        on)
    2.  Finance (notes on seeking funding, copies of grant proposals,
        etc; contains NSF grant template updated as of 2023
        requirements)
    3.  Reports (not papers; project-related reports like status)
    4.  Administration (CRediT author list, publication checklist)
2.  Ethics Governance
    1.  Ethics Approval (IRB protocol, CITI certification)
    2.  Forms (**blank** consent, waiver, etc forms that have been
        approved by the IRB; completed forms should be stored securely)
3.  Study (`001-Study_1` subfolder contains a template with the
    following for each different study)
    1.  Input (files/docs used in the experiment itself; survey
        instrument, anything)
    2.  Content
        1.  Data (raw and tidied data)
        2.  Media (video recordings, audio, screencasts, so on; do
            **not** include identifiable participant content)
    3.  Data Analysis (eda, munging scripts, transformation, etc)
    4.  Outputs (tables, figures, etc)
    5.  Drafts (One folder for each draft publication; there is a
        template Quarto file included in folder 01. Rename `01` to the
        outlet you’re targeting with that particular draft.
4.  Dissemination (these folders are *archives* to easily find content
    derived from this project)
    1.  Presentations (put slide decks and whatnot in here)
    2.  Publications (finished publications in their final form go here,
        while preprints would stay in the study’s `drafts` folder)
    3.  Publicity (any sort of publicity like social media posts, et
        cetera)

Note that the Dissemination folder is for *archiving* content. Once
something is published or made available, put a copy in the appropriate
folder.
