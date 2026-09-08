# Refactoring Plan: Biostatistics Practicum
*2026-09-07 14:05 PDT, revised 2026-09-07 17:40 PDT*

## Revision note

The first draft of this plan (14:05 PDT) contained three measurement
errors, all corrected below and marked **[corrected 17:40 PDT]** at the
point of correction. In summary: the license situation is materially
worse than reported and is a four-way conflict rather than a single
GPL-3 declaration; `11-quarto` has no computed figures rather than
three; and the per-chapter answer sections, credited as a strength in
the first draft, are placed at the maximum possible distance from the
questions they answer, which is itself a named reviewer complaint. Two
defects the first draft missed entirely have been added: the PDF ships
with no table of contents, and the book contains no embedded media of
any kind. Counts that changed on re-measurement are noted in Part 1.

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

The book has 173 exercises and no solutions to any of them, and
the answer sections it does have sit at the far end of the chapter from
the questions. It has 258 display-only code blocks against 48
executable ones, so the large majority of its code cannot be verified
by rendering and produces no output. Twenty-nine of its 38 chapters
contain exactly one figure, and that figure is a schematic diagram
rather than a computed result: of 170 sections that show code, about 20
show what the code produced. Its reader-facing license is CC
BY-NC-ND, which disqualifies it as an open educational resource
outright, and three other files disagree with that declaration. It has
no glossary, no index, no table of contents in the PDF, no embedded
media of any kind, and no alt text anywhere.

None of these is a writing problem. All are production decisions that
can be reversed in a defined amount of work, and the first three
account for most of the available gain.

## Part 1. Measured state

*Baseline is the 2026-09-07 scan; 'Now' is 2026-09-08, after
Phases A to D. Rows without a 'Now' value are unchanged.*

| Property | Baseline | Now | Target from evidence |
|---|---|---|---|
| Total words | 111,865 | ~120,000 | n/a |
| Pages | ~248 (estimated, wrong) | **712** (rendered) | Downey: ~140 per semester course |
| Chapters and appendices | 38 | 39 (glossary added) | n/a |
| Median chapter, rendered | n/a | **18 pages** | one sitting |
| Chapters over 25 pages | n/a | 4 | split or justify |
| Exercises | 173 in 34 files | 176 in 34 files | n/a |
| Chapters publishing solutions | 0 | **14**, 48 chunks | OpenIntro: nearly all |
| Chapters labeling open-ended sets | 0 | **20** | state why no key exists |
| Executable `{r}` chunks | 48, in 11 files | **166** | code that renders is code that is checked |
| Top-level ```` ```r ```` display blocks | 128 | **60** | mostly correct as display |
| Technical figures (code-generated) | ~20 | 27 | 1 per code-bearing section |
| Portraits placed (policy allows 4 to 5) | 0 | | 5, per the April policy |
| `credits.qmd` rows complete | 0 of 5, plus cover TODO | | all |
| Other ambient imagery | 0 | | 0, per the April policy |
| Technical sections | 374 | | n/a |
| Of those, code-bearing | 170 | | each yields a rendered artifact |
| Of those, prose only | 204 | | exempt from the figure floor |
| Files whose only figure is a mermaid diagram | 29 | | n/a |
| Content files with zero figures | 5 | | zero |
| `fig-alt` coverage | 0 of 46 files | **all rendering figures** | all informative figures |
| Figure labels inside display fences | 5, in `11-quarto`, `12-rmd-workflow`, `23-penguins` | | render nothing; see Finding 2 |
| Files containing `fig-cap` | 34 of 46 | | n/a |
| Embedded video, iframe, or media | 0 | | distributed through chapters |
| Glossary | absent | **appendix F, ~75 terms** | present |
| Index | absent | absent (see Phase D) | present |
| HTML table of contents | docked sidebar, search, breadcrumbs | | correct as is |
| PDF table of contents | absent (`toc: false`) | **present, verified** | present |
| Quiz-to-answer link | present in all 34 | unchanged | adjacent |
| License, reader-facing | CC BY-NC-ND 4.0 | **CC BY 4.0** | CC BY |
| License, code | MIT / CC0 / GPL-3, disagreeing | **MIT printed, GPL-3 package** | code only |
| Body-text contrast | ~16:1; teal accent ~5.0:1 | | at or above 4.5:1 |
| Heading hierarchy | clean, no level skips | | correct as is |
| Output formats | HTML, PDF (6.5 x 9in trim) | | plus print-on-demand |
| `freeze: auto` | set | | correct as is |
| Bibliography entries | 99; 34 from 2024 or later | | correct as is |
| 'Check your understanding' sections | 1 per chapter (2 in `03`) | | 1 per major section |

Several things in that table are worth stating plainly as strengths,
because they are unusual. The bibliography is current, with 25 entries
from 2024, 4 from 2025 and 5 from 2026, and only 7 entries predating
2008, so the staleness signal that drives de-adoption is absent. The
HTML navigation is complete and would draw no reviewer complaint:
docked sidebar, full-text search, breadcrumbs, page navigation, and
anchor sections. Every chapter opens with `Sources`, `Prerequisites`
and `Learning objectives`, which is a real answer to modularity, the
weakest criterion in the reviewer corpus. Contrast and heading
hierarchy pass their accessibility checks. And the book already has a
per-chapter prerequisites quiz with published answers, which is a
retrieval practice structure most textbooks lack entirely.

**[corrected 17:40 PDT]** The first draft credited that quiz structure
without auditing where its answers sit. They sit at the last heading of
every chapter. In `13-wrangling.qmd` the quiz is at line 25 and
`Prerequisites answers` at line 692. The structure is therefore right
and its placement is the specific defect the reviewer corpus names,
namely solutions that require scrolling to the end of the chapter. The
refactoring extends the structure and must also move it.

## Part 2. Findings, ranked by expected impact

### Finding 1. 173 exercises, zero solutions, and the answers that do exist are as far from their questions as the file allows

**Measured.** Thirty-four files carry an `## Exercises` section, with
173 numbered items among them, 27 of those files having exactly five. A
search for solution or answer headings returns only the per-chapter
`Prerequisites answers` sections, which answer the opening quiz and not
the exercises.

