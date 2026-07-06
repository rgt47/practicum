# Deep Review of the Biostatistics Practicum
*2026-07-05 17:42 PDT*

This document records a deep review of the *Biostatistics
Practicum* undertaken at the author's request. The charge had four
parts: to confirm that the prose reads in the author's voice; to
sharpen the disciplinary focus from general public health toward
biostatistics specifically; to add figures, diagrams, tables, and
bilingual (R and Python) code where they earn their place; and to
benchmark the book against comparable courses at leading research
universities, checking both the reference list and the topic
coverage. What follows is a summary of the findings and of the
changes already made, together with a plan for the work that
remains.

## 1. Executive summary

The manuscript is in strong condition. The voice is already
consistent with the author's fingerprint across all twenty-five
chapters, and the disciplinary framing is sound in the clinical
chapters. The single largest weakness was not prose but
presentation: the book rendered no figures at all. Every code block
was display-only, so a chapter on plotting contained no plots and a
chapter on missing-data diagnostics never showed a missingness map.
That deficiency has now been addressed in the highest-value
chapters, the reproducibility infrastructure has been rewired so
that executable figures and Python chunks do not break the
deployment, and per-chapter epigraphs have been added throughout.
The peer comparison confirms that the book's coverage of Git,
`renv`, Docker, compendia, Quarto, and clinical-data standards
matches or leads its peers, and identifies a short list of
practical topics, principally databases, the Unix shell,
pipeline tooling, and de-identification, whose addition would bring
the book to full parity.

## 2. Voice

The prose is faithful to the author's established register. The
collegial *we*, the hedged and scope-aware claims, the
worked-example openings, the rhetorical question answered in the
next sentence, and the numbered closing summaries all appear where
they should. 'The statistician's contribution' and 'Principle in
use' sections recur with the right cadence. No wholesale rewriting
was warranted, and none was done.

Three small matters were corrected. First, the 'Further reading'
lists and a few body sentences used a triple-hyphen that Quarto
renders as an em dash, in violation of the house style; these were
replaced with commas in twelve chapters. Second, an unfinished
`TODO` block in the alternative-wrangling appendix was completed in
prose. Third, two substantive content inconsistencies were
reconciled, described in section 6.

## 3. Biostatistics focus

The clinical chapters, missing data, CDISC and ADaM, the analysis
plan, and the ADNI case study, are the disciplinary high points and
need no strengthening. The generic material is concentrated where
one would expect it: the graphics chapter and the Palmer Penguins
case study rely on non-clinical examples throughout. Rather than
strip the penguins, which serve well as a clean warm-up, the review
added clinical counterparts alongside them: a simulated
two-arm longitudinal trajectory figure in the graphics chapter, a
blood-pressure-by-visit reshaping example in the wrangling chapter,
and a Kaplan-Meier curve rendered from the CDISC pipeline the
chapter already builds. The intent is to let a first-year
biostatistics student see the figure they will actually be asked
for, not only the textbook scatter plot.

## 4. Figures, diagrams, tables, and bilingual code added

All additions below were rendered and verified to build. The book
now produces real figures rather than describing them.

- **Graphics (ch. 16).** The `purrr`-per-group plot, the
  `patchwork` composition, the regression-diagnostic panel, and the
  house-theme definition are now executable and render. A new
  simulated clinical trajectory figure and a bilingual
  `pandas`/`matplotlib` scatter were added.
- **Missing data (ch. 17).** The `naniar` missingness map and
  per-variable bar chart now render, and a Mermaid diagram of the
  three-step multiple-imputation procedure was added.
- **Wrangling (ch. 13).** A runnable wide-to-long reshape with a
  rendered blood-pressure trajectory, and a `dplyr`-to-`pandas`
  translation table with an executable Python chunk.
- **Joins (ch. 15).** A decision diagram for choosing a join, the
  `band_members` example made executable, and a `dplyr`-to-`pandas`
  merge translation table with a Python chunk.
- **CDISC (ch. 19).** A rendered Kaplan-Meier curve with a risk
  table, and a Mermaid diagram of the CRF-to-SDTM-to-ADaM-to-TLF
  pipeline.
