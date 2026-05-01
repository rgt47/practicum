# Biostatistics Practicum
*2026-04-23 19:06 PDT*

Source repository for the open-access graduate textbook
**Biostatistics Practicum**. The book covers the practical
workflow that surrounds statistical modelling: reproducibility,
Git, Docker, Quarto reporting, tidyverse data wrangling, and
clinical-trial case studies. It fills the practical-skills gap
that most graduate statistical training leaves open; Jenny
Bryan's STAT 545 (Bryan 2019) at UBC is the pedagogical model.

- **Live site:** <https://rgtlab.org/practicum>
- **License:** CC BY-NC-ND 4.0 (see `LICENSE.md`)
- **Format:** Quarto book (HTML + PDF)
- **Template:** Follows Posit/Hadley book conventions (Advanced R,
  R for Data Science, R Packages).

## Local build

Prerequisites: Quarto 1.5+ and R 4.4+.

```bash
make deps       # install R package dependencies
make render     # render HTML + PDF to _book/
make preview    # live preview at http://localhost:4200
```

## Content sources

Chapter outlines are derived from three sources:

1. **Author's graduate practicum lecture materials** (speaker
   notes, slides, supporting scripts). These provide the
   pedagogical spine: reproducibility, federal requirements,
   Git, SAPs, workspace setup, testing, and case studies.
2. **Working blog posts** at `~/prj/qblog/posts/`, drawn from
   real analyses and workstation setup notes. These contribute
   practical 'how I actually do it' content layered on the
   pedagogical material.
3. **Stat 545** (Jenny Bryan, UBC) for the philosophical framing
   and the Quarto + wrangling supplementary material.

## Deploying to `rgtlab.org/practicum`

Recommended pattern: deploy to its own Netlify site
(`practicum.netlify.app`) and add a path-based redirect from the
main `rgtlab.org` site:

```
/practicum/*  https://practicum.netlify.app/:splat  200
```

## Relationship to the sibling book

This book is a companion to **Statistical Computing in the Age
of AI** (at
`~/Dropbox/prj/tch/01-phb228-stat-computing/phb228-2026/textbook/`),
which covers the statistical modelling and inference that this
book explicitly excludes. The two books share audience, style,
and the Prereq/Quiz-answers pedagogy.

## Open source questions

- **Chapter 18 (CDISC):** authored from a draft originally
  at `~/Dropbox/prj/tch/01-phb228-stat-computing/phb228-2026/textbook/19-cdisc.qmd`
  (now deleted; canonical copy lives only here with anchor IDs
  renumbered 19 → 18).