**[corrected 17:40 PDT, and partly retracted 18:05 PDT]** Those answer
sections are the last heading in every chapter that has one, and the
17:40 revision called that placement 'maximally distant' and a direct
instance of the reviewer complaint about solutions requiring a scroll
to the chapter end.

That was overstated, and executing Phase A disproved it. All 34
chapters already carry an inline cross-reference from the quiz to its
answers: 'You can find the answers at the end of the chapter in
@sec-quiz-answers-NN.' In HTML that is one click. In PDF it renders as
a numbered section reference. The reviewer complaint is about books
where the reader must scroll to find the answer; here the reader
follows a link. The remaining defect is real but minor: the answer is
not adjacent, so the reader leaves the question to reach it.

The book therefore has one substantial defect here, not two. The
exercises have no answers at all. The quiz answers are correctly
written, correctly linked, and merely not adjacent, which is a
refinement rather than a fix. Phase A item 4 was satisfied before it
was written.

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

### Finding 2. 258 display-only code blocks against 48 executable

**Measured.** 258 fenced blocks across 27 files marked as plain `r`,
`bash`, `sh`, `sql`, `yaml`, `python`, or `sas`, against 48 executable
`{r}` chunks confined to 11 files. The first draft reported 226 for the
display-only count under a narrower regex; 258 is the figure to work
against. The display-only blocks are not chunks Quarto declined to run;
they are blocks that were never wired to run. The worst concentrations
are `22-sas` (25), `11-quarto` (22), `12-rmd-workflow` (19), and
`05b-git-teams` and `13-wrangling` (17 each).

**Why it matters.** Two consequences follow, and the second is the
expensive one. First, none of that code is verified by rendering, so a
typo in a display-only block survives every build indefinitely, and
`freeze: auto` does not help because there is nothing to freeze.
Second, code that does not execute produces no output, which is the
direct upstream cause of Finding 3. A chapter on plotting that shows
plotting code without plots is the canonical reviewer complaint in this
literature.

**Corrected triage, 19:10 PDT, and it shrinks the problem by more than
half.** The 258 figure counts every non-executable fence in the book,
and most of them are correctly non-executable. Parsed properly, with
nested fences handled:

| Fence | Count | Disposition |
|---|---|---|
| ```` ```r ```` | 128 | the only convertible pool |
| ```` ```bash ```` | 80 | stays: git, Docker, shell, cloud |
| ```` ```yaml ```` | 15 | stays: configuration examples |
| ```` ```sas ```` | 15 | stays: no SAS at render |
| ```` ```qmd ````, `Rmd`, `dockerfile`, `json` | 20 | stays: displayed source |

So 130 of the 258 must never convert. A further 18 ```` ```r ```` blocks
sit *inside* ` ````qmd ` examples and are displayed source too, which is
why a naive `grep -c '^```r$'` returns 146 rather than 128.

**Observed conversion rate, from two chapters actually done: 58%, not
the ~90% this plan assumed.** In `13-wrangling`, 9 of 17 converted; in
`14-types`, 9 of 14. The blocks that resist are a consistent set:
deliberate antipattern pairs marked `# bad` and `# good` where the bad
branch must not run, file I/O against paths the book does not ship,
and environment-dependent calls such as `Sys.setlocale` to a French
locale. These are not defects. A book teaching what not to do needs
code that does not run.

Applying 58% to the remaining 110 gives roughly **64 further
conversions**, for about 82 in total rather than the 118 implied
earlier. Re-measure rather than trusting that extrapolation; two
chapters is a thin base.

**Realistic scope.** Much of this code genuinely cannot execute at
render: shell sessions, Docker builds, `git` interactions, cloud
provisioning, and SAS. That is a legitimate reason for a display block,
and those should stay display-only and be verified another way. The
target is the subset that could execute and simply is not: the
wrangling, types, joins, graphics, missing-data, CDISC, and case-study
chapters.

**Action.** Triage all 258 blocks into three categories. Executable and
should run, convert to `{r}` chunks. Not executable in principle,
mark explicitly and add a verification note saying how the command was
checked and when. Executable but expensive, run once and cache with
`freeze`. Do the conversion chapter by chapter, verifying the render
after each, since converting a block that errors will break the build.

### Finding 3. Twenty-nine chapters whose only figure is a schematic, five files with nothing at all, and no separation of technical from ambient imagery

**Measured. [corrected 17:40 PDT]** Eleven files contain executable
`{r}` chunks: `02b-deidentification` (2), `12b-acquisition` (7),
`13-wrangling` (4), `14-types` (1), `15-joins` (2), `15b-databases`
(7), `16-graphics` (6), `17-missing` (2), `19-cdisc` (6),
`23-penguins` (8), and `25d-ethics` (3), for roughly 20 computed
figures in total. Twenty-nine files contain exactly one figure, a
mermaid diagram.

