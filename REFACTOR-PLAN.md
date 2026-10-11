# Refactoring Plan: Biostatistics Practicum
*2026-09-07 14:05 PDT, revised 2026-09-07 17:40 PDT, merged with the
readability plan, expert reviews, and LLM-section review 2026-10-09*

## Revision note

**Map of this document.** Findings 1 to 10 and Phases A to D are the
September structural plan and its implementation record. Findings 11
to 23 come from the October reading pass, Finding 24 from a review of
the LLM sections, Findings 25 to 30 from three expert reviews, and
Finding 31 from a measurement of visual density with a list of 54
candidate tables and figures.
Parts 3 to 7 hold the proposals; Part 6 is the consolidated defect
register; Phases E to K are the remaining work; Part 11 records the
author's decisions (resolved 2026-10-09; one minor item open).

**2026-10-09 merge.** This document now combines two plans. The first
(2026-09-07) was a structural and adoptability audit based on a
mechanical scan; Phases A to D below record what was implemented from
it between 2026-09-07 and 2026-09-11 and what remains. The second
(`READABILITY-PLAN.md`, 2026-10-09) came from a full line-by-line
reading of all 47 source files plus a survey of learning-science and
e-textbook guidance; it addressed prose, approachability, and
memorability, which the first plan deliberately excluded. Its findings
are Findings 11 to 23, and its proposals are Parts 3 to 7 and Phases E
to J. `READABILITY-PLAN.md` has been removed; this file supersedes it.

**2026-10-09, expert reviews and LLM sections.** Added Finding 24 (a
review of all 33 'Collaborating with an LLM' sections against current
practice) with its specification in 4.6, and Findings 25 to 30 from
three independent expert reviews (pharmaceutical biostatistics,
academic biostatistics, industry data science), each of which
recommended adoption only after major revisions. Their defects are
consolidated in Part 6, whose new Tier 1 table defines Phase E1.
Phase K (content gaps) and decisions 11 to 14 are new. Two earlier
claims were strengthened rather than changed: the missing-data and
SAP defects first noted in the reading pass were verified by
computation, and the reviewers found them to be worse than first
described.

**2026-10-09, later.** Added lessons from a structural reading of
Hadley Wickham's *Advanced R* (2nd edition, adv-r.hadley.nz) and its
companion *Advanced R Solutions*: section-level exercises, an Outline
in the chapter card, margin footnotes for asides, nested numbered
sections, a recurring visual grammar (4.5), short part introductions,
a solutions companion, 'Getting help' and 'Meta-techniques' sections,
and a generated colophon (5.5 to 5.9). Two of these reopen or extend
decisions (Part 11, decisions 9 and 10).

Two positions taken by the September plan are reopened by the October
reading rather than silently overridden. Part 9 ('What not to do')
said not to rewrite prose for voice and not to split chapters on
length. Both were listed as open decisions in Part 11 (since resolved), with the case
for and against, because they reverse choices the author made
deliberately.

**2026-09-07 17:40 PDT.** The first draft of this plan (14:05 PDT)
contained three measurement errors, all corrected below and marked
**[corrected 17:40 PDT]** at the point of correction. In summary: the
license situation is materially worse than reported and is a four-way
conflict rather than a single GPL-3 declaration; `11-quarto` has no
computed figures rather than three; and the per-chapter answer
sections, credited as a strength in the first draft, are placed at the
maximum possible distance from the questions they answer, which is
itself a named reviewer complaint. Two defects the first draft missed
entirely have been added: the PDF ships with no table of contents, and
the book contains no embedded media of any kind. Counts that changed
on re-measurement are noted in Part 1.

## Purpose and method

This document proposes a refactoring of *Biostatistics Practicum* for
its primary audience: first-year master's students in data science or
biostatistics, and entry-level data science engineers. It has two
aims, pursued in sequence. The first is that the book be adoptable and
practicable: legally open, navigable, with exercises that give
feedback and code that runs. The second is that it be readable,
approachable, and memorable for that audience.

**Structural pass (2026-09-07 to 2026-09-08).** Findings 1 to 10 rest
on a mechanical scan of the 38 content files in `analysis/report/`,
measured against the evidence base assembled for the blog post 'What
Makes an Open Textbook Work'
(`~/prj/ryyblog/posts/pub-open-textbook-guidebook/`). The proxies used
were whether students can practice with feedback, whether the book is
navigable and assignable in pieces, whether it is legally and
practically adoptable, and whether it presents anything to look at.
Counts are reproducible from the scripts in the appendix; where a
number is an estimate, it says so.

**Reading pass (2026-10-09).** Findings 11 to 23 rest on three sources.

1. A full reading of all 47 `.qmd` files (about 136,000 words) in six
   groups, recording per-chapter metrics, openings, closings, prose
   samples, pedagogy, callout use, defects, and memorability devices,
   with `file:line` references.
2. A survey of about 30 searches and 8 page reads on learning science
   (Dunlosky et al. 2013; Mayer; Sweller; Ginns et al. 2013),
   technical-lesson design (Wilson, *Teaching Tech Together*; The
   Carpentries; Timbers and Cetinkaya-Rundel; R4DS; Happy Git; Missing
   Semester; Julia Evans), and on-screen reading (Nielsen Norman Group;
   Delgado et al. 2018).
3. Direct verification of a sample of the reading's claims.

Evidence labels follow the usual convention: **verified** (a command
was run and the result observed), **inspected** (the source was read
and the statement confirmed), and **inferred** (consistent with the
pattern, not checked). Six reading-pass claims were independently
re-checked and all held: the underpowered SAP (verified with
`power.prop.test`), the daylight-saving example (inspected in
`_freeze/`), the unused callout conventions (verified by `grep`), the
merge-conflict example, the missing-data mechanism table, and the ADNI
follow-up cutoff (all inspected).

**Expert and specialist reviews (2026-10-09).** Findings 24 to 30 rest
on four further sources: a review of every LLM section against current
practice (statements about current tools are expert knowledge as of
mid-2026, not verified against vendor documentation); three expert
reviews, each reading its assigned chapters in full and running R,
Quarto, and Git checks where feasible; and a structural reading of
*Advanced R* (2nd edition) as a model of presentation (Part 5,
sections 5.5 to 5.9). The expert reviewers were simulated personas
instructed to review as a senior pharmaceutical biostatistician, an
academic biostatistician, and a senior data scientist would; they are
not external human reviewers, and Phase D's catalog listing should
wait for human expert review (Part 10).

`DEEP-REVIEW.md` (2026-07-05) covered voice, disciplinary framing, and
peer comparison, and `REVIEW-CHECKLIST.md` (2026-09-07) is the
per-chapter ownership review. Neither is superseded.

## Executive summary

**Where the structural work stands.** The September plan found the
book in good condition on the criteria reviewers rate most often and in
poor condition on three that matter most for learning and adoption:
exercises without solutions, code that did not execute, and a
reader-facing license (CC BY-NC-ND) that disqualified it as an open
resource. Most of that has been fixed. The prose is now CC BY 4.0 with
all declarations reconciled; the PDF has a table of contents; every
rendered figure has alt text; executable chunks rose from 48 to 166;
14 chapters publish worked solutions and the other 20 state why they
cannot; a glossary exists; and a `renv.lock` was added. Open items are
the index, three of five portraits, the catalog listing and
print-on-demand, CI that actually executes code, and a Dockerfile. The
`renv.lock` has never been restored: on 2026-10-09 the PDF render
failed against the empty project library and succeeded only with renv
disabled.

**What the reading found.** The book has a strong intellectual spine
and weak delivery to its stated audience. The spine is the idea that
the dangerous errors in applied statistics are *silent*: a join that
multiplies rows, a package update that changes a number, a stale
intermediate file, a figure that misleads without a false value. That
idea recurs in at least fourteen chapters, is never named, and is
rarely what a student meets first. Six problems account for most of
the readability gap.

1. **Every chapter makes the student wait.** An epigraph, a 'Sources'
   or 'Why this chapter exists' note, a bypass quiz, and four to seven
   objectives precede the motivating story, which typically arrives 40
   to 90 lines in. Several of those notes address curriculum reviewers
   rather than students.
2. **The chapter template repeats itself.** 'Orientation', 'The
   statistician's contribution', and 'Principle in use' restate the
   same points in most chapters.
3. **The book does not use its own conventions.** `conventions.qmd`
   promises Verification, Pitfall, and LLM-prompt callouts. None
   appears in any chapter (verified).
4. **There is no running example.** Successive chapters use penguins,
   airquality, band_members, a 'readmissions' cohort that never exists
   as data, and several unrelated synthetic schemas.
5. **The register sits above the audience.** Formal first-person
   plural, hedging, and undefined acronyms raise the cost of every
   page. This is the point on which the reading most directly
   questions an earlier decision (the rgtvoice pass); see Part 11.
6. **Correctness defects cluster where code does not run.** Examples
   include an underpowered model SAP, a daylight-saving demonstration
   that prints the opposite of its comment, and a merge-conflict lesson
   whose 'merged' answer is identical to one side.

The remedy for the readability gap is not new content. It is a
smaller, consistent chapter template, one running study carried from
the first chapter to a capstone, executed examples, and a short
numbered set of habits.

**What the expert reviews found.** Three expert reviews (pharmaceutical
biostatistics, academic biostatistics, industry data science) each
concluded that the book should be adopted only after major revisions,
and for overlapping reasons. The statistical core is wrong where
students cannot check it: the missing-data chapter inverts the
condition under which complete-case analysis is unbiased and rests its
conclusions on a simulation that reseeds itself into a handful of
datasets; the model SAP is underpowered, misdescribes its estimand, and
the HF-HOME example contradicts itself across three chapters. Several
compliance statements would be harmful if acted on (PHI deposited in
dbGaP; date shifting called Safe Harbor; 'FDA requires SAS'). Many
infrastructure recipes do not run as written, CI cannot fail, and the
LLM guidance contains no data-governance rule. The reviewers also
agreed on what is distinctive and worth keeping: the statistician's
judgment layer, the review checklists, acquisition, testing
philosophy, and communication.

