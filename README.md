# Biostatistics Practicum
*2026-04-23 19:06 PDT*

Source repository for the textbook accompanying **PHB 243B:
Practicum in Biostatistics** at UCSD. The book covers 'everything
that comes up during data analysis except statistical modelling
and inference' (Bryan 2019), filling the practical-skills gap
that most graduate statistical training leaves open.

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

1. **PHB 243B lecture materials** at
   `~/Dropbox/prj/tch/02-phb243b-biostat/lec*/`. These provide
   the course-based spine (reproducibility, federal requirements,
   Git, SAPs, workspace setup, testing, case studies).
2. **Working blog posts** at `~/prj/qblog/posts/`, drawn from
   real analyses and workstation setup notes. These contribute
   practical 'how I actually do it' content layered on the
   pedagogical material.
3. **Stat 545** (Jenny Bryan, UBC) for the philosophical framing
   and the Quarto + wrangling supplementary material.

## Chapter-to-source map

| #  | Chapter                                | Primary source          |
| -- | -------------------------------------- | ----------------------- |
|  1 | Why reproducible research              | 243B L2                 |
|  2 | Federal reproducibility requirements   | 243B L3                 |
|  3 | Team science for biostatisticians      | 243B L2 team-science    |
|  4 | Setting up your workstation            | 243B L6 + blogs 01, 06, 26, 30, 48 |
|  5 | Git and GitHub for solo developers     | 243B L4 + blogs 25, 49  |
|  6 | Cloud compute and remote servers       | blogs 22, 23, 48        |
|  7 | Research compendia with rrtools        | 243B + blog 28          |
|  8 | renv for package management            | 243B L6, L12            |
|  9 | Docker for reproducibility             | blogs 32, 33, 47        |
| 10 | The zzcollab framework                 | blogs 14, 42            |
| 11 | Reproducible reports with Quarto       | stat545 + blogs 07, 29  |
| 12 | Rmd workflow: conversions and tables   | blogs 17, 38            |
| 13 | Data wrangling essentials              | stat545 + blogs 04, 15, 43 |
| 14 | Factors, strings, and dates            | stat545                 |
| 15 | Joining and reshaping                  | stat545                 |
| 16 | Plotting with ggplot2 and purrr        | blog 16 + stat545       |
| 17 | Statistical analysis plans             | 243B L5, L7, L13-17     |
| 18 | CDISC data standards                   | `textbook/19-cdisc.qmd` (author's draft) |
| 19 | Testing data analysis workflows        | 243B L8 + blog 40       |
| 20 | AI-assisted coding                     | blog 46 ellmer + new    |
| 21 | Case study: Palmer Penguins            | 243B L10 + blogs 08-13  |
| 22 | Case study: ADNI MCI prediction        | 243B L12-17             |
| 23 | Course synthesis and review            | 243B L19                |

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
