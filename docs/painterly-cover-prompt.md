# Painterly cover-image prompt (fallback / alternate)
*2026-04-25 14:30 PDT*

> **Status:** not the canonical cover system. The practicum
> ships its cover via the procedural Python script at
> `images/build-cover.py`, which is reproducible,
> versionable, and free of API dependencies. This document
> is preserved for the narrow case where a more painterly
> top zone is wanted (real watercolour bleeds rather than
> procedural radial blobs), or where a separate hero/social
> card with bespoke illustration is wanted alongside the
> procedural cover. In that case, ask Gemini for the
> *background only* (no text), save the PNG, modify
> `build-cover.py` to load the AI-painted PNG instead of
> calling `watercolour_zone()`, and let the script overlay
> the text exactly as it does today.

The prompt below is intended for Gemini (Imagen 3) and
similar text-to-image models. Title, subtitle, and author
text are intentionally omitted from the generation; overlay
them programmatically afterwards so that typography matches
the rest of the book.

## Prompt (paste into Gemini)

```
A scholarly cover-art illustration for a graduate
biostatistics textbook titled 'Biostatistics Practicum:
Reproducible analysis workflows for biostatisticians.'

Visual concept: a modern flat-illustration composition
depicting a reproducible-research workflow as a calm,
ordered system of layered components. The central subject
is a 'research compendium' rendered as three slightly
overlapping horizontal panels stacked on a soft pedestal:
the bottom panel evokes a raw-data layer (faint tabular
grid suggestive of rows and columns, no actual numbers);
the middle panel evokes an analysis layer with abstracted
chart motifs (a small scatter plot with a regression line,
a boxplot silhouette, a histogram silhouette) treated as
simple geometric shapes; the top panel evokes a manuscript
layer with abstract horizontal lines suggesting paragraphs
and one block suggesting a figure caption. Around the
stack, a small constellation of softly-drawn workflow
icons: a Git-branch graph (three connected circular nodes
with two branching lines), a small container cube with
faint shading, a tidy four-cell spreadsheet grid, a code-
block bracket symbol rendered as two short vertical
strokes with serifs, and a small dotted line connecting
two of the icons to suggest a pipeline. The arrangement
should feel like a deliberate diagram, not a chaotic
explosion of icons.

Style: contemporary flat illustration with subtle
gradients, in the visual tradition of cover art for Posit
or O'Reilly statistical-computing books (for example, the
cover language of *ggplot2*, *Tidy Modeling with R*, and
*Mastering Shiny*). Clean geometric shapes; minimal but
intentional detail; no photorealism; no 3D rendering; no
glossy highlights; no isometric perspective; no sticker-
style outlines. Slight paper-grain texture across the
background for warmth.

Color palette: anchored in deep teal #2c7a7b (the book's
primary brand colour). Complementary accents in soft
ivory or cream #f8f4e9 for the background, muted gold
#c9a961 for selective highlights and rule lines, and
charcoal #2d3748 for line work and small details. Use
muted versions of the palette throughout; avoid pure
black, pure white, and any saturated red, orange, or
magenta.

Composition: vertical 2:3 aspect ratio, sized for a 1200
by 1800 pixel book cover. The central subject occupies
the middle 60% of the canvas vertically. The top 20% and
bottom 20% are intentionally simpler and quieter so that
title text (above) and author/date text (below) can be
overlaid afterwards without competing with the
illustration. Loose symmetrical balance rather than strict
mirror symmetry. The pedestal under the stack should feel
grounded but not heavy, like a faint horizontal line or
soft shadow rather than a literal table.

Mood: scholarly, restrained, contemporary; intellectually
serious without being austere. The image should feel like
the cover of a textbook a graduate student would be proud
to keep on a shelf next to *R for Data Science* and
*Advanced R*.

Hard constraints (do not include):
- No text of any kind: no letters, numbers, mathematical
  symbols, or symbols that look like text. The title will
  be added later.
- No human figures, faces, hands, or silhouettes.
- No neural networks, brains, robots, sparks, lightning
  bolts, or other AI-cliche imagery.
- No penguins, mice, or laboratory animals (the book uses
  the Palmer Penguins dataset for one chapter only;
  featuring penguins on the cover would mislead readers
  about the book's scope).
- No code with syntax highlighting; no editor windows; no
  command-line prompts; no shell terminals.
- No Quarto, R, RStudio, Posit, GitHub, Docker, AWS, or
  Netlify logos or recognisable brand marks.
- No stock-photo office settings with laptops, mugs, or
  desks.
- No flying papers, no swirls, no abstract 'data
  explosion' compositions.

Output: a single image, vertical 2:3 aspect ratio, 1200 by
1800 pixels, suitable as a book-cover illustration that I
will overlay typographic title and author text on
programmatically.
```

## Variants

### Horizontal hero (16:9) for blog or social-card use

Use the same prompt with two changes near the end:

- Replace 'vertical 2:3 aspect ratio, sized for a 1200 by
  1800 pixel book cover' with 'horizontal 16:9 aspect
  ratio, sized for a 1920 by 1080 pixel hero image'.
- Replace the 'top 20% and bottom 20%' sentence with: 'The
  left 30% and right 30% are intentionally simpler so that
  overlay text (title left, subtitle right) can be added
  afterwards without competing with the illustration.'

### Square (1:1) for thumbnail use

- Replace the aspect-ratio sentence with 'square 1:1
  aspect ratio, sized for a 1024 by 1024 pixel
  thumbnail'.
- Drop the 'top 20% and bottom 20%' simplification clause
  (a thumbnail does not need text overlay space).

## Iteration tips

If the first generation is unsatisfactory, the most
productive iteration levers (in order):

1. **Tighten the negative list.** If Gemini produces
   undesired elements (penguins, code, faces), explicitly
   forbid each one in the negative-constraint block.
2. **Tighten the colour palette.** Add hex values for any
   accents that drift; explicitly forbid colours that
   appear unwanted.
3. **Specify the icon set.** Replace the constellation
   description with a more restrictive list (for example,
   'three icons only: a Git branch, a container cube, and
   a tidy grid').
4. **Adjust the style anchor.** If the result feels too
   illustrated, replace 'flat illustration' with
   'minimalist editorial illustration' or 'risograph
   print-style illustration'. If it feels too abstract,
   replace with 'isometric flat illustration with light
   directional shading'.
5. **Reduce iconography density.** If the composition is
   busy, reduce the surrounding icons from five to three,
   or remove them entirely and rely on the central stack
   alone.

Save the working version that produces a usable image.
The combination of the central layered-stack metaphor and
the restrained Posit-tradition palette is the
load-bearing part of this prompt; the surrounding details
adjust the mood and density.

## After generation

Save the result as `images/cover.png` (replace the current
placeholder). Because the prompt deliberately omits text,
overlay the title, subtitle, author, and year using
ImageMagick or a vector-graphics tool. A reproducible
script for the overlay step in the same `images/`
directory makes future regeneration trivial when the
title or author changes.

---
*Source: ~/Dropbox/prj/tch/biostatistics-practicum/images/hero-prompt.md*