- **Conceptual diagrams.** A three-ingredient reproducibility
  diagram and a summary table in chapter 1; a Git branch graph in
  chapter 5; an `renv` snapshot-restore cycle in chapter 8; a
  Docker layer-caching diagram in chapter 9; a CONSORT-style
  cohort-derivation diagram in the ADNI case study.
- **Case study (ch. 23).** The missingness map and the exploratory
  scatter now render.
- **Epigraphs.** A sourced, thematically matched epigraph was added
  to all twenty-six chapters, using the same `.bookepigraph`
  mechanism as the blockchain curriculum, with matching SCSS.

A note on the bilingual material. Python parallels were added only
where they teach something, principally in the wrangling, joins,
and graphics chapters, where a student's existing `pandas` fluency
is the fastest bridge into the tidyverse. The infrastructure
chapters (Git, `renv`, Docker, cloud, `zzcollab`) were left in R
and shell alone, because a Python parallel there would be noise
rather than signal.

## 5. Build and workflow changes

Executable R and Python chunks require support that the previous
build did not provide, and adding them naively would have broken
the Netlify deployment on the next push. The following changes make
the executable content safe to publish.

- `_freeze/` is no longer git-ignored. Rendered results are now
  committed, which is the standard Quarto pattern for a project
  whose computation spans R and Python: the continuous-integration
  build reuses the frozen figures and never needs to re-execute an
  unchanged chapter.
- The GitHub Actions workflow now installs the additional R
  packages the executable chunks use, and provisions Python with
  `pandas`, `numpy`, `matplotlib`, `statsmodels`, `scikit-learn`,
  and `plotnine`, as a fallback for any chapter that is
  re-executed.
- A project `.Rprofile` points `reticulate` at a local Python
  interpreter when `RETICULATE_PYTHON` is unset.
- Global knitr options now scale every figure to the text width
  (`out.width: 100%`), and the stylesheet caps images, SVG
  diagrams, and wide tables at the column width. This is what keeps
  figures and Mermaid diagrams from running off the page in either
  HTML or PDF.

To publish, render locally (`quarto render`) and commit the updated
`_freeze/` directory along with the sources. The author should be
aware that this is a genuine change to the publishing workflow: the
freeze must be regenerated and committed whenever an executable
chunk changes.

## 6. Content corrections

- **SAS reference coding (ch. 22).** The chapter conflated two
  distinct differences between SAS and R, the parameterization type
  (effect versus reference coding) and the choice of reference
  level (last versus first sorted), and in one place asserted them
  as if contradictory. The check-your-understanding answer now
  separates the two correctly. A related technical error was fixed:
  the worked example applied `param = ref` to `PROC GLM`, which does
  not accept it; the example now uses `PROC GLM` in its native
  parameterization and explains the reference-level difference, with
  a pointer to `PROC GENMOD` or `PROC GLMSELECT` for reference
  coding.
- **Testing framework (ch. 20).** The chapter teaches `testthat`,
  which is the framework a reader is most likely to meet elsewhere,
  but this conflicts with the house standard of `tinytest` used in
  `zzcollab`-scaffolded projects. A callout now reconciles the two
  and gives the small substitutions needed to transfer the
  chapter's material to `tinytest`.

## 7. Peer-course comparison

Five parallel searches examined roughly two dozen graduate courses
and training curricula across US, UK, European, and Australian
institutions, together with The Carpentries and the canonical
reproducible-research literature. The comparison set included Johns
Hopkins Biostatistics 140.776, Harvard BST 260, Columbia P8160,
UNC BIOS 735, UW BIOST 561, Berkeley Statistics 243, Michigan
Biostat 615/625, Minnesota PubH 7460, Vanderbilt's R Workflow
(Harrell), Stanford BIODS 253, LSHTM, Imperial, ETH Zurich, Oxford,
Monash ETC5513, Karl Broman's Tools for Reproducible Research, and
the Johns Hopkins Data Science specialization.

