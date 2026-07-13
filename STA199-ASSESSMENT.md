# Assessment of STA 199 (Duke, Fall 2025) for Inclusion in the Practicum
*2026-07-13 11:21 AEST*

## Purpose

This document assesses the material published at
<https://sta199-f25.github.io/> (STA 199, 'Introduction to Data
Science and Statistical Thinking', Duke University, Fall 2025,
Çetinkaya-Rundel and Knox) for potential incorporation into
*Biostatistics Practicum*, and proposes a concrete plan of work.

## Epistemic status

The judgements below rest on the following evidence, and the reader
should weight them accordingly.

- **Inspected.** The full Practicum source (40 `.qmd` files, 16,755
  lines) was read in this session. Claims about what the Practicum
  does and does not cover are verified against the source.
- **Inspected, indirectly.** The STA 199 site was read through a
  fetch-and-summarise tool, page by page: the syllabus, the schedule
  (the site index), the project description and all six milestones,
  the computing-access page, and the slide decks for ethics, web
  scraping, and communication. The full link inventory was extracted
  from the site index, so the topic list is complete.
- **Not inspected.** The labs, homeworks, and application exercises
  were not read individually, only enumerated. The slide decks were
  read through a summariser rather than in full, and in two cases the
  summariser reported the page to be thinner than its title promised
  (see 'Caveats' below).
- **Unverified.** No licence statement was found on the STA 199
  syllabus or index pages. The licensing question in the 'Risks'
  section is therefore open, not settled.

## Verdict in one paragraph

STA 199 is an undergraduate introduction to data science; the
Practicum is a graduate practicum in biostatistical craft. The
majority of the STA 199 syllabus is either already covered by the
Practicum at a higher level (visualisation, transformation, tidying,
joining, types, Quarto, Git basics) or deliberately excluded from it
(linear models, logistic regression, model selection, bootstrap
inference), the latter belonging to the companion volume. Direct
transplantation is therefore inappropriate for most of the course.
However, STA 199 exposes four genuine gaps in the Practicum, one of
which is serious: the Practicum teaches Git for a solo developer and
team science as a social practice, but never teaches the mechanics of
collaborating on a repository. It also has no treatment of data
acquisition (files, APIs, scraping), no ethics beyond regulatory
compliance, and no chapter on communicating a finished analysis. Four
new or extended chapters are proposed below, none of which should be
copied from STA 199; the course is useful as evidence that the gaps
exist and as a source of examples, not as a source of text.

## Standing constraint: no STA 199 datasets

**No dataset used in STA 199 is to be used in the Practicum.** This
is a firm constraint on everything proposed below, not a preference.

The reason is that the STA 199 datasets are uniformly small, tidy,
public, and non-clinical, and most arrive as a pre-cleaned course CSV
(income inequality, Bechdel, sales taxes, Durham climate, Hollywood
age gaps, Madison ice cover, Chicago taxis, NC counties, inflation,
Card and Krueger, Duke Lemur Center; plus `openintro::email`,
`openintro::duke_forest`, and `usdata` county data). That is the right
choice for a first course in data science and precisely the wrong one
for this book, whose central claim is that real biomedical data arrive
wide, irregular, and inconsistently coded. A pre-cleaned CSV cannot
demonstrate the cleaning discipline of @sec-wrangling, and a dataset
with no patients cannot demonstrate anything in @sec-deident.

Where a new chapter needs data, use one of the sources the book has
already established: `palmerpenguins` (already used, and the only
overlap with STA 199, which is incidental and predates it), a
synthetic clinical dataset fabricated in the chapter as @sec-cdisc and
@sec-deident already do, or ADNI under its data-use agreement. The
acquisition chapter's API example is to use a synthetic REDCap-shaped
payload committed to the repository, for this reason and also so that
the chapter renders in CI without a network call.

## What STA 199 contains

The course spans 26 lectures, six labs, six homeworks, fifteen
application exercises, three exams, and a six-milestone team project.
The topic sequence, taken from the site index:

