# Refactoring Plan: Biostatistics Practicum
*2026-09-07 14:05 PDT*

## Purpose and method

This document proposes a refactoring of *Biostatistics Practicum*
against the evidence base assembled for the blog post 'What Makes an
Open Textbook Work' (`~/prj/ryyblog/posts/pub-open-textbook-guidebook/`).
The goal stated for the exercise was engagement and impact. Those are
not directly measurable from the manuscript, so this plan uses the
proxies that the literature actually supports: whether students can
practice with feedback, whether the book is navigable and assignable
in pieces, whether it is legally and practically adoptable by other
instructors, and whether it presents anything to look at.

The findings below rest on a mechanical scan of all 38 content files
in `analysis/report/` performed on 2026-09-07, not on a reading of the
prose. Counts are reproducible from the scripts noted in the appendix.
Where a number is an estimate rather than a count, it says so.

Two prior documents overlap with this one and are not superseded.
`DEEP-REVIEW.md` (2026-07-05) covered voice, disciplinary framing, and
peer comparison. `REVIEW-CHECKLIST.md` (2026-09-07) is the per-chapter
ownership review, currently open at chapter `00-intro`. This plan is
concerned with structure and adoptability, and deliberately says
nothing about prose quality, which the rgtvoice pass has already
addressed.

## Executive summary

The manuscript is in better condition than most open textbooks on the
criteria reviewers rate most often, and is in poor condition on three
criteria that the evidence says matter most for learning and adoption.

The book has roughly 180 exercises and no solutions to any of them. It
has 226 display-only code blocks against 48 executable ones, so the
large majority of its code cannot be verified by rendering and produces
no output. Thirty of its 38 chapters contain exactly one figure, and
that figure is a schematic diagram rather than a computed result. It
carries a GPL-3 license, which is a software license and will not be
accepted by the open-textbook catalogs through which adoption actually
happens. It has no glossary and no index, and no alt text anywhere.

None of these is a writing problem. All five are production decisions
that can be reversed in a defined amount of work, and the first three
account for most of the available gain.

## Part 1. Measured state

| Property | Measured | Target from evidence |
|---|---|---|
| Total words | 111,865 | n/a |
| Estimated pages (at 450 w/p) | ~248 | Downey: ~140 per semester course |
| Chapters and appendices | 38 | n/a |
| Median chapter length | ~6 pages | one sitting; acceptable as is |
| Chapters over 9 pages | 5 | split or justify |
| Exercises (approx.) | ~180 | n/a |
| Exercises with published solutions | 0 | OpenIntro: nearly all |
| Chapters with exactly 5 exercises | 30 of 38 | proportional to chapter weight |
| Executable `{r}` chunks | 48 | code that renders is code that is checked |
| Display-only fenced blocks | 226 | n/a |
| Computed figures (R-generated) | ~20, in 8 chapters | reviewers flag words-only texts |
| Chapters whose only figure is a mermaid diagram | 30 | n/a |
| Chapters with zero figures | 4 | zero |
| Files containing `fig-alt` | 0 of 46 | all informative figures |
| Glossary | absent | present |
| Index | absent | present |
| License | GPL-3 | CC BY |
| Output formats | HTML, PDF | plus print-on-demand |
| `freeze: auto` | set | correct as is |
| Bibliography entries | 99, recency good | correct as is |
| 'Check your understanding' sections | 1 per chapter | 1 per major section |

Two things in that table are worth stating plainly as strengths,
because they are unusual. The bibliography is current, with 25 entries
from 2024 and several from 2026, so the staleness signal that drives
de-adoption is absent. And the book already has a per-chapter
prerequisites quiz with published answers, which is a retrieval
practice structure most textbooks lack entirely. The refactoring
extends that structure rather than inventing one.

## Part 2. Findings, ranked by expected impact

### Finding 1. About 180 exercises, zero solutions

**Measured.** Every chapter except `00-intro`, `25-synthesis`, and the
three appendices carries an `## Exercises` section, almost always with
five numbered items. A search for solution or answer headings returns
only the per-chapter `Prerequisites answers` sections, which answer the
opening quiz and not the exercises.

**Why it ranks first.** Dunlosky and colleagues rate practice testing
as one of only two high-utility study techniques, and the mechanism
depends on feedback: a student who cannot check an answer is not doing
retrieval practice, only doing homework. OpenIntro ships more than 550
exercises with solutions to nearly all in-text exercises, placed in
footnotes on the explicit principle that the check should be immediate.
Reviewers in the Open Textbook Library corpus complain when solutions
are merely at the end of the chapter; this book does not have them at
all. For a self-studying reader, which an open book acquires in
quantity, an exercise without an answer is close to worthless.

