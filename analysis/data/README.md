# Data Directory
*2026-11-09 13:01 PST*

This directory holds the data the book's chapters read. Everything
in it is synthetic or generated. No file here contains data about
real people.

```
data/
├── raw_data/
│   └── hfhome/        # HF-HOME trial exports and codebook
├── derived_data/      # build products; empty in the repository
└── README.md          # this file
```

## HF-HOME, the running study (`raw_data/hfhome/`)

HF-HOME is a synthetic two-arm randomized trial that runs through
the book and is the subject of the capstone (Chapter 35). It has
2,432 patients discharged after a heart-failure admission at five
sites, randomized 1:1 to usual care or to home-health visits
within seven days of discharge. Randomization is stratified by
site and ejection-fraction stratum. The primary outcome is
readmission or death within 30 days.

| File | Rows | Contents |
|---|---|---|
| `demographics.csv` | 2,432 | One row per patient. Contains direct identifiers (names, MRNs, dates of birth, telephone numbers, ZIP codes). |
| `randomization.csv` | 2,432 | Site, ejection-fraction stratum, sequence number, date, and arm. |
| `baseline.csv` | 2,432 | Discharge date, ejection fraction, discharge medication count, blood pressure, and weight. |
| `visits.csv` | 6,317 | One row per contact: discharge, home-health visits, and the day-30 clinic visit. |
| `labs.csv` | 23,233 | Laboratory results, one row per visit and test. |
| `medications.csv` | 16,927 | One row per discharge medication. |
| `outcomes.csv` | 2,432 | Whether the outcome was ascertained, the 30-day composite event, and the first event. |
| `crf_export.csv` | 2,432 | The raw case-report-form export, with each site's conventions for dates, sex codes, missing values, and identifiers. |

The codebook, `raw_data/hfhome/README.md`, documents every column
and every planted problem, with the chapter that teaches how to
find it.

**Read the codebook with care.** Its Design section reports the
observed event rate in each arm, because it documents the
generator. A student doing the capstone should not read that
section until their analysis plan is tagged (Chapter 35, 'The
project').

### Handling

- **Do not edit these files.** They are the evidence that the
  analysis starts from. Cleaning happens in code, and its results
  go to `derived_data/`.
- **Treat `demographics.csv` as protected health information.**
  The identifiers are synthetic, but they take the form real ones
  do, so that the de-identification exercises behave realistically.
  They must not leave the project, enter a prompt to a language
  model, or appear in a deposit.
- **Read every file with an explicit column specification.** Study
  IDs and ZIP codes carry leading zeros that a default
  `read.csv()` drops.

### Regenerating the files

The files are generated, not collected:

```bash
Rscript analysis/scripts/make_hfhome.R
```

The script calls `practicum::hfhome_generate()` with seed
20260423 and writes the eight files and the codebook. Every
number in the codebook is computed from the data it writes.

## Derived data (`derived_data/`)

Chapters and the capstone write cleaned and analysis-ready
datasets here, for example `analytic.rds`. These files are build
products. They can be rebuilt from `raw_data/` by the chapter or
pipeline that makes them, so none is kept in the repository.

## Other datasets the book uses

Two case studies use data that is not stored here:

- **Palmer penguins** (Chapter 30). The data come from the
  `palmerpenguins` R package [Horst, Hill, and Gorman 2022],
  loaded with `library(palmerpenguins)`.
- **ADNI** (Chapter 31). The Alzheimer's Disease Neuroimaging
  Initiative data are available only under a data-use agreement
  and are not redistributed. The chapter runs its pipeline on a
  synthetic stand-in, and explains how to run it on the real data
  once access is granted.
