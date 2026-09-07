# Ownership Review White Paper: Biostatistics Practicum

*2026-09-07 13:34 PDT*

## Purpose

This white paper summarizes the ownership review of *Biostatistics
Practicum* undertaken against the five-phase checklist from
['Review Methodology for AI-Assisted Textbook
Drafting'](https://practicum.rgtlab.org). The full working checklist,
including blank per-chapter templates for chapters not yet reviewed,
lives in `REVIEW-CHECKLIST.md` at the repository root. This document
is a condensed, print-friendly summary of findings to date, intended
for a quick scan rather than as the working document itself.

## Scope of this summary

Three chapters have a checklist entry open: `00-intro`, `01-why`, and
`02b-deidentification`. Of these, only `00-intro` has been reviewed
so far, through Phase 2 of five. `01-why` and `02b-deidentification`
have checklist scaffolding in place but no review work done yet.
Nothing below should be read as covering the rest of the book's
thirty-seven chapters and appendices, which remain untouched.

## Findings: 00-intro (Introduction)

### Phase 1 — Structural

The chapter's account of the book's eight parts, and the chapter
membership of each, matches `_quarto.yml` exactly. One exception was
found.

**Finding 1: stale appendix count.** The chapter states, "Two
appendices follow: alternative wrangling paradigms... and the
peer-program survey." `_quarto.yml` actually builds three appendices;
`E-lab-software.qmd` ("The rgtlab Software") exists but is named
nowhere in this chapter, and the stated count is still two. A search
of every other chapter (`grep -rn "appendices\|appendix" *.qmd`)
found no other place that counts or enumerates the appendices, so
the inconsistency is confined to this one chapter and has not
propagated elsewhere. The book's owner has taken this fix directly
rather than delegating it back to an assistant.

This chapter has no explicit learning-objectives section and no
exercises. Both are correctly absent: the chapter is front-of-book
orientation, not an instance of the recurring chapter pattern it
describes for the rest of the book.

### Phase 2 — Section-by-section

No worked examples or code appear in this chapter, so most of the
usual verification load does not apply here. One exception was
found.

**Finding 2: incomplete pattern description.** "The chapter pattern"
section lists eleven components that recur across chapters:
Prerequisites quiz, Learning objectives, Orientation, The
statistician's contribution, Technical sections, Worked examples,
Collaborating with an LLM, Principle in use, Exercises, Further
reading, and Prerequisites answers. A sample of seven chapters
(`01-why`, `03-team-science`, `05-git-solo`, `09-docker`,
`16-graphics`, `19-cdisc`, `24-adni`) showed that every one of them
in fact opens with a twelfth component, a `## Sources` callout, that
this list omits entirely. A reader using this section as a map to
what each chapter contains will be surprised by the very first
heading in every chapter that follows.

A secondary, lower-confidence observation: in `01-why.qmd`, "The
statistician's contribution" appears well after several technical
sections rather than immediately after Orientation, which is one
plausible reading of the list's order in `00-intro`. Because the
list may be intended as an unordered inventory rather than a strict
page sequence, this was not logged as a required change.

No hallucinated citations or historical claims were found. The
citation `[@wickham2019advr]` resolves in `references.bib` and is
used consistently in `11-quarto.qmd` and `25-synthesis.qmd`. The
companion-book title, *Statistical Computing in the Age of AI*, is
used consistently across `index.qmd`, `16-graphics.qmd`, and
`24-adni.qmd`. All thirty-five `@sec-` cross-references in the
chapter were checked and resolve to real chapter labels; no notation
drift was found.

### Changes required, logged but not yet applied

- Update the appendices paragraph to name and cross-reference
  `E-lab-software.qmd` as Appendix E, and change "Two appendices" to
  "Three appendices." (In progress by the book's owner.)
- Add "Sources" to the bulleted list in "The chapter pattern,"
  placed first, since it opens every sampled chapter before the
  Prerequisites quiz, with a one-line description matching its
  actual content.

### Not yet reviewed for this chapter

Phases 3 through 5, and the ownership sign-off, remain open. Phase 3
(verification of examples and exercises) and the exercise-related
sign-off items are expected to resolve as not applicable, since this
chapter has neither worked examples nor exercises by design.

## Status of 01-why and 02b-deidentification

Both chapters have the full five-phase checklist and ownership
sign-off scaffolded in `REVIEW-CHECKLIST.md`, ready to fill in. No
review work has been performed on either yet.

## Reminders carried over from the source methodology

- Review in curriculum order, not chapter by chapter in isolation;
  a notation inconsistency is invisible within a single chapter.
- A well-written explanation can still be quietly wrong at a
  boundary the text does not mention.
- Work every exercise yourself rather than spot-checking; an
  unverified exercise is common in assistant-drafted material.
- "Read it" is not "can teach it." The ownership sign-off exists
  because reading a section is not the same as having reviewed it.

## Where to continue

The working checklist, including the exact phase items and the
templates for chapters not yet started, is in `REVIEW-CHECKLIST.md`
at the repository root. This white paper will be regenerated as
further chapters are reviewed.

---
*Rendered on 2026-09-07 at 13:34 PDT.*<br>
*Source: ~/prj/tch/02-practicum/docs/review-white-paper.md*