**Complication specific to this book.** Roughly half the exercises
instruct the student to work on their own project or their own data,
which admits no answer key. That is a defensible design for a
practicum, but it cannot be the whole exercise set, because it means a
reader without an ongoing project cannot self-assess anywhere in the
book.

**Action.** Split the exercise set in two. Retain the open-ended
'apply to your own work' items, and mark them as such so the reader
knows no key exists. Add, to every chapter, three to five exercises
that operate on a dataset the book ships, and publish worked solutions
for those. Place solutions where OpenIntro places them, which is close
to the question, either in a collapsible callout immediately following
the exercise or in a per-chapter solutions section reached by anchor
link rather than by scrolling.

### Finding 2. 226 display-only code blocks against 48 executable

**Measured.** 226 fenced blocks marked as plain `r`, `bash`, or `sh`
against 48 executable `{r}` chunks, with only one chunk explicitly
marked `eval: false`. The display-only blocks are not chunks Quarto
declined to run; they are blocks that were never wired to run.

**Why it matters.** Two consequences follow, and the second is the
expensive one. First, none of that code is verified by rendering, so a
typo in a display-only block survives every build indefinitely, and
`freeze: auto` does not help because there is nothing to freeze.
Second, code that does not execute produces no output, which is the
direct upstream cause of Finding 3. A chapter on plotting that shows
plotting code without plots is the canonical reviewer complaint in this
literature.

**Realistic scope.** Much of this code genuinely cannot execute at
render: shell sessions, Docker builds, `git` interactions, cloud
provisioning, and SAS. That is a legitimate reason for a display block,
and those should stay display-only and be verified another way. The
target is the subset that could execute and simply is not: the
wrangling, types, joins, graphics, missing-data, CDISC, and case-study
chapters.

**Action.** Triage all 226 blocks into three categories. Executable and
should run, convert to `{r}` chunks. Not executable in principle,
mark explicitly and add a verification note saying how the command was
checked and when. Executable but expensive, run once and cache with
`freeze`. Do the conversion chapter by chapter, verifying the render
after each, since converting a block that errors will break the build.

### Finding 3. Thirty chapters whose only figure is a schematic

**Measured.** Only eight chapters contain any R-generated figure:
`11-quarto` (3), `12-rmd-workflow` (2), `13-wrangling` (1),
`16-graphics` (5), `17-missing` (2), `19-cdisc` (1), `23-penguins` (4),
and `25d-ethics` (2), for roughly 20 computed figures in total. Thirty
chapters contain exactly one figure, a mermaid diagram. Four files
contain none at all, including `25b-communicating`, which at about 11
estimated pages is among the longest in the book.

**Why it matters.** 'The textbook contains only words' is a verbatim
reviewer complaint from the Open Textbook Library corpus, offered with
the prediction that it costs student engagement. The mermaid diagrams
are genuinely useful and should stay; the point is that a schematic of
a workflow is not the same as seeing what the code produced.

**Relationship to `DEEP-REVIEW.md`.** That document identified this
exact defect in July 2026 and reported it addressed 'in the
highest-value chapters'. The measurement confirms the fix was real and
partial: the eight chapters with computed figures are presumably those
chapters. This plan proposes finishing the job.

**Action.** Set a floor of one computed figure or rendered table per
major technical section, not per chapter. Priority order is the
chapters where a visual is load-bearing and currently absent:
`25b-communicating` (zero figures in a chapter about communicating
results is the sharpest single instance), `14-types`, `15-joins`,
`15b-databases`, `12b-acquisition`, `24-adni`, `17-missing` beyond its
current two, and `20-testing`. This work is largely a byproduct of
Finding 2 and should be scheduled with it.

### Finding 4. GPL-3 license blocks catalog adoption

**Measured.** `LICENSE.md` and `DESCRIPTION` both declare GPL-3.

**Why it matters.** GPL-3 is a software license. Applied to prose it is
at best ambiguous about attribution and derivative works in the way a
teaching text needs, and more practically it is not a license that the
open-textbook catalogs accept. Those catalogs are how adoption happens:
faculty report discoverability as a barrier roughly half the time, and
the Open Textbook Library's review program is explicitly dual-purpose,
supplying both credibility and awareness. A book that cannot be listed
forgoes the main distribution channel available to it.

**Action.** Relicense the prose under CC BY, keeping GPL-3 or MIT for
the code in `R/` and the scripts, and state the split explicitly in
`LICENSE.md` and in the colophon. Avoid ND and NC variants, which are
widely held to disqualify a work as an open educational resource
because they forbid the revision and remix that define the category.
Confirm that every contributor consents before relicensing, since this
cannot be undone unilaterally later.

### Finding 5. No glossary, no index, no alt text

**Measured.** No glossary file or heading anywhere in the book. No
index. Zero of 46 files contain a `fig-alt` attribute.