**Order of work.** Tier 1 defects (Part 6, Phase E1) come first and
should be fixed before the book is assigned again. Then the remaining
correctness work, the template and running study (the author's
decisions, recorded in Part 11, fix their scope), and finally the chapter-by-chapter rewrite, in which
the content gaps the reviewers identified (Phase K) are added as
sections paired with cuts, so that the book does not grow.

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
| Executable `{r}` chunks | 48, in 11 files | **166** (168 on 2026-10-09, including solution chunks; Phase C's '118' is an interim figure) | code that renders is code that is checked |
| Top-level ```` ```r ```` display blocks | 128 | **60** | mostly correct as display |
| Technical figures (code-generated) | ~20 | 27 | 1 per code-bearing section |
| Portraits placed (policy allows 4 to 5) | 0 | **2** (Gentleman, Wickham; commit `57b9bc5`) | 5, per the April policy |
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
weakest criterion in the reviewer corpus. (*2026-10-09:* the reading
pass qualifies this. The modularity function is real, but the same
apparatus delays every chapter's motivation, and two chapters open
differently; Finding 11 and the template in 4.1 keep the function in a
shorter chapter card.) Contrast and heading
hierarchy pass their accessibility checks. And the book already has a
per-chapter prerequisites quiz with published answers, which is a
retrieval practice structure most textbooks lack entirely.

**[corrected 17:40 PDT]** The first draft credited that quiz structure
without auditing where its answers sit. They sit at the last heading of
every chapter. In `13-wrangling.qmd` the quiz is at line 25 and
`Prerequisites answers` at line 692. The structure is therefore right
and its placement is the specific defect the reviewer corpus names,
namely solutions that require scrolling to the end of the chapter. The
refactoring extends the structure and must also move it. (*Partly
retracted 18:05 PDT; see Finding 1. Every quiz already links to its
answers, so the defect is minor.*)

## Part 2. Findings

Findings 1 to 10 come from the structural pass of 2026-09-07 and carry
their implementation status inline. Findings 11 to 23 come from the
reading pass of 2026-10-09, Finding 24 from the LLM-section review,
Findings 25 to 30 from the expert reviews, and Finding 31 from a
visual-density measurement. Where a later finding
overlaps an earlier one, the later finding says so.

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
the seductive-details caution already recorded in Part 9, which say
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
hard. Note that this plan's own Part 9 instructs against adopting an NC
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

### Finding 10. The book does not satisfy its own Five Pillars

**Added 2026-09-08.** Not in the original scan, and found only by
looking at the repository's CI while migrating the testing chapter.
`10-zzcollab` names five pillars as the minimum for a reproducible
project. This project has two and a half of them.

| Pillar | In this repository |
|---|---|
| 1. Dockerfile | **absent** |
| 2. `renv.lock` | **absent** |
| 3. `.Rprofile` | present, but never loaded (below) |
| 4. Source code | present |
| 5. Data | present, synthetic and `palmerpenguins` |

**There is no `renv.lock` anywhere in the repository.** The book that
devotes a chapter to `renv`, and whose own figure lists the lockfile as
pillar two, does not pin its own R packages. The render now depends on
roughly thirty packages, and nothing records which versions produce the
numbers in the text.

**The `.Rprofile` is inert.** It sits at the repository root, but
Quarto renders from `analysis/report`, and R sources `.Rprofile` from
the working directory. Running R from the render directory shows
`RETICULATE_PYTHON` unset, so the file has no effect on any build.

Were it loaded, it would be worse rather than better. It hardcodes
`/opt/miniconda3/bin/python3` and instructs the reader to 'adjust the
path below to match your machine', which is the ambient-machine-state
dependency the surrounding chapters exist to argue against. The
`reticulate::py_require()` declarations added in Phase C supersede it.

**CI renders from a committed cache and therefore never executes the
code.** `_freeze/` is tracked, 120 files, and holds fully executed
markdown. `.github/workflows/render-book.yml` finds no `renv.lock`, so
it installs only `knitr` and `rmarkdown`, then renders. That succeeds
only because Quarto reads the frozen results rather than running
anything. The workflow is a markup gate, not an execution gate.

This qualifies a claim made repeatedly in this plan. Finding 2 argues
that converting display blocks to executable chunks means the code is
'checked by rendering'. It is checked when the author renders. It is
not checked by CI, and a package update that broke every chunk would
deploy green.

**In fairness**, a book is not a clinical analysis, the freeze cache is
the correct mechanism for an expensive build, and committing it is
deliberate. The objection is narrower: the project asks readers to
adopt practices it does not apply to itself, and a reader who clones
this repository to see a worked compendium finds two pillars missing.

**Action, in order of value.**

1. Add a `renv.lock`. This is the one that unblocks the others, and it
   is `renv::init()` plus `renv::snapshot()`.
2. Move `.Rprofile` to `analysis/report/`, or delete it. It currently
   does nothing, and what it would do is wrong now that `py_require()`
   handles Python.
3. Add a scheduled CI job that renders with `--cache-refresh` against
   the restored lockfile, so the code is executed somewhere other than
   the author's laptop. Weekly is enough; it is the only thing that
   would catch upstream package drift.
4. Consider a Dockerfile. The workflow already builds and renders in
   one when present, so this is the cheapest pillar to add.

---

The following findings come from the 2026-10-09 reading pass. Each
states the observation, the evidence, and the principle from the
literature that it engages. Line references are to `analysis/report/`.

### Finding 11. The hook is buried under scaffolding

Most chapters open in this order: epigraph, metadata callout,
three-question bypass quiz, learning objectives, then 'Orientation'.
The motivating content usually appears 40 to 90 lines into the
source. Examples include the following.

- **`01-why`.** 'They are entropy... A step was done by hand on a
  Thursday afternoon and never written down' (01:69-76) is excellent
  and arrives after a boilerplate Sources note, a quiz, and five
  objectives.
- **`22-sas`.** The real hook, 'R-only graduates from this program
  have reported being excluded at the screening stage' (22:26-29), is
  inside a metadata callout. The body opens with a market-share
  sentence.
- **`02b-deidentification`, `20b-ci`, `25c-federal`, `25-synthesis`,
  and `00-intro`.** All five open with a definition or a recap rather
  than a problem.

Several opening callouts justify the chapter to a curriculum committee
rather than to a reader: 'This chapter brings the Practicum to parity'
(15b:29-30), 'places the Practicum ahead of its peers' (20b:17-30), and
the peer-survey notes in 10b and 17. 'Sources' callouts cite a private
path (`~/prj/sfw/07-zzcollab/zzcollab/`, 10:20-21), a Dropbox path
(19:16-25), and internal blog slugs (06:21-23).

The best hook in the book, the three silent failures 'each caught by
an assertion, a lockfile, or a dependency graph', sits in the preface
(preface:137-143), which many students will not read.

*Principle.* Advance organizers and motivation should precede detail.
Adult learners engage when material is problem-centered and visibly
relevant. On screen, 79 percent of readers scan, and front-loaded
content determines whether they continue (NN/g).

### Finding 12. Template fatigue and internal redundancy

The roughly seventeen-section skeleton is applied identically
everywhere: Prerequisites quiz, Learning objectives, Orientation, The
statistician's contribution, content, Worked example, Collaborating
with an LLM, Principle in use (always three habits), five exercises,
Further reading, and quiz answers. Consistency is a strength for
navigation. The cost is repetition, of which the following are
examples.

- `05-git-solo` argues 'why Git for solo work' three times before the
  first command (05:54-144).
- 'The statistician's contribution' repeats Orientation in 15, 16, 18,
  19, and 20b, and repeats 'Principle in use' in 10 and 19.
- The CNSR inversion is restated five times in `19-cdisc` and again in
  `22-sas`.
- The preface, `00-intro`, and `01-why` each restate the federal
  mandate, the ethics-last rationale, and the audience description.

*Principle.* Coherence (cut what does not serve the objective) and the
NN/g finding that concise text improves measured usability by 58
percent. Repetition that is not retrieval practice is reading cost
without learning benefit.

### Finding 13. Published conventions are not implemented

Verified by `grep`: `callout-warning`, `callout-important`, and
`title='Verification'` occur only in `conventions.qmd`. Every callout
in the chapters is either a note (Sources, Check your understanding) or
a tip (Solutions). Pitfalls are buried in prose. LLM prompts appear
as a plain section in most chapters, as a tip callout titled 'Prompts
to try' in 19, and as the never-used 'LLM prompt' callout in the
conventions page. `21-ai-coding` describes itself as 'the meta-chapter
on the "Collaborating with an LLM" callouts', which do not exist.

The preface and introduction also misdescribe the chapter pattern.
They say every chapter opens with 'Sources' (02b and 04b do not), and
they promise 'adversarial prompts designed to expose their limits'
where the prompts are benign drafting requests.

*Principle.* Signaling. A small number of consistent visual cues helps
readers locate what matters. A convention that is described but not
used is worse than none, because it teaches students to ignore the
conventions page.

### Finding 14. No through-line dataset or cast

The datasets in use, in order, are approximately the following.

| Chapters | Data |
|---|---|
| 01, 03, 04, 04b | none, or invented per chapter |
| 02b | four fictional patients (Ana Ruiz and others) |
| 05 to 09 | a 'readmissions' cohort that is never real data |
| 10 | penguins |
| 10b | a 'visits' pipeline |
| 11 | `data/readmissions.csv`, which does not exist |
| 12 | `y ~ x1 + x2` |
| 12b | Durham and Chapel Hill CRF extracts |
| 13 | penguins and a simulated blood-pressure trial |
| 14 | penguins, toy vectors, a synthetic CRF |
| 15, 15b | band_members, then two different patient schemas |
| 16 | penguins and a trajectory simulation |
| 17 | airquality and penguins |
| 18 | a hypothetical trial |
| 19, 22 | two independent synthetic ADaM builds |
| 23, 24 | penguins, ADNI |
| 25b | HF-HOME trial (1,500 or 2,706 patients; see Part 6) |

The preface promises penguins and ADNI as running examples
(preface:178-180). Neither appears in Parts I to II.

*Principle.* A running case is consensus practice (R4DS, Data Science
in a Box) and serves spacing and interleaving. Each chapter revisits
earlier material on familiar data, so retrieval happens naturally.
It also lets later chapters build on outputs students made earlier.
'Real, rich, accessible data' is one of Timbers and
Cetinkaya-Rundel's ten rules.

### Finding 15. Register and jargon

Examples of the formal register appear in most chapters: 'We would
urge the reader to read it instead as two statements' (05b:357-358),
'We bring in this chapter the habits of software engineering to bear'
(20:79-80), 'it is, we would argue, never the useful question'
(06:58-61), and 'The errors are, we would stress, of the silent kind'
(10b:69-70). Clever but opaque phrasing also appears: 'The request
does not launder the inference' (25b:122-123) and 'irritating the
editor is a strictly dominated strategy' (25b:515-516).

Undefined on first use: inferential reproducibility and BLAS (01),
HbA1c and EHR (03), l-diversity and t-closeness (02b), VPC, AMI,
vCPU, and SLURM (06), `libgsl-dev` (10), estimand, mITT, and ADSL (19),
DUA and Youden index (24), and '243B template' (18, 24), which is a
course number.

The best passages already use the right voice. Examples include 'A
merge conflict is a disagreement about the analysis, not about the
text' (05b:100), 'hosting is not archiving' (25c), and 'The query is
the recipe; the dated file is the ingredient' (12b:135). The target
register exists in the book. It is not yet the default.

*Principle.* Personalization: conversational, second-person text
improves retention (d = 0.30) and transfer (d = 0.54) in meta-analysis
(Ginns, Martin and Marsh 2013). This does not conflict with an
academic tone. Precision and second person are compatible.

### Finding 16. Exercises assume a career the student does not have

About 15 of the 32 exercises in the first seven chapters require the
student's own past analyses, collaborators, PI, or projects. Exercise
sets in 05 to 12, 20b, 21, 22, 25b, and 25c say 'no answer key is
possible'. Several of those exercises are in fact solvable against a
supplied file (04b exercises 1, 2, and 4, for example). The skills most
worth modeling (the memo, the reviewer response, the DMSP) have no
model answer anywhere.

*Relation to Findings 1, 6, and 7.* Phase B already added solutions in
14 chapters and retrieval prompts in most, and it labeled the other 20
exercise sets open-ended because their exercises change machine state,
need a collaborator, or need software the book does not ship. That
judgment holds for the exercises as written. This finding adds two
points. First, it concerns the *premise* of the open-ended exercises
(a career the student does not yet have), not only their keys. Second,
the running study proposed in Part 5 removes the premise for several
of those chapters, which is why Phase G revisits them.

*Principle.* Retrieval practice with feedback is the strongest effect
in the literature (Dunlosky et al. 2013, 'high utility'). Rowland
(2014) reports a larger effect with feedback than without. A sequence
of worked example, then faded example, then independent problem is
strongly supported for novices.

### Finding 17. Correctness defects cluster in code that does not run

Part 6 lists the defects. The pattern matters more than the
individual items. Chapters 10, 10b, 11, and 12 execute no code, and
`24-adni`, the book's showcase case study, is display-only. These
chapters contain most of the errors found, including object names that
are never created (24:389-424), a pipeline that contradicts its own
rule (24:360), and Dockerfiles that differ in base image, pinning, and
render command across 07, 08, and 09 and do not render a `.qmd` file.
Executed chapters carry a second class of error: hand-typed `#>` output
that disagrees with the real output (14:520-523).

For this audience, an error in a worked example is not a typo. A
first-year student copies it, gets a different answer, and concludes
that either they or the book is unreliable. Both conclusions damage
approachability.

*Relation to Finding 2.* Phase C converted 68 blocks and argued that
the remaining display-only code is correctly so. This finding does not
dispute that triage. It observes that the defects concentrate in
exactly that residue, and in hand-typed output inside executed chunks,
which Phase C did not audit. The `tools/check-calls.R` check verifies
that named functions exist; it cannot catch a wrong argument, a wrong
object name, or arithmetic in prose.

### Finding 18. Forward dependencies and sequence

The following are inspected examples.

- **`04-workstation` uses the shell before it is taught.** It relies on
  `cd`, `stow`, and `.zshrc` before `04b-shell` teaches `pwd` and
  `cd`.
- **`05b-git-teams` depends on six later chapters**, including
  resolving `renv.lock` conflicts before renv is introduced.
- **`06-cloud` depends on `09-docker`**, three chapters later.
- **`07-rrtools` requires renv, Docker, and CI** in its objectives
  before chapters 08, 09, and 20b.
- **'Five Pillars' is undefined where first used.** It appears in 08
  and is defined in 10.
- **`10b-targets` comes before `11-quarto`** but its report target
  presupposes Quarto.
- **`12b-acquisition` invokes the 'raw-data rule of @sec-wrangling'**,
  which is the next chapter.
- **`03-team-science` claims earlier coverage that has not happened.**
  It says the book 'has spent several chapters lowering that cost',
  citing tools taught later.
- **`25d-ethics` comes after the chapters it applies to.** Each of its
  five failures belongs to an earlier chapter (02b, 12b, 16, 25b), so
  students meet the failures long after forming the habits.

*Principle.* Novices cannot hold unresolved references in working
memory. Each forward reference is a small split-attention cost.

### Finding 19. Encyclopedic and perishable detail inside tutorial text

Tutorial chapters carry reference and version-specific material,
including the following.

- AWS AMI IDs, prices, and `pip install awscli` (06).
- ODA registration clicks (22).
- Model strings and the ellmer API (21).
- A full `_quarto.yml` dump and website configuration (11).
- Starship prompts, tmux bindings, and Nerd Fonts in a chapter that
  promises a 'minimum viable workstation' (04).
- A full `rows_*` tour (15).
- The zzcollab bundle and extension mechanics (10:368-424).
- Dated policy statements ('by the end of 2025') throughout 25c.

*Principle.* Diataxis separates tutorial, how-to, reference, and
explanation. Wilson defines a maintainable lesson as one 'cheaper to
update than to replace'. Perishable detail inside narrative text is the
classic failure of practitioner-written books.

### Finding 20. Length per sitting

Finding 8 measured the rendered book at 712 pages and a median
of 18 pages per chapter. Five chapters exceed 25 minutes of reading
at 200 words per minute: 12b (30), 25b (29), 17 (28), 25d (28), and
05b (26), with 16 and 22 next at about 23. The personalization effect
decays in lessons longer than about 35 minutes. NN/g and segmenting
research both favor shorter, self-contained units.

*Relation to Finding 8.* Finding 8 measured pages and concluded that
no chapter is an outlier on length alone, and recommended splitting
nothing. Word-based reading time and rendered pages rank chapters
differently, because code and output occupy pages without adding
reading time. The two measures agree that no chapter is extreme. This
finding therefore proposes removing reference and perishable material
(Finding 19) rather than splitting on length, with one content-based
exception; see Part 11, decision 2.

### Finding 21. Memorable devices exist but are scattered

The book already contains strong devices. These include the Five
Pillars, the three-legged stool, 'snapshot writes, restore reads',
'convert to factor late', '`collect()` late', 'Estimate, then double',
'Stale results are worse than slow ones', and 'What catches them is
not care but arithmetic'. Also memorable are the and/but/therefore
skeleton, the five ethics failures and their 'where caught' table, and
the 86,400-fold upstream-drift story. None is collected, numbered, or
referred back to. No chapter has a cheat sheet. The 'Principle in use'
triads, three per chapter for about 35 chapters, add up to more than
100 'habits', which is too many to remember.

### Finding 22. The capstone does not integrate

`25-synthesis` is a recap of the table of contents plus a reading
list. Its two habit lists contradict each other, and one contradicts
the testing chapter. Its claim that 'everything else flows from' the
compendium contradicts the ethics chapter's thesis that infrastructure
'is orthogonal to whether the analysis misleads'. It never returns to
the opening problem of `01-why`, and it sets no integrative task.

### Finding 23. The glossary is disconnected

Appendix F has about 75 terms but no chapter links to it (verified by
the reader with `grep sec-glossary`). Bold first uses are not
connected to entries. Many terms used in late chapters are missing,
among them DUA, AUC, data leakage, MCI, DMSP, dbGaP, HIPAA, IRB, and
minimum clinically important difference.

*Relation to Finding 5.* Phase D built the glossary and noted it was
cross-referenced to the chapters that develop each term. The reverse
direction, from the chapter text to the glossary, is what is missing.

### Finding 24. The LLM sections describe the chat-window practice of about 2024

*Added 2026-10-09 from a dedicated review of all 33 'Collaborating
with an LLM' sections (plus the 'With AI assistance' callout in
`19-cdisc` and the tooling sections of `21-ai-coding`), read in full.
Statements about the source are inspected. Statements about current
tools and practice are from expert knowledge as of mid-2026 and are not
verified against vendor documentation.*