| Block | Lectures |
|---|---|
| Toolkit | Hello world; meet the toolkit (R, RStudio, Quarto, Git) |
| Visualisation | Grammar of graphics; EDA I and II |
| Transformation | Grammar of data transformation; tidying; joining |
| Data acquisition | Data types and classes; importing and recoding; web scraping (single page); web scraping (many pages) |
| Ethics | Data science ethics |
| Modelling | Language of models; linear model (single, then multiple predictors); model selection and overfitting; logistic regression; spending your data; model evaluation |
| Communication | Developing and communicating data science |
| Inference | Quantifying uncertainty; making decisions; looking further |

The project runs the semester: collaborative Git practice, proposal,
progress check, structured peer review of two other teams, second
progress check, then a reproducible written report and a presentation.
The computing environment is a browser-hosted RStudio container
provisioned centrally by the university, with a GitHub organisation
for submission.

## Coverage map against the Practicum

| STA 199 topic | Practicum status | Verdict |
|---|---|---|
| R, RStudio, Quarto, Git toolkit | @sec-workstation, @sec-quarto, @sec-git-solo | Covered, more deeply. Decline. |
| Grammar of graphics, EDA | @sec-graphics | Covered. Decline. |
| Grammar of transformation, tidying | @sec-wrangling | Covered. Decline. |
| Joining | @sec-joins | Covered, and better (cardinality assertions, anti-join audits). Decline. |
| Data types and classes | @sec-types | Covered. Decline. |
| Importing and recoding data | Absent. The Practicum reads CSVs without ever teaching the read | **Gap. Adopt.** |
| Web scraping, single and many pages | Absent | **Gap. Adopt.** |
| Data science ethics (misrepresentation, privacy, bias) | @sec-deident covers HIPAA and disclosure control only | **Partial gap. Extend.** |
| Linear and logistic models, model selection, evaluation | Excluded by design (companion volume) | Decline. |
| Spending your data (train/test) | Touched only in @sec-adni (participant-level CV) | Decline as a chapter; see note below. |
| Quantifying uncertainty, bootstrap, decisions | Excluded by design | Decline. |
| Developing and communicating data science | @sec-team-science covers register and effect-size language, not narrative, slides, or the artefact | **Partial gap. Extend.** |
| Collaborative Git (project milestone 1) | @sec-git-solo is explicitly solo; @sec-team-science is explicitly social | **Serious gap. Adopt.** |
| Structured peer review (milestone 4) | Mentioned nowhere as a practice the student performs | **Gap. Adopt, as an exercise pattern.** |
| Quarto website as project artefact | @sec-quarto covers documents and books, not sites | Minor gap. Fold in. |
| Code style and code smells | Absent | Minor gap. Fold in. |
| Containerised RStudio | @sec-docker is stronger | Decline. |
| Wooclap, Gradescope, exam structure | Course infrastructure | Not applicable. |

## Proposed additions

Four substantive items, ranked by the size of the hole they fill, plus
three minor ones. Chapter numbering follows the existing `NNb`
convention for insertions so that no anchors renumber.

### 1. New chapter: `05b-git-teams.qmd`, 'Git for Teams'

**Why.** This is the Practicum's clearest structural gap. Chapter 5 is
titled 'Git and GitHub for Solo Developers' and defers team workflows
to the companion volume; chapter 3 teaches the social norms of
collaboration (authorship, scope, intake) but no mechanics. A graduate
biostatistician who has read the book cannot resolve a merge conflict,
open a pull request, or review a colleague's code. The gap is not
theoretical: the Practicum's own case studies (@sec-penguins,
@sec-adni) presuppose a compendium passed between team members, and
@sec-ci depends on pull-request triggers that the reader has never
been shown.