The conclusion is favourable. The book's treatment of Git, `renv`,
Docker, research compendia, Quarto, and the tidyverse is
well-aligned with the peer set, and in its containerization and
CDISC/ADaM coverage it leads. The peer courses that dominate the
statistical-computing space, Berkeley 243, ETH Computational
Statistics, Columbia P8160, devote most of their time to numerical
optimization, simulation, bootstrap, and Bayesian computing, which
this book deliberately assigns to its companion volume. That
exclusion is defensible but should be stated explicitly in the
preface, so that a reader comparing the two does not perceive an
unexplained gap.

## 8. Reference audit

The bibliography was missing several works that nearly every peer
reproducibility course assigns. Fourteen entries were added and the
most important were cited in text: Peng (2011), Sandve et al.
(2013), Wilson et al. (2017), and Gentleman and Temple Lang (2007)
in the opening chapter, the FAIR principles (Wilkinson et al.
2016), van Buuren (2018) in the missing-data chapter, Wilke (2019)
in the graphics chapter, and Grolemund and Wickham (2011) in the
types chapter. The remaining additions, Harrell's *R Workflow*,
Broman's *Tools for Reproducible Research*, Morris, White and
Crowther (2019) on simulation studies, Bengtsson (2021) on futures,
Kurtzer et al. (2017) on Singularity, and the `targets` manual,
support the new topics recommended in section 9 and are ready to be
cited as that material is written.

## 9. Recommended new topics

The peer comparison identified a short list of practical topics
that sit squarely in the book's remit, are taught at multiple peer
institutions, and are currently absent. The author has asked that
these be added as material rather than merely noted. They are
listed here in priority order, with the intended home for each. The
prose for these sections remains to be written; this review
establishes the plan and has seeded the bibliography.

1. **Databases and SQL (highest peer frequency, seven courses).**
   A new chapter, or a major section of the wrangling part, on
   `DBI` and `dbplyr`: querying a clinical data warehouse or REDCap
   back-end at the source rather than exporting flat files.
   Biostatistics students meet this on their first project.
2. **The Unix shell (five-plus courses).** A short chapter on the
   command line as the substrate under Docker, Git, and HPC job
   submission, which the book currently assumes rather than teaches.
3. **Pipeline tooling with `targets` (a reproducibility-specific
   gap).** The dependency-aware build tool that makes a compendium
   re-runnable end to end. This is the natural capstone to the
   existing infrastructure chapters.
4. **Continuous integration with GitHub Actions.** Running the
   book's existing tests and `renv` checks automatically on every
   push. Few peers teach this, so it would differentiate the book
   rather than merely bring it to parity.
5. **HIPAA de-identification and data ethics (biostat-critical).**
   The Safe Harbor eighteen-identifier rule and basic
   disclosure-control practice. Conspicuously absent given the
   clinical-data focus, and explicitly taught at Broman and Johns
   Hopkins. This belongs in or beside the federal-requirements
   chapter.
6. **Regular expressions and dates (daily tools).** Chapter 14
   already covers `stringr` and `lubridate`; the recommendation is
   to strengthen it with a runnable, bilingual example and to frame
   the material against clinical free-text and interval arithmetic.

A parenthetical scope note in the preface should also record that
simulation design, bootstrap, optimization, and Bayesian computing
are treated in the companion volume, so their absence reads as
deliberate.

## 10. Residual items and caveats

- **PDF Mermaid diagrams.** The diagrams are constrained to the
  column width in HTML and verified there. A full PDF build with
  `xelatex` was not run in this pass; the author should render the
  PDF once and confirm that the wider flowcharts (the
  multiple-imputation fan, in particular) fit the narrower PDF text
  block.
- **ADNI figures.** The ADNI trajectory figure remains display-only
  because the real ADNIMERGE data are under a data-use agreement and
  are not present in the build environment. The simulated trajectory
  in the graphics chapter serves as the rendered illustration; the
  new cohort-derivation diagram in the ADNI chapter needs no data.
- **A pre-existing cross-reference warning.** Chapter 12 emits an
  unresolved-cross-reference warning for `@fig-demographics`, which
  appears inside a code example demonstrating cross-reference
  syntax. It is harmless and was left untouched to preserve the
  example's fidelity.

---
*Prepared as part of a deep editorial review. The concrete edits
described above are in the working tree and were verified to render;
they have not been committed.*
