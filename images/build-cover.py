#!/usr/bin/env python3
"""
Build a cover image for the Biostatistics Practicum, in the
visual idiom of the Springer Texts in Statistics series:
two-zone composition with a watercolour-painted top zone
and a solid bottom zone, clean sans-serif typography.

Usage:
    python3 build-cover.py
Output:
    cover.png   (1200 x 1800, the book cover)
"""

import math
import random
from PIL import Image, ImageDraw, ImageFilter, ImageFont

# --- canvas ---------------------------------------------------------------

W, H        = 1200, 1800           # cover dimensions (2:3)
SPLIT_Y     = int(H * 0.36)        # top/bottom boundary

# --- colours --------------------------------------------------------------

# brand teal anchors the bottom zone
TEAL_DARK   = (44, 122, 123)       # #2c7a7b
TEAL_DEEP   = (31, 78, 86)         # darker teal for shadowing
CREAM       = (248, 244, 233)      # used sparingly for hairline
GOLD        = (201, 169, 97)       # accent
INK         = (45, 55, 72)         # charcoal
WHITE       = (255, 255, 255)

# top-zone watercolour palette: cool teals to dusty plum to coral
WATERCOLOUR = [
    (33,  84, 110),   # deep blue-teal
    (52, 142, 142),   # mid teal
    (122, 110, 162),  # dusty violet
    (188, 105, 130),  # dusty rose
    (216, 145, 110),  # warm coral
]

# --- helpers --------------------------------------------------------------

def lerp(a, b, t):
    return tuple(int(a[i] + (b[i] - a[i]) * t) for i in range(3))


def palette_at(t, palette=WATERCOLOUR):
    """Linear interpolation across a palette, t in [0, 1]."""
    n = len(palette) - 1
    pos = t * n
    i   = int(pos)
    if i >= n:
        return palette[-1]
    return lerp(palette[i], palette[i + 1], pos - i)


def watercolour_zone(width, height, seed=47):
    """
    Build a soft watercolour-style gradient by drawing many
    overlapping radial blobs across the canvas. The result
    feels painted rather than printed.
    """
    rng  = random.Random(seed)
    base = Image.new('RGB', (width, height), (240, 240, 240))
    px   = base.load()

    # diagonal gradient as a base
    for y in range(height):
        for x in range(width):
            # use a curved diagonal so the colours feel painted
            t = (x / width * 0.55 + y / height * 0.45)
            t = max(0.0, min(1.0, t))
            px[x, y] = palette_at(t)

    # overlay several blurred blobs to fake watercolour bleed
    overlay = Image.new('RGB', (width, height), (0, 0, 0))
    odraw   = ImageDraw.Draw(overlay)
    mask    = Image.new('L', (width, height), 0)
    mdraw   = ImageDraw.Draw(mask)

    for _ in range(28):
        cx = rng.randint(-100, width + 100)
        cy = rng.randint(-50, height + 50)
        r  = rng.randint(180, 480)
        col = palette_at(rng.uniform(0, 1))
        odraw.ellipse((cx - r, cy - r, cx + r, cy + r), fill=col)
        mdraw.ellipse((cx - r, cy - r, cx + r, cy + r), fill=70)

    overlay = overlay.filter(ImageFilter.GaussianBlur(radius=120))
    mask    = mask.filter(ImageFilter.GaussianBlur(radius=80))
    base    = Image.composite(overlay, base, mask)

    # final softening for a paper-grain feel
    base    = base.filter(ImageFilter.GaussianBlur(radius=2))
    return base


def add_paper_grain(img, strength=8, seed=11):
    """Light random noise to suggest paper grain."""
    rng    = random.Random(seed)
    grain  = Image.new('L', img.size, 128)
    gpx    = grain.load()
    for y in range(img.size[1]):
        for x in range(img.size[0]):
            gpx[x, y] = max(0, min(255, 128 + rng.randint(-strength, strength)))
    grain = grain.filter(ImageFilter.GaussianBlur(radius=0.5))
    img.paste(Image.blend(img.convert('RGB'),
                          Image.merge('RGB', (grain, grain, grain)),
                          0.05))
    return img


