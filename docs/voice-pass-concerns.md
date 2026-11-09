# Voice Pass: Open Concerns
*2026-11-08 10:35 PST*

The reviewers who revised the prose of the book on 2026-11-07 also
noted factual, technical, and consistency concerns. They were told
to report these and not to change them. This file collects those
concerns.

**How each item was checked.** Unless an item is marked otherwise,
it comes from a reviewer reading the source. No code was run and no
external documentation was consulted. Treat each item as a lead to
check, not as an established error. Line numbers are approximate
because the prose edits shifted them. All paths are relative to
`analysis/report/`.

## Resolved

- [x] **`14b-functions.qmd`, chunk `functions-scoping-frozen`.** The
  chunk emptied `hf_events` globally, and every later chunk would
  have run on an empty table. Confirmed by reading the source, and
  fixed: the table is saved before the demonstration and restored
  after it. Confirmed by the 2026-11-08 render: the later chunks
  produce per-site rates (0.206, 0.246, 0.212, ...) and no NaN.
- [x] **`21-ai-coding.qmd:66`, `@sec-tooling`.** Not a problem.
  `@sec-tooling` is the anchor of the tooling appendix heading
  (`H-tooling.qmd:1`), and `@sec-ai-tooling` is a subsection of it.
- [x] **zzcollab profile names** (`10-zzcollab.qmd`,
  `25-synthesis.qmd`). Checked against
  `~/prj/sfw/07-zzcollab/zzcollab/templates/bundles.yaml`, which
  defines `minimal`, `tidyverse`, `rstudio`, and `publishing`, and
  keeps `analysis` as a deprecated alias. The book is correct. The
  profile list in `~/.claude/CLAUDE.md` is out of date.

## 1. Decisions for the author

- [ ] **License conflict.** Confirmed by grep. `copyright.qmd:13`
  says CC BY-NC-ND 4.0. `index.qmd:27`, `colophon.qmd:19`,
  `credits.qmd:36`, and `preface.qmd:252` say CC BY 4.0. Under
  NC-ND terms, the book's own definition of OER
  (`F-glossary.qmd`, about line 561) would exclude it.
- [ ] **Two site URLs.** `copyright.qmd` uses
  `https://rgtlab.org/practicum`, while the `vol*-about.qmd` files
  use `https://practicum.rgtlab.org`.
- [ ] **Author attribution.** `credits.qmd` asks readers to contact
  'the author', but the book is credited to the 'rgtlab curriculum
  team'.