**Content.** Remotes and the fetch/merge/rebase distinction; branch
protection on `main`; feature branches and pull requests; code review
as a practice, with what a statistician should look for in a
colleague's analysis diff (join cardinality, seeds, hardcoded
thresholds); merge conflicts, including the conflict markers and how
to reconcile two intentional analytic changes rather than picking a
side; the specific pain of conflicts in rendered artefacts and
`renv.lock`, and the `.gitattributes` and gitignore discipline that
avoids them; `git blame` and `git bisect` as debugging tools on a
shared history.

**What STA 199 offers.** The merge-conflict pre-read, and the
observation that a first collaborative exercise should be a deliberate
conflict manufactured on purpose. That exercise pattern is worth
borrowing. The pre-read itself is thin (conflict markers only, no
commands, no branches, no pull requests) and is not a drafting source.

**Effort.** One chapter, roughly 550 lines, matching the house
structure (quiz, objectives, orientation, statistician's contribution,
technical sections, worked example, LLM callout, principle in use,
exercises, further reading, quiz answers).

### 2. New chapter: `12b-acquisition.qmd', 'Getting Data In: Files, APIs, and Scraping'

**Why.** The Practicum's data chapters begin with a data frame already
in memory. `readr`, `readxl`, and `haven` appear only incidentally
(the last only inside the SAS chapter); there is no treatment of file
encodings, delimiters, column-type specification, or the failure modes
of a CRF export. There is no treatment at all of the two ways a
biostatistician actually obtains data in 2026 that are not a file: a
REST API (REDCap, ClinicalTrials.gov, PubMed, the FDA openFDA
endpoints) and, occasionally, a scrape.

**Content.** Reading files with explicit column specifications, and
why `col_types` is a data-integrity assertion rather than a
convenience; encodings, byte-order marks, and the shell triage already
taught in @sec-shell; Excel serial dates, cross-referencing the
existing pitfall in @sec-types; REDCap and `httr2` against a token-
authenticated API, with the token in `.Renviron` and never in the
repository; JSON to tibble; pagination and rate limiting; scraping with
`rvest` and CSS selectors, framed as the last resort rather than the
first; `robots.txt`, terms of service, and the 'can you / should you'
distinction; and, most importantly for this book, the discipline of
caching the acquired data to a dated, immutable raw file so that the
analysis does not re-hit the network on every render. That last habit
is the raw-data rule of @sec-wrangling applied to acquisition, and it
is the reason this chapter belongs in the Practicum rather than in the
companion.

**What STA 199 offers.** The `rvest` and SelectorGadget mechanics, and
the sound instruction to save scraped interim data as RDS rather than
re-scrape at render time. Its API coverage is a single sentence and
its scraping ethics are deferred to the ethics lecture, so both must
be written fresh.

**Effort.** One chapter, roughly 600 lines. Requires a live example;
propose a synthetic REDCap-shaped JSON payload committed to the repo,
so that the chapter renders in CI without a network call.

### 3. Extend `02b-deidentification.qmd`, or add `02c-ethics.qmd`

**Why.** The Practicum's ethics is entirely regulatory. It teaches
what HIPAA requires (Safe Harbor, Expert Determination), what NIH
requires (DMSP), and what the FDA requires (CDISC). It does not teach
what none of them require: that an analyst can comply fully and still
mislead. The three canonical failures are absent, and all three are
biostatistical rather than generic: presenting an association as a
cause, presenting overlapping confidence intervals as a difference,
and choosing an encoding that exaggerates an effect.

**Content.** Aggregation harm, where individually public data become
harmful in combination (the OkCupid release is the standard case and
transfers directly to the quasi-identifier argument already made in
@sec-deident); causal overclaiming, with the media-coverage-of-an-
observational-study case; visual misrepresentation, with truncated
axes, area-versus-population encodings, and dual axes; and the
overlapping-interval fallacy, which is the version of the problem a
biostatistician is most likely to commit personally.

**Placement decision.** Recommend a new short chapter `02c-ethics.qmd`
rather than an extension of `02b`, on the grounds that de-identification
is a technical procedure and this is a chapter about judgement, and
mixing them would blur a distinction the book otherwise maintains
carefully. Cross-reference @sec-graphics for the encoding material and
add a reciprocal pointer there.