def font(name, size, weight=''):
    """
    Load a TrueType / system font. macOS fonts are .ttc
    collections; pillow accepts an index for the face.
    """
    candidates = {
        'avenir-medium':   ('/System/Library/Fonts/Avenir.ttc', 2),
        'avenir-heavy':    ('/System/Library/Fonts/Avenir.ttc', 6),
        'avenir-black':    ('/System/Library/Fonts/Avenir.ttc', 7),
        'avenir-book':     ('/System/Library/Fonts/Avenir.ttc', 1),
        'avenir-light':    ('/System/Library/Fonts/Avenir.ttc', 0),
        'helvetica-bold':  ('/System/Library/Fonts/Helvetica.ttc', 1),
        'helvetica':       ('/System/Library/Fonts/Helvetica.ttc', 0),
    }
    path, idx = candidates[name]
    return ImageFont.truetype(path, size, index=idx)


def draw_text(draw, xy, text, fnt, fill, anchor='lt', spacing=0):
    draw.text(xy, text, font=fnt, fill=fill, anchor=anchor, spacing=spacing)


# --- build ---------------------------------------------------------------

def build():
    # base canvas
    canvas = Image.new('RGB', (W, H), TEAL_DARK)

    # top watercolour zone
    top = watercolour_zone(W, SPLIT_Y, seed=47)
    canvas.paste(top, (0, 0))

    # solid bottom zone is already the canvas fill
    draw = ImageDraw.Draw(canvas)

    # hairline divider in cream
    draw.rectangle((0, SPLIT_Y, W, SPLIT_Y + 3), fill=CREAM)

    # vertical accent on left edge of top zone (Springer-style spine cue)
    draw.rectangle((0, 0, 14, SPLIT_Y), fill=TEAL_DEEP)
    draw.rectangle((14, 0, 17, SPLIT_Y), fill=CREAM)

    # --- top-zone typography ---------------------------------------------
    # series imprint (small caps style, generic — not Springer)
    series_fnt = font('avenir-heavy', 36)
    draw_text(draw, (60, 90),
              'GRADUATE BIOSTATISTICS SERIES',
              series_fnt, WHITE, anchor='lt')

    # author names, stacked
    author_fnt = font('avenir-medium', 64)
    authors = ['Ronald “Ryy” G. Thomas']
    y = 240
    for line in authors:
        draw_text(draw, (60, y), line, author_fnt, WHITE, anchor='lt')
        y += 76

    # --- bottom-zone typography -------------------------------------------
    # title (large, white, on teal)
    title_fnt    = font('avenir-black', 134)
    title_lines  = ['Biostatistics', 'Practicum']
    y = SPLIT_Y + 110
    for line in title_lines:
        draw_text(draw, (60, y), line, title_fnt, WHITE, anchor='lt')
        y += 158

    # subtitle (medium, off-white, two lines)
    sub_fnt = font('avenir-medium', 56)
    y += 34
    for line in ['Reproducible analysis workflows',
                 'for biostatisticians']:
        draw_text(draw, (62, y), line, sub_fnt, CREAM, anchor='lt')
        y += 70

    # edition / year, italic-feel via lighter weight + smaller size
    edition_fnt  = font('avenir-light', 46)
    edition_text = 'First Edition  ·  2026'
    draw_text(draw, (60, H - 200),
              edition_text, edition_fnt, CREAM, anchor='lt')

    # publisher / lab mark in the lower right
    mark_fnt = font('avenir-heavy', 44)
    draw_text(draw, (W - 60, H - 80),
              'rgtlab', mark_fnt, WHITE, anchor='rs')
    # underline beneath the mark
    draw.rectangle((W - 240, H - 64, W - 60, H - 60), fill=GOLD)

    # final paper grain
    canvas = add_paper_grain(canvas)
    return canvas


if __name__ == '__main__':
    img = build()
    out = 'cover.png'
    img.save(out, optimize=True)
    print(f'wrote {out} ({img.size[0]} x {img.size[1]})')