- [ ] **Edits that slightly change meaning.** Keep or revert each:
  - `preface.qmd`: Quarto 'took over much of the role of R
    Markdown' (was 'absorbed R Markdown's role').
  - `04b-shell.qmd`: 'In our view' added before `set -euo pipefail`
    being 'the most valuable line'.
  - `05b-git-teams.qmd`: 'In our view' added before review being
    'the most valuable thing a second reader does'.
  - `22-sas.qmd`: 'tends to go wrong at the boundary' (was 'goes
    wrong').
  - `21-ai-coding.qmd`: the AI disclosure paragraph now says
    'we'/'our' instead of 'the author'.
  - `23-penguins.qmd`: 'tells you little' (was 'tells you
    nothing'). Also, 'arc' became 'sequence' in the opener only,
    while `@tbl-penguins-arc` and the rest of the chapter still
    say 'arc'.
  - `10b-targets.qmd`: Make is 'far more widely installed' (was
    'ubiquitous').
- [ ] **Chapter-card labels.** 'You'll need' and 'You'll be able
  to' are contractions in a template used across the whole book.
  The reviewers left them alone.

## 2. Code that may fail or give wrong output

- [ ] `19-cdisc.qmd`, about line 890: the `tern` sketch passes
  `is_event = 'event'`, but `adtte` has no `event` column, and
  `analyze_vars('CNSR', afun = s_proportion)` looks like an invalid
  combination. The chunk is display-only.
- [ ] `19-cdisc.qmd`, about line 695: the `DTH30` derivation sets
  `CNSR = 0` for any `DTHDT` without the 30-day window check that
  `RDTH30` has. The solution says the count 'must be smaller' when
  it could be equal.
- [ ] `20-testing.qmd`, about line 654: the `validate` example
  checks `visit_day >= 0` on `hf_rand`, which presumably has no
  `visit_day` column.
- [ ] `20-testing.qmd`, about line 590: the prose implies that
  pointblank's `stop_at` halts the pipeline. In a `create_agent()`
  workflow it probably records the failure without halting.
- [ ] `20-testing.qmd`, about lines 685 and 700: the outcomes
  exercise asks for '`ascertained` is logical', but neither
  solution checks the type.
- [ ] `06-cloud.qmd:585`: the inline code `` `r`'`nsim`'` `` is
  malformed. Confirmed in the rendered HTML, which shows a stray
  `r`, `nsim` in curly quotes, and a stray backtick.
  $n_{\text{sim}}$ was presumably meant.
- [ ] `16-graphics.qmd:736`, `740`, and `848`: `@fig-bar-vs-points`
  and `@fig-trajectory` are inside backticks, so they will print as
  literal code rather than links. This may be intentional if the
  text is showing the syntax.
- [ ] `16-graphics.qmd:380` and `1042`: `coord_trans()` may have
  been renamed `coord_transform()` in ggplot2 4.0, which the book
  targets.
- [ ] `21-ai-coding.qmd:971`: `chat$extract_data()` and
  `type_enum(values)` may be out of date for current `ellmer`
  (possibly `chat_structured()`). The chunk is display-only.
- [ ] `13-wrangling.qmd`, about line 352: the inline `lazy_wrong[1]`
  would render NA without warning if the lazy parse produced no
  wrong dates.
- [ ] `25d-ethics.qmd`, exercise 6: the y-axis is fixed at 20% to
  24.5%, which assumes both arms' observed risks fall in that
  range.

## 3. Factual claims to check against sources

- [ ] `preface.qmd`: 'every NIH application has carried a Data
  Management and Sharing Plan'. The 2023 policy probably applies
  only to research that generates scientific data.
- [ ] `preface.qmd`: 'The FDA has required CDISC-conformant
  submissions since 2016'. This probably applies to certain
  application types and to studies starting after December 2016.
- [ ] `preface.qmd`: 'NIH/NSF reproducibility requirements'. These
  are mainly data-sharing and public-access requirements.
- [ ] `02c-deident-practice.qmd:908`: differential privacy bounds
  the change in the output distribution, not in 'that result'.
- [ ] `03-team-science.qmd:784`: 'second only to coding for those
  in their first five years' should be checked against
  `@slade2023team`.
- [ ] `17-missing.qmd`, about line 850: the descriptions of fmi and
  lambda are nearly identical. Strictly, lambda is
  $(1 + 1/M)B/T$, and fmi adds a degrees-of-freedom adjustment.
- [ ] `19-cdisc.qmd`, about line 1240: Part 11 'will not accept' a
  derivation run only at the console. Part 11 governs electronic
  records, not analysis provenance, so this is overstated.
- [ ] `20-testing.qmd`, about line 946: pre-commit usually leaves
  the reformatted file unstaged, not 'staged'.
- [ ] `22-sas.qmd:705`: with `TYPE = UN`, the between-within method
  normally gives within-subject effects within-subject degrees of
  freedom. Check against the PROC MIXED documentation.
- [ ] `23-penguins.qmd:781`: held-out accuracy 'would come back
  lower' is not shown in the chapter. 'may' would match the
  evidence.
- [ ] `24-adni.qmd:144`: 'roughly 15,000 visits on about 2,000
  participants' depends on the ADNIMERGE release. Recent releases
  may be closer to 16,000 rows and 2,400 participants.
- [ ] `25b-communicating.qmd`, about line 1205: CONSORT asks for
  the effect estimate and its precision. It does not ask for the
  primary p-value to be reported 'prominently'.
- [ ] `05b-git-teams.qmd`, about line 321: 'need a paid or
  organization plan' for branch protection. Check against
  GitHub's current plan documentation.
- [ ] `08-renv.qmd`, about line 290: only lockfiles from older
  versions of `renv` carry a `Hash` field.
- [ ] `04b-shell.qmd`, about line 829: the note on macOS `md5 -r`
  implies that current macOS ships `md5sum`.
- [ ] `14b-functions.qmd`: `sapply()` 'can shrink the same way'.
  `lapply()` and `sapply()` keep `NULL` elements, so the length is
  preserved. This appears in the Iteration table, rule of thumb 3,
  and the cheat sheet.
- [ ] `14b-functions.qmd`, after exercise 7: leaving `'condition'`
  out of the class vector probably produces a garbled error, not a
  silent failure.
- [ ] `14b-functions.qmd`, exercise 8 solution: check whether
  `tinytest::expect_silent()` fails on a message, or only on
  warnings and errors.
- [ ] `14b-functions.qmd`: the `traceback()` and `recover`
  transcripts show purrr's error format from before version 1.0.
- [ ] `14b-functions.qmd`, cheat sheet: `rlang::abort()` has no
  `data =` argument. Named fields go through `...`.
- [ ] `14b-functions.qmd`, `options(error = recover)` paragraph: the
  option is set for the session, not written to `.Rprofile`.
- [ ] `K-interactive-deliverables.qmd`: `CDISCFilterableTeal` may
  not be a current teal class. Current teal uses `cdisc_data()` and
  `teal_data`.
- [ ] `09-docker.qmd:238` and `240` against
  `10-zzcollab.qmd:1354`: image sizes disagree (`rocker/r-ver` is
  0.8 GB in one and 650 MB in the other; `rocker/tidyverse` is
  3 GB against 1.2 GB). The 10-zzcollab table also lists
  `rocker/rstudio` as smaller than `rocker/tidyverse`, which is
  built on top of it.
- [ ] `10-zzcollab.qmd:1572` to `1580`: the `R CMD check` example
  has several problems. The warning shown does not fit the roxygen
  block. It is not the failure the text describes. Real output
  would probably include a 'no visible binding for global variable'
  NOTE. Finally, `R CMD check` does not verify that `NAMESPACE`
  matches what roxygen2 wrote.

## 4. Internal inconsistencies

- [ ] `15b-databases.qmd`, about line 484: 'One row lost and one
  row gained leave a count that is off by one'. A lost row and a
  gained row cancel out.
- [ ] `14b-functions.qmd`, exercise 2: the exercise refers to
  itself, and the explanation in the solution does not match the
  code. The first call works because `default` was supplied.
- [ ] `14b-functions.qmd`, exercise 6: `-99` is returned for two
  values, not 'one value'.
- [ ] `14b-functions.qmd`, chapter card: it names four packages but
  says 'All three packages are installed'. It also says `tinytest`
  is called with its namespace, while the code uses
  `library(tinytest)`.
- [ ] `03-team-science.qmd:579` against `1088`: Habit 11 is 'Match
  the verb to the evidence' in one place and 'to the design' in
  the other.
- [ ] `01-why.qmd:657`: 'the book puts @sec-ethics last' conflicts
  with `00-intro.qmd`, which says a print volume may place it
  earlier.
- [ ] `04-workstation.qmd`, about line 434, against `08-renv.qmd`,
  about line 131: the macOS renv library paths disagree
  (`aarch64-apple-darwin20` against `x86_64`).
- [ ] `04-workstation.qmd`, setup script: installs
  `font-jetbrains-mono`, while the Fonts section recommends the
  Nerd Font variant.
- [ ] `05b-git-teams.qmd`, about line 358, and quiz answer 3: the
  check answer and quiz say CI runs 'against the proposed state
  rather than the merged one', but the body says 'against the
  proposed merge'.
- [ ] `05-git-solo.qmd`, quiz answer 3: presents `git stash` as a
  way to avoid committing, while the body prefers a commit.
- [ ] `08-renv.qmd`, about line 666: Docker is 'in the next
  chapter'. Check this against the actual chapter order.
- [ ] `11-quarto.qmd`, prerequisites answer 3: 'Commit `_freeze/`'
  without qualification, while the body says 'Commonly' and warns
  about merge conflicts.
- [ ] `15b-databases.qmd`, reproducible-extract section: cites
  `@sec-apis` for the raw-data rule, while the chapter card cites
  `@sec-acquisition`.
- [ ] `18-analysis-plan.qmd:1303`: 'due with the grant application,
  two years before the first dataset exists' reads as a general
  rule. It presumably applies only to HF-HOME.
- [ ] `18-analysis-plan.qmd`, about line 208: 'distinguishes the two
  situations' does not say which two situations.
- [ ] `19-cdisc.qmd`, about line 939: 'the ADaM double-programming
  check earlier in this chapter' comes later. The cross-reference
  also points to the section it already sits in.
- [ ] `10-zzcollab.qmd:1274`: the tidyverse profile is said to use
  `rocker/tidyverse`, but the digest example shows `rocker/r-ver`.
- [ ] `10-zzcollab.qmd:1171`: the `rrtools` row cites
  `@marwick2018packaging`. Elsewhere the package is cited as
  `@marwick2018rrtools`.
- [ ] `10-zzcollab.qmd:1479`: 'nine lines' does not match the
  DESCRIPTION file shown. Also, `License: MIT + file LICENSE` needs
  a LICENSE file to pass `R CMD check`.
- [ ] `25-synthesis.qmd`, prerequisites answer 3: the question asks
  for 'three files', but the answer also requires the raw data and
  scripts.
- [ ] `25b-communicating.qmd`, comment 3.2: the reviewer objects to
  'a logistic regression', but the primary analysis shown is an
  unadjusted Wald risk difference.
- [ ] `25b-communicating.qmd`: 'A guideline's number changes less
  often than its content' is unclear. 'Number' probably means
  version or year.
- [ ] `G-instructor-guide.qmd`, capstone notes: says to drop
  milestone 11 in a short term, then to grade milestone 11.
- [ ] `G-instructor-guide.qmd`, Ethics notes: 'each of the five
  failures' is followed by four chapters.
- [ ] `colophon.qmd` against `I-rmd-migration.qmd`: confirm that
  'Habit 4' (pin the environment) matches the numbering in
  `@sec-habits`.

## 5. Exercise numbering and solution labels

- [ ] `03-team-science.qmd:1058`: exercise 9 comes before
  cumulative exercises 7 and 8.
- [ ] `10b-targets.qmd`, about line 1045: cumulative exercises 7
  and 8 reuse numbers the chapter already used.
- [ ] `11-quarto.qmd`, about line 860: exercise 10 comes before
  exercise 6.
- [ ] `14-types.qmd`: exercise 7's solution is labeled `soln-14-5`,
  and exercise 5's is labeled `soln-14-5a`.
- [ ] `15-joins.qmd`: `soln-15-3` and `soln-15-4` are swapped.
- [ ] `16-graphics.qmd`: two exercises are numbered 6, and one
  solution is labeled `soln-16-7` (line 855).
- [ ] `17-missing.qmd:1221`: exercise 5's solution is labeled
  `fig-soln-17-4`. Also, the text gives delta the open interval
  (-1, 1), while `seq(-1, 1, by = 0.25)` includes both endpoints.
- [ ] `20-testing.qmd`: there are two exercise 1s and two
  exercise 4s.
- [ ] `23-penguins.qmd`: `soln-23-1` and `soln-23-2` are swapped.

## 6. Hard-coded values and minor items

- [ ] `02c-deident-practice.qmd:733`: 'Site A enrolled 701 patients'
  is typed in, not computed inline.
- [ ] `02c-deident-practice.qmd:860`: 'consistent with the
  protective effect' is fixed prose about a computed odds ratio.
- [ ] `15b-databases.qmd`, about line 245: '163 unascertained
  outcomes' is typed in, not computed inline.
- [ ] `25c-federal.qmd`, `@tbl-federal-asof`: several rows are
  blank under Verified, and three are blank under Effective.
- [ ] `21-ai-coding.qmd:936`: defines `hf()` a second time (first
  defined at about line 340).
- [ ] `12c-apis.qmd`, about line 605: one line of the
  cumulative-practice item runs past the wrap width.
- [ ] Wrap width: some lines in the revised paragraphs exceed about
  72 characters (for example in `04-workstation.qmd`). This is
  cosmetic only.

## Build status

As of 2026-11-08, every build succeeds with code execution:

- the whole-book HTML site;
- the whole-book PDF (1,341 pages);
- the three print volumes, regenerated from the revised chapters
  with `tools/build-volumes.py` (651, 449, and 336 pages).

The only '??' or '?@' strings in the PDFs are dbplyr's `SQL [?? x
5]` header and deliberate examples in `11-quarto` and
`I-rmd-migration`. The volumes were rendered with `R_LIBS_USER`
pointed at the project's renv library, since the generated volume
folders have no `.Rprofile`.

- **`16-graphics.qmd` (resolved).** It first failed at
  `graphics-worked-verify` because XQuartz, which CRAN's R for
  macOS needs for cairo, was missing. After XQuartz was installed
  the chapter rendered, and all 11 figures were written.
- **No unresolved cross-references.** Every `?@fig-` in the built
  HTML is a deliberate example inside `<code>`, in `11-quarto` and
  `I-rmd-migration`.
- **Pre-render checks passed.** These are `tools/us-spelling` in
  check mode and `tools/check-entities.sh`.
- **Structure unchanged.** A script compared the changed files with
  `HEAD`. Code chunks, anchors, cross-references, citations, inline
  R, and div fences were unchanged, apart from two mermaid figure
  captions and the deliberate 14b fix.
- **Not built.** The PDF and the `vol*` profiles were not built.

### Build environment notes for this machine

- **R 4.6 platform change.** CRAN's R 4.6.0 reports the platform
  `aarch64-apple-darwin23`, so renv created a new, empty project
  library for it. The earlier library was under
  `aarch64-apple-darwin25.4.0`.
- **Miniconda shadows system tools.** `/opt/miniconda3/bin` comes
  before the system's `xml2-config` and `curl-config` on `PATH`.
  This makes `curl` and `xml2` link against Miniconda libraries
  that R cannot load. Restore with Miniconda removed from `PATH`.
- **No CRAN gfortran or gettext.** CRAN's gfortran (`/opt/gfortran`)
  and gettext (`/opt/R/arm64`) are not installed. The restore used
  Homebrew's gfortran 16 and gettext, through a temporary
  `R_MAKEVARS_USER` file. As a result, `mvtnorm`, `pan`,
  `RcppArmadillo`, and `data.table` load Homebrew's
  `libgfortran`/`libintl`. If Homebrew's `gcc` or `gettext`
  changes, rebuild them.
- **Packages missing from the lockfile (resolved).** `duckdb`,
  `gtsummary`, `mmrm`, `quarto`, and `targets` are now recorded in
  `renv.lock` with their 14 new dependencies. Recording them also
  raised `xfun` from 0.58 to 0.62. The recorded R version was kept
  at 4.6.1.
- **Recorded but unused.** `renv::status()` reports `here`,
  `RcppTOML`, `repr`, `reticulate`, and `skimr` as recorded but not
  used by any file renv scans. They were left in the lockfile.
