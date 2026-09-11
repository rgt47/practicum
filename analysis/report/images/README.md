# Images
*2026-04-23 19:06 PDT*

Image assets for **Biostatistics Practicum**.

## Policy

- **Cover image:** required. One image, placed here as
  `cover.png` (or `.jpg`/`.svg`). Referenced from `_quarto.yml`
  via `cover-image:` under the `book:` key. Should be clean and
  scholarly; either a hex-sticker composite (matches Posit book
  family convention) or a thematic still photograph.
- **Content figures only inside chapters.** Follow the Posit
  editorial discipline. Figures exist to teach. Do not add
  decorative chapter-opener images, AI-generated hero images, or
  part-divider art.
- **Portraits of foundational figures:** permitted sparingly
  (four to five across the book), placed in `portraits/`. Each
  portrait appears once, at the first substantive introduction
  of the figure, using a compact right-aligned block:

  ```markdown
  ![Jenny Bryan, whose *Happy Git with R* set the standard for
   teaching version control to
   statisticians.](images/portraits/bryan.jpg){fig-align='right'
   width='25%'}
  ```

  All portraits must be CC-BY/CC0 or appear under permission;
  attribution goes in `credits.qmd`.

## Current state (2026-09-08)

Two portraits are placed, both from Wikimedia Commons with named
photographers and explicit licenses, resized to 400 px on the long
edge and stripped of metadata:

- `portraits/gentleman.jpg` — Ch 7, CC BY 3.0, R Consortium
- `portraits/wickham.jpg` — Ch 13, CC BY-SA 4.0, self-supplied

Both sit in a `.column-margin` block before the chapter's
`## Orientation` heading, with the license credited in the caption and
in full in `credits.qmd`.

**The other three planned slots are removed, not deferred.** A search
of Wikimedia Commons in September 2026 found no freely licensed
photograph of Jenny Bryan, JJ Allaire or Yihui Xie, and none of their
personal sites states license terms permitting reuse. The same search
found nothing for Frank Harrell, Roger Peng, Donald Rubin, Karl Broman,
Carl Boettiger or Friedrich Leisch.

Four cautions for anyone repeating that search:

- `File:JJ_Allaire_at_Web_2.0.jpg` on Commons is **Jeremy Allaire**,
  his twin brother. The file page says so; the filename does not.
- A CC badge in a personal site's footer is not a usable grant when it
  carries no version and no scope, and when the subject probably does
  not hold rights to a photograph taken of them.
- `opensource.posit.co/people/` has headshots of Bryan, Allaire and
  Wickham, and its footer reads "All rights reserved". Open-source
  software does not imply openly licensed photographs.
- **Follow the image URL before trusting a page's license.** rOpenSci
  licenses its site CC BY, and two of its pages behave oppositely.
  The Jenny Bryan headshot is self-hosted under `ropensci.org/img/`
  and is plausibly covered. The Carl Boettiger headshot on his author
  page is hot-linked from `github.com/cboettig.png`, a GitHub avatar
  that rOpenSci neither owns nor can license. Same footer, different
  answer.

No useR! conference group photographs are freely licensed on
Commons either, and a crowd photograph would in any case be ambient
decoration under the policy above rather than a figure tied to an
argument.

The gap is not a search problem. Working statisticians rarely have
Commons portraits because nobody has uploaded one. Email is the route
that works.

## Planned portraits (original April list, now superseded)

| Chapter                        | Figure                  | Reason                                        |
| ------------------------------ | ----------------------- | --------------------------------------------- |
| Ch 5 Git for Solo Developers   | Jenny Bryan             | *Happy Git with R*; pedagogical canon         |
| Ch 7 Research Compendia        | Ben Marwick             | `rrtools` principal author                    |
| Ch 11 Reproducible Reports     | JJ Allaire              | Quarto, Posit founder                         |
| Ch 12 Rmd Workflow             | Yihui Xie               | `knitr`, `rmarkdown`, `bookdown` author       |
| Ch 13 Data Wrangling           | Hadley Wickham          | tidyverse, *R for Data Science*               |

## Contributing an image

1. Obtain the image from a CC-BY/CC0 source (Wikimedia Commons,
   Posit community, conference video), or from the subject's own
   public profile with permission.
2. Resize to approximately 400 px on the long edge; compress.
3. Save as `portraits/<surname>.jpg`.
4. Add an entry to `credits.qmd` with source URL, license, and
   attribution text.
5. Reference from the target chapter with the compact markdown
   block above.
