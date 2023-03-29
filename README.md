---
editor_options: 
  markdown: 
    wrap: 72
---

<h1 align="center">

<br> Education, children's social care and offending: local authority
level dashboard <br>

</h1>

<p align="center">

<a href="#introduction">Introduction</a> \|
<a href="#requirements">Requirements</a> \| <a href="#how-to-use">How to
use</a> \| <a href="#how-to-contribute">How to contribute</a> \|
<a href="#contact">Contact</a>

</p>

------------------------------------------------------------------------

## Introduction

This interactive dashboard was created to complement the previously
published [Education, children's social care and
offending](https://www.gov.uk/government/publications/education-childrens-social-care-and-offending)
descriptive analysis with the aim of providing local authority specific
breakdowns, for each local authority in England, where possible.

Live version of the dashboard can be accessed at

-   <https://department-for-education.shinyapps.io/childrens-social-care-and-offending/>

The dashboard contains 3 main tabs:

-   **Demographics**: This tab contains a high-level analysis of
    demographic factors (including information about each select LA,
    gender, age at first offence, ethnicity and free school meal
    eligibility).

-   **School experience**: This tab contains analysis that relates to
    children's experiences whilst in school (including findings on
    attainment , persistent absence, suspensions & exclusions,
    alternative provision and special educational needs).

-   **Children's social care experience**: This tab contains analysis
    that relates to children's experiences with children's social care
    (including findings on children who had been recorded as children in
    need or a children looked after)

There is also the option to select sub-tabs within these tabs, to look
at more specific variables within each page, with explanatory text
included where necessary.

The dashboard also includes a dashboard and data overview on the
homepage tab, as well as an accessibility and support and feedback tab
for information on where to find further support.

------------------------------------------------------------------------

## Requirements

You should list out the software and programming skills needed, as well
as any access requirements = e.g.

### i. Software requirements (for running locally)

-   Installation of R Studio 1.2.5033 or higher

-   Installation of R 3.6.2 or higher

-   Installation of RTools40 or higher

### ii. Programming skills required (for editing or troubleshooting)

-   R at an intermediate level, [DfE R training
    guide](https://dfe-analytical-services.github.io/r-training-course/)

-   Particularly [R Shiny](https://shiny.rstudio.com/)

### iii. Access requirements

-   Access to the Stats Development Team SQL modelling area
    (MA_SDT_NS_DATA) in T1PRANMSQL\SQLPROD,60125. Request access from
    Cam Race and forward on your request to the PDR mailbox
    ([PupilData.REPOSITORY\@education.gov.uk](mailto:PupilData.REPOSITORY@education.gov.uk){.email})

------------------------------------------------------------------------

## How to use

### Running the app locally

1.  Clone or download the repo.

2.  Open the R project in R Studio.

3.  Run `renv::restore()` to install dependencies.

4.  Run `shiny::runApp()` to run the app locally.

### Packages

Package control is handled using renv. As in the steps above, you will
need to run `renv::restore()` if this is your first time using the
project.

### Tests

UI tests have been created using shinytest that test the app loads, that
content appears correctly when different inputs are selected, and that
tab content displays as expected. More should be added over time as
extra features are added.

GitHub Actions provide CI by running the automated tests and checks for
code styling. The yaml files for these workflows can be found in the
.github/workflows folder.

The function run_tests_locally() is created in the Rprofile script and
is available in the RStudio console at all times to run both the unit
and ui tests.

### Deployment

-   The app is deployed to the department's shinyapps.io subscription
    using GitHub actions, to
    <https://department-for-education.shinyapps.io/la-school-places-scorecards>.
    The yaml file for this can be found in the .github/workflows folder.

### Navigation

In general all .r files will have a usable outline, so make use of that
for navigation if in RStudio: `Ctrl-Shift-O`.

### Code styling

The function tidy_code() is created in the Rprofile script and therefore
is always available in the RStudio console to tidy code according to
tidyverse styling using the styler package. This function also helps to
test the running of the code and for basic syntax errors such as missing
commas and brackets.

------------------------------------------------------------------------

## How to contribute

Details on how to contribute to the app should go here, e.g.

### Flagging issues

If you spot any issues with the application, please flag it in the
"Issues" tab of this repository, and label as a bug.

### Merging pull requests

Only members of the Statistics Development team can merge pull requests.
Add lauraselby, cjrace and sarahmwong as requested reviewers, and the
team will review before merging.

------------------------------------------------------------------------

## Contact

If you have questions about the dashboard or data within it, please
contact us at
[statistics.development\@education.gov.uk](mailto:statistics.development@education.gov.uk)
or [SV.RESEARCH\@EDUCATION.GOV.UK](mailto:SV.RESEARCH@EDUCATION.GOV.UK).