**Why it matters.** 'There is no index, glossary or table of contents'
is, again, a verbatim reviewer complaint, and comprehensiveness in the
Open Textbook Library rubric explicitly asks for an effective index or
glossary. The book does have a navigable sidebar table of contents, so
this is two thirds of a known complaint rather than all of it. Alt text
is a WCAG requirement for informative images and an accessibility
criterion reviewers apply; at zero coverage the book currently fails it
outright.

**Action.** Three separable tasks. Add a glossary appendix collecting
the terms already bolded on first use across the chapters, which makes
this largely an extraction job rather than a writing job. Add a
back-of-book index for the PDF output. Add `fig-alt` to every figure,
which is roughly 50 short descriptions once Findings 2 and 3 have
increased the figure count.

### Finding 6. Exercise count is uniform, not proportional

**Measured.** Thirty of 38 chapters carry exactly five exercises,
irrespective of chapter weight. `10b-targets` at about 4 estimated
pages has five; `12b-acquisition` at about 11 has five.

**Why it matters.** This is the structural item flagged in
`REVIEW-CHECKLIST.md` Phase 1 as 'exercise placement and count
proportionate to the chapter's weight'. Uniformity of exactly five is
the signature of a template applied evenly rather than a judgment made
per chapter, and it means the longest and most demanding chapters are
the least practiced.

**Action.** Rebalance to roughly one exercise per major section, which
would put the short chapters near three and the long ones near eight.
Fold this into the Finding 1 work rather than doing it separately.

### Finding 7. Retrieval density is one check per six pages

**Measured.** Almost every chapter has exactly one 'Check your
understanding' section; `03-team-science` has two.

**Why it matters.** The existing structure is right and there is simply
not much of it. Given the reading-compliance evidence, that most
students do not read a chapter straight through, a single mid-chapter
check is easy to miss entirely.

**Action.** Target one short retrieval prompt per major section, with
the answer immediately available. This is cheap relative to its
evidential support and should be done alongside Finding 1.

### Finding 8. Length and modularity

**Measured.** About 248 estimated pages. Five chapters exceed nine
estimated pages: `12b-acquisition` and `25b-communicating` at about 11,
`05b-git-teams` and `25d-ethics` at about 10, `22-sas` at about 9.

**Why it matters.** Downey's target of roughly 140 pages for a
semester course is a guideline from one author rather than an empirical
result, and a practicum spanning Git through CDISC has a defensible
reason to be longer. I would not restructure the book to hit 140. The
per-chapter figure matters more, and at a median of about six pages the
book is already close to the one-sitting target. Modularity is the
weakest criterion across the Open Textbook Library corpus, at 62.5%
positive, and this book is better placed than most because every
chapter opens with a prerequisites quiz that states what it assumes.

**Action.** Split only the five long chapters, at natural seams, and
leave the total length alone. Make the modularity that already exists
explicit by stating in the preface that chapters are assignable
individually, since an instructor assigning three chapters of a free
book incurs no cost justification.

### Finding 9. Adoption mechanics are entirely unaddressed

**Measured.** The book renders to HTML and PDF and is hosted. There is
no evidence in the repository of a catalog listing, an ISBN, a
print-on-demand edition, or a list of adopting courses.

**Why it matters.** Perceived quality is mediated by colleague
recommendation, personal knowledge of the author, and peer review
rather than by intrinsic merit, and a commercial publisher's marketing
resources are, in OpenIntro's phrase, humbling. A book with no
distribution strategy is read by the author's own students and nobody
else. Separately, more than a quarter of students in one e-textbook
pilot believed they would have learned more from paper, and
print-on-demand is nearly free to offer.

**Action.** After the license change, list in the Open Textbook Library
and solicit reviews, which is simultaneously a credibility and an
awareness act. Produce a print-on-demand paperback from the existing
PDF. Publish a page of adopting courses as it accumulates.

## Part 3. Phased plan

Effort figures are estimates in working days for one person, offered
for sequencing rather than for scheduling, and they assume AI
assistance for the mechanical parts with human verification of every
result.

### Phase A. Adoptability unblock (about 2 days)

Small, self-contained, and a precondition for everything in Phase D.

1. Relicense prose to CC BY, keep code under GPL-3 or MIT, document
   the split in `LICENSE.md`, `DESCRIPTION`, and the colophon.
2. Fix the two open items from `REVIEW-CHECKLIST.md` on `00-intro`:
   the appendix count and the missing 'Sources' entry in the chapter
   pattern list.
3. Add a `fig-alt` to every figure that currently exists.

*Acceptance.* The license split is stated in three places; `00-intro`
describes three appendices; `grep -L fig-alt` returns no file that
contains a figure.

### Phase B. Practice with feedback (about 8 to 12 days)

The highest-value phase. Do it chapter by chapter in curriculum order.

1. Per chapter, classify existing exercises as open-ended or
   checkable, and label the open-ended ones explicitly.