**What STA 199 offers.** The case studies, which are well chosen. The
'can you / should you' framing. Note that the cases are drawn from
public reporting and can be cited rather than copied.

**Effort.** One short chapter, roughly 350 lines.

### 4. Extend `03-team-science.qmd` and `16-graphics.qmd`; new chapter
`25b-communicating.qmd`, 'Communicating a Finished Analysis'

**Why.** The Practicum tells the reader to lead with effect size and to
prefer plots to tables, and then stops. It never addresses the artefact
the reader will actually be judged on: the twenty-minute talk to a
clinical audience, the one-page memo to a PI, the reviewer response
letter. This is a real professional skill and the book's silence on it
is conspicuous given that it devotes a chapter to SAS on the grounds
of employability.

**Content.** The narrative arc, and why chronology of the analysis is
the wrong order for presenting it; the 'and / but / therefore' skeleton
as an antidote to the methods-first habit; null results as results, and
how to present a study that found nothing without either apologising or
overclaiming; the talk versus the paper versus the memo, and what
changes between them; the reviewer response letter as a genre; and
structured peer review, both giving and receiving, as the practice that
trains the judgement.

**What STA 199 offers.** The narrative-arc framing, the null-results
point, and the peer-review milestone. All three are sound and all three
need rewriting for a graduate clinical audience.

**Effort.** One chapter, roughly 450 lines, placed immediately before
the synthesis chapter.

### Minor additions

- **Quarto websites** (@sec-quarto, one section, roughly 40 lines). The
  `format: html` project site as a deliverable, alongside the book and
  paper formats already covered. Motivated by the internal analysis
  portal, not by the student project.
- **Code style and code smells** (new section in @sec-ai-coding, or an
  appendix, roughly 60 lines). The tidyverse style guide, `styler`, and
  `lintr`. This is a natural fit next to the AI-assisted-coding chapter,
  because a reviewable diff is the precondition for auditing generated
  code, and it connects to the code-review section of the proposed Git
  for Teams chapter.
- **Peer review as an exercise pattern** (throughout). STA 199 makes a
  student review two other teams' work. The Practicum's exercises are
  uniformly solitary. Adding a review-a-colleague's-artefact exercise to
  the chapters where it makes sense (@sec-why already has one, and
  @sec-joins, @sec-testing, and the new communication chapter should)
  would cost little and would exercise the judgement the book claims to
  teach.

## What to decline, and why

- **All modelling and inference content** (lectures 15 through 25). The
  Practicum states in @sec-intro that models and inference are the
  companion volume's territory and treats their absence as deliberate.
  Importing linear regression, logistic regression, model selection,
  the bootstrap, or hypothesis testing would violate the book's stated
  scope and duplicate the companion. The one adjacent item worth a
  second look is 'spending your data': the train/test/validate split is
  arguably workflow rather than method, and @sec-adni already asserts
  participant-level cross-validation without having taught data
  splitting anywhere. Recommend a cross-reference to the companion
  rather than a chapter.
- **The tidyverse basics** (lectures 3 through 8). Chapters 13 through
  16 cover the same ground at a graduate level and with clinical data.
  There is nothing to import.
- **The containerised RStudio environment.** @sec-docker teaches the
  reader to build the container; STA 199 hands the student one. The
  Practicum's treatment is the more demanding and the correct one for
  its audience.
- **Course infrastructure** (Wooclap, Gradescope, exam structure, the
  team-contribution survey). Not book content, though the contribution
  survey is a reasonable device for an instructor teaching from the
  book and could be mentioned in an instructor's note if one is ever
  written.

## Risks and caveats