The first draft credited `11-quarto` with three R-generated figures and
`12-rmd-workflow` with two. Neither has any. `grep '^```{r'` returns
zero for both, and no `11-quarto_files` render directory exists. The
first draft also missed `02b-deidentification`, `15b-databases`, and
`14-types`, which do have chunks.

**A claimed live bug, retracted 19:10 PDT.** The 18:30 revision
reported that `23-penguins.qmd` line 470 contained broken
cross-references to `@fig-scatter` and `@tbl-coef`. It does not. Line
451 opens a ` ````qmd ` fence, so that entire passage is the displayed
*source* of an example manuscript, not live document content. The
render confirms it: the text appears escaped inside a code block and
Quarto emits no crossref warning for it. The claim came from reading a
`sed` window that did not extend far enough back to show the enclosing
fence.

**Two genuine broken cross-references were found by rendering, and are
fixed.** `25c-federal.qmd` pointed at `@sec-quiz-answers-02` and
`25d-ethics.qmd` at `@sec-quiz-answers-02c`; neither anchor exists, and
the correct targets were `-25c` and `-25d`. Quarto reported both as
`WARN: Unable to resolve crossref`. These were invisible to every grep
in this plan and surfaced the moment the book was built, which is the
argument for rendering as a verification step rather than a final one.

**The mechanism of that error, confirmed 18:05 PDT.** Both files do
contain `#| label: fig-` lines, five between them, which is what the
first draft counted. Every one of them sits inside a ````qmd or ```r
display fence, shown to the reader as an example of how to write a
figure chunk. They are illustrations of syntax, not figures. A scan
that greps for `fig-` labels without checking whether the enclosing
fence is executable will count them, and a chapter that teaches
figure-chunk syntax is exactly the chapter where it will do so. Count
figures by executable fence, never by label.

Five content files contain no figure of any kind, neither computed nor
schematic: `11-quarto`, `25b-communicating`, `C-alternative-wrangling`,
`D-peer-survey`, and `E-lab-software`.

`11-quarto` is arguably the sharpest instance in the book, sharper than
`25b-communicating`. It is a chapter about rendering, carrying 22
display-only blocks, that renders nothing. `25b-communicating` is the
close second: 4,999 words, the second-longest file in the book, fifteen
major sections, no figure, no table, and no code block of any kind.

**Also measured, and missed by the first draft.** The book contains no
embedded video, iframe, or media element anywhere. Distributed video is
the one addition students in the design studies asked for by name. This
is noted for completeness rather than proposed as work; producing video
is a far larger commitment than the rest of this plan and should be
decided separately.

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

**Action, revised 17:40 PDT. Two kinds of figure, two different targets.**

The first draft used 'figure' for one thing. It is two, and they are
governed by different evidence, so this revision separates them.

A **technical figure** is generated by code in the chapter: a plot, a
rendered table, a printed output block, a diagram of a structure the
chapter builds. It shows the reader what the code produced. An
**ambient image** is related to the topic but not produced by it: a
photograph, a portrait of a scientist, a generated metaphor figure.
It sets tone.

The evidence treats these oppositely. Technical figures answer the
'contains only words' complaint and are what reviewers mean when they
ask for figures. Ambient images fall under the coherence principle and
the seductive-details caution already recorded in Part 4, which say
that extraneous material placed inside an explanation can reduce
learning. Note that the blog post flags its Mayer and seductive-details
citations as unverified against primary sources, so that caution is
the weakest-evidenced claim in this plan and is treated here as a
reason for restraint rather than prohibition.

Accessibility marks the same divide from the other side. WCAG assigns a
decorative image a null `alt`, which is an instruction to screen reader
users to skip it. An image that genuinely needs a description is
carrying information and is a technical figure. So the two categories
are not a matter of taste; they differ in whether a subset of readers
is told to ignore them.

**Target 1, technical figures: one per code-bearing section.** Not one
per chapter, and not a fixed count per section. The rule is
conditional, because a uniform per-section floor would force invented
plots into the prose sections, and an invented plot is a seductive
detail with a `ggplot` theme.

Measured: of the 374 technical sections in the book (excluding the
eight boilerplate headings that appear in every chapter), 170 contain a
code fence of any kind and 204 are prose only. The conditional rule
therefore targets roughly 170 rendered artifacts against the current
~20, and exempts the 204 prose sections. The per-chapter distribution
is uneven and matches the subject matter, from `11-quarto` at 10 and
`16-graphics` at 9 down to `25b-communicating`, `D-peer-survey`, and
`E-lab-software` at zero.

`25b-communicating` is the case the rule handles badly and needs a
judgment call. It has ten technical sections and no code, so the
conditional rule exempts it entirely, which is the wrong answer for the
chapter with the sharpest visual deficit in the book. Treat it as an
exception: it should acquire three or four rendered artifacts, a memo,
a figure it discusses, a reviewer-response table, by having code added
rather than by being exempted.

Priority order for the technical work is the files where a visual is
load-bearing and currently absent: `11-quarto` (a chapter on rendering
that renders nothing, 10 code-bearing sections and no output),
`25b-communicating` (as an exception, above), `12-rmd-workflow` (7),
`20-testing` (8), `24-adni` (5), `C-alternative-wrangling` (4), and
`17-missing` beyond its current two. `14-types`, `15-joins`,
`15b-databases`, and `12b-acquisition` already have chunks and need
more output rather than a first figure. This work is largely a
byproduct of Finding 2 and should be scheduled with it.

**Target 2, ambient images: finish the policy that already exists.
[revised 18:20 PDT, during Phase A execution]** The book already has a
written image policy at `analysis/report/images/README.md`, dated
2026-04-23, which neither the 14:05 nor the 17:40 draft consulted. It
says 'content figures only inside chapters', that 'figures exist to
teach', and: 'Do not add decorative chapter-opener images,
AI-generated hero images, or part-divider art.' It permits 'portraits
of foundational figures: permitted sparingly (four to five across the
book)', requiring CC-BY or CC0 sourcing and a `credits.qmd` entry for
each, and it names the five: Jenny Bryan in `05-git-solo`, Ben Marwick
in `07-rrtools`, JJ Allaire in `11-quarto`, Yihui Xie in
`12-rmd-workflow`, Hadley Wickham in `13-wrangling`.

That policy reaches this plan's conclusion on generated imagery by the
same reasoning and is stricter on everything else. It governs. The
17:40 draft proposed an ambient image at each of the eight part
openers; that proposal has been dropped. It is forbidden by the policy
as part-divider art, and it does not survive the evidence on its own
terms either: a part opener is a book-level structure serving a reader
who moves through the book in order, and the reading-compliance
evidence says that reader is rare. What the corpus asks for is
modularity at section and chapter level, which this book already
supplies through per-chapter `Sources`, `Prerequisites`, and `Learning
objectives`. The orienting work a part opener would do is already done
once, by `fig-book-map` in `00-intro`.

**The ambient target is therefore the policy's own unfinished
business: five portraits, none of which exist.**
`images/portraits/` is empty, all five `credits.qmd` rows read TODO for
source and license, no chapter references a portrait, and the cover
image's attribution line is also TODO. This is not a budget to design.
It is a budget designed in April and never started.

*Action.* Source the five named portraits under CC-BY or CC0, place
each at the first substantive mention of its subject using the compact
right-aligned block the policy specifies, complete the five
`credits.qmd` rows with source URL and license, and complete the cover
attribution. Add no other ambient imagery.

The one thing the policy does not address is cultural relevance, which
at 66.6% positive is the second-weakest criterion in the reviewer
corpus and the one ambient use with affirmative support in the evidence
base, since the guidance asks for diversified names, contexts, and
photographs in examples. Five portraits of tool authors do not serve
it. Note this as an open question for the human reading pass rather
than resolving it here: the answer may lie in the examples and names
rather than in more images.

Generated metaphor figures are excluded for three reasons and not only
the seductive-details one. They have no provenance to record, and
`credits.qmd` requires attribution for material. They are the purest
instance of decoration the category admits. And a book containing both
`21-ai-coding` and `25d-ethics` will be read closely on precisely this
point, so illustrating it with unattributed generated imagery invites
the review one would least like to receive.

*Acceptance for both targets.* Every code-bearing section produces at
least one rendered artifact in the built book, verified by rendering
rather than by grep, with `25b-communicating` handled as the stated
exception; the five portraits named in the April image policy are
placed and fully attributed in `credits.qmd`, the cover attribution is
complete, and no other ambient imagery has been added.

### Finding 4. The reader-facing license is CC BY-NC-ND, and three other files disagree with it

**Measured. [corrected 17:40 PDT]** The first draft reported that
`LICENSE.md` and `DESCRIPTION` both declare GPL-3. That is wrong about
`LICENSE.md` and incomplete about the rest. Four files declare a
license, in two camps:

| File | Declares |
|---|---|
| `LICENSE.md` line 4 | CC BY-NC-ND 4.0 |
| `analysis/report/index.qmd`, License section | CC BY-NC-ND 4.0 |
| `DESCRIPTION` | GPL-3 |
| `CITATION.cff` | GPL-3 |

`index.qmd` is the landing page of the published book, so CC BY-NC-ND
is what a prospective adopter actually reads. It also states that code
samples are CC0, which is a third position and the only one of the four
that is defensible as written.

**Why it matters, and why this is worse than the first draft said.**
The first draft framed the problem as a software license misapplied to
prose, which is a category error with ambiguous consequences. The
actual problem is an active, published restriction on precisely the
reuse that defines the category. ND forbids derivative works, and
revision and remix are the affordances that make a work an open
educational resource at all, so CC BY-NC-ND does not merely fail to be
accepted by the catalogs, it fails to qualify as an OER. NC compounds
it by blocking the print-on-demand economics of Finding 9 and by
introducing the compatibility conflicts that make combining sources
hard. Note that this plan's own Part 4 instructs against adopting an NC
or ND variant, written in apparent ignorance that the book already
carries one.

The secondary problem is the disagreement itself. Four files, two
answers, and no statement anywhere of a prose-versus-code split. An
adopter who checks two of them learns that the authors do not know what
the license is.

**Action.** Unchanged in substance from the first draft, but now a
correction rather than a clarification. Relicense the prose under CC
BY, keep MIT or GPL-3 for the code in `R/` and the scripts, and state
the split in all four files plus the colophon so that they agree.
Confirm that every contributor consents before relicensing, since this
cannot be undone unilaterally later. Anyone who has relied on the
NC or ND terms to date should be identified before the change, though
in a repository with no catalog listing and no recorded adopters that
population is probably empty.

### Finding 5. No glossary, no index, no alt text, and no table of contents in the PDF

**Measured.** No glossary file or heading anywhere in the book. No
index. Zero of 46 files contain a `fig-alt` attribute, against 34 that
contain `fig-cap`.

**[corrected 17:40 PDT]** The first draft asserted that the book 'does
have a navigable sidebar table of contents, so this is two thirds of a
known complaint rather than all of it.' That is true of the HTML output
and false of the PDF. `_quarto.yml` sets `toc: false` under the `pdf`
format, and no `\tableofcontents` appears in any of the LaTeX includes.
The PDF is therefore a 712-page document (rendered and counted
2026-09-08) with no table of
contents, no index, and no glossary, which is the complete verbatim
complaint rather than two thirds of it, and it is the closest match in
the entire reviewer corpus to this book's actual condition: a long PDF
with 'little in the PDF that allows for quick and easy browsing without
intense scrolling'.

The HTML output is the opposite case and needs no work. It has a docked
sidebar, full-text search, breadcrumbs, page navigation, and anchor
sections. Body-text contrast is roughly 16:1 and the teal accent used
for links and code computes to about 5.0:1 against white, both above
the 4.5:1 threshold, and the heading hierarchy contains no level skips.

Alt text is a WCAG requirement for informative images and an
accessibility criterion reviewers apply; at zero coverage the book
fails it outright in both formats.

**Action.** Four separable tasks. Set `toc: true` for the PDF format
and verify the result renders sensibly under `scrbook`, which is a
one-line change and the cheapest item in this entire plan. Add a
glossary appendix collecting the terms already bolded on first use
across the chapters, which makes this largely an extraction job rather
than a writing job. Add a back-of-book index for the PDF output. Add
`fig-alt` to every figure, which is roughly 50 short descriptions once
Findings 2 and 3 have increased the figure count.

### Finding 6. Exercise count is uniform, not proportional

**Measured.** Twenty-seven of the 34 files with an `## Exercises`
section carry exactly five, irrespective of chapter weight.
`10b-targets` at 1,882 words has five; `12b-acquisition` at 5,249 words
has five. The six exceptions are `03-team-science`, `15-joins`,
`20-testing` and `25d-ethics` at six, `12-rmd-workflow` at seven,
`19-cdisc` at four, and `C-alternative-wrangling` at three.

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

**Measured from the rendered PDF, 2026-09-08.** 712 pages across 39
chapters and appendices. Median chapter **18 pages**, mean 17.8. The
distribution is tighter than the word counts suggested:

| Pages | Chapters |
|---|---|
| 26 to 28 | `13-wrangling`, `16-graphics`, `17-missing`, `22-sas` |
| 20 to 24 | 12 chapters |
| 14 to 18 | 15 chapters |
| 10 to 12 | 5 chapters |
| 4 to 8 | 3 appendices |

**This changes Finding 8 substantially.** The earlier version ranked
chapters by word count and named six over 4,000 words as split
candidates. Rendered, the picture is different. `25b-communicating` was
second-longest by words and is 20 pages, mid-pack. `05b-git-teams` was
third and is 18. The genuinely long chapters are `13-wrangling`,
`16-graphics` and `17-missing` at 28, none of which appeared in the
word-count list at all, because code and figures occupy pages that
words do not count.

Median 18 pages is roughly a 45-minute read, which is above the
one-sitting target but not alarmingly so, and no chapter is an outlier
demanding a split on length alone. **The recommendation is now to split
nothing on these numbers.** The book's length problem is its total, not
its per-chapter distribution, and the total is a consequence of scope
plus the executable-output work of Phase C rather than of any chapter
sprawling.

The glossary is the longest single unit at 35 pages, which is expected
for a reference appendix and is not a reading unit.

Word counts are
more reliable than the page estimates, so they are given directly here.
Median chapter 2,900 words. Six files exceed 4,000 words:
`12b-acquisition` (5,249), `25b-communicating` (4,999),
`05b-git-teams` (4,908), `25d-ethics` (4,762), `22-sas` (4,262), and
`03-team-science` (4,044). The first draft omitted `03-team-science`
from this list.

**Why it matters.** Downey's target of roughly 140 pages for a
semester course is a guideline from one author rather than an empirical
result, and a practicum spanning Git through CDISC has a defensible
reason to be longer. I would not restructure the book to hit 140. The
per-chapter figure matters more, and at a median of about six pages the
book is already close to the one-sitting target. Modularity is the
weakest criterion across the Open Textbook Library corpus, at 62.5%
positive, and this book is better placed than most because every
chapter opens with a prerequisites quiz that states what it assumes.

**Action, revised 2026-09-08.** Split nothing on length. The rendered
median is 18 pages and no chapter is an outlier; the four longest are
`13-wrangling`, `16-graphics`, `17-missing` and `22-sas` at 26 to 28,
none of which the word-count proxy identified. The book's length
question is its 712-page total, not its per-chapter distribution.

*Superseded.* Split only the five long chapters, at natural seams, and
leave the total length alone. Make the modularity that already exists
explicit by stating in the preface that chapters are assignable
individually, since an instructor assigning three chapters of a free
book incurs no cost justification.

### Finding 9. Adoption mechanics are entirely unaddressed

**Measured.** The book renders to HTML and PDF and is hosted at
`practicum.rgtlab.org`. There is no evidence in the repository of a
catalog listing, an ISBN, a print-on-demand edition, or a list of
adopting courses.

**One thing the first draft missed, in the book's favor.** The PDF
geometry is already set to a 6.5 x 9 inch trim with asymmetric inner
and outer margins, which is a print book's page and not a screen's. The
print-on-demand edition is therefore closer than the first draft
implied. It is still blocked, though, on both the NC license of Finding
4 and the missing PDF table of contents of Finding 5, because a
712-page paperback with no way to navigate it is not a product worth
selling.

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
Item 1 is now a correction of a published error rather than an
improvement, which raises its priority above everything else in this
plan.

1. Relicense prose to CC BY, keep code under MIT or GPL-3, and make
   `LICENSE.md`, `analysis/report/index.qmd`, `DESCRIPTION`,
   `CITATION.cff`, and the colophon agree with each other. The
   published book currently tells readers it is CC BY-NC-ND.
2. Set `toc: true` under the `pdf` format in `_quarto.yml` and confirm
   the rendered PDF carries a usable table of contents. One line.
3. Fix the two open items from `REVIEW-CHECKLIST.md` on `00-intro`:
   the appendix count and the missing 'Sources' entry in the chapter
   pattern list.
4. Move each chapter's `Prerequisites answers` section adjacent to its
   quiz, or make it reachable by an anchor link from the quiz, rather
   than leaving it as the last heading of the chapter.
5. Add a `fig-alt` to every figure that currently exists.

*Acceptance.* All five license declarations agree and none contains ND
or NC for the prose; the rendered PDF opens on a table of contents;
`00-intro` describes three appendices; no chapter's answer section is
its last heading without a link from the question; every figure that
renders carries a `fig-alt`.

**Status: complete as of 2026-09-07 18:40 PDT, except for the render
verification.** Item 1 done across `LICENSE.md`,
`analysis/report/index.qmd`, `colophon.qmd`, `DESCRIPTION`, and
`CITATION.cff`; a fifth disagreement was found and resolved in passing,
since `LICENSE.md` had called printed code MIT while `index.qmd` called
it CC0. Item 2 done (`toc: true`, `toc-depth: 2`). Item 3 done. Item 4
required no work: all 34 chapters already carried
`@sec-quiz-answers-NN` from the quiz. Item 5 done, 43 alt texts, which
is every figure that renders. The five remaining `fig-` labels sit
inside display fences and produce no image, so they take no alt text
and are a Finding 2 item instead.

*Not yet verified.* The book has not been rendered since these changes.
`toc: true` under `scrbook` is untested, and the alt text has not been
seen in built output.

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

*Acceptance, as originally written.* Every chapter has at least three
exercises with published solutions; no chapter has exactly five
exercises by coincidence of template; a reader with no project of their
own can self-assess in every chapter.

**Status: 2026-09-08. The third criterion is not achievable and should
be struck.** Fourteen chapters now carry worked solutions (45
executable solution chunks): `02b-deidentification`, `12b-acquisition`,
`13-wrangling`, `14-types`, `15-joins`, `15b-databases`, `16-graphics`,
`17-missing`, `18-analysis-plan`, `19-cdisc`, `20-testing`, `23-penguins`,
`24-adni`, `25d-ethics`. Every one of the remaining twenty chapters has
had its exercise set labeled as open-ended, with a one-line statement of
*why* no answer key exists.

The limitation this plan anticipated turned out to be structural rather
than incidental. The twenty labeled chapters are the infrastructure and
practice half of the book, and their exercises are not checkable in
principle: they modify a machine's state (`04-workstation`, `08-renv`,
`09-docker`, `07-rrtools`, `10-zzcollab`), require a collaborator and a
remote (`05b-git-teams`, `20b-ci`), need software the book does not ship
(`22-sas` needs SAS; `21-ai-coding` needs API credentials), or produce a
document rather than a value (`25b-communicating`, `25c-federal`,
`01-why`, `03-team-science`).