The sections are the book's most consistent structure: in every
chapter, three prompts, each with 'What to watch for' and
'Verification'. They total about 1,400 source lines, roughly six
percent of the book. Several are excellent: `25b` (the model's
agreeableness as the vehicle for overclaiming, and adversarial review
of one's own draft), `25d` ('the one it will get wrong'), `12b` (ask
the model to argue the case *against* scraping), and `05b` (the
force-push warning, `--force-with-lease`, and 'revert rather than
rewrite'). The weaknesses are systematic rather than local.

1. **The workflow is copy-paste into a chat window.** Nearly every
   prompt begins 'Paste X and ask Y'. By 2026 frontier practice for
   analysis work is agentic: Claude Code, Codex CLI, Gemini CLI,
   Cursor, and Positron Assistant read the project, run the code,
   observe the output, and iterate. Most of the 'Verification' steps
   in the book (run the tests, re-render, count rows, rebuild the
   image) are now steps an agent performs itself. The human's role
   has shifted to specifying acceptance criteria before the work and
   reviewing evidence and diffs after it. Neither is taught.
2. **There is no data-governance rule anywhere.** Prompts instruct the
   reader to paste the first twenty lines of a file (12b), five rows
   (13), 'the tables' (15), a lockfile, a schema, and in `24-adni`
   material from a cohort governed by a data use agreement. Neither
   the sections nor chapter 21 says what may be sent to which
   endpoint: schemas and synthetic rows yes; PHI, DUA-restricted, or
   proprietary sponsor data only to an institution-approved deployment
   with appropriate agreements (zero retention, BAA), and often not at
   all. The two expert reviews (Part 6) reached the same conclusion
   independently.
3. **Capability claims are generic and will date.** About twenty
   sections open with the same formula, 'LLMs handle X well; the trap
   is Y', and many rely on 'the LLM should know this' or 'in our
   experience'. These are unfalsifiable and describe models of two
   generations ago. The durable 2026 failure modes are different: not
   syntax or hallucinated functions, which current models rarely
   produce in mainstream R, but plausible analytic choices made
   silently on underspecified requests; agreeableness (sycophancy);
   confident claims about policy, regulation, and package versions
   past the knowledge cutoff; fabricated citations; over-engineering;
   and, in agentic use, weakening or editing tests until they pass.
4. **The prompts are one-liners.** Best practice is to supply context
   (the data dictionary, the SAP section, the house style), state
   constraints, define the acceptance check first, and ask the model
   to list its assumptions and ask clarifying questions before writing
   code. No section shows a fully specified prompt.
5. **The highest-value techniques are absent.** These are: writing the
   assertion or test first and asking the model to satisfy it;
   independent re-derivation in a fresh session or with a second model
   as a check, which is the AI analogue of double programming and
   maps directly onto pharma QC practice; a project instruction file
   (`AGENTS.md` or `CLAUDE.md`) that encodes the book's own habits
   (native pipe, `relationship =` on joins, `tinytest`, never edit
   `data/raw/`); giving the model live access to documentation and the
   R session through tools such as the `btw` package and MCP servers,
   which removes most hallucinated-API errors at the source; and
   committing or branching before any agent touches the repository.
6. **There is no LLM provenance habit.** For a book whose thesis is
   reproducibility, it never asks the reader to record the model,
   date, and prompt that produced a piece of code or prose, and it
   does not mention journal disclosure policies (ICMJE and most
   publishers now require disclosure, and an AI cannot be an author).
   Model outputs are nondeterministic and model identifiers retire,
   so an unlogged LLM step is an unreproducible step.
7. **Volume and repetition.** Three prompts times 33 chapters is about
   100 prompts, many of them trivial ('ask for a config; test it;
   iterate') with verification steps that are not actionable ('have a
   colleague read it', 'iterate'). One or two strong prompts per
   chapter would teach more.
8. **Format is inconsistent.** Plain sections in most chapters, a tip
   callout in 19, and an 'LLM prompt' callout defined in
   `conventions.qmd` and never used (Finding 13).

Specific errors and weak advice in individual sections are listed in
Part 6 and in 4.6.

---

The following findings come from three independent expert reviews
commissioned on 2026-10-09, each reading its assigned chapters in
full: a pharmaceutical-industry biostatistician (10 chapters), an
academic biostatistician who directs an MS program (14 chapters), and
a senior industry data scientist and engineer (19 chapters). Each
reviewer ran R, Quarto, and Git checks where feasible, and labeled
claims as verified, inspected, or expert knowledge. All three reached
the same verdict: **adopt only with major revisions**. Their
individual defects are consolidated in Part 6; the findings below are
the patterns.

### Finding 25. The statistical core is wrong in the places students cannot check

The academic and pharma reviewers independently identified the same
cluster, and both verified it by computation.

- **Missing-data theory is inverted (17, repeated in 23).** The book
  teaches that complete-case analysis is biased under MAR. For
  regression coefficients, complete-case analysis is unbiased whenever
  missingness is independent of the outcome given the covariates,
  whatever the mechanism label (White and Carlin 2010; Hughes et al.
  2019). The academic reviewer's 300-replicate run of the chapter's own
  design gave complete-case bias of -0.003 against multiple-imputation
  bias of +0.064 when *x* is missing on *x* itself, and -0.185 against
  -0.024 when missingness depends on *y* (verified). The table also
  says MAR needs no sensitivity analysis, contradicting the chapter's
  own principle and regulatory expectation.
- **The simulation behind the chapter's conclusions is broken.**
  `mice(seed = 1)` inside the replicate function resets the global
  RNG, so the 100 'replicates' are a handful of datasets (verified by
  both reviewers: two alternating values in one run, five distinct
  datasets in another). The interpretation at 17:917-945 rests on it.
- **The model SAP is underpowered and its estimand is misdescribed
  (18).** It needs 1,094 per arm for 80 percent power, not 750
  (verified three times), and attrition is not applied (71, not 64).
  A covariate-adjusted model with a random site intercept estimates a
  conditional, not marginal, odds ratio. The analysis regresses on
  treatment received, not randomized assignment. There are no
  estimand attributes or intercurrent events, though ICH E9(R1) is
  cited and death before readmission is the obvious one. The
  multiplicity scheme (primary at 0.05, then Bonferroni over
  secondaries) allows familywise error near 0.10; the conditional HC1
  rule is a pretest procedure (Long and Ervin 2000 support
  unconditional HC3).
- **The HF-HOME running example contradicts itself across 03, 18, and
  25b.** Trial size (1,500 or 2,706), power target (4.5 or 5 points),
  estimand (odds ratio or risk difference), and missingness (6.3
  percent missing, or 'every outcome ascertained') all disagree. The
  sensitivity code adds imputed events without enlarging the
  denominator. The observational intake version in 03 builds in
  immortal-time bias (exposure 'within 7 days' against a 30-day
  outcome), uses a causal verb, and records 'Red flags noted: None'.
- **Smaller verified errors:** the daylight-saving example (14),
  factor joins said to match codes (they match labels, 14), a
  p-value inconsistent with its interval (03), a confidence interval
  for a mean presented as an individual prediction (03), and others in
  Part 6.

This finding strengthens Finding 17 and changes its priority. The
running study proposed in Part 5 must be built from *one* canonical
SAP with every number computed, or it will propagate these
inconsistencies into every chapter.

### Finding 26. Compliance and regulatory statements a student could act on are wrong

From the pharma reviewer, confirmed against the source where marked.

- **PHI deposited in dbGaP and TCIA** in the model DMSP (25c:414-419;
  inspected). Both accept de-identified data only, and dbGaP is not a
  home for general clinical CRFs (BioLINCC, Vivli, ICPSR, and the
  NIA and NIDA archives are).
- **Date shifting and MRN hashing presented as Safe Harbor** (02b).
  Safe Harbor permits the year only; date shifting is an Expert
  Determination technique; a re-identification code may not be
  derived from an identifier (45 CFR 164.514(c)). HIPAA and the Common
  Rule notion of 'coded' data are conflated, and the limited data set
  with a DUA, the most common research pathway, is absent.
- **'A regulatory submission to FDA requires SAS-formatted
  deliverables'** (22:98-103; inspected). FDA requires the open XPT
  transport format, not SAS software, and R-based submissions have
  been accepted (R Consortium pilots). This misinforms career choices.
- **Industry roles and analysis sets are misdescribed** (19): in
  industry, statistical programmers build ADaM; mITT is described with
  the usual safety-set definition; analysis sets are conflated with
  the estimand's population; `1L - CNSR` silently fails for CNSR
  values other than 0 and 1 (verified).
- **The DMSP is not 'graded' in peer review** (25c), and the NIH 2024
  Public Access Policy is missing.

### Finding 27. Many infrastructure recipes do not work as written

From the data-science reviewer, most verified by running them.

- **The PDF prints `&#96;` literally** wherever inline code was
  escaped (07:330, 11:156, 11:588-595, 12:615; verified with
  `pdftotext` on the 2026-10-09 PDF).
- **`quarto convert paper.Rmd -o paper.qmd` writes a Jupyter
  notebook** (12; verified, Quarto 1.10.18).
- **`tinytest::test_all()` exits 0 on failure**, so both CI workflows
  in 20 and 20b stay green when tests fail (verified); 20b never
  installs Quarto.
- **`renv.lock merge=ours` does nothing without a driver, and with one
  silently discards the collaborator's lockfile; `--theirs` inverts
  under rebase** (05b; verified in a throwaway repository).
- **A popped stash cannot be recovered from the reflog** (05;
  verified); reflog expiry for unreachable entries is 30 days.
- **The zzcollab chapter does not match the zzcollab repository**: no
  `modeling` or `shiny` profile, a different bundle schema, no
  `make render`, and `make check-renv` edits `DESCRIPTION` rather than
  auditing (inspected against `templates/bundles.yaml` and the
  Makefile).
- **Docker** (`version =` argument, `rmarkdown::render()` on `.qmd`,
  mismatched mounts, no `.dockerignore`), **renv** (snapshot type,
  sandbox, static dependency discovery), and **freeze** (per document,
  not default, ignored on single-file render) defects, as already
  recorded in Finding 17, were independently confirmed.

### Finding 28. Security and currency gaps for an industry hire

- **Security advice:** a public dotfiles repository as 'the modern
  standard' (04); IAM users with long-lived keys rather than SSO and
  instance roles (06); RStudio exposed on all interfaces with a
  literal password (09); a committed database password (09); `.gitignore`
  that omits `.Renviron`; no secrets management, no parameterized SQL
  (15b), and no LLM data governance anywhere (Finding 24).
- **Absent in late 2026** (verified by search): devcontainers and
  Codespaces, pre-commit, keyring or secrets managers, DuckDB and
  Parquet as defaults, Posit Package Manager dated snapshots, uv,
  supply-chain basics (pinning Actions by SHA, `permissions:`, OIDC),
  Positron as a primary IDE, SLURM batch scripts and job arrays.
- **Industry content absent** (pharma reviewer): MMRM and
  reference-based multiple imputation; group-sequential designs and
  DMCs; multiplicity procedures; safety analyses (TEAE, MedDRA);
  Define-XML, Pinnacle 21; TLF shells and double programming; GxP,
  21 CFR Part 11, validation of R (R Validation Hub, `riskmetric`);
  the R Consortium submission pilots; `rtables`/`tern`, `Tplyr`,
  `gtsummary`.
- **Academic content absent:** the ASA Ethical Guidelines (2022),
  Belmont and the revised Common Rule, research misconduct and
  questionable research practices, causal-inference foundations (DAGs,
  target-trial emulation; Hernán 2018), Gamble et al. (2017) for SAPs,
  TRIPOD+AI for the ADNI prediction model, CONSORT and SPIRIT 2025,
  `pointblank` or `validate` for data validation.

### Finding 29. In-house tools are positioned as requirements

All three reviewers raised this independently. Mention counts:
zzcollab 68, zztable1 20, zzlongplot 18, zzpower 15 (verified). None
is on CRAN. Learning objectives require `zzpower` (18:49); `zzc
analysis` is called 'non-negotiable' (23:585-587); `zzrenvcheck` is
placed ahead of `renv::status()` (08); the test framework follows
from what zzcollab ships (20:82-84); `theme = 'fda'` implies an FDA
figure standard that does not exist (24). Appendix E's disclosure is
commendable but does not offset the positioning. Industry uses `pwr`,
`rpact`, `gsDesign`, `gtsummary`, `rtables`, `ggsurvfit`, and renv
with Docker. This strengthens house rule 10 and decision 5 in Part 11
and extends decision 5 to all `zz*` packages.

### Finding 30. Scholarship and positioning

- **Reproducibility scholarship is thin** (01): Duke and Potti
  (Baggerly and Coombes 2009), Reinhart-Rogoff (Herndon, Ash and
  Pollin 2014), and NASEM (2019) are absent (verified by search);
  'inferential reproducibility' is narrowed; data-sharing mandates are
  conflated with computational reproducibility.
- **Comparator texts are not cited** (verified by search): Alexander,
  *Telling Stories with Data* (the closest competitor), The Turing
  Way, OpenIntro, Data Science in a Box.
- **Chapters 13 to 16 largely restate R4DS 2e** with the same
  dataset. The academic reviewer recommends pointing to R4DS for verb
  tours and keeping only the clinical-judgment layer, which is the
  book's distinctive contribution.
- **Prerequisites and pacing are inconsistent:** the preface asks for
  undergraduate statistics while `00-intro` assumes GLMs and survival
  analysis, which first-year students are learning concurrently; 35
  chapters at two per week is 17.5 weeks, not a quarter.

**What the reviewers would keep.** The 'statistician's contribution'
framing, the analysis-diff review checklist (05b), the semantic-
conflict callout, `git bisect run` with an assertion, 12b as a whole,
the '500 rows proves nothing' callout, the structural-versus-
correctness testing distinction (20), the tag-versus-digest callout
(09), the 'you cannot test MAR' callout, precise versus inconclusive
nulls and the response-to-reviewers material (25b), the
overlapping-interval demonstration and Obermeyer case (25d),
GitHub-versus-Zenodo (25c), SAP tag provenance, and the honest
disclosures in 21 and appendix E. Several of these ('statistician's
contribution') are sections the readability findings proposed to
fold away; Part 4 keeps their content and moves it, and the plan
should take care not to lose it.

### Finding 31. Few figures and tables, and long unbroken prose where there is no code

*Added 2026-10-09. Measured from source with
`scratchpad/vis/vis.awk`; counts are verified, the thresholds are a
working heuristic.*

**The finding.** The book breaks up its text often enough where there
is code, but it rarely uses figures or tables, and where code is
absent (every chapter's opening and the conceptual chapters) readers
meet long stretches of unbroken prose. Specifically:

1. About 21 computed figures with figure labels, concentrated in six
   chapters (13, 16, 17, 19, 23, 25d); most other chapters have one
   mermaid diagram as their only image.
2. About 17 tables in the whole book, although its content is full of
   comparisons, defaults, and checklists.
3. In 15 chapters the longest unbroken prose run begins within the
   first 20 source lines: the opening scaffolding runs 700 to 1,300
   words (four to six minutes) before the first code block or figure.
4. The conceptual chapters are the most text-heavy.

| Chapter | Prose words per visual element | Longest run (words) | Run starts at |
|---|---|---|---|
| 25b-communicating | 902 | 2,657 | 467 (null results, reviewers) |
| 03-team-science | 989 | 1,531 | 433 (portfolio, communication) |
| 18-analysis-plan | 326 | 1,325 | 21 (opening) |
| 05b-git-teams | 218 | 1,236 | 659 (LLM section) |
| 01-why | 735 | 1,210 | 154 (anatomy, failure modes) |
| 25c-federal | 744 | 1,208 | 19 (opening) |
| 17-missing | 178 | 1,152 | 627 (reporting) |
| 12b-acquisition | 269 | 1,105 | 19 (opening) |
| 25d-ethics | 369 | 1,078 | 19 (opening) |
| 10-zzcollab | 291 | 1,070 | 394 (bundles) |
| 00-intro | 1,556 | 918 | 158 |
| 25-synthesis | 693 | 889 | 146 |
| Data chapters (13, 14, 15, 16, 20, 22, 23) | 83 to 138 | 506 to 857 | mostly the opening |

*Method and limits.* Visual elements are computed figures (labeled
figures in executed chunks), mermaid diagrams, images, pipe tables,
executed and display code blocks, and callouts. Prose words exclude
code, tables, headings, and fenced-div markers. Counting callouts and
display-only code as breaks flatters the infrastructure chapters;
unlabeled solution plots are not counted as figures (the September
scan found 27 technical figures); output printed by executed chunks is
not measured. There is no controlled evidence for a specific
visual-density threshold. The rule proposed below (house rule 15) is
an editing heuristic consistent with the NN/g scanning findings and
the segmenting principle, not an evidence-based target.

**Relation to Findings 3 and 11.** Finding 3 counted figures; Finding
11 described the scaffolded openings. This finding measures the
spacing of visual breaks, which is how readers experience both, and
adds two points neither covered: the near-absence of tables, and the
specific text-heavy stretches.

**The fix is a list, not placeholders.** Empty placeholder tables or
figures inserted into the chapters were considered and rejected: the
book renders and deploys from `main`, so placeholders would eventually
ship, and inserting slots at a fixed interval produces graphics for
their own sake, which Part 9 forbids. Instead, the candidates below are
each tied to source material that already exists in the chapter. Most
are conversions of prose that is already structured as a list or
comparison; none requires new analysis except where noted.

*Key.* **Type:** T, table converted from existing prose; F, figure
from existing or small new executable code; B, before-and-after pair;
D, diagram; C, cut instead of illustrate. **Status:** Ready, can be
done now from existing content; After E1, depends on a Tier 1
correction (Part 6); After F, depends on the template or habit list
(Phase F); Verify, contains dated or expert-knowledge facts to check
against primary sources first.

| Chapter:lines | Type | Candidate | Source content | Status |
|---|---|---|---|---|
| 00:37-108 | T | 'The book in one table': part, the question it answers, key tools; placed beside `fig-book-map` | Eight paragraphs describing Parts I to VIII | Ready |
| 00:218-232 | T | Four-step reading method: step, what you do, why it works | Numbered list | Ready |
| 00:248-274 | T | Chapter anatomy: element, purpose, where to find it | Twelve-item list; rewrite after the template changes | After F |
| 01:96-105 | T | Kinds of reproducibility: what is held fixed, what varies, example | Three-item list (correct the 'inferential' definition per Finding 30) | Ready |
| 01:176-178 | T | What breaks without each leg of the stool | Three-line list | Ready |
| 01:186-214 | T | Five failure modes: how each shows up, which tool catches it, which chapter teaches the tool | Five bold-led paragraphs; also the natural place to name the motto | Ready |
| 01:225-236 | T | Cost-benefit scenarios: event, cost without a compendium, cost with one | Three numbered scenarios | Ready |
| 01 (new) | F | Output of the 'break it, then fix it' script run twice | Proposed in Part 7 | After G |
| 03:122-188 | T | Collaboration spectrum: mode, statistician's role, authorship expectation | Section prose | Ready |
| 03:195-222 | T | Authorship scenarios against ICMJE criteria; separate CRediT roles from ICMJE eligibility | Criteria list and scenario list | Ready |
| 03:315-327 | T | Scope-of-work template: element, what to write, example | Six bold-led items | Ready |
| 03:335-460 | T | A sample project portfolio: project, stage, next deliverable, hours | Portfolio section; breaks the 1,531-word run | Ready |
| 03:461-497 | C | Move results communication to 25b | Duplicates 25b | Ready |
| 03:95-102, 499-524 | T | Disagreement tiers: preference, best practice, validity, and the response to each | Two overlapping sections, merged | Ready |
| 03:534-566 | T | The intake document rendered as a filled form | Worked example; remove the immortal-time bias first | After E1 |
| 18:57-133 | C | Cut the duplicated Orientation and contribution prose | Opening run of 1,325 words | Ready |
| 18:135-153 | F | Simulated false-positive rate as analytic choices multiply | 'Researcher degrees of freedom' argument; a small new simulation | Ready |
| 18:169-204 | T | SAP sections: contents, ICH E9 or Gamble et al. (2017) counterpart | Thirteen-item '243B' list | After E1 |
| 18:302-315 | T | Pre-specified versus exploratory, side by side | Two parallel lists | Ready |
| 18:520-530 | F | Power curve for the HF-HOME design marking 750 and 1,094 per arm | Worked SAP; turns the defect into a lesson | After E1 |
| 25:37-85 | C/D | Replace the eight-part recap with `fig-book-map`, every part checked off | Recap list | Ready |
| 25:149-169 | T | The numbered habits: habit, chapter, failure it prevents | Seven-item habit list (reconcile with the map) | After F |
| 25:217-251 | T | Reading list by year: title, why | Twelve-item list | Ready |
| 25b:128-174 | T | And/but/therefore skeleton filled in for HF-HOME | Narrative-arc section | After E1 |
| 25b:217-227 | B | Annotated memo: the five parts labeled on a real memo | Five-item memo structure | After E1 |
| 25b:235-315 | F | Estimate and interval for the primary and each sensitivity analysis | Existing memo chunks, once the denominator is fixed | After E1 |
| 25b:428-496 | F | Four interval patterns against zero and the MCID: precise null, inconclusive, benefit, harm | Null-results section; synthetic numbers; breaks the 2,657-word run | Ready |
| 25b:497-611 | T | Three reviewer comments: concede or defend, response, change made | Three worked responses | After E1 |
| 25b:612-629 | T | Peer-review checklist | Six-question list | Ready |
| 25b (new) | B | Chronological versus answer-first memo, side by side | Described, never shown (Part 7) | After E1 |
| 25c:124-147, 197-205 | T | Policy 'as of' table: agency, requirement, effective date, source, date verified | Nelson memo and agency lists | Verify |
| 25c:157-171 | T | DMSP elements: what to write, HF-HOME example | Six-element list | After E1 |
| 25c:180-187 | T | Data type, PHI status, appropriate repository, access mode | Data-type list; corrected repositories | After E1 |
| 25c:253-294 | T | GitHub versus Zenodo versus domain repository: DOI, permanence, access control | Two repository lists | Ready |
| 25d:563-569 | T | Move the existing 'where each failure is caught' table to the opening as an advance organizer | Existing table | Ready |
| 25d:148-157, 495-507 | T | Aggregation and representativeness checklists | Two three-item lists | Ready |
| 05b:509-550 | T | Analysis-diff review checklist as a table | Existing checklist | Ready |
| 05b:339-371 | B | Conflict before and after resolution, with row counts | Conflict example, once rebuilt | After E1 |
| 05b:665-718 | C | LLM section reduced to one callout (4.6) | Source of the 1,236-word run | After F |
| 12:543-567 | T | Rendering failures: error message, cause, fix | 'Common rendering failures' | Ready |
| 12:166-178 | T | R Markdown versus Quarto differences | Four-item list (remove the `quarto convert` claim) | After E1 |
| 12b:72-99 | T | Source type (file, interface, scrape): risk, how to freeze it | Opening taxonomy; breaks the opening run | Ready |
| 12b:277-303 | T | Import checklist: pathology, symptom, detection, fix | Five pathologies | Ready |
| 16:115-135 | B | Bar of means versus points with summaries, same data | Bar-chart paragraph | Ready |
| 16 (new) | T | Figure checklist: claim, channel, distribution, uncertainty, theme, export | 'Statistician's contribution' wall (96-160) | Ready |
| 17:142-172 | D | The three mechanisms as small graphs (what missingness depends on) | Mechanism table, corrected | After E1 |
| 17:627-643 | T | Reporting standards: guideline, item, what to report | Reporting section (item numbers per Part 6) | Verify |
| 17:886-945 | F | Bias and coverage of complete-case and MI from the rerun simulation | Solution 2 | After E1 |
| 20b (new) | B | A red CI log excerpt, annotated: where the first error is | Described in 245-249 | After E1 |
| 21:202-257 | T | LLM failure catalog: failure, example, check that catches it | Nine bold-led modes | Ready |
| 21:337-351 | D | The four Cs as a loop | Verify-first workflow | After F |
| 22:549-578 | T | Defaults that differ: reference level, coding, covariance, censoring, date epoch | Reference-coding callout and scattered notes | After E1 |
| 22:582-626 | B | Annotated SAS log: ERROR, WARNING, the NOTE that matters | Log-reading section | Ready |
| 06:204-249, 407-408 | T | Compute options and costs 'as of' a date | Service catalog and prices | Verify |
| All chapters | D | Recurring pipeline diagram with the chapter's layer highlighted (4.5) | New | After F |

The 'Ready' items, about 30 of the 54, can be done immediately and
independently of every other phase; a handful in the heaviest chapters
(01:186-214, 03:499-524, 12b:72-99, 25b:428-496, 25d:563-569) would
remove most of the worst runs on their own. The rest are scheduled
with the phase they depend on (Part 8).

### Finding 32. Coverage gaps against comparable courses, books, and current practice

*Added 2026-10-10.* A worldwide sweep of comparable courses, textbooks,
and recent regulatory and professional sources found that the book is
ahead of most peers on AI-assisted coding and covers the core tooling
well, but lacks several foundational practice topics that most peers
teach (writing and debugging functions, analysis code as a package,
publication tables), carries five citations superseded in 2025 and
2026, and has no treatment of regulated-industry computing (21 CFR
Part 11, ICH E6(R3), package validation, run logging). The evidence,
gap table, and proposed additions are in Part 13.

---

## Part 3. House rules for the readability refactor

These rules translate the literature into decisions an editor can
apply mechanically. The evidence strength for each is given in
brackets.

1. **Motivation before structure** [moderate]. The first thing under
   the chapter title is either a three-to-six-sentence problem (a
   person, a failure, a consequence) or a direct statement of what the
   chapter will let the reader do (4.1). Metadata moves to the end or
   to an instructor guide.
2. **Direct, precise, unhedged** [moderate]. Remove 'we would
   argue/urge/stress/note' and 'it appears' in every case. The
   author's voice is otherwise kept; instructions, exercises, and
   callouts address the reader as 'you' (Part 11, decision 1).
3. **Define on first use, link to the glossary** [consensus]. Every
   bold term links to its glossary anchor. Every acronym is expanded at
   its first use in each chapter, not only in the book.
4. **One idea per paragraph, conclusion first** [strong for
   usability]. Any paragraph over about 10 source lines is split or
   converted to a list or table.
5. **Execute every example that claims an output** [book's own
   principle]. No hand-typed `#>` lines in executed chunks. Display-only
   code is allowed only where execution is impossible (cloud, SAS,
   interactive Git) or would mutate the book's own build (Phase C), and
   it is then labeled as such; where possible, a self-contained toy
   project shows real output instead (Phase E2).
6. **Retrieval after every major section, with feedback** [strong].
   Use one or two short questions in a collapsed callout directly after
   the section, not at the end of the chapter. Multiple-choice
   distractors target named misconceptions.
7. **Exercise ladder in every chapter** [strong for novices]. One
   faded example and two or three closed exercises with adjacent keys,
   placed at the ends of the sections they exercise (4.1); then, at
   the chapter end, one cumulative exercise that reuses an earlier
   chapter and at most one open 'on your own work' exercise.
8. **At most two callouts per screen, from a fixed set of four**
   [consensus]. The set is listed in Part 4. No callout may carry prose
   that belongs in the body.
9. **Perishable facts live in dated tables** [consensus]. Prices, IDs,
   versions, policy deadlines, and API names go in one 'As of
   YYYY-MM-DD' box per chapter or in an appendix.
10. **Tool-neutral first, in-house tools second** [consensus]. Each
    concept is taught with the general tool. `zz*` packages appear as
    'one way to automate this', always beside the portable
    alternative. This makes the claim in appendix E true. It is the
    minimum under either answer to Part 11, decision 5.
11. **Name the silent-failure rule once and point back to it**
    [consensus; serves spacing]. See 4.4.
12. **Pilot before publishing** [consensus]. Every rewritten chapter
    is read by at least two students from the target audience before
    it is considered done.
13. **One source for every running-example number** [book's own
    principle; Finding 25]. Every figure quoted about HF-HOME or the
    running study is computed from one canonical SAP and dataset, never
    retyped in a second chapter.
14. **Statistical and compliance claims get a second reader**
    [Findings 25, 26]. Any change to 02b, 17, 18, 19, 22, 24, or 25c is
    read by a biostatistician or a compliance colleague other than the
    author before it ships.
15. **Visual spacing** [heuristic; Finding 31]. Aim for at least one
    figure or table per about 400 prose words and no unbroken prose run
    over about 600 words. Meet it by converting existing structured
    prose, by showing output that already exists, or by cutting; never
    by adding a graphic for its own sake.

---

## Part 4. Redesigned chapter template

### 4.1 Template

The proposal reduces the repeated scaffolding from about nine sections
to five fixed elements, and moves the rest into the body or out of the
student-facing text.

| Order | Element | Replaces | Notes |
|---|---|---|---|
| 1 | **Opening** (no heading, 3 to 6 sentences): either a story (a person, a silent failure, a consequence) or a direct payoff statement ('Understanding X will let you: ...' with three bullets, the *Advanced R* opener) | Epigraph position, Sources, 'Why this chapter exists' | Keep the epigraph after the opening if wanted |
| 2 | **Chapter card**: time to read, 'You'll need' (prerequisite chapters and the `library()` calls), 'You'll be able to' (3 to 4 objectives with measurable verbs), and an **Outline** (one linked bullet per major section) | Learning objectives (4 to 7), Prerequisites prose | Bypass quiz stays, collapsed, with 'if these answers come quickly, skip to the next chapter' |
| 3 | **Body**, organized as a few numbered `##` sections with `###` subsections; each major section ends with a 'Check' callout and its own **Exercises** subsection | Orientation, Statistician's contribution, end-of-chapter CYU, end-of-chapter exercises | Statistician's contribution is folded into the sections where each judgment arises |
| 4 | **Rules of thumb** (3 or fewer, each numbered against the book-wide list) | Principle in use | See 4.3 |
| 5 | **Cumulative practice** (one mixed exercise reusing an earlier chapter, at most one open 'own work' exercise), a one-page **cheat sheet**, and Further reading cut to 3 items | Exercises, quiz answers at the end | Cheat sheets also collected in an appendix |

*Exercises live at the section, not the chapter end.* *Advanced R*
closes every major section with its own numbered exercise block (3 to
9 items; 33 across six sections of its functions chapter), some with a
'(Hint: ...)' scaffold. Placing practice immediately after the material
it exercises serves segmenting and spacing better than a single
end-of-chapter set, and hints are the cheapest form of fading. Short
keys stay adjacent in collapsed blocks; long model answers go to the
solutions companion (5.6).

*Asides go to margin footnotes, not callouts.* *Advanced R* uses no
callout boxes at all; history, version notes, terminology, and side
remarks are numbered footnotes. Set `reference-location: margin` in
`_quarto.yml` (margin notes in HTML, ordinary footnotes in PDF) and
move version-specific remarks, provenance notes, and tangents there.
Together with the four-callout limit in 4.2, this is the main
mechanism for clearing the reading path (Findings 11 and 19).

*Numbered, nested sections.* The chapters are currently flat: in
`13-wrangling` every heading, including each 'Check your
understanding', is a `##`. Group subsections under fewer `##`
headings, so the sidebar is scannable and cross-references can point to
a subsection ('as in Section 13.3.2') as *Advanced R* does throughout.

LLM material becomes one small 'LLM prompt' callout placed beside the
task it supports, rather than a section. Material that only explains
the book's design (peer survey, curriculum parity, Sources) moves to a
new *Instructor Guide* appendix or to `D-peer-survey`.

### 4.2 Callout set

Use exactly four types, and update `conventions.qmd` to match.

| Callout | Quarto type | Purpose | Frequency |
|---|---|---|---|
| **Check** | note, collapsed | Retrieval question with explained answer | After each major section |
| **Verification** | tip | A concrete command the reader runs to confirm success | After each worked example |
| **Pitfall** | warning | A silent failure students have actually hit | One to three per chapter |
| **LLM prompt** | important | A prompt plus the check that verifies its output | Zero to two per chapter |

Solutions use collapsed blocks inside the exercise, not a callout type.

### 4.3 A short, numbered list of habits

Replace the more than 100 'Principle in use' habits with a book-wide
list of about twelve numbered habits. Each chapter's 'Rules of thumb'
cites the numbers it exercises ('Habit 4: count before and after every
join'). The list is printed in the introduction, in the synthesis
chapter, and on a tear-out card. The draft below is assembled from
rules the book already states.

1. Raw data are evidence; derived data are a build product.
2. Every number in the prose is computed.
3. Snapshot writes, restore reads; pin the environment.
4. Count before and after every join; declare the relationship.
5. Convert late, validate early (types, factors, dates).
6. A bug that produces `NA` is cheap; a bug that produces a plausible
   number is expensive. Write the assertion.
7. Test the statistics, not the shape.
8. Stale results are worse than slow ones; let the pipeline decide
   what to rebuild.
9. Pre-specify, then tag the commit before you see the outcome.
10. Hosting is not archiving.
11. Lead with the answer; match the verb to the design.
12. Send the model structure, not data; verify what it wrote. Your confidence measures its
    readability, not its correctness.

### 4.4 The book's motto

Name the through-idea once, in chapter 1, and refer back to it by name:
**'Make silent failures loud.'** Each chapter's opening story is an
instance of a silent failure. Each Pitfall callout names the failure.
Each Verification callout is the mechanism that makes it loud. The
synthesis chapter closes the loop. The phrase is close to the book's
existing language (14:563-565, 10b:69, 11:315, 12:249, 12b:117), so it
is a naming exercise, not new content.

### 4.5 A recurring visual grammar

*Advanced R*'s most transferable device is a single diagram language
used across chapters: in its 'Names and values' chapter, 21 diagrams
share one grammar (names as rounded boxes, arrows to values, explained
conventions for color and dotted lines), which the next chapter
extends, and each major section opens with a small summary tree showing
where the topic sits. The *Practicum* has about one mermaid diagram per
chapter, each in its own style.

Adopt one recurring diagram: the project pipeline from raw data to
report, layered with the Five Pillars (raw data, code, environment,
document, archive). It appears at the top of each chapter with the
layer the chapter addresses highlighted, and grows as the book
proceeds. This is dual coding of the book's structure and a
'you are here' marker for readers who enter mid-book. Each instance
carries `fig-alt` text, which *Advanced R* omits.

### 4.6 The LLM callouts (responds to Finding 24)

**One protocol, taught once, applied everywhere.** Move the durable
core of `21-ai-coding` (the verify-first loop, failure modes, data
governance, agentic practice) into Part II, so that the protocol is
learned before the first chapter that uses it (Part 11, decision 11).
Give it a memorable name. A proposal, the four Cs:

1. **Context.** Give the model what a colleague would need: the data
   dictionary or schema, the relevant SAP section, the house style.
   Send structure, not data.
2. **Constraints.** State packages, idioms, and prohibitions ('use
   `relationship =` on every join; do not modify `data/raw/`; no
   new dependencies').
3. **Criteria.** Write the acceptance check *before* asking: the
   assertion, the test, the expected row count, the number the
   rendered document must reproduce. Ask the model to list its
   assumptions and to ask questions before writing code.
4. **Check.** Run the criteria; read the diff; for anything that will
   be reported, re-derive it independently (a fresh session, a second
   model, or by hand). Log the model, date, and prompt.

**Rules stated once in 21 and referenced by every callout.**

- *Data governance.* Schemas, summaries, and synthetic rows may go to
  any approved tool. PHI, DUA-restricted data (ADNI), and proprietary
  sponsor code go only to an institution-approved deployment under
  the governing agreement, and in many cases nowhere. Check the DUA.
- *Agent safety.* Commit or branch before an agent edits the
  repository; run agents with the least permission that works; never
  give an agent production credentials or cloud keys; treat text the
  agent reads from downloaded files, web pages, and issues as
  untrusted (prompt injection); verify that any package an agent
  proposes actually exists on CRAN or PyPI before installing it
  (hallucinated package names are registered by attackers).
- *Tests are off-limits.* An agent asked to make tests pass may weaken
  or delete them. Review every change to `inst/tinytest/` separately,
  or forbid it in the instruction file.
- *Project instruction file.* Ship an `AGENTS.md` (or `CLAUDE.md`) in
  the running-study repository that encodes the numbered habits. It
  is the book's habits made machine-readable, and it is the single
  highest-leverage step a student can take.
- *Provenance and disclosure.* Record model, date, and prompt for any
  LLM-produced code or text that reaches a deliverable; follow the
  journal's AI-disclosure policy; an AI is never an author.
- *Live documentation.* Prefer tools that give the model the
  installed package documentation and the R session (the `btw`
  package, MCP servers) over relying on its training data.

**Per-chapter format.** Replace each three-prompt section with one or
two 'LLM prompt' callouts placed beside the task they support. Each
contains a fully specified prompt (context, constraints, criteria),
the chapter-specific failure mode, and a check that is executable,
ideally the chapter's own Verification callout. Delete the formula
opener ('LLMs handle X well; the trap is Y') and every 'the LLM should
know this'. At least three chapters (13, 15, 20) show an agentic
version: the agent runs the code and the student reviews evidence.

**Chapter actions for the LLM callouts.** 'Keep' means retain as an
exemplar of the new format after conversion.

| Chapter | Keep | Fix or replace | Add |
|---|---|---|---|
| 01 | Prompt 1 (audit a script) | Let an agent run the script in a clean container rather than guess | Provenance habit introduced here |
| 02b | Prompt 1 | Prompt 2 inherits the Safe Harbor mislabeling (Part 6) | Data-governance rule introduced here: send the schema, never the rows |
| 03 | Prompt 2 (red flags) | Prompt 3 title says ICMJE, body asks CRediT | A planted-flag request with a model answer |
| 04 | none | 'Stale `.Rhistory`' is not a common startup cause; a restored `.RData` is | Ask the agent to verify an install with `R --version`, `quarto check` |
| 04b | Both | none | 'Echo before rm' as a standing agent instruction |
| 05 | Prompt 3 (reflog first) | none | Commit before any agent session |
| 05b | Prompt 3 (force push, revert) | Prompt 1's verification depends on the defective conflict example | none |
| 06 | Prompt 2 (failure handling) | Prices and AMIs from the model are stale by construction | Never paste or expose keys; budgets and alarms before an agent provisions anything |
| 07 | none | Prompt 1 must require a commit first and forbid moving `data/raw/` | none |
| 08, 09 | Layer-order checks | Pinned `rocker/r-ver:4.4.0` in prompts; no digest pinning | `.dockerignore`, digest pinning in the criteria |
| 10 | none | 'zzcollab-compliant', `zzc analysis`, and the bundle schema are wrong against the current repository | Tool-neutral Five Pillars audit |
| 10b | Both | none | none |
| 11 | Prompt 1 (inline numbers) | none | Criterion: change the data, re-render, numbers change |
| 12 | none | Conversion prompts must not suggest `quarto convert` for Rmd | none |
| 12b | All three | none | Treat scraped content as untrusted input to an agent |
| 13 | Prompt 1 | Send the column names and a synthetic row, not five real rows | Agentic version on the running study |
| 14 | Prompt 3 | Prompt 1 calls `parse_date_time()` with multiple orders 'canonical' without warning that ambiguous orders (dd/mm vs mm/dd) silently misparse; that is the chapter's own silent failure | none |
| 15 | Prompt 3 | Add `unmatched = "error"` beside `relationship =` | Agentic version with the join checklist as criteria |
| 15b | Prompt 1 | none | Parameterized queries; never paste credentials or connection strings |
| 16 | Prompt 1 | Prompt 2 steers away from `plot_annotation(tag_levels = "A")`, the idiomatic choice | none |
| 17 | Prompt 1 | Prompt 3 should require named sensitivity analyses (delta, reference-based) | none |
| 18 | Prompt 2 | Prompt 3 verifies against `zzpower`; use `power.prop.test`, `pwr`, or `rpact`, and note that the chapter's own SAP is underpowered | Estimand attributes as criteria |
| 19 | Prompt 2 | Convert tip callout to the standard format | Independent re-derivation as the AI analogue of double programming |
| 20 | Prompt 1 (bug injection) | Name it mutation testing | Agents weakening tests; the tests-off-limits rule |
| 21 | 'Vibe coding' versus agentic coding; 'when not to' | `chat_claude()` is superseded by `chat_anthropic()`; `chat_async(stream = TRUE)` is not the ellmer API; `cor()` default is not pairwise; hard-coded model ID; CLI list omits Codex CLI, Gemini CLI, Positron Assistant | The four Cs; governance; agent safety; instruction files; `btw`/MCP; provenance and disclosure; move core to Part II |
| 22 | Prompt 1 (flag every NOTE) | Prompt 2 censoring sentence is garbled | none |
| 23 | Prompt 3 | Prompt 2 proposes imputing sex 'from sex-specific distributions', which is circular | none |
| 24 | Prompt 1 (dropouts) | Prompt 3's '30% missing on a predictor: complete case is bad' contradicts the corrected theory in 17; DUA warning missing | Check the DUA before sending anything |
| 25b, 25d | All | none | Use as the model for the rewrite |
| 25c | Prompt 2 | Prompt 3 steers toward dbGaP and TCIA, compounding the PHI-deposit error (Part 6) | none |

---

## Part 5. Book-level restructuring

### 5.1 A running study

Create one synthetic study, distributed as a small data package or
companion repository and generated by a seeded script, that every
chapter from 01 to the capstone uses. The book already contains its
pieces: the heart-failure PI in `03`, the readmissions cohort in 05 to
09, the HF-HOME trial in `25b`, the CRF extracts in `12b`, the dosing
strings in `14`, and the ADSL/ADTTE build in `19`. Consolidate them into
one study (provisionally HF-HOME). Its foundation is the single
canonical SAP that Phase E1 produces (Finding 25, house rule 13):
the current HF-HOME material contradicts itself across 03, 18, and
25b, and a running study built on it would spread those
contradictions to every chapter. It would include the following.

- A messy CRF export with the planted file pathologies of 12b (BOM,
  leading zeros, mixed date formats, empty strings).
- Demographics, visits, labs (with a duplicate visit that breaks a
  naive join), dosing strings, and dropout.
- An SDTM-like layer and the ADaM build in 19, exported as `.xpt` for
  the SAS chapter.
- A small set of identifiers for de-identification exercises.
- A recurring cast: the PI, a co-analyst who causes the merge
  conflict, and a reviewer.

Penguins remains as the warm-up dataset where a non-clinical example
reduces load (early ggplot2, the 23 capstone). ADNI remains the
real-data case study, with an executable synthetic stand-in.

Two consequences follow. First, exercises become checkable, because
everyone has the same data. Second, later chapters can say 'the join
you wrote in chapter 15', which is retrieval practice at no extra
cost.

### 5.2 Part order (adopted 2026-10-09, decision 3)

The current order puts infrastructure (Parts III and IV) before
students have any data to protect. R4DS, Data Science in a Box, and
Timbers and Cetinkaya-Rundel all argue for 'the whole game' first:
early, visible results with real data, then the machinery. A revised
order that also removes every forward dependency in Finding 18 is
shown below. It is a recommendation, not a requirement. The template
and the running study deliver most of the gain under either order.

| Part | Chapters (current file names) | Change |
|---|---|---|
| Start here | Preface for students; 00-intro rebuilt as a 'whole game' tour: clone the study repo, render a report, change one line, watch a number change silently, catch it | Instructor material moves to an Instructor Guide appendix |
| I. Why and with whom | 01-why; 03-team-science (trimmed); 02b concepts only | De-identification code moves after wrangling |
| II. Your toolkit | 04b-shell, then 04-workstation (essentials only), 05-git-solo, 05b-git-teams (renv conflicts deferred); the durable core of 21-ai-coding if decision 11 is accepted | Shell before workstation; AI protocol before first use |
| III. Data in hand | 12b split into two chapters; 13, 14, 15, 15b, 16, 17; 02b implementation section | Running study introduced in 12b |
| IV. Documents and environments | 11 merged with the troubleshooting half of 12; 08-renv; 09-docker; 07 merged into 10 as 'Assembling the compendium'; 10b-targets; 06-cloud and HPC | All dependencies resolved in order |
| V. Analysis practice | 18-analysis-plan plus the DMSP from 25c; 20-testing absorbing 20b-ci; 21-ai-coding (durable core, unless moved to Part II by decision 11) | Planning documents sit together |
| VI. Industry | 19-cdisc, 22-sas (adjacent, sharing ADaM data) | Removes two independent ADTTE builds |
| VII. Analysis to audience | 23-penguins (explicit map to chapters), 24-adni (executable), 25d-ethics (catalog), 25b-communicating | Ethics flags seeded earlier in their home chapters |
| VIII. Capstone | 25-synthesis rebuilt as a capstone project with a rubric | See 5.4 |
| Appendices | Cheat sheets; Tooling as of date; Instructor Guide; C, D, E, F | New appendices absorb perishable and reference material |

The net change in chapter count is small. Three merges (07 into 10,
20b into 20, part of 12 into 11) offset one split (12b). The 25c
deposition mechanics fold into the case studies.

### 5.3 Length targets

- 15 to 20 minutes of reading per chapter (3,000 to 4,000 words,
  including code).
- Chapters currently over 25 minutes are split or cut, with reference
  material moved out.
- Apply the cut list in Part 7 before adding anything. The target is
  a book about 15 percent shorter in words and longer in practice.

### 5.4 Capstone

Replace the recap with a project. Students take the running study from
raw CRF export to a deposited compendium with a SAP, tests, CI, a
one-page memo, and a reviewer response. The project has a rubric
indexed to the numbered habits. `23-penguins` serves as the worked
model, with each step labeled by the chapter that taught it. The
chapter ends by answering the question posed in `01-why`.

### 5.5 Part introductions (reopens a Part 9 rule)

Each part of *Advanced R* opens with a page of about 400 to 500 words:
one framing paragraph, a numbered one-line description of each
chapter, and the advice that a reader who can answer a chapter's quiz
may skip it. Part 9 of this plan forbids part-opener prose pages, on
the grounds that `fig-book-map` already orients and that few readers
proceed linearly. The *Advanced R* practice suggests the opposite
inference from the same premise: a reader who enters mid-book is
exactly the one who needs to know what each chapter assumes. A lighter
version (100 to 200 words, no images, the question the part answers,
one line per chapter, skip advice) is proposed as Part 11, decision 9.
The image prohibition is unaffected.

### 5.6 A solutions companion

*Advanced R Solutions* (Grosser, Bumann, and Wickham) is a separate
book whose numbering mirrors the main text, which keeps the main text
lean. Immediate feedback is better supported for novices, so short
keys stay adjacent to their exercises. The companion is for what has
no home today: full model answers to the memo, the reviewer response,
the DMSP, the SAP, and the capstone, with commentary on why each choice
was made. It is also a natural contribution route for teaching
assistants and former students (Part 11, decision 10).

### 5.7 Introduction and colophon

Two sections of the *Advanced R* introduction have no counterpart in
`00-intro`, which already has 'What this book does not cover':

- **Getting help**: where to ask, and how to write a minimal
  reproducible example with `reprex`. Every first-year student needs
  this, and it is an instance of the book's own thesis.
- **Meta-techniques**: the few habits that apply everywhere. This is
  the natural home for the numbered habit list (4.3) and the motto
  (4.4).

*Advanced R*'s colophon records the package versions used to build the
book. The *Practicum* colophon describes fonts and tools and states
that build reproducibility is managed through `renv` 'and a pinned
`zzcollab` Docker image'. The repository has no Dockerfile (Finding
10), and the lockfile has never been restored, so that sentence is
currently false (Part 6). Replace it with a statement generated at
render time from the lockfile or `sessionInfo()`, which makes the
colophon a demonstration of habit 2 rather than a claim.

### 5.8 Register model

*Advanced R* uses 'I' for the author, 'you' for the reader, and states
limits plainly ('R is not a particularly fast programming language').
It is informal in grammar and precise in content. It is the concrete
model for the middle course in Part 11, decision 1: the change is to
hedging and indirection, not to precision or academic standards.

### 5.9 What not to borrow from *Advanced R*

- **Empty alt text on diagrams.** The *Practicum* is ahead here.
- **No end-of-chapter summary.** That is acceptable for intermediate
  readers; novices benefit from Rules of thumb and a cheat sheet
  (expertise reversal).
- **Solutions only in a separate book.** Immediate feedback should come
  first for this audience.
- **CC BY-NC-SA.** The *Practicum* deliberately chose CC BY so that it
  qualifies as an open educational resource.

---

## Part 6. Correctness register

These are defects that a student would notice or reproduce. Fix them
before any stylistic work, because each one costs trust. The register
has four tables. The first holds defects that would cause harm or a
wrong professional decision if acted on; fix them before anything
else. The others are ordered by how they were established. Many
entries in the third table were later confirmed independently by the
expert reviewers; those are marked 'confirmed'.

**Tier 1: fix first (expert reviews; harm or wrong decision if acted on)**

| Location | Defect | Evidence |
|---|---|---|
| 25c:414-419, 180-183 | Model DMSP deposits PHI-containing CRFs in dbGaP and PHI imaging in TCIA; both accept de-identified data only | inspected |
| 02b:187-221, 258-286 | Date shifting and MRN hashing labeled Safe Harbor; Safe Harbor permits year only; a re-identification code may not be derived from an identifier | inspected; hashing point expert knowledge |
| 22:98-103 | 'FDA requires SAS-formatted deliverables'; FDA requires XPT transport files, not SAS | inspected |
| 17:78-80, 168-172, 346-350; 23:216-222, 729-738 | Complete-case analysis taught as biased under MAR; unbiased when missingness is independent of outcome given covariates; 'bounded by fraction lost' and the 5 percent rule unsupported | verified by simulation |
| 17:886-914 | `mice(seed = 1)` inside `replicate()` collapses 100 replicates to a few datasets; conclusions at 917-945 rest on it | verified |
| 18:520-530, 288-292 | Underpowered (1,094 per arm needed, not 750); attrition not applied (71, not 64); conditional OR called marginal; as-treated exposure; no estimand attributes; Bonferroni scheme lets FWER near 0.10 | verified (power, attrition) and inspected |
| 03, 18, 25b | HF-HOME inconsistent across chapters (size, power target, estimand, missingness); sensitivity code omits missing patients from denominator; reviewer response quotes 3.6 where code gives 3.8; immortal-time bias in the 03 intake | verified and inspected |
| 20:541, 20b:177 | `tinytest::test_all()` exits 0 on failure, so CI never fails | verified |
| PDF output (07:330, 11:156, 11:588-595, 12:615) | `&#96;` printed literally | verified with `pdftotext` |
| 21 (whole chapter) and every LLM section | No guidance on PHI, DUA-restricted, or proprietary data sent to LLMs; 19:565 encourages pasting SDTM | verified by search |
| 19:394, 420 | `1L - CNSR` silently fails for CNSR other than 0 or 1; use `CNSR == 0` | verified |

**Verified or inspected directly by the plan author**

| Location | Defect |
|---|---|
| 18:528-530 | 750 per arm for 80% power at p = 0.25 vs 0.20. `power.prop.test` gives 1,094 per arm; 750 gives 64% power (verified) |
| 14:520-523 | DST example: 2026 DST begins March 8, so `+ hours(24)` from March 9 crosses nothing. The frozen output prints `01:00:00` for both lines, contradicting the hand-written comment (inspected in `_freeze/`) |
| 05b:339-371 | 'Preserve both intents' resolution is identical to the incoming side, since `sbp <= 220` subsumes `<= 250`; the later LLM check (05b:685-686) relies on a difference that does not exist (inspected) |
| 17:169-171 | Mechanism table marks complete case 'Biased' under MAR; the chapter's own Solution 2 shows near-unbiasedness under covariate-dependent MAR (inspected) |
| 24:360 | Two-year follow-up threshold used to classify a three-year outcome, the bias the chapter condemns at 79-88 (inspected) |
| all chapters | Verification, Pitfall, and LLM-prompt callouts promised but unused (verified) |
| colophon.qmd | States build reproducibility is managed by `renv` and 'a pinned `zzcollab` Docker image'; no Dockerfile exists and the lockfile has never been restored (inspected; render failure observed 2026-10-09) |

**Inspected by one reader, to confirm during editing**

| Location | Defect |
|---|---|
| 04:367-369 | Says `install.packages()` updates `renv.lock`; it does not without `snapshot()` (confirmed) |
| 05b:460 | `renv.lock merge=ours` needs a driver configuration and contradicts 'do not pick a side'; `--theirs` inverts under rebase (confirmed by test) |
| 08:109-111, 143, 424-425 | Snapshot `type` misdescribed; sandbox called 'the cache'; `::` detection misdescribed (confirmed) |
| 09:220-221 | `install.packages(..., version =)` has no such argument (confirmed by test) |
| 07, 08, 09 | `rmarkdown::render()` on `.qmd`; Dockerfiles disagree and do not render Quarto; `rocker/r-ver` called Debian (confirmed) |
| 07:353-361 | `rticles` presented as Quarto formats; NEJM template claimed; propensity score called 'the exposure' (confirmed) |
| 11:411-422 | `freeze` described as per-chunk and as the default (confirmed by test) |
| 12:324-328, 423-427 | knitr chunk headers stripped from examples (confirmed) |
| 12b:485-486 | `as.numeric('')` yields `NA`, not 0 |
| 13:164-174 | Tidy-table example code references a column the table does not have |
| 15:483-520 | Worked example's final row-count assertion would fail on its own fixture |
| 16:438-441 vs 532, 750 | `theme_set()` called wrong, then used, then mandated |
| 18:288-292, 526-528, 711 | Attrition not applied; conditional OR called marginal; undefined `n_cluster_adj` |
| 19:196-198, 322 | SDTM dates described as ISO strings but built as `Date` |
| 20:35 vs 937-945 | Quiz question and answer name different functions |
| 21:222, 635 | `cor()` default is not pairwise; `filter` attributed to base |
| 22:327, 362, 574, 727, 864 | Nonexistent variable; 'five' introduces six; wrong reference level; MIXED/LOGISTIC label; garbled censoring sentence |
| 23:148-155, 341, 735 | Balance claim self-contradicts; hard-coded number after 'every number is computed'; MAR vs MCAR |
| 24:389-424, 517 | Object names never created; `vfold_cv(strata=)` used where grouped CV is needed |
| 25b:146 vs 258 | HF-HOME randomized 1,500 vs 2,706 patients; memo claims MI, code does not |
| 25-synthesis | Habit map and habit list disagree; 'Two appendices' when there are four |
| C:77-79 | `admiral` claimed to use `data.table` internally (likely false) |
| 25b, 25d, D | British spellings ('per cent', 'fortnightly', 'catalogues') that the `us-spelling` hook misses |

**Additional defects from the expert reviews and the LLM-section
review** (evidence as labeled by the reviewer: V verified, I inspected,
E expert knowledge)

| Location | Defect |
|---|---|
| 12:156-161, 241-247, 597, 736-739 | `quarto convert` does not convert Rmd to qmd; it wrote a Jupyter notebook (V) |
| 11:690 | Exercise 4 on `freeze` cannot succeed on a single-file render (V) |
| 20b | Workflow never installs Quarto; exercise names `publish.yml`, actual file is `render-book.yml` (V, E) |
| 05:624, 463 | Popped stash is not recoverable from the reflog (V); reflog expiry for unreachable entries is 30 days (I) |
| 05:481 | `echo "*.html\n*.pdf"` under bash writes one literal line (V); `.gitignore` omits `.Renviron` |
| 10 (throughout) | Profiles, bundle schema, `make` targets, and `check-renv` behavior do not match the current zzcollab repository; zzcollab does not 'compose rrtools' (I) |
| 04:448, 621; 06:213, 243; 09:296-301, 436 | Public dotfiles as standard; long-lived IAM keys; RStudio on all interfaces with a literal password; committed database password (I, E) |
| 06 | `pip install awscli` is CLI v1; region-specific AMI; shebang on line 2 and no `trap`; `t3.medium` not free tier; EBS cost overstated (E, I) |
| 04:160-165, 497, 265 | No `quarto:` pin key (it is `quarto-required`); cask name `font-jetbrains-mono`; R installed twice; bash completion sourced in zsh (E) |
| 10b:233, 304 | `CMD` runs at container run, not image build; no `tar_option_set(packages =)`; no `tar_quarto()` (I) |
| C:124-129, 142 | `dt[, x]` does return a vector (V); `melt(..., measure.vars = v1:v3)` errors (V) |
| 14:286-291, 202-203 | Factor joins match labels, not codes (V) |
| 14:116, 445-460 | `as.Date(45405)` is 2094, not 'year 124' (V); binomial intercept of 18.2 is an inverse-logit near 1 (V) |
| 03:471-476, 487-490 | p-value inconsistent with the stated interval (V); CI for a mean presented as an individual prediction (I) |
| 03:534-566 | Intake example has immortal-time bias, a causal verb, and 'Red flags noted: None' (I) |
| 17:635-643, 389-391 | CONSORT and STROBE item numbers misattributed; LOCF attribution to E9(R1) unconfirmed (E) |
| 17:614, 617-663 | Delta adjustment applied to both arms barely moves the contrast; regulators expect active-arm shift and a two-dimensional tipping point; edits `imp$imp` rather than using `post` (E, I) |
| 17 | Mean imputation and missing indicators for *baseline covariates in RCTs* are valid (White and Thompson 2005) but branded antipatterns (E) |
| 18:113-120 | Conditional HC1 is a pretest procedure; pre-specify HC3 (E) |
| 19:75-80, 104-111, 361, 690 | Roles (programmers build ADaM); mITT defined as safety set; analysis sets conflated with estimand population; `TRTEDT` from disposition; TRTEMFL incomplete (I, E) |
| 22:462-484, 506, 551, 596-608 | PROC MIXED example not equivalent to its R code; no MMRM; GENMOD default is PARAM=GLM; PHREG without CLASS errors; MERGE example implausible (V, I, E) |
| 24:356-372, 291, 429, 235 | Early converters who drop out excluded; ADNIMERGE not on public GitHub; `theme = 'fda'` implies a nonexistent standard; APOE4 risk understated (I, E) |
| 25c:174, 76-77 | DMSP not scored in peer review; NIH 2024 Public Access Policy missing (E) |
| 25d:295 | 'Roughly three times' is 2.2 times (V) |
| 23:63-64, 226, 557-561, 745-752 | iris baggage is eugenics, not colonialism (E); `na.omit` drops rows the model does not need (V); circular sex imputation (I); cross-sectional coefficient called an 'effect' (I) |
| 25b:7-10 | Whyte quotation misquoted (E) |
| 21:124, 134, 525 | `chat_claude()` superseded by `chat_anthropic()`; `chat_async(stream = TRUE)` not the ellmer API (V, ellmer 0.4.1); hard-coded model ID |
| 14 LLM prompt 1 | `parse_date_time()` with multiple orders recommended without the dd/mm vs mm/dd ambiguity warning (I) |
| 16 LLM prompt 2, 16:724 | Steers away from `plot_annotation(tag_levels = "A")` (I) |
| 04 LLM prompt 2 | 'Stale `.Rhistory`' is not a common startup cause; restored `.RData` is (E) |
| 24 LLM prompt 3 | 'Complete case is bad at 30 percent missing on a predictor' contradicts the corrected theory (I) |

---

## Part 7. Chapter actions

These are short directives that follow from the per-chapter readings.
'Cut' means move to an appendix or the Instructor Guide unless stated.

| Chapter | Open with | Cut or move | Add | Merge or reorder |
|---|---|---|---|---|
| preface | Three silent failures | Peer-curricula section to Instructor Guide | 'For students' page | Split students and instructors |
| 00-intro | A reviewer asks for a rerun six months later | Eight-part prose (use table + map) | Whole-game tour on the running study | Remove duplication with preface |
| 01-why | Duke/Potti or the three silent failures | Federal paragraph to a pointer | Break-it-then-fix-it script; failure-mode checklist | Name the motto here |
| 02b | Sweeney re-identification | R implementation to Part III | Correct Safe Harbor versus Expert Determination labeling (Tier 1); mnemonic for suppress/generalize/hash/shift; Limited Data Set with DUA; LLM data-governance rule | Concepts stay in Part I |
| 03 | The heart-failure PI's first email | Duplicate disagreement section; results communication to 25b | Scenario exercises with model answers | Recurring PI across chapters |
| 04 | Keep current hook | Fonts, tmux, starship to 'Level up' appendix | Per-OS tabs including WSL; 'Is my machine ready?' checklist | After 04b |
| 04b | A file with a planted BOM | None | Shipped `visits.csv`; solutions; shell-vs-R table | Before 04 |
| 05 | March vs November analyst | Two of three 'why' passes; `zzgit` | 'Oh no, I...' recovery table; conflict and detached-HEAD sections | None |
| 05b | Two analysts, 1,847 vs 1,912 rows | Meta callout; renv.lock conflicts to 08 | Fixed conflict example | Second person throughout |
| 06 | A job that ran out of memory | AWS catalog to glossary box; prices to dated table | Minimal SLURM `sbatch` example | After 09 |
| 07 + 10 | A collaborator gets a different p-value | rticles; zzcollab bundles and extension | Tool-neutral Five Pillars checklist; one canonical Dockerfile; any remaining zzcollab text rewritten against the current repository | Merge as 'Assembling the compendium' |
| 08 | Keep silent-regression hook | Dockerfile section to 09 | renv verbs card; P3M snapshots | None |
| 09 | Same code, different number | Compose to a pointer | Apple Silicon first; CI-tested Dockerfile | None |
| 10b | Table 2 from a stale intermediate | Peer-survey callout | Runnable pipeline with real `tar_make()` output; `tar_quarto()` | After 11 |
| 11 + 12 | A number typed into a sentence | YAML dump and website to reference | Runnable mini-project; freeze vs cache table; error/cause/fix table | Merge; retitle remainder 'Troubleshooting documents' |
| 12b | Keep current hook | Duplicate callout | Import checklist card | Split in two; owns the raw-data rule |
| 13 | The running study's CRF export | `stringsAsFactors`, `%>%` digressions; pandas to an aside | Exclusion counts at each filter; verbs card | Continues from 12b |
| 14 | Keep current hook | API tours to cheat sheet | Problem-then-verb vignettes on dosing data | None |
| 15 | Keep current hook | `rows_*` to an aside | Visible fixtures; join checklist reused in 15b and 18 | None |
| 15b | Credentials, not a CSV | Parity callout | SQL-to-dplyr card; same tables as 15 | None |
| 16 | Before/after makeover of a bar-of-means figure | DPI folklore; `zzlongplot` beside the portable alternative | Figure checklist | Trajectory figure as spine |
| 17 | A trial with dropout | LOD aside and reporting detail to 'going further' | Corrected complete-case theory and rerun simulation (Tier 1); mechanisms by story before notation; MMRM, reference-based MI, tipping point (Phase K) | Defer pre-specification to 18 |
| 18 | An outcome switch caught by audit | Duplicated Orientation | Canonical HF-HOME SAP with estimand attributes, corrected power, named multiplicity procedure (Tier 1); downloadable SAP skeleton; DMSP from 25c; Gamble et al. (2017) in place of '243B' | Planning documents together |
| 19 | Keep alumni hook, moved to top | Four of five CNSR restatements; Sources | ADaM variable card; define estimand | Adjacent to 22 |
| 20 + 20b | The 86,400-fold drift | testthat comparison to the end; duplicate worked example | Red CI log excerpt; offline exercises with keys | Merge |
| 21 | Keep thesis | ellmer and model strings to dated appendix; styler/lintr earlier | Executed planted-bug examples with assertions; the four Cs, governance, and agent safety (4.6) | Core to Part II if decision 11 is accepted; otherwise after 20 |
| 22 | Screening-stage exclusion | ODA click-path | Correct 'FDA requires SAS' (Tier 1); defaults-that-differ table; offline log-reading exercises; MMRM in both languages; R submission pilots | Reuse 19's ADaM |
| 23 | Keep framing | Literal `paper.qmd` | Step-to-chapter map; testing and CI steps | Worked model for capstone |
| 24 | A family asking 'will this progress?' | '243B' | Executable synthetic run; `gtsummary` alternatives | None |
| 25d | OkCupid scrape | Meta callout | Solutions; inline statistics | Ethics flags seeded in 02b, 12b, 16, 25b |
| 25b | 'So did it work?' email | Meta callout | Before/after rewrite of a chronological memo | Final act before capstone |
| 25c | DMSP due before the work begins | Dated policy to an 'as of' table; renv repetition | Filled DMSP for the study with de-identified deposit and appropriate repositories (Tier 1) | DMSP to 18; deposition to case studies |
| 25 | The question from 01-why | Recap and reading list | Capstone project with rubric; reconciled habit list | None |
| F | n/a | None | Links from every bold term; missing terms; A to Z order | None |

---

## Part 8. Phased plan

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
3. ~~For blocks that cannot execute, add a dated verification note
   stating how and when the command was checked.~~ **Revised
   2026-09-08.** Replaced with an automated check, for two reasons.

   A dated note is a claim about the past that decays from the moment
   it is written, and 60 of them across the book would be 60 assertions
   nobody re-checks. Worse, most could not be written honestly in the
   first place: verifying `renv::init()`, a `docker build`, or an AWS
   provisioning sequence means running it against a real project,
   daemon or account, and writing 'verified' beside a command nobody
   ran is the failure mode this whole plan exists to correct.

   What *is* checkable, mechanically and repeatedly, is whether the R
   functions those blocks name still exist. That is the part of the
   code-rot exposure a rendered build cannot see, because `freeze`
   protects only executed chunks.

   **The book already had this check, and it was broken in two ways.**
   `tools/check-calls.R` predates this plan, is wired into
   `make check`, and its header records that it once caught five
   nonexistent calls the render never would have. I wrote a duplicate
   before looking in `tools/`, which was wasted work and a reminder to
   read the repository before adding to it. The duplicate is deleted;
   both bugs below are fixed in the original.

   *It verified nothing when run the way the Makefile runs it.* The
   script called `list.files(".")`, so from the repository root it
   found no `.qmd` files, reported `ok: 0 resolvable calls verified`,
   and exited 0. A passing check that checks nothing is the vacuous
   test `20-testing` warns against, sitting in the project's own
   toolchain. It now resolves `analysis/report` explicitly and verifies
   **106 calls, 18 unverifiable here**.

   *It reported a false failure when run correctly.* `haven::write_xpt`
   was flagged as not exported. The call is real; the extracted token
   was `write_xpt.` with a sentence-ending period absorbed, because an
   R function name may legitimately contain a period and the pattern
   cannot tell punctuation from identifier. Trailing periods are now
   stripped before resolution. The offending sentence was one I added
   to a `fig-alt` in `22-sas` earlier in this same session, so the
   check caught a defect introduced by the refactoring itself.

   Note what none of this covers: shell, Docker, cloud and SAS commands
   remain unverifiable without a human running them, and no note in the
   text should imply otherwise. Writing 'verified' beside a command
   nobody ran is the failure mode this plan exists to correct.
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
attribution line. (*Superseded later on 2026-09-08 by commit
`57b9bc5`: portraits of Gentleman and Wickham were placed and the
reasons the others are absent were recorded. Gentleman is not on the
April policy's list of five; the policy or the placement should be
reconciled. Three portraits remain open; see Part 11, decision 8.*)

**Chapter splitting was not attempted.** Six files exceed 4,000 words.
Splitting them is an editorial act that changes the book's structure
and its cross-references, and it should follow from a reading rather
than from a word count.

**Catalog listing and print-on-demand are the author's to perform.**
Both require accounts, identity, and a submission the author stands
behind. They also depend on Phase B being far enough along that a
reviewer would not immediately note the missing solutions, which is now
true for fourteen chapters and not for the rest.

### Finding 10 follow-up (status 2026-10-09)

Item 1 is done in form only: `renv.lock` was added on 2026-09-09
(commits `1459c73`, `f17ba8d`) and records 215 packages. It has never
been restored. On 2026-10-09 a PDF render failed at
`12-rmd-workflow.qmd` because the project library was empty
(`knitr` and `rmarkdown` not installed), and the book rendered only
with `RENV_CONFIG_AUTOLOADER_ENABLED=FALSE` against the global
library. The lockfile is therefore untested, and the numbers in the
current PDF come from whatever versions happen to be installed
globally. Items 2 to 4 (`.Rprofile`, executing CI, Dockerfile) are
open. Run `renv::restore()` once, render, and fix whatever fails;
until then the book does not meet its own second pillar in practice.

### Phases E to K. Correctness, readability, and content (from the 2026-10-09 reviews)

Effort estimates are approximate and assume one author working with
assistance. Phase E is independent of every decision in Part 11 and
should start first.

**Phase E. Correctness (about 9 to 14 days; revised upward after the
expert reviews).** Two stages.

*E1, Tier 1 (about 5 to 8 days).* Fix every item in the Tier 1 table
of Part 6 before any other work, and before the book is assigned
again. The largest item is a single canonical HF-HOME SAP (estimand
attributes, randomized assignment, corrected power and attrition, a
named multiplicity procedure), from which chapters 03, 18, and 25b
compute every number they quote. Rewrite the missing-data theory in 17
and 23 around the condition under which complete-case analysis is
unbiased, and rerun the simulation without the inner seed. Correct the
compliance statements in 02b, 22, and 25c, and have a privacy officer
or regulatory colleague read the corrected 02b and 25c. Fix the CI
exit status. Add a render-time check that fails the build if `&#96;`
appears in output.

*Implementation record (2026-10-10).* Every phase below was
executed in order on stacked branches, each verified by a clean full
render (HTML and PDF: no warnings, no unresolved references or
citations, no literal entities) before its commit:

| Phase | Branch | Commit | Result |
|---|---|---|---|
| E1 | refactor/phase-e1 | `0d39fb1` | Tier 1 defects fixed |
| E2 | refactor/phase-e2 | `19559a1` | Rest of Part 6; canonical Dockerfile built and run |
| F, G | refactor/phase-f | `2b7292a` | Template, habits, pipeline diagram; HF-HOME generator and data |
| H, K | refactor/phase-h | `cbb2615`, `cbe01bf`, `8704816` | All chapters converted; content gaps added |
| I | refactor/phase-i | `1491fa9` | Merges, splits, moves, data-first order, capstone, PDF answers filter |
| J | refactor/phase-j | see branch head | Part pages, cheat-sheet index, getting help, generated colophon, glossary anchors and links, `openany` |

Outstanding after Phase J: the lockfile restore and executing CI
(Finding 10, deferred by the author); SAS verification; the
remaining portraits and the portrait-policy question (decision 15);
bolding glossary terms at first use so that more can be linked
(house rule 3); `targets`, `gtsummary`, and `mmrm` are used by
chapters but absent from `renv.lock`; second readers for the
statistical and compliance chapters (house rule 14); human expert
re-review before any catalog listing; student pilots. The PDF is
1,188 pages (decision 19).

*E1 status (2026-10-09):* complete; commit `0d39fb1` on branch
`refactor/phase-e1`, verified by a clean full render (HTML and PDF,
no unresolved references, no literal entities).

*E2 status (2026-10-09, branch `refactor/phase-e2`):* complete and
committed after a clean full render; the canonical Dockerfile was
built and run (R 4.4.0 on Ubuntu 22.04, Quarto 1.6.40) and is used
verbatim in 07, 08, and 09. SAS syntax in 22 remains unverified
(SAS OnDemand connection deferred by the author). Run against the
local R library by the author's direction. The Finding
10 follow-up (restoring `renv.lock`, executing CI, a Dockerfile for
the book) is deferred until the author chooses to restore the
lockfile; all E2 verification uses the global library.

*E2, the rest of Part 6 (about 4 to 6 days).* Fix the remaining
defects in Part 6, confirming each 'E' item against its primary source
first. Make the remaining display-only worked examples that *can*
execute do so, in particular the worked examples in 15, 17, and 24 (the last
against a synthetic stand-in for ADNIMERGE, since the real data are
restricted). Replace every hand-typed `#>` line in an executed chunk
with real output. Build and CI-test one canonical Dockerfile and use
it verbatim in 07, 08, and 09. This phase also closes the Finding 10
follow-up above.

Note the tension with Phase C. Phase C correctly concluded that most
blocks in 10, 10b, 11, and 12 should stay display-only because running
them would mutate the project or reach the network. Phase E does not
reverse that. It proposes a small, self-contained example project
inside each of those chapters (a toy `_targets.R`, a toy Quarto
project in a temporary directory) that can execute without touching
the book's own state, so that the reader sees real output.

**Phase F. Conventions and template (about 3 days).** Rewrite
`conventions.qmd` to the four-callout set of Part 4 and set
`reference-location: margin` for footnoted asides (4.1). Write the
numbered habit list and the motto, and draw the recurring pipeline
diagram (4.5). Move all metadata callouts
(Sources, peer-survey justifications, curriculum parity) into an
Instructor Guide appendix. Prototype the template on two chapters of
different kinds, for example `15-joins` and `08-renv`, and pilot them
with two or three students before continuing.

**Phase G. Running study (about 5 to 8 days).** Write the seeded
generator and companion repository described in Part 5. Rewrite
exercises in 04b, 12b, 13, 14, 15, 15b, 16, 17, 19, 20, and 22 against
it, with adjacent keys. This also revisits a Phase B judgment: several
chapters labeled open-ended in Phase B (04b, 05, 05b, 22, 25b) admit
checkable exercises once shared data and a shared repository exist,
for example a planted conflict in the study repository, or SAS log
reading that needs no SAS installation.

**Phase H. Openings, register, and cuts (about 1 to 2 days per
chapter, 25 to 40 days total).** Apply the template, opening story,
retrieval checks, cut list, and the Finding 31 table and figure
candidates chapter by chapter, most-assigned chapters first (13, 15,
16, 17, 01, 05, 08, 11, 18, 20). The 30 candidates marked 'Ready' in
Finding 31 do not depend on any phase and may be done earlier as
quick wins. The register
change in this phase follows decision 1 in Part 11 (the middle
course: remove hedges, define acronyms, second person in
instructions, exercises, and callouts).

**Phase I. Reorder and capstone (about 5 days).** Apply the part order
if adopted (Part 11, decision 3), resolve the remaining forward
references, rebuild 25 as a capstone, and seed the ethics flags in
their home chapters.

**Phase J. Reference apparatus (about 3 days).** Cheat-sheet appendix,
'Tooling as of' appendix, glossary links from bold first uses,
'Getting help' and 'Meta-techniques' sections in `00-intro`, a
generated colophon (5.7), part introductions (decision 9), and a
`testthat` translation appendix (decision 14). Webr or
Quarto Live for the closed exercises in the data chapters is optional
and has consensus support only. This phase absorbs the open items of
Phase D (no index, per decision 8; portraits are the author's).

**Phase K. Content gaps (about 10 to 15 days; scope depends on
decisions 12 to 14).** The expert reviews (Finding 28) list topics a
professional reader expects. Consistent with the rule against adding
chapters (Part 9), these enter as sections of existing chapters,
prioritized by what an entry-level hire needs first:

1. *LLM governance and agentic practice* (21, moved to Part II per
   decision 11; see 4.6).
2. *Estimands* in 18 (the five ICH E9(R1) attributes, intercurrent
   events, a worked HF-HOME estimand), cited from 17 and 19.
3. *Missing data for trials* in 17: MMRM, reference-based multiple
   imputation, tipping-point analysis; the NRC (2010) report.
4. *Security basics* across 04, 06, 09, 15b: secrets and `keyring`,
   SSO instead of keys, parameterized SQL, `.dockerignore`, binding to
   localhost.
5. *Reproducibility cases and scholarship* in 01: Duke and Potti,
   Reinhart-Rogoff, NASEM (2019).
6. *Industry practice* in 19 and 22: pharmaverse TLF tools, the R
   submission pilots, validation of R packages, double programming and
   `diffdf`, an MMRM in both languages.
7. *Currency* in 04, 08, 09, 20b: Posit Package Manager snapshots,
   devcontainers, pre-commit, DuckDB and Parquet, pinned Actions.
8. *Causal foundations* where the book already uses causal language
   (23, 25d): a DAG, target-trial emulation, and the 'C-word'
   argument, in a page each.
9. *Comparator texts* cited in the preface and in Further reading.

To keep the book from growing, pair every addition with a cut from the
same chapter (Part 7 and the R4DS overlap in decision 13).

**Pilot loop.** After each phase, collect a short reading-time and
confusion log from two or three students. The Carpentries require
pilots for good reason: 'you are not your learners' (Wilson).

## Part 9. What not to do

The first two items below were written on 2026-09-07 and are retained
with their original reasoning; the October reading contested both,
and both were resolved on 2026-10-09 (Part 11, decisions 1 and 2).

- ~~Do not rewrite prose for voice.~~ **Resolved 2026-10-09, decision
  1: the voice is kept; hedges are removed, acronyms defined, and
  instructions, exercises, and callouts address the reader as 'you'.**
  The September reasoning was that the rgtvoice pass is complete,
  `DEEP-REVIEW.md` found the register consistent, and further prose
  churn would consume the budget that Phase B needed. The October
  reading agrees the register is consistent and finds that it is
  consistently above the audience (Finding 15); the middle course
  answers both.
- ~~Do not restructure the book to reach 140 pages.~~ **Retained in
  substance; resolved 2026-10-09, decision 2.** No
  restructuring toward a page target is proposed. The October plan
  proposes moving reference and perishable material out of tutorial
  chapters, which shortens them, and splitting one chapter
  (`12b-acquisition`) on content grounds rather than length.
- Do not delete the mermaid diagrams in favor of computed figures.
  They serve a different purpose and reviewers do not complain about
  schematics; they complain about their absence of everything else.
- Do not retain the NC or ND terms, and do not adopt them elsewhere to
  retain commercial control. (Resolved: the prose is CC BY 4.0.)
- Do not add humor, trivia, or decorative photographs to chase
  engagement. The seductive-details literature shows harm (meta-analytic
  g of about -0.33), and the book's `images/README.md` states the rule
  more strictly: no chapter-opener images, no generated hero images,
  no part-divider art, and four to five portraits at most. Stories are
  kept only when they are instances of the chapter's failure mode.
- Do not add part-opener images. ~~Or prose pages.~~ **Prose pages
  permitted from 2026-10-09 (5.5; Part 11, decision 9): 100 to 200
  words, image-free.**
  `fig-book-map` in `00-intro` orients a linear reader once; a short
  part introduction serves the reader who enters mid-book.
- Do not set a uniform per-section figure count. A figure invented to
  satisfy a quota in a prose section is a seductive detail with a
  `ggplot` theme.
- Do not add chapters. The problem is density and delivery, not
  coverage. The content gaps the expert reviews identified (Phase K)
  enter as sections of existing chapters, each paired with a cut;
  decision 12 is the one possible exception.
- Do not convert prose wholesale into bullet lists. Scannability comes
  from headings and short paragraphs; the book's best passages are
  prose and should stay prose.
- Do not let the LLM prompts grow back into sections. One callout,
  beside the task.
- Do not remove the bypass quiz without replacing it. Retrieval with
  feedback is the strongest effect available; it moves and
  multiplies, it does not disappear.
- Do not let in-house tools carry concepts. Every `zz*` mention needs
  its portable alternative within the same paragraph.

## Part 10. Sequencing

Phases A to D were sequenced as A, B, C, D, on the grounds that A was
short and unblocked D, B carried the most evidential support per unit
of work, C generated figures as a byproduct, and D (catalog listing)
should wait until exercises had solutions. A is complete, B and C are
substantially complete, and D's remaining items were settled by
decision 8 on 2026-10-09.

The remaining work should run in this order:

1. **Phase E1 (Tier 1 defects).** Before the book is assigned again.
   Three expert reviewers independently judged the book not adoptable
   until these are fixed.
2. **Phase E2 and the Finding 10 follow-up.** Independent of every
   decision, and every defect in Part 6 costs reader trust.
3. **Part 11 decisions.** Recorded 2026-10-09; only item 15 (the
   portrait policy) remains open, and it blocks nothing.
4. **Phase F, then G.** The template and the running study are the two
   changes with the largest effect per unit of work. If only one
   readability phase is ever done, do Phase G: shared data makes
   exercises checkable, gives the book a through-line, and supplies
   spaced retrieval at no additional cost. Phase G depends on the
   canonical SAP from E1.
5. **Phases H, K, I, J,** chapter by chapter, with the pilot loop.
   Phase K's additions to a chapter are made in the same pass as that
   chapter's Phase H rewrite, so each chapter is opened once.
6. **Phase D's catalog listing and print-on-demand** last, for the
   reason the September plan gave, and not before an external expert
   has re-read the corrected statistical and compliance chapters.

## Part 11. Decisions for the author

### Decisions recorded 2026-10-09

The author accepted the plan's recommendation on every decision. The
options and arguments that informed each are retained below the table
as the record of what was weighed.

| # | Decision | Resolution |
|---|---|---|
| 1 | Register | **Middle course.** Keep the author's voice; remove hedges ('we would argue', 'it appears'); define every acronym at first use in each chapter; use second person in instructions, exercises, and callouts. No book-wide rewrite to second person. |
| 2 | Chapter splits | **Split `12b-acquisition` only**, at its seam between files and APIs or scraping. Elsewhere, shorten by moving reference and perishable material out (04, 06, 11, 15, 16, 17, 21), not by splitting. |
| 3 | Part order | **Data-first order of 5.2**, adopted together with the running study (decision 4); the two are a package. |
| 4 | Running study | **HF-HOME**, built on the single canonical SAP produced in Phase E1. |
| 5 | In-house tools | **Optional, community tool first.** Teach `power.prop.test`/`pwr`/`rpact`, `gtsummary`, `ggplot2`, and `renv` with Docker as primary; present each `zz*` package as an option with its validation status. zzcollab becomes one section of a tool-neutral 'Assembling the compendium' chapter (07 merged with 10), rewritten against the current repository. |
| 6 | Interactivity | **Deferred.** No webR or Quarto Live for now; revisit after the pilot loop. |
| 7 | Instructor material | **Appendix** in the book (an Instructor Guide), for ease of keeping it in sync. |
| 8 | Phase D carry-overs | **No PDF index** (HTML search and the PDF table of contents suffice). Remaining portraits: the author sources and license-checks them personally. Catalog listing and print-on-demand: **after** human expert re-review of the corrected statistical and compliance chapters. |
| 9 | Part introductions | **Yes**, 100 to 200 words each, image-free (5.5). The Part 9 rule against part-opener prose pages is withdrawn; the rule against part-opener images stands. |
| 10 | Solutions companion | **Yes, conditionally**: start it if a teaching assistant or former student will co-author. Otherwise, collapsed keys adjacent to exercises suffice. |
| 11 | AI chapter placement | **Move the durable core of 21 into Part II** (the four Cs, governance, agent safety); tooling detail goes to the dated 'Tooling as of' appendix. |
| 12 | Estimands | **A section of 18**, not a new chapter. Revisit if it exceeds about 1,500 words. |
| 13 | R4DS overlap | **Cut** the generic verb tours in 13 to 16 and the pandas side-by-sides; point to R4DS 2e; keep the clinical-judgment layer. This offsets the Phase K additions. |
| 14 | Test framework | **Keep `tinytest`**, and add a short `testthat` translation appendix (the existing testthat comparison callout in 20 moves there). |
| 17 | Template rollout (new, after Phase F review) | **Roll out as is.** The prototypes in 15 and 08 were approved; the template applies to all remaining chapters in Phase H. The author accepted the length growth the template brings (08 prose +43%, 15 +17%); cuts under decision 13 remain the offset. |
| 18 | HF-HOME seed (new) | **Keep the pre-chosen seed (20260423) and report the result honestly.** The default draw is inconclusive (risk difference 2.6 points, 95% CI -1.0 to 6.0), though the generator is unbiased (83% of 200 draws significant). Chapter 25b's memo is rewritten around an inconclusive result, which also serves its null-results section; choosing a seed after seeing results would be the researcher-degrees-of-freedom problem the book teaches against. |
| 19 | Length (new, after Phase H batch 1) | **Accept the growth.** Batch 1 and the prototypes grew 37% in words; the PDF reached 846 pages with 25 chapters unconverted, projecting to roughly 950 to 1,000 pages. The author accepted this over a hard per-chapter budget; the one-quarter core path (decision 16) carries more of the load. The target in 5.3 ('about 15 percent shorter') is withdrawn. |
| 20 | SAP sensitivity rule (new) | **Two-dimensional tipping point.** SAP section 11 in 18 is rewritten to vary the assumed outcome risk among unascertained patients in each arm separately and report which combinations would change the conclusion in either direction, as 17 demonstrates; 25b follows. The former one-dimensional rule had nothing to tip because the HF-HOME result is inconclusive. |
| 15 | Portrait policy (new) | **Open item for the author**: the Gentleman portrait is placed but Gentleman is not among the five named in the April image policy (`images/README.md`). Amend the policy or replace the portrait. |
| 16 | Course length (new) | **Two quarters, with a one-quarter core path.** The book targets a two-quarter sequence at about two chapters a week (35 chapters is 17.5 weeks; the earlier claim that a single quarter is realistic was false). Quarter 1: Parts I to III of 5.2 (why, toolkit, data); Quarter 2: Parts IV to VIII (documents and environments, analysis practice, industry, case studies, capstone). A one-quarter core of 20 chapters, two a week, is printed in the preface ('Course length and the one-quarter core', implemented 2026-10-09): why, de-identification, shell, workstation, Git solo and teams, acquisition, wrangling, joins, graphics, missing data, Quarto, renv, Docker, analysis plans, testing, AI-assisted coding, ethics, communicating, and the penguins case study. Pharmaceutical-track students add CDISC and SAS. Consequences: cuts (decision 13) and Phase K additions should protect the core chapters' length; the capstone (5.4) belongs to Quarter 2. |

### Decisions recorded 2026-10-11 (Part 13)

The author accepted a different option than recommended on 21 and
23; the options and the recommendation as weighed are retained for
the record.

| # | Decision | Options | Resolution |
|---|---|---|---|
| 21 | Topic additions (13.3) | Tier 1 only; Tier 1 and 2; all tiers | **All tiers (1, 2, and 3).** The recommendation was Tier 1 and 2 (Tier 2 items are the most widely taught and clearly in scope; Tier 3 is borderline or narrowly taught); the author chose to include Tier 3 as well, about 32.5k words, roughly +160 pages total. |
| 22 | rgtlab tested alternatives (13.6) | Feature zzlongplot and zzrctsim; feature zzlongplot only; feature none | **Feature both.** Both meet the tested-and-trusted bar on re-run comparisons. zzrctsim's MCSE formulas should still be cross-checked against rsimsum before the Gap 14 section ships. |
| 23 | Volume split (13.4) | Two volumes; three (industry volume); one volume; decide after additions | **Three volumes now.** The recommendation was to decide after the additions shipped and were measured; the author chose to commit now to a third, shorter industry volume (Part VI plus the new regulated-computing material), keeping Volume 2 nearer 600 pages. The 13.4 page estimates remain projections until Tier 2 and 3 content is written; the three-way split should be re-measured against the actual word counts once Phase K (updated for all tiers) completes. |
| 24 | rgtlab corrections (13.6, items 1 to 7) | Apply as Tier 1; defer | **Apply as Tier 1.** Each fixes a statement in the current book that a re-run showed to be false or incomplete; none depends on decisions 21 to 23. |

Consequences for the rest of this plan: house rule 2 and Phase H
apply the middle course; Part 5.2 is adopted rather than proposed;
Phase K proceeds with estimands in 18, and now also carries all three
tiers of Part 13 additions (decision 21) and the Gap 14 zzrctsim
section (decision 22); Phase J omits the index and includes part
introductions; Tier 1, including the seven rgtlab corrections, should
be done as the start of (or ahead of) Phase K rather than waiting for
the rest; the volume split (decision 23) becomes a three-volume plan
to design once Phase K's actual page counts are known, with the
industry volume drawing on Part VI and the regulated-computing
material from Gap 5; the remaining `[conditional on decision N]`
wording elsewhere in this document should be read in light of the
resolutions above.

### Options as weighed

1. **Register (reverses a September position).** Keep the rgtvoice
   register, or move to second person for this audience?
   - *For changing:* a meta-analysis of conversational style reports
     retention d = 0.30 and transfer d = 0.54 (Ginns, Martin and Marsh
     2013), and the book's most memorable lines already use direct
     address. Formal hedging ('we would urge the reader') is a cost a
     first-year student pays on every page.
   - *For keeping:* the voice is deliberate and consistent; the effect
     sizes are modest and some later studies find smaller benefits;
     the effect fades in lessons over about 35 minutes; and a full
     pass costs weeks.
   - *Middle course:* keep the voice, but remove hedges ('it appears',
     'we would argue'), define every acronym on first use, and put
     second-person address in instructions, exercises, and callouts
     only.
2. **Chapter splits (reverses a September position in part).** The
   September plan split nothing, on rendered page counts. The October
   reading proposes splitting `12b-acquisition` (the longest reading
   unit, about 30 minutes, with two separable halves) and moving
   reference material out of 04, 06, 11, 15, 16, 17, and 21, which
   shortens chapters without splitting them. Accept, or keep the
   current units?
3. **Part order.** Adopt the data-first order of Part 5, or keep
   infrastructure first and apply only the dependency fixes of
   Finding 18? The template and the running study work under either.
4. **The running study.** Consolidate on HF-HOME, or another domain
   closer to the program's applied focus?
5. **In-house tools (extended by Finding 29).** zzcollab: one section
   in a tool-neutral compendium chapter, keeping the Five Pillars as
   the durable idea, or a full chapter as now (rewritten against the
   current repository either way)? All `zz*` packages: teach the
   community tool first (`power.prop.test`, `pwr`, `rpact`;
   `gtsummary`; `ggplot2`; `renv` with Docker) and present the
   in-house package as an option with its validation status, or keep
   the current positioning? All three expert reviewers recommended
   the former.
6. **Interactivity.** Is webR or Quarto Live worth the build and
   maintenance cost? No outcome evidence specific to the format was
   found.
7. **Instructor material.** An appendix in the book or a separate
   instructor site?
8. **Carried over from Phase D.** Whether a PDF index is worth the
   `\index{}` markup; sourcing the three remaining portraits; catalog
   listing and print-on-demand (now a 712-page product).
9. **Part introductions (reverses a Part 9 rule in part).** Add a
   100-to-200-word, image-free introduction to each part, as in
   *Advanced R* (5.5), or keep `fig-book-map` as the only orienting
   device?
10. **Solutions companion.** Start a separate model-answers volume for
    the long-form deliverables (5.6), and if so, invite teaching
    assistants or former students to co-author it?
11. **Placement of the AI chapter.** Move the durable core of
    `21-ai-coding` (the four Cs, governance, agent safety) into Part II
    so it precedes the 30 chapters whose LLM callouts depend on it,
    leaving tooling detail in a dated appendix (4.6)? Students use
    these tools from the first week regardless of where the chapter
    sits.
12. **Estimands.** Treat ICH E9(R1) estimands as a section of 18
    (Phase K), or as the one new chapter the plan would admit? The
    pharma reviewer listed it first among absent topics.
13. **Overlap with R4DS 2e.** Cut the generic verb tours in 13 to 16
    (and the pandas side-by-sides) and point to R4DS, keeping only the
    clinical-judgment layer, as the academic reviewer recommends? This
    is also the largest available source of length to offset Phase K.
14. **Test framework.** The book teaches `tinytest`, partly because
    zzcollab ships it. The data-science reviewer argues that `testthat`
    fluency matters more for a first job. Keep `tinytest`, switch, or
    teach `tinytest` with a short `testthat` translation appendix?

## Part 12. Limitations of this analysis

### Structural pass (2026-09-07 to 2026-09-08)

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

### Reading pass (2026-10-09)

- **Reading coverage.** The reading was done by six parallel readers
  with a shared rubric. Cross-group consistency judgments (for
  example, 'appears in fourteen chapters') are aggregated from their
  reports and are approximate.
- **Defect verification.** Of the defects in Part 6, six were
  confirmed directly. The rest were inspected by one reader each, and
  some rest on that reader's knowledge of tool APIs (renv, Quarto,
  rticles, ellmer) rather than on execution.
- **Measurement methods.** Reading-time estimates use 200 words per
  minute including code. The 712-page count comes from
  Finding 8, not from a new measurement.
- **Source-reading depth.** Several effect sizes come from secondary
  summaries rather than full papers, notably Rey (2012) and Rowland
  (2014). The literature review found no controlled evidence on
  optimal chapter length, glossary tooltips, or webR exercises, so
  recommendations on those points are inferred.
- **No student testing.** Nothing in this plan has been tested with
  students. The pilot loop in Part 8 is the mechanism for correcting
  it.

### Expert and LLM-section reviews (2026-10-09)

- **Simulated reviewers.** The three expert reviews were produced by
  model reviewers instructed to adopt expert personas. They read the
  source in full and ran checks, and the plan author re-confirmed
  three of their critical claims against the source (the SAS
  statement, the dbGaP deposit, and the inner `mice` seed). They are
  not a substitute for human expert review, which Part 10 requires
  before the catalog listing.
- **Coverage.** Each reviewer read only assigned chapters (10, 14, and
  19 of them). Some chapters were read by two reviewers and some by
  one; no chapter was read by all three.
- **Evidence status in Part 6.** Items labeled 'E' rest on the
  reviewer's expert knowledge (regulatory item numbers, policy dates,
  vendor APIs) and must be checked against primary documents during
  editing. Reviewers disagreed in detail on one verified result (two
  versus five distinct datasets in the reseeded simulation); both
  establish that the simulation is invalid.
- **Currency of the LLM review.** Statements about current tools and
  practice reflect knowledge as of mid-2026 and will date fastest of
  anything in this plan. Product names in 4.6 belong in the dated
  'Tooling as of' appendix, not in chapter prose.

## Part 13. Topic additions from the coverage sweep (2026-10-10)

### 13.1 Method and evidence

Three researchers worked from one brief containing the book's scope
statement (it deliberately does not teach statistical theory or
methods, which the companion book covers), its chapter titles, and all
203 section headings, and checked coverage by grepping the chapter
files. Each cited only sources it opened or saw in search results, and
labeled which.

| Sweep | Sources | Read in full |
|---|---|---|
| University courses (US, Canada, UK, Europe, Hong Kong, plus Data Carpentry and an industry course) | 27 | 21; 6 from catalog or search snippets only |
| Textbooks, open books, reference sites (R4DS 2e, The Turing Way, Telling Stories with Data, Modern Statistics with R, R Packages, rstats.wtf, Happy Git, RAPs with R, UK RAP guidance and the 'Duck Book', Carpentries, R for Clinical Study Reports, pharmaverse, rOpenSci dev guide, Missing Semester, and others) | 30 | most; 5 partly |
| Regulators, standards bodies, societies, tool vendors (FDA, EMA, ICH, ICMJE, NIH, EQUATOR, CDISC, NIST, ASA, RSS, Posit, R Validation Hub) | 34 | 2 fetched; the rest from search results |

**Limits.** Coverage status rests on grep and section headings, not on
re-reading every chapter, so 'partly covered' judgments are inferred.
Many dates in the regulatory sweep come from search results or
secondary sources and must be confirmed against primary sources before
any of them is printed (house rule 14 and the verification pass). No
course syllabus was found for several institutions searched (for
example Michigan, Karolinska, Oxford, UCL, NUS); they are not counted.

**What the sweep confirms is already covered.** Git, Quarto, import,
wrangling, joins, dates, APIs and scraping, SQL, Arrow and DuckDB,
testing and CI, renv and Docker, targets, cloud and HPC, ethics and
privacy, de-identification, estimands, NIH data sharing, CDISC and the
R submission pilots, TRIPOD+AI, Positron, and AI-assisted coding, on
which the book is ahead of nearly every peer source.

**What is out of scope** (companion book): regression, inference,
machine learning methods, Bayesian workflow, bootstrap, power theory.

### 13.2 Gap table

'Peers' counts sources across the three sweeps that teach the topic
(approximate). Fit: IN scope for a practicum, or BORDERLINE.

| # | Topic | Peers | Status in the book | Fit | Settled? |
|---|---|---|---|---|---|
| 1 | Superseded citations: CONSORT 2010 to CONSORT 2025 and SPIRIT 2025; ICMJE 2024 to January 2026 (new AI section); riskmetric now maintenance-only (successor val.meter); Dataset-JSON status | regulatory sweep | STALE | IN | yes |
| 2 | Writing functions, iteration, and debugging your own code (`traceback`, `browser`, `debugonce`, `rlang::abort`, `rlang::last_trace`) | 14+ (6 courses, 8 books) | PARTLY: functions used throughout, never taught; no debugging | IN | yes |
| 3 | Analysis code as a package (DESCRIPTION, roxygen2, `R CMD check`, pkgdown) without zzcollab | 11 | PARTLY: only through zzcollab | IN | yes |
| 4 | Publication and submission tables (gtsummary or gt Table 1; TLF assembly with rtables or tfrmt) | 6 | PARTLY: used in case studies, never taught | IN | yes |
| 5 | Regulated-industry computing: 21 CFR Part 11, ICH E6(R3) data integrity and computerized systems, audit trails, R package validation (R Validation Hub), eSubmission mechanics (pkglite, eCTD layout) | industry course, R4CSR, pharmaverse, regulators | ABSENT (Part 11 and Validation Hub: no mentions) | IN | mostly |
| 6 | Run logging and audit trails (logger or cli; logrx or whirl) | 3 | ABSENT | IN | yes |
| 7 | Choosing a reporting guideline (CONSORT 2025 and -AI, SPIRIT 2025 and -AI, STROBE, TRIPOD+AI, TRIPOD-LLM, CHART, TARGET for target-trial emulation) | regulatory sweep | PARTLY: TRIPOD+AI only | IN | yes |
| 8 | LLMs as analysis components, and evaluating an LLM step before trusting it (structured extraction with a validation set, a small evaluation harness) | 1 course (3 weeks), Posit vitals | PARTLY: appendix H only, no evaluation | IN | no (volatile) |
| 9 | Regulation of AI in analysis: FDA 2025 draft credibility framework, FDA and EMA principles, NIH 2025 applicant rules, ICMJE AI section, EU AI Act dates | regulatory sweep, ASA and RSS statements | PARTLY: disclosure only | IN as a dated box | no (volatile) |
| 10 | Declarative data validation (pointblank, validate) | 3 | ABSENT | IN | yes |
| 11 | Style, lint, format (styler, lintr, Air, pre-commit) | 5+ | PARTLY: only in the AI chapter | IN | yes |
| 12 | Licensing and citation of code and data (LICENSE, CITATION.cff, DOI linkage) | 5 | PARTLY: only in the example DMSP | IN | yes |
| 13 | Trusted research environments, the Five Safes, federated analysis, output disclosure control | 2 + UK guidance | ABSENT by name | IN | mostly |
| 14 | Planning and reporting a simulation study (ADEMP, Monte Carlo standard errors) | 2 | PARTLY: a simulation runs in 06; no plan or reporting | IN | yes |
| 15 | Accessible figures and documents (alt text, color, WCAG 2.1 AA, Quarto options) | regulatory sweep; book uses fig-alt but does not teach it | ABSENT | IN | yes |
| 16 | Preregistration, registered reports, preprints | 4 | PARTLY: SAP pre-specification only | IN | yes |
| 17 | Consulting practice by performance: simulated intake role-play, jury-style presentation rubric | 4 | PARTLY: intake covered, no exercise | IN | yes |
| 18 | A replication exercise (reproduce a published figure from deposited code and data) | 2 | PARTLY: cases discussed, nothing assigned | IN | yes |
| 19 | Generating synthetic data and judging its utility and disclosure risk; differential privacy as a concept | 2 | PARTLY: synthetic data used, not taught | IN | partly |
| 20 | Interactive deliverables (Shiny, teal, shinylive and webR) | 9 | ABSENT as a taught topic | BORDERLINE | partly |
| 21 | Data-management operations (roles matrix, participant tracking, REDCap design) | 3 | PARTLY: REDCap mentioned | IN | yes |
| 22 | Make and Snakemake beside targets; Python interoperability in a compendium | 5 to 6 each | PARTLY | BORDERLINE | yes |
| 23 | Nix and rix as an alternative to renv plus Docker | 2 | ABSENT (one mention) | BORDERLINE | partly |
| 24 | Smaller items: multiverse or specification-curve extension of the 25b sensitivity grid; profiling (profvis, bench) before scaling out; compute carbon; ICH M11 structured protocol; lay summaries and posters; professional-society AI statements | 1 to 3 each | ABSENT or PARTLY | IN or BORDERLINE | mostly |

### 13.3 Proposed additions

Placement uses the current part order. Size is new words, including
code; pages assume the book's current ratio of about 200 words per
rendered page.

**Decision 21 (2026-10-11): all three tiers are approved for
implementation.** Tiers are kept below only as an implementation
sequence (Tier 1 first), not as a scope boundary.

**Tier 1: correct now (no decision needed beyond approval).**

| Item | Where | Size |
|---|---|---|
| Gap 1, superseded citations, each confirmed against its primary source | 25b, 18, 21, 19 | small |
| rgtlab corrections 1 to 7 in 13.6 (zzrenvcheck claim, zzgit footnote, R.nvim name, zzcollab `make r`, zztable1 missing row, appendix E entries, HF-HOME codebook randomization note); decision 24 | 08, 05, 04, 10, 23, 24, E, HF-HOME README | small |

**Tier 2: recommended additions (most widely taught, clearly in scope).**

| Item | Where | Form | Size |
|---|---|---|---|
| Gap 2, functions, iteration, debugging | Part III, after @sec-types, before @sec-joins | **New chapter**, 'Writing and Debugging Functions', on HF-HOME | about 5,500 words |
| Gap 3, analysis code as a package | @sec-zzcollab | Section | 1,500 |
| Gap 4, publication and submission tables | @sec-communicating (Table 1); @sec-cdisc (TLFs) | Two sections | 2,500 |
| Gaps 5 and 6, regulated-industry computing and run logging | @sec-cdisc (Part 11, E6(R3), validation, eSubmission); @sec-targets (logging) | Sections | 3,500 |
| Gap 7, choosing a reporting guideline | @sec-communicating, cross-referenced from @sec-analysis-plan and @sec-adni | One table and section | 1,000 |
| Gaps 8 and 9, LLM components with evaluation; regulation of AI | @sec-ai-coding (durable method); appendix H (code); 25c 'as of' table (dates) | Section and dated box | 2,000 |
| Gap 10, declarative validation | @sec-testing, beside the assertions | Section | 1,200 |
| Gap 11, style and lint | Move from @sec-ai-coding to @sec-testing; add Air and pre-commit | Move plus small section | 500 net |
| Gap 12, licensing and citation | @sec-federal | Section | 1,000 |
| Gap 13, trusted research environments | @sec-deident-practice | Section | 1,200 |
| Gap 14, simulation studies | @sec-cloud job-array example, pointed to from @sec-analysis-plan | Section, plus the zzrctsim tested-alternative feature (13.6, decision 22, after the rsimsum cross-check) | 1,200 |
| Gap 15, accessibility | @sec-graphics (figures); @sec-quarto (documents) | Two sections | 1,500 |
| Gaps 16 to 18, preregistration; consulting role-play; replication exercise | @sec-analysis-plan; @sec-team-science and the Instructor Guide; @sec-why | Sections and exercises | 2,000 |

Tier 2 total: about 24,000 words, roughly +120 pages.

**Tier 3: optional (borderline or narrowly taught).**

| Item | Where | Form | Size |
|---|---|---|---|
| Gap 19, synthetic data and differential privacy | @sec-deident-practice | Section and concept box | 1,200 |
| Gap 20, interactive deliverables | New appendix, 'Interactive Deliverables' | Appendix | 3,000 |
| Gap 21, data-management operations | @sec-team-science or @sec-acquisition | Section | 1,200 |
| Gaps 22 and 23, Make and Snakemake, Python interop, Nix and rix | @sec-targets; @sec-docker | Asides | 1,500 |
| Gap 24, smaller items | Their home chapters | Paragraphs | 1,500 |

Tier 3 total: about 8,500 words, roughly +40 pages.

### 13.4 Consequences for length and the volume split

With all tiers approved (decision 21), the PDF is projected at about
1,350 pages. The additions are not evenly split:

| Volume (as proposed) | Now | With Tier 2 | With all tiers |
|---|---|---|---|
| 1, Parts I to III | about 550 | about 600 (the new functions chapter, accessibility in 16, TREs in 02c) | about 615 |
| 2, Parts IV to VIII | about 640 | about 710 (regulated computing, tables, logging, packages, reporting guidelines) | about 735 |

**Decision 23 (2026-10-11): three volumes, settled now rather than
after the additions ship.** Volume 2 at about 735 pages would
approach the print-on-demand page ceiling noted when the split was
first discussed (roughly 800 to 830 pages for common services, from
memory, to be confirmed). The third volume is the industry material:
Part VI (@sec-cdisc, @sec-sas) plus the new regulated-computing
sections from Gap 5 and 6, which makes a coherent short book for
pharmaceutical-track students and should bring Volume 2 down near 600
pages. These figures are still projections; Phase K should re-measure
all three volumes' page counts once the Tier 2 and 3 content is
written, and the exact chapter boundary for the industry volume
(whether it also takes Gap 4's TLF section, which currently sits in
@sec-cdisc) should be fixed at that point.

### 13.5 Process

Additions follow the same rules as Phases H and K: one branch, the
chapter template, HF-HOME examples with computed numbers, verification
of every regulatory date against its primary source before it ships,
and a second reader for the regulated-computing material (house rule
14). Tier 1 can be done first and independently.

### 13.6 rgtlab software as tested alternatives (review of 2026-10-10)

**Rule.** A lab tool may appear beside the community standard (never
in its place, decision 5) only if it is *tested and trusted*: (a) its
test suite passes; (b) its tests check correctness of results, not
only structure; and (c) on the same input its output agrees with the
community tool within a stated tolerance, verified by running both.
A tool failing any of (a) to (c) gets at most a sentence.

**Method and evidence.** Three read-only reviewers covered the 18
projects in `~/prj/sfw` under one brief, working on copies in the
scratchpad, with R 4.6.1 and the local library. For every R package
they ran the test suite and `R CMD check --as-cran --no-manual
--ignore-vignettes` (vignettes were not built), and ran a comparison
against the community tool. On 2026-10-11 the coordinator re-ran
every result that a verdict rests on (marked R below): zzlongplot,
zzrctsim, zztable1, zzpower, zzrenvcheck, zzgit, and zzedc. All
reproduced. Results for the out-of-scope and MENTION-only methods
packages (zzmesoimpute, zzalloc, zzfisher, zzcondpower,
zzuncondexact, zzworld), zzvim-R, zzobj2fig, and the zzcollab scaffold
rest on the reviewers' runs only; none of them changes a verdict. Not done: vignette builds,
Docker builds, zzcollab shell tests, PostgreSQL backends, the gitleaks
content scan (gitleaks absent), and comparisons against blockrand,
randomizr, simstudy, rsimsum, and NADA2 (not installed). None of the
packages is on CRAN; all are GitHub-only with a single maintainer.

| Project | Tests | Comparison with the community tool | Verdict | Where | Beside |
|---|---|---|---|---|---|
| zzlongplot 0.6.0 | 312 pass; tests check interval arithmetic | HF-HOME NT-proBNP by arm and visit: means and 95% t bounds equal `stat_summary(mean_cl_normal)` to 3 decimals in all 4 cells (R) | **FEATURE** (keep existing section) | @sec-graphics, @sec-adni | ggplot2 |
| zzrctsim 0.2.0 | 338 pass; bias and coverage within 3 MCSE | B = 1000, true effect −3: bias 0.015 (MCSE 0.015), coverage 0.956, versus a hand-written loop −0.019 (0.016), 0.951; one data set: `fit_ancova()` equals hand-coded `lm()` (−2.646391, SE 0.486232) (R) | **FEATURE** (new, in Gap 14) | @sec-cloud-worked, from @sec-analysis-plan-power | hand loop plus rsimsum |
| zzcollab 0.2.0 | 158 pass; R CMD check 1 NOTE; tests mostly argument and git handling | scaffold passes the chapter's own pillar audit except the Git row, as Exercise 7 expects | Keep optional section; fix 3 claims | @sec-zzcollab | rrtools, workflowr |
| zztable1 0.6.0 | 600 pass; mostly structural | counts, %, means, SDs, p-values agree with gtsummary and table1; **missing row blank with `missing = TRUE`** (R); LaTeX header puts `\\` in a cell (inspected) | **NOT YET** | @sec-penguins, @sec-adni | gtsummary |
| zzpower 1.1.0 | 980 pass; tests exercise pwr, not zzpower | HF-HOME design 1,092 per arm versus 1,094 (`power.prop.test`) and 1,091.9 (`pwr`); d = 0.5 t-test 64 versus 63.77 (R); `p2` silently defaults to 0.30; default 10% dropout gives 1,213.5 per arm | MENTION | @sec-analysis-plan | power.prop.test, pwr |
| zzrenvcheck 0.8.0 | 170 pass; parser tests are correctness tests | code packages match `renv::dependencies()`; but with default `transitive = FALSE` reports PASS while `renv::status()` lists 7 unrecorded packages; never compares code with the lock; does not flag unused lock entries (R, committed 0.8.0). Uncommitted 0.9.0 work in `~/prj/sfw` fixes the two-pass auto-fix and locks installed versions, but `transitive` still defaults to FALSE; re-test when released | MENTION; correct the text | @sec-renv | renv::status |
| zzgit 0.1.1 | no suite | committed `.Renviron` with `DB_PASSWORD` to main without gitleaks (R); protected-branch guard is a push prompt, not a commit block; new-branch push fails (no `-u`) (R) | MENTION; reword footnote | @sec-git-solo | gitleaks pre-commit hook |
| zzvim-R | 68 themis tests pass | renders `.qmd` through `rmarkdown::render(html_document)`, so `@fig-` cross-references stay literal | MENTION; correct | @sec-workstation | R.nvim |
| zzobj2fig 0.4.0 | 337 pass (compile tests skipped, no pdfcrop) | cells match `summary(lm)` and kableExtra; headers mangled (`Std\_\_Error`); README shows CRAN and 'stable' badges | MENTION | Gap 4 TLF section | gt, kableExtra |
| zzmesoimpute 0.2.0 | 126 pass; MLE recovery tested | censored MLE equals `survival::survreg` within 2e-3 over 500 reps; SD of log concentration 0.858 (LOD/2), 1.0005 (MLE), truth 1 | MENTION (methods) | @sec-missing-further | survreg, NADA2 |
| zzedc 0.8.0 | 3,232 of 3,235 pass (3 stale UI-text tests); suite aborts if a PostgreSQL backend is configured but absent | 'encrypted' database has a plaintext `SQLite format 3` header (R); after rewriting one audit row and re-hashing the chain, `verify_audit_integrity()` returns valid (R); no validation package exists | **NOT YET**; never cite for Part 11 | @sec-acquisition, Gap 5 | REDCap |
| simrun-demo | 1 trivial test | reruns to its logged value; no ADEMP, no MCSE; no remote | NOT YET | @sec-cloud-hpc | job arrays |
| zzalloc 0.3.0 | 112 pass; correctness tests | stratified blocks of 4 on HF-HOME strata: imbalance never above 2, permutations uniform (p = 0.79), against a base-R reference | OUT OF SCOPE (methods) | footnote at most | blockrand, randomizr |
| zzfisher, zzcondpower, zzuncondexact | 1,625, 159, 78 pass | match `fisher.test` to 2e-13, exact enumeration, and `Exact` to 1e-7 | OUT OF SCOPE (methods) | companion book | |
| nof1power 0.1.0 | 1 placeholder test | empty scaffold, no exports | NOT YET; correct appendix E | none | |
| zzworld 0.2.0 | 510 pass | Levenshtein equals stringdist on 5 inputs | OUT OF SCOPE | appendix E only | |

**Corrections the book needs now** (Tier 1, independent of any
addition):

1. @sec-renv (`08-renv.qmd` lines 493 to 501): 'every package the code
   uses is declared and locked, and no locked package is unused' is
   false as written. Say what it checks (code against DESCRIPTION,
   DESCRIPTION against the lock, with `transitive = TRUE` for full
   coverage) and keep `renv::status()` as the authority.
2. @sec-git-solo footnote (`05-git-solo.qmd` lines 175 to 179): the
   guard is a confirmation before *pushing* to a protected branch;
   content scanning requires gitleaks, without which it checks
   filenames only and will commit an `.Renviron` holding a password.
   The gitleaks pre-commit hook in the main text stays the
   recommendation.
3. @sec-workstation (`04-workstation.qmd` line 719): the plugin is
   R.nvim, not 'R-Nvim'; do not imply zzvim-R renders Quarto with
   cross-references.
4. @sec-zzcollab (`10-zzcollab.qmd` lines 1261 to 1270): `make r`
   without an image asks before running host R and defaults to No;
   `make check-renv` installs zzrenvcheck from GitHub HEAD, unpinned,
   on first use; `zzc --help` lists profiles that disagree with
   `bundles.yaml` (fix in zzcollab, not the book).
5. @sec-penguins and @sec-adni (`23-penguins.qmd` line 357,
   `24-adni.qmd` line 752): the zztable1 examples fail the book's own
   'Missing shown as a row' checklist. Remove them, or show gtsummary
   only, until zztable1 is fixed.
6. Appendix E: nof1power describes functions that do not exist;
   zzedc's entry should state that encryption at rest is not active
   and that no validation evidence exists; zzobj2fig and zzpower
   entries should not imply maturity beyond version and tests.
7. HF-HOME codebook (`raw_data/hfhome/README.md` line 21) says
   'permuted blocks of 4'; the generator balances incomplete final
   blocks across the trial to fix exactly 1,216 per arm
   (`R/hfhome.R` line 524). Add that clause to the codebook.

**Features to write** (each 150 to 400 words, after the community
tool, with the comparison shown as computed output):

- *zzlongplot* in @sec-graphics: the existing section already has the
  right shape; add the computed agreement with `stat_summary`, the
  per-point n, and the caveat that day-30 means describe attenders.
- *zzrctsim* in the new simulation-study section (Gap 14): plan the
  study by ADEMP in a hand-written loop first, report MCSE with a
  helper, then show zzrctsim as a tested alternative that forces the
  estimand to be declared and attaches an MCSE to every measure;
  limits: Gaussian longitudinal outcomes only, one reference fitter.
  Its MCSE formulas should first be cross-checked against rsimsum.

**What would move the NOT YET tools up** (for the author's software,
not the book): zztable1, render the missing row and value-level
tests against gtsummary; zzpower, require `p2`, round enrolled n up,
add reference-value tests; zzrenvcheck, compare code with the lock
and default to transitive checks; zzedc, encryption that works or
fails loudly, an externally anchored audit trail, and a validation
package. Its tampering demonstration is itself a good teaching example
for Gap 5: a hash chain without an external anchor is not an audit
control.

**Repository status to check before printing.** zzuncondexact is a
private repository and simrun-demo has no remote; neither should be
cited until public. Public status of the others was confirmed only
for group B's packages.

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


## Principal sources

- Dunlosky, J., et al. (2013). Improving students' learning with
  effective learning techniques.
  https://www.psychologicalscience.org/news/releases/which-study-strategies-make-the-grade.html
- Adesope, O., et al. (2017). Rethinking the use of tests.
  https://education.wsu.edu/documents/2018/01/rethinking-use-tests.pdf/
- Cepeda, N. J., et al. (2006). Distributed practice in verbal recall
  tasks. https://pubmed.ncbi.nlm.nih.gov/16719566/
- Brunmair, M., and Richter, T. (2019). Similarity matters: a
  meta-analysis of interleaved learning.
- Ginns, P., Martin, A. J., and Marsh, H. W. (2013). Designing
  instructional text in a conversational style: a meta-analysis.
- Kirschner, P., Sweller, J., and Clark, R. (2006). Why minimal
  guidance during instruction does not work.
- Wilson, G. *Teaching Tech Together*. https://teachtogether.tech/en/
- The Carpentries. Lesson development handbook.
  https://docs.carpentries.org/handbooks/lesson_developers.html
- Timbers, T., and Cetinkaya-Rundel, M. Ten simple rules for teaching
  data science. https://arxiv.org/html/2602.02874v1
- Wickham, H., Cetinkaya-Rundel, M., and Grolemund, G. *R for Data
  Science* (2e), introduction. https://r4ds.hadley.nz/intro.html
- Bryan, J. *Happy Git and GitHub for the useR*.
  https://happygitwithr.com/
- Nielsen Norman Group. How users read on the web.
  https://www.nngroup.com/articles/how-users-read-on-the-web/
- Delgado, P., et al. (2018). Don't throw away your printed books.
  https://www.uv.es/lasalgon/papers/Delgado%202018%20dont%20throw%20away%20your%20printed%20books.pdf
- Faded Parsons problems. https://acelab.berkeley.edu/projects/faded-parsons
- Diataxis documentation framework.
  https://ubuntu.com/blog/diataxis-a-new-foundation-for-canonical-documentation

---
*Rendered on 2026-10-09 at 17:31 PDT.*<br>
*Source: ~/prj/tch/02-practicum/REFACTOR-PLAN.md*