2. Per chapter, add three to five checkable exercises built on a
   dataset the book already ships.
3. Write worked solutions for every checkable exercise and place them
   adjacent to the question, in a collapsible callout for HTML and a
   per-chapter solutions block for PDF.
4. Rebalance exercise counts to roughly one per major section.
5. Add a retrieval prompt per major section, with the answer
   immediately available.

*Acceptance.* Every chapter has at least three exercises with published
solutions; no chapter has exactly five exercises by coincidence of
template; a reader with no project of their own can self-assess in
every chapter.

### Phase C. Executable code and figures (about 10 to 15 days)

1. Triage all 226 display-only blocks into executable, not executable,
   and expensive.
2. Convert the executable subset to `{r}` chunks, one chapter at a
   time, rendering after each chapter.
3. For blocks that cannot execute, add a dated verification note
   stating how and when the command was checked.
4. Bring every major technical section to at least one computed figure
   or rendered table, prioritizing `25b-communicating`, `14-types`,
   `15-joins`, `15b-databases`, `12b-acquisition`, `24-adni`, and
   `20-testing`.
5. Add `fig-alt` to each new figure as it is created.

*Acceptance.* A full render completes clean; no chapter has zero
figures; the count of computed figures is at least one per major
technical section.

### Phase D. Reference apparatus and distribution (about 5 days)

1. Build the glossary appendix by extracting bolded first-use terms.
2. Add a PDF index.
3. Split the five long chapters at natural seams.
4. State the modular-assignment policy in the preface.
5. List in the Open Textbook Library and solicit reviews.
6. Produce a print-on-demand paperback.

*Acceptance.* Glossary and index present in both output formats; no
chapter over about nine estimated pages; catalog listing submitted.

## Part 4. What not to do

- Do not rewrite prose for voice. The rgtvoice pass is complete and
  `DEEP-REVIEW.md` found the register already consistent across all
  chapters. Further prose churn would consume the budget that Phase B
  needs.
- Do not restructure the book to reach 140 pages. The length is
  defensible for the scope, and the per-chapter length is already
  close to target.
- Do not delete the mermaid diagrams in favor of computed figures.
  They serve a different purpose and reviewers do not complain about
  schematics; they complain about their absence of everything else.
- Do not adopt an NC or ND license variant to retain commercial
  control. It would disqualify the book from the catalogs that Phase D
  depends on, and Downey's observation applies: as copyright holder
  you retain the ability to grant separate licenses later regardless
  of the public default.
- Do not add humor or decorative photographs to chase engagement. The
  seductive-details literature suggests entertaining tangents can
  reduce learning, and OpenIntro's stated practice is to pursue
  attention through interesting data and questions instead.

## Part 5. Sequencing

Phase A first, because it is short and unblocks Phase D. Phase B next,
because it carries the most evidential support per unit of work and is
independent of Phase C. Phase C next, and it will generate most of the
figures Finding 3 asks for as a byproduct. Phase D last, because
listing a book in a catalog before its exercises have solutions invites
the review one would least like to receive.

If only one phase is ever done, do Phase B.

## Part 6. Limitations of this analysis

This is a mechanical scan, not a reading. Word counts include code
blocks and YAML, so page estimates run high; the 450-words-per-page
divisor is conventional rather than measured against this book's
rendered output. Exercise counts come from counting numbered list items
under an `## Exercises` heading and will miss exercises formatted
differently. The figure counts distinguish mermaid diagrams from
R-generated figures by chunk syntax and would misclassify a figure
included by another route, though no markdown image includes were found
in any chapter.

I have not assessed cultural relevance, which is the second-weakest
criterion across the Open Textbook Library corpus at 66.6% positive and
which cannot be measured by grep. That requires a reading pass over the
examples, and it should be added to the per-chapter review in
`REVIEW-CHECKLIST.md` rather than guessed at here.

Nor have I verified that the proposed exercise solutions are feasible
for every chapter. Some topics, cloud provisioning and team Git among
them, may not admit a self-checkable exercise on a shipped dataset, and
those chapters may have to remain open-ended with the limitation
stated to the reader.

Finally, the effort estimates are estimates. No part of this plan has
been executed, and nothing in it has been tested against the actual
difficulty of converting the first display block or writing the first
solution set.

## Appendix. Reproducing the measurements

The two scan scripts used are in the session scratchpad:
`measure.sh` (per-chapter words, exercises, figures, chunks, retrieval
sections) and `measure2.sh` (chunk types, alt text, formats, license,
exercise style). They are read-only over `analysis/report/` and can be
rerun after each phase to confirm the acceptance criteria above.

---
*Rendered on 2026-09-07 at 14:04 PDT.*<br>
*Source: ~/prj/tch/02-practicum/REFACTOR-PLAN.md*
