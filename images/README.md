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

## Planned portraits

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