- **Licensing is unresolved.** No licence statement was found on the
  pages inspected. The Practicum is CC BY-NC-ND. If STA 199 is licensed
  under a share-alike term, as course materials from this author
  commonly are, then copying prose or figures would create an
  incompatibility, and the ND term on the Practicum complicates
  matters further in the other direction. **This must be checked before
  any text or figure is reused.** The plan above is deliberately
  structured so that no reuse is necessary: every item is a
  write-from-scratch chapter for which STA 199 is evidence of a gap and
  a source of citable examples, not a drafting source. Cases such as the
  OkCupid release are matters of public record and can be cited to their
  primary reporting.
- **Audience mismatch is the standing risk.** STA 199 is a first course
  for undergraduates with no statistics background; the Practicum
  assumes an MS-level statistician with working R fluency. Every item
  adopted must be rewritten upward. The specific failure mode to guard
  against is tone: the Practicum's register is austere and the STA 199
  material is, appropriately for its audience, not.
- **Chapter-count creep.** The book is already 40 files and its own
  introduction concedes it is dense. The four proposed chapters take it
  to 44 and add roughly 2,000 lines, an increase of about 12 per cent.
  This is defensible only because each fills a gap rather than deepening
  existing coverage. Resist the temptation to add anything further from
  this source.
- **Two STA 199 pages were thinner than their titles.** The summariser
  reported that 'Web scraping many pages' does not in fact cover
  iteration, `purrr`, rate limiting, or `robots.txt`, and that the
  collaborative-Git pre-read covers conflict markers but not commands,
  branches, or pull requests. If those pages are load-bearing for any
  decision, they should be read directly rather than trusted through the
  summary. They are not load-bearing for the plan above, which treats
  both topics as write-from-scratch.

## Implementation sequence

Ordered by value delivered per unit of work, and arranged so that each
chapter's cross-references point only backwards to work already done.

1. **`05b-git-teams.qmd`.** Largest gap, no dependencies, and unblocks
   the pull-request material that @sec-ci currently assumes. Add to
   `_quarto.yml` under 'Data Science Workstation', after `05-git-solo`.
2. **`12b-acquisition.qmd`.** Second-largest gap. Add under 'Data
   Wrangling and Graphics' as the first chapter of the part, before
   `13-wrangling`, since acquisition precedes wrangling. Requires the
   synthetic API payload fixture; budget time for that.
3. **`02c-ethics.qmd`.** Short, self-contained. Add under
   'Reproducibility Mindset' after `02b-deidentification`. Add the
   reciprocal cross-reference in @sec-graphics at the same time, along
   with the deceptive-encoding section proposed for that chapter.
4. **`25b-communicating.qmd`.** Add under 'Case Studies and Synthesis',
   before `25-synthesis`, so that the synthesis chapter can close on it.
5. **Minor items.** Quarto websites, code style, and the peer-review
   exercises, folded into existing chapters in a single editing pass.

Each new chapter must carry the house structure (opening quiz with
answers at the end, learning objectives, orientation, a 'statistician's
contribution' section, technical sections, a worked example, a
'Collaborating with an LLM' callout with a verification step, 'Principle
in use', exercises, further reading) and must pass the existing render
in CI. The quiz-answer anchors follow the established `sec-quiz-answers-
NNb` pattern.

## Open questions for the author

1. Is 'spending your data' workflow or method? The plan above declines
   it as method, but @sec-adni asserts participant-level splitting
   without teaching splitting, which is a small internal inconsistency
   that either a cross-reference or a short section would resolve.
2. Should the Practicum acquire an instructor's note? Several STA 199
   devices (the paired starter/solution application exercises, the
   published answer keys, the contribution survey, the deliberate
   merge-conflict exercise) are pedagogical infrastructure rather than
   book content, and there is currently nowhere in the book to put them.
3. Does the collaborative-Git material belong here at all, or in the
   companion volume, which @sec-git-solo says covers 'Git's mechanics in
   team contexts'? The recommendation above is that it belongs here,
   because the Practicum is the volume about workflow and because its own
   later chapters depend on it. If the companion already has it, the
   correct action is a cross-reference and a scope note, not a chapter.
