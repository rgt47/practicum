# Ownership Review: Biostatistics Practicum
*2026-09-07 12:00 PDT*

This is the per-chapter tracking copy of the checklist from ['Review
Methodology for AI-Assisted Textbook
Drafting'](../../ryyblog/posts/rp-book-review-methodology/analysis/report/index.qmd),
applied to *Biostatistics Practicum*
(`analysis/report/`). One instance of the five-phase checklist plus
the ownership sign-off is copied per chapter below, rather than held
in memory across chapters in progress at once. A "no" anywhere in a
chapter's sign-off is a blocker, not a note for later.

Update the status table as chapters are reviewed. Check off phase
items as they are done; leave the sign-off unchecked until every
phase item for that chapter is checked.

## Status table

| # | Chapter | Phase 1 | Phase 2 | Phase 3 | Phase 4 | Phase 5 | Sign-off |
|---|---|---|---|---|---|---|---|
| 00 | Introduction | ✓ (1 issue) | ✓ (1 issue) | | | | |
| 01 | Why Reproducible Research | | | | | | |
| 02b | De-identification and Data Ethics | | | | | | |
| 03 | Team Science for Biostatisticians | | | | | | |
| 04 | Setting Up Your Workstation | | | | | | |
| 04b | The Unix Shell | | | | | | |
| 05 | Git and GitHub for Solo Developers | | | | | | |
| 05b | Git for Teams | | | | | | |
| 06 | Cloud Compute and Remote Servers | | | | | | |
| 07 | Research Compendia with rrtools | | | | | | |
| 08 | renv for Package Management | | | | | | |
| 09 | Docker for Reproducibility | | | | | | |
| 10 | The zzcollab Framework | | | | | | |
| 10b | Reproducible Pipelines with targets | | | | | | |
| 11 | Reproducible Reports with Quarto | | | | | | |
| 12 | Rmd Workflow: Conversions and Tables | | | | | | |
| 12b | Getting Data In: Files, APIs, and Scraping | | | | | | |
| 13 | Data Wrangling Essentials | | | | | | |
| 14 | Factors, Strings, and Dates | | | | | | |
| 15 | Joining and Reshaping | | | | | | |
| 15b | Databases and SQL for Biostatisticians | | | | | | |
| 16 | Plotting with ggplot2 and purrr | | | | | | |
| 17 | Missing Data: Diagnosis, Imputation, Reporting | | | | | | |
| 18 | Statistical Analysis Plans | | | | | | |
| 19 | Clinical Data Standards: CDISC, SDTM, and ADaM | | | | | | |
| 20 | Testing Data Analysis Workflows | | | | | | |
| 20b | Continuous Integration with GitHub Actions | | | | | | |
| 21 | AI-Assisted Coding | | | | | | |
| 22 | SAS for R Programmers | | | | | | |
| 23 | Case Study: Palmer Penguins | | | | | | |
| 24 | Case Study: ADNI MCI Prediction | | | | | | |
| 25 | Course Synthesis and Review | | | | | | |
| 25b | Communicating a Finished Analysis | | | | | | |
| 25c | Federal Requirements and Deposition | | | | | | |
| 25d | Ethics Beyond Compliance | | | | | | |
| C | Alternative Wrangling Paradigms | | | | | | |
| D | The Peer-Program Survey | | | | | | |
| E | The rgtlab Software | | | | | | |

## Per-chapter checklist template

Copy this block into a new section below for the chapter under
review, replacing `NN-slug` and the title.

```
### NN-slug — Chapter Title

**Phase 1: Structural**

- [ ] Drafted section headings and order match the curriculum outline
- [ ] Every stated learning objective is addressed, and nothing falls
      outside the stated objectives without reason
- [ ] Exercise placement and count proportionate to the chapter's
      weight in the curriculum

**Phase 2: Section-by-section**

- [ ] Every section reviewed for correctness, pedagogical alignment,
      worked-example integrity, notation/terminology consistency,
      and clarity
- [ ] Every worked example reworked independently before comparing
      against the drafted solution
- [ ] Every AI-generated-textbook pattern checked for, not just read
      past: notation drift, exercises without a verified answer,
      oversimplification at the boundary, hallucinated citations or
      historical claims, uneven difficulty curve, pattern mimicry in
      code examples

**Phase 3: Verification of examples and exercises**

- [ ] Every worked example independently recomputed, not trusted
      from the drafted derivation
- [ ] Every code example run in the exact environment (language and
      package versions) the book specifies
- [ ] Every exercise worked and its answer confirmed against the
      answer key, or an answer key created if none exists

**Phase 4: Cross-chapter integration**

- [ ] Terminology and techniques confirmed consistent with prior
      chapters, with no silent reintroduction or contradiction
- [ ] Any notation introduced in this chapter checked against how a
      later chapter uses it
- [ ] Forward references ("as we will see in Chapter N") confirmed
      to resolve to material that chapter actually contains

**Phase 5: Pedagogical and factual safety**

- [ ] No factual claim presented with more certainty than the field
      actually supports
- [ ] No method, theorem, or dataset misattributed to the wrong
      source
- [ ] Examples and exercises confirmed original or appropriately
      licensed, with no inadvertent overlap with an existing
      textbook's problem set

**Before publishing: ownership sign-off**

- [ ] Can teach the chapter's material from memory at the level the
      book targets
- [ ] Can work every exercise in the chapter and confirm the answer
      against the answer key
- [ ] Can identify where a student's likely misunderstanding would
      arise and explain past it
- [ ] Can predict how the chapter would need to change for a
      different audience level
- [ ] Can answer a reader's or reviewer's challenge to any specific
      claim or derivation, unaided

**Understanding:**

**Concerns:**

**Questions:**

**Changes required:**
```

## Reminders while working through this (from the source post)

- Review in curriculum order, not in isolation — a notation
  inconsistency is invisible within a single chapter.
- A well-written explanation can still be quietly wrong at the
  boundary; clear prose is not evidence of correctness.
- Do not delegate a flagged fix back to the assistant and accept the
  correction unread.
- Work every exercise yourself; an unverified exercise is common in
  assistant-drafted problem sets, not a rare edge case.
- "Read it" is not "can teach it." If you cannot teach the section
  from memory, it has not actually been reviewed.

## Reviews in progress

### 00-intro — Introduction

**Phase 1: Structural**

- [x] Drafted section headings and order match the curriculum outline
      — the eight parts and their chapter membership described here
      match `_quarto.yml` exactly, chapter for chapter. **Exception:**
      the appendices do not match; see Changes Required.
- [x] Every stated learning objective is addressed, and nothing falls
      outside the stated objectives without reason — N/A, this
      chapter has no "Learning objectives" section; it is the
      orientation chapter that describes the pattern other chapters
      follow, not an instance of that pattern itself.
- [x] Exercise placement and count proportionate to the chapter's
      weight in the curriculum — N/A, this chapter has no exercises,
      consistent with its role as front-of-book orientation.

**Phase 2: Section-by-section**

- [x] Every section reviewed for correctness, pedagogical alignment,
      worked-example integrity, notation/terminology consistency,
      and clarity — no worked examples in this chapter (orientation
      only). **Exception found:** "The chapter pattern" section's
      list of recurring components omits one; see Changes Required.
- [x] Every worked example reworked independently before comparing
      against the drafted solution — N/A, this chapter has no
      worked examples.
- [x] Every AI-generated-textbook pattern checked for, not just read
      past: notation drift (none found — all 35 `@sec-` labels in
      this chapter verified to resolve against actual chapter files),
      exercises without a verified answer (N/A, no exercises),
      oversimplification at the boundary (none found),
      hallucinated citations or historical claims (checked:
      [@wickham2019advr] resolves in references.bib and is used
      consistently in 11-quarto.qmd and 25-synthesis.qmd; the
      Aristotle epigraph and the companion-book title *Statistical
      Computing in the Age of AI* are both used consistently across
      the book — see index.qmd, 16-graphics.qmd, 24-adni.qmd),
      uneven difficulty curve (N/A), pattern mimicry in code
      examples (N/A, no code in this chapter).

**Phase 3: Verification of examples and exercises**

- [ ] Every worked example independently recomputed, not trusted
      from the drafted derivation
- [ ] Every code example run in the exact environment (language and
      package versions) the book specifies
- [ ] Every exercise worked and its answer confirmed against the
      answer key, or an answer key created if none exists

**Phase 4: Cross-chapter integration**

- [ ] Terminology and techniques confirmed consistent with prior
      chapters, with no silent reintroduction or contradiction
- [ ] Any notation introduced in this chapter checked against how a
      later chapter uses it
- [ ] Forward references ("as we will see in Chapter N") confirmed
      to resolve to material that chapter actually contains

**Phase 5: Pedagogical and factual safety**

- [ ] No factual claim presented with more certainty than the field
      actually supports
- [ ] No method, theorem, or dataset misattributed to the wrong
      source
- [ ] Examples and exercises confirmed original or appropriately
      licensed, with no inadvertent overlap with an existing
      textbook's problem set

**Before publishing: ownership sign-off**

- [ ] Can teach the chapter's material from memory at the level the
      book targets
- [ ] Can work every exercise in the chapter and confirm the answer
      against the answer key
- [ ] Can identify where a student's likely misunderstanding would
      arise and explain past it
- [ ] Can predict how the chapter would need to change for a
      different audience level
- [ ] Can answer a reader's or reviewer's challenge to any specific
      claim or derivation, unaided

**Understanding:** The chapter's "What this book covers" section
walks the reader through eight parts, each named and cross-referenced
to its chapters via `@sec-` labels, then a mermaid dependency diagram
of the parts, then scope boundaries ("What this book does not
cover"), audience assumptions, a recommended reading workflow, the
recurring per-chapter pattern, a note on the AI framing relative to
the companion volume, and a three-sentence summary. It is pure
orientation prose: no exercises, no learning-objectives section, by
design.

**Concerns:**

1. The appendix count is stale. The prose says "Two appendices
   follow: alternative wrangling paradigms
   (@sec-alternative-wrangling)... and the peer-program survey on
   which several chapters rest their case for existing
   (@sec-peer-survey)." `_quarto.yml` builds three appendices;
   `E-lab-software.qmd` ("The rgtlab Software") exists but is not
   named here, and the count is still stated as two. This is a
   Phase 1 (structural) and Phase 4 (cross-chapter integration)
   finding: the introduction is the book's map, and the map has a
   place that isn't on it. Owner has taken this fix.

2. "The chapter pattern" section lists eleven recurring components
   (Prerequisites quiz, Learning objectives, Orientation, The
   statistician's contribution, Technical sections, Worked examples,
   Collaborating with an LLM, Principle in use, Exercises, Further
   reading, Prerequisites answers) but omits a twelfth: every sampled
   chapter (`01-why.qmd`, `03-team-science.qmd`, `05-git-solo.qmd`,
   `09-docker.qmd`, `16-graphics.qmd`, `19-cdisc.qmd`, `24-adni.qmd`)
   opens with a `## Sources` callout-note before the Prerequisites
   quiz, e.g. "Adapted from author's lecture notes and supporting
   materials for a graduate practicum in biostatistics." This is
   exactly the kind of pattern-description gap Phase 2 exists to
   catch: a reader following "The chapter pattern" as a map to what
   they'll see will be surprised by the first heading in every
   chapter after this one. Separately, the list's ordering also
   doesn't quite match what chapters do in practice — in
   `01-why.qmd`, "The statistician's contribution" appears after
   several technical sections, not immediately after Orientation as
   the list's sequence might suggest — but the list may be intended
   as an unordered inventory rather than a strict page order, so
   this is a lower-confidence observation, not logged as a required
   change.

**Questions:** Is `E-lab-software.qmd` intentionally omitted from the
overview because it's a late addition, or should it be folded into
the Part-VIII description with the other two appendices?
Answered — checked (`grep -rn "appendices\|appendix" *.qmd`): no
other chapter counts or enumerates the appendices, so the stale
"two" is confined to `00-intro.qmd` and not propagated. This is
purely a fix-in-place, not a book-wide inconsistency.

**Changes required:**
- [ ] Update the appendices paragraph in `00-intro.qmd` to name and
      cross-reference `E-lab-software.qmd` (Appendix E), and change
      "Two appendices" to "Three appendices." (Owner fixing directly.)
- [ ] Add "Sources" to the bulleted list in "The chapter pattern,"
      placed first (it opens every sampled chapter, before the
      Prerequisites quiz), with a one-line description matching its
      actual content, e.g. "A callout noting what lecture notes or
      prior material the chapter draws on."

### 01-why — Why Reproducible Research

**Phase 1: Structural**

- [ ] Drafted section headings and order match the curriculum outline
- [ ] Every stated learning objective is addressed, and nothing falls
      outside the stated objectives without reason
- [ ] Exercise placement and count proportionate to the chapter's
      weight in the curriculum

**Phase 2: Section-by-section**

- [ ] Every section reviewed for correctness, pedagogical alignment,
      worked-example integrity, notation/terminology consistency,
      and clarity
- [ ] Every worked example reworked independently before comparing
      against the drafted solution
- [ ] Every AI-generated-textbook pattern checked for, not just read
      past: notation drift, exercises without a verified answer,
      oversimplification at the boundary, hallucinated citations or
      historical claims, uneven difficulty curve, pattern mimicry in
      code examples

**Phase 3: Verification of examples and exercises**

- [ ] Every worked example independently recomputed, not trusted
      from the drafted derivation
- [ ] Every code example run in the exact environment (language and
      package versions) the book specifies
- [ ] Every exercise worked and its answer confirmed against the
      answer key, or an answer key created if none exists

**Phase 4: Cross-chapter integration**

- [ ] Terminology and techniques confirmed consistent with prior
      chapters, with no silent reintroduction or contradiction
- [ ] Any notation introduced in this chapter checked against how a
      later chapter uses it
- [ ] Forward references ("as we will see in Chapter N") confirmed
      to resolve to material that chapter actually contains

**Phase 5: Pedagogical and factual safety**

- [ ] No factual claim presented with more certainty than the field
      actually supports
- [ ] No method, theorem, or dataset misattributed to the wrong
      source
- [ ] Examples and exercises confirmed original or appropriately
      licensed, with no inadvertent overlap with an existing
      textbook's problem set

**Before publishing: ownership sign-off**

- [ ] Can teach the chapter's material from memory at the level the
      book targets
- [ ] Can work every exercise in the chapter and confirm the answer
      against the answer key
- [ ] Can identify where a student's likely misunderstanding would
      arise and explain past it
- [ ] Can predict how the chapter would need to change for a
      different audience level
- [ ] Can answer a reader's or reviewer's challenge to any specific
      claim or derivation, unaided

**Understanding:**

**Concerns:**

**Questions:**

**Changes required:**

### 02b-deidentification — De-identification and Data Ethics

**Phase 1: Structural**

- [ ] Drafted section headings and order match the curriculum outline
- [ ] Every stated learning objective is addressed, and nothing falls
      outside the stated objectives without reason
- [ ] Exercise placement and count proportionate to the chapter's
      weight in the curriculum

**Phase 2: Section-by-section**

- [ ] Every section reviewed for correctness, pedagogical alignment,
      worked-example integrity, notation/terminology consistency,
      and clarity
- [ ] Every worked example reworked independently before comparing
      against the drafted solution
- [ ] Every AI-generated-textbook pattern checked for, not just read
      past: notation drift, exercises without a verified answer,
      oversimplification at the boundary, hallucinated citations or
      historical claims, uneven difficulty curve, pattern mimicry in
      code examples

**Phase 3: Verification of examples and exercises**

- [ ] Every worked example independently recomputed, not trusted
      from the drafted derivation
- [ ] Every code example run in the exact environment (language and
      package versions) the book specifies
- [ ] Every exercise worked and its answer confirmed against the
      answer key, or an answer key created if none exists

**Phase 4: Cross-chapter integration**

- [ ] Terminology and techniques confirmed consistent with prior
      chapters, with no silent reintroduction or contradiction
- [ ] Any notation introduced in this chapter checked against how a
      later chapter uses it
- [ ] Forward references ("as we will see in Chapter N") confirmed
      to resolve to material that chapter actually contains

**Phase 5: Pedagogical and factual safety**

- [ ] No factual claim presented with more certainty than the field
      actually supports
- [ ] No method, theorem, or dataset misattributed to the wrong
      source
- [ ] Examples and exercises confirmed original or appropriately
      licensed, with no inadvertent overlap with an existing
      textbook's problem set

**Before publishing: ownership sign-off**

- [ ] Can teach the chapter's material from memory at the level the
      book targets
- [ ] Can work every exercise in the chapter and confirm the answer
      against the answer key
- [ ] Can identify where a student's likely misunderstanding would
      arise and explain past it
- [ ] Can predict how the chapter would need to change for a
      different audience level
- [ ] Can answer a reader's or reviewer's challenge to any specific
      claim or derivation, unaided

**Understanding:**

**Concerns:**

**Questions:**

**Changes required:**

(Add further per-chapter sections here as you start them, using the
template above.)