Inventing checkable exercises for those chapters was considered and
rejected. An artificial exercise on `palmerpenguins` in the Docker
chapter would satisfy the acceptance criterion and teach nothing about
Docker. `20-testing` was the one case where new exercises were genuinely
warranted, and three were written.

So the honest target is: **every chapter either publishes solutions or
states why it cannot**, which is now met. A reader with no project of
their own can self-assess in fourteen chapters and is told plainly where
they cannot.

### Phase C. Executable code and figures (in progress since 2026-09-07 19:00 PDT)

**Progress as of 2026-09-08.** Executable `{r}` chunks: 48 to 118.
Top-level ```` ```r ```` display blocks: 128 to 60. Sixty-eight blocks
converted across fourteen chapters. The full book renders clean with no
warnings.

**The remaining 60 are mostly not convertible, and the reason is
structural rather than incidental.** The chapters left are the
infrastructure ones, where the code's purpose is to change the state of
a machine: `08-renv` (9 blocks, all `renv::init`, `snapshot`,
`restore`, `install.packages`), `07-rrtools` (compendium scaffolding
and `use_github`), `04-workstation` (`.libPaths()` output for a
hypothetical machine, and an `.Rprofile` listing), `10b-targets`
(`tar_make()` would run a pipeline), `24-adni` (needs the restricted
ADNIMERGE package), `21-ai-coding` (live API calls), `15b-databases`
(a remote Postgres connection), and `12-rmd-workflow` (one block sets
`opts_chunk` globally, which would leak into the rest of the render).

Running these would mutate the project's own lockfile and library,
publish repositories, or reach the network at build time. They are
correctly display-only and should receive the dated verification note
of item 3 rather than conversion.

**Revised expectation.** The realistic ceiling is roughly 75 to 80
conversions of the original 128, not the 115 estimated at the higher
bar on 2026-09-07. That estimate was extrapolated from data-analysis
chapters and did not account for the infrastructure half of the book,
where display-only is the correct state for nearly every block.

**A blocking build failure was fixed first, and it was not in the
plan.** The book did not render at all: `13-wrangling` chunk
`wrangle-pandas` died on `ModuleNotFoundError: No module named
'pandas'`. The `Makefile` documents this ('a build without deps-py
fails at 13-wrangling.qmd') and expects `pip install -r
requirements.txt` against the ambient interpreter. That is precisely
the dependency-on-machine-state this book argues against everywhere
else. It is fixed by declaring the requirement in the document instead:
`reticulate::py_require()` in the four chapters with Python chunks
(`13-wrangling`, `14-types`, `15-joins`, `16-graphics`), so reticulate
provisions its own environment through uv. `requirements.txt` and the
`deps-py` target are now redundant for the book build and should be
reviewed.

The 10-to-15-day figure was estimated before Finding 3 was given a
countable target. Bringing 170 code-bearing sections to a rendered
artifact from a base of about 20 is a larger job than that estimate
covers, and the ambient images add sourcing and attribution work that
is not development time at all. Treat this phase as the one most likely
to overrun, and re-estimate after the first three chapters.

1. Triage all 258 display-only blocks into executable, not executable,
   and expensive. Start with the heaviest files: `22-sas` (25),
   `11-quarto` (22), `12-rmd-workflow` (19), `05b-git-teams` and
   `13-wrangling` (17 each).
2. Convert the executable subset to `{r}` chunks, one chapter at a
   time, rendering after each chapter.
3. For blocks that cannot execute, add a dated verification note
   stating how and when the command was checked. `22-sas` and
   `05b-git-teams` are expected to stay largely display-only.
4. Bring every code-bearing section to at least one rendered artifact,
   which is 170 sections against the current ~20, prioritizing the
   five files that currently have no figure of any kind: `11-quarto`,
   `25b-communicating`, `C-alternative-wrangling`, `D-peer-survey`,
   and `E-lab-software`, then `12-rmd-workflow`, `20-testing`,
   `24-adni`, and `17-missing`. Leave the 204 prose-only sections
   alone; do not invent figures to fill them.
5. Handle `25b-communicating` as the stated exception, adding code so
   that it acquires three or four rendered artifacts rather than being
   exempted for having none.
6. Source and place the five portraits named in the April image
   policy, complete their `credits.qmd` rows and the cover
   attribution, and add no other ambient imagery.
7. Add `fig-alt` to each new technical figure as it is created; give
   ambient images a null `alt` if they are genuinely decorative, and
   reclassify them as technical if they are not.

*Acceptance.* A full render completes clean; no content file has zero
figures; every code-bearing section produces a rendered artifact in the
built book, verified by rendering rather than by grep; ambient images
number no more than about twenty and all carry provenance.

### Phase D. Reference apparatus and distribution (about 5 days)

1. Build the glossary appendix by extracting bolded first-use terms.
2. Add a PDF index.
3. Do not split chapters on length. Superseded by the rendered
   page counts; see Finding 8.
4. State the modular-assignment policy in the preface.
5. List in the Open Textbook Library and solicit reviews.
6. Produce a print-on-demand paperback.

*Acceptance.* Glossary and index present in both output formats; no
chapter over about nine estimated pages; catalog listing submitted.

**Status: 2026-09-08. Two of six done; four are blocked on decisions or
actions only the author can take.**

*Done.* The glossary is written and shipping as appendix F
(`F-glossary.qmd`), roughly 75 terms across ten domains, each
cross-referenced to the chapter that develops it. The
modular-assignment policy is stated in the preface under 'Assigning
parts of this book', including the honest caveat that Parts I to III
are a dependency chain rather than independent modules.

*Not done, and why.*

**The index needs a decision before it needs work.** A back-of-book
index requires `\index{}` markup at every occurrence of every term
across 38 chapters. That is not a scan-and-insert job: the markup is
LaTeX, so it has to be confined to PDF output or it leaks into HTML as
literal text, and deciding which occurrences of a term deserve an entry
is editorial judgment, not pattern matching. Note also that the HTML
edition already has full-text search and the PDF now has a table of
contents, so the index is a PDF-only gain. Recommend deciding whether
it is worth the source clutter before anyone starts.

**The five portraits are blocked on licensing, which should not be
automated.** The April image policy names Bryan, Marwick, Allaire, Xie
and Wickham, requires CC-BY or CC0 sourcing, and requires a
`credits.qmd` entry per image. Sourcing and verifying the license of a
photograph of a living person is a judgment with real consequences if
it is wrong, and it is not a task to delegate to a tool that cannot see
the license page it is reading. `images/portraits/` is still empty and
five `credits.qmd` rows still read TODO, along with the cover's own
attribution line.

**Chapter splitting was not attempted.** Six files exceed 4,000 words.
Splitting them is an editorial act that changes the book's structure
and its cross-references, and it should follow from a reading rather
than from a word count.

**Catalog listing and print-on-demand are the author's to perform.**
Both require accounts, identity, and a submission the author stands
behind. They also depend on Phase B being far enough along that a
reviewer would not immediately note the missing solutions, which is now
true for fourteen chapters and not for the rest.

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
- Do not retain the NC or ND terms the book currently carries, and do
  not adopt them elsewhere to retain commercial
  control. They disqualify the book from the catalogs that Phase D
  depends on, and Downey's observation applies: as copyright holder
  you retain the ability to grant separate licenses later regardless
  of the public default.
- Do not add humor or decorative photographs to chase engagement. The
  seductive-details literature suggests entertaining tangents can
  reduce learning, and OpenIntro's stated practice is to pursue
  attention through interesting data and questions instead. The
  book's own `images/README.md` already states this rule more
  strictly, and it governs: no chapter-opener images, no generated
  hero images, no part-divider art, and four to five portraits at
  most.
- Do not add part-opener images or prose pages. The image policy
  forbids the art, and the prose pages fail the evidence on their own
  terms: a part opener serves a linear reader the reading-compliance
  data says is rare, it strengthens Organization (78.0% positive)
  rather than Modularity (62.5%), and `fig-book-map` in `00-intro`
  already does the orienting work once.
- Do not set a uniform per-section figure count. A figure invented to
  satisfy a quota in a prose section is a seductive detail with a
  `ggplot` theme, and it costs the same effort as a real one.

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

**On the reliability of the first draft. [added 17:40 PDT]** The
re-measurement that produced this revision found three substantive
errors and two omissions in a document that presented its counts as
reproducible. The license error is the serious one, because the first
draft's remedy happened to be right while its diagnosis was wrong, and
a reader acting on the diagnosis alone would have believed the book was
merely mislicensed rather than actively non-open. The `11-quarto`
figure error came from crediting a chapter with output it does not
produce. Both were the result of trusting a scan without spot-checking
its output against the files. The counts in this revision were verified
against `analysis/report/` directly on 2026-09-07, but they are still
grep over source rather than inspection of rendered output, and the
same class of error remains possible.

**On the two Finding 3 targets specifically.** The 170 code-bearing
sections is a count of sections containing a fence of any kind,
including `bash`, `yaml`, and `sas` blocks that will never render an
artifact, so it is an upper bound on what the conditional rule can
yield and the achievable number is lower. It will also move once
Finding 2's conversion runs. The ambient target is now the April image
policy's own five portraits rather than a number derived here, which
removes the print-cost question from the critical path; if a larger
photographic budget is ever revisited, the claim that color interior
printing would defeat a sub-ten-dollar paperback is stated from general
knowledge and needs a vendor quote before it is relied on.

**Now verified, 2026-09-08.** The book was rendered to both HTML and
PDF. Both complete clean with no warnings. `toc: true` under `scrbook`
produces a correct multi-level table of contents with page numbers, and
the trim is the intended 6.5 by 9 inches (468 by 648 points).

**And the page estimate was wrong by a factor of nearly three. The
book is 712 pages, not ~248.** Every draft of this plan repeated the
248 figure, derived by dividing 111,865 words by a conventional 450
words per page. That divisor is for a dense prose page on a larger
trim. This book is set at 11pt on a 6.5 by 9 inch page, and a large
share of its content is code and rendered output, which occupy a page
at a fraction of prose density. The estimate should not have been
carried through four revisions without a render to check it, and the
lesson is the same one this plan keeps relearning: build the artifact
before quoting numbers about it.

**Consequences for the plan.** Finding 8 argued against restructuring
toward Downey's ~140-page target on the grounds that 248 was
defensible for the scope. At 712 that argument is much weaker, and
length becomes a live question rather than a settled one. Note also
that Phase C *added* pages by converting display blocks into executed
chunks with output, so this number will keep rising. The
print-on-demand item in Phase D needs rethinking: a 712-page paperback
is a different product, and a different price, from the sub-ten-dollar
edition the evidence base describes. Cultural relevance remains unassessed. The contrast
ratios are computed from the hex values in `practicum.scss` rather than
measured against rendered output, and no dark-mode variant was
examined. Whether the worked examples are in fact worked, as opposed to
described, has not been checked by reading them.

## Appendix. Reproducing the measurements

The two scan scripts used for the first draft are in the session
scratchpad: `measure.sh` (per-chapter words, exercises, figures,
chunks, retrieval sections) and `measure2.sh` (chunk types, alt text,
formats, license, exercise style). They are read-only over
`analysis/report/` and can be rerun after each phase to confirm the
acceptance criteria above.

The corrections in this revision came from a second, independent scan
on 2026-09-07 at 17:40 PDT, scripted as `chk1.sh` through `chk9.sh` in
the session scratchpad. The checks that found the errors are worth
stating in full, since they should be part of any future verification:

- `grep -c '^```{r' *.qmd` for executable chunks, per file, which is
  what showed `11-quarto` and `12-rmd-workflow` at zero.
- A loop reporting files where both the mermaid count and the `{r}`
  count are zero, which is what produced the five-file zero-figure
  list.
- `grep -i '^license' DESCRIPTION`, `head -8 LICENSE.md`, `grep -i
  license CITATION.cff`, and the License section of `index.qmd`, read
  as four separate files rather than assumed to agree.
- `grep -n '^#\+ ' <chapter>.qmd` to produce a heading map, which is
  what revealed that `Prerequisites answers` is always the last
  heading.
- `grep -rn 'toc' _quarto.yml`, which is what found `toc: false` under
  the `pdf` format.

The general lesson is that a count aggregated across files hides the
per-file zeros, and the per-file zeros are where the defects are.

The section counts underlying the two Finding 3 targets come from
`sec.sh` (technical sections per file, defined as `^## ` headings less
the eight boilerplate headings) and `secode.sh` with `secode.awk`
(of those, how many contain a code fence). They yield 374 technical
sections, 170 code-bearing and 204 prose-only, and the part count of 8
comes from `grep -c '^    - part:' _quarto.yml`. Rerunning these after
Phase C converts display blocks to chunks will move the code-bearing
count, so re-measure rather than treating 170 as fixed.

---
*Rendered on 2026-09-07 at 17:40 PDT.*<br>
*Source: ~/prj/tch/02-practicum/REFACTOR-PLAN.md*
