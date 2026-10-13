#!/usr/bin/env python3
"""Regenerate the three print-volume build directories (decision 23).

The book is one continuous site at practicum.rgtlab.org; HTML has no
page limit, so this script never touches the HTML build. It only
splits the PDF for print-on-demand, into report-vol1/, report-vol2/,
and report-vol3/, siblings of analysis/report/ so that every chapter's
existing '../data/...' relative paths keep resolving correctly.

Each volume directory is fully generated (never hand-edit it):
chapter .qmd files are copied from analysis/report/ and, for any
@sec-/@fig-/@tbl- reference to an anchor defined in a chapter this
volume does not include, the reference is rewritten to plain prose
naming the chapter and its volume (a printed volume cannot hyperlink
into a book it is not bound with). The chapter number used in that
prose is computed from each volume's OWN numbering (every volume
restarts chapter numbering at the Introduction, same as any
multi-volume print book), never the single-book's 1-35 numbering.
Shared assets (images, the bibliography, the pipeline-diagram
helper, the PDF-answers filter) are symlinked back to
analysis/report/, so there is exactly one copy of each.

Volume assignment is an editorial choice independent of the single
book's part structure (the HTML site keeps its own, unchanged part
order). As of 2026-10-13: Volume 1 opens with the two case studies
and the capstone as a preview, before the toolkit and data parts;
the de-identification and ethics chapters moved to Volume 3's new
'Compliance and Ethics' part, ahead of analysis plans and CDISC.

Run from anywhere:
    python3 tools/build-volumes.py
Then render each volume's PDF:
    cd analysis/report-vol1 && RENV_CONFIG_AUTOLOADER_ENABLED=FALSE \\
        quarto render
(repeat for report-vol2, report-vol3). The generated directories are
gitignored; only this script, the three vol*-about.qmd files, and
the two new part-blurb files below (real, authored content) are
committed.

To change volume assignment or order again, edit VOLUME_STRUCTURE
only; everything else (numbering, cross-volume rewriting, the
generated _quarto.yml) follows from it automatically.
"""
import re
import shutil
from pathlib import Path

import yaml

REPORT = Path(__file__).resolve().parent.parent / 'analysis' / 'report'

# file -> display title (no numbers; numbers are computed per volume)
CHAPTER_TITLES = {
    '01-why': 'Why Reproducible Research',
    '03-team-science': 'Team Science for Biostatisticians',
    '02b-deidentification': 'De-identification and Data Ethics',
    '04b-shell': 'The Unix Shell',
    '04-workstation': 'Setting Up Your Workstation',
    '05-git-solo': 'Git and GitHub for Solo Developers',
    '05b-git-teams': 'Git for Teams',
    '21-ai-coding': 'AI-Assisted Coding',
    '12b-acquisition': 'Getting Data In: Files',
    '12c-apis': 'APIs, Scraping, and Freezing What You Receive',
    '13-wrangling': 'Data Wrangling Essentials',
    '14-types': 'Factors, Strings, and Dates',
    '14b-functions': 'Writing and Debugging Functions',
    '15-joins': 'Joining and Reshaping',
    '15b-databases': 'Databases and SQL for Biostatisticians',
    '16-graphics': 'Plotting with ggplot2 and purrr',
    '17-missing': 'Missing Data: Diagnosis, Imputation, Reporting',
    '02c-deident-practice': 'De-identification in Practice',
    '11-quarto': 'Reproducible Reports with Quarto',
    '08-renv': 'renv for Package Management',
    '09-docker': 'Docker for Reproducibility',
    '10-zzcollab': 'Assembling the Compendium',
    '10b-targets': 'Reproducible Pipelines with targets',
    '06-cloud': 'Cloud Compute and Remote Servers',
    '18-analysis-plan': 'Statistical Analysis Plans',
    '20-testing': 'Testing and Continuous Integration',
    '19-cdisc': 'Clinical Data Standards: CDISC, SDTM, and ADaM',
    '22-sas': 'SAS for R Programmers',
    '23-penguins': 'Case Study: Palmer Penguins',
    '24-adni': 'Case Study: ADNI MCI Prediction',
    '25d-ethics': 'Ethics Beyond Compliance',
    '25b-communicating': 'Communicating a Finished Analysis',
    '25c-federal': 'Federal Requirements and Deposition',
    '25-synthesis': 'Capstone: HF-HOME from Export to Deposit',
}

APPENDIX_INFO = [
    # file, letter, title (all appendices live in Volume 2)
    ('C-alternative-wrangling', 'A', 'Alternative Wrangling Paradigms'),
    ('D-peer-survey', 'B', 'The Peer-Program Survey'),
    ('E-lab-software', 'C', 'The rgtlab Software'),
    ('F-glossary', 'D', 'Glossary'),
    ('G-instructor-guide', 'E', 'Instructor Guide'),
    ('H-tooling', 'F', 'Tooling as of October 2026'),
    ('I-rmd-migration', 'G', 'Migrating from R Markdown'),
    ('J-cheat-sheets', 'H', 'Cheat Sheets'),
    ('K-interactive-deliverables', 'I', 'Interactive Deliverables'),
]

VOLUME_TITLE = {
    1: 'Data, Toolkit, and a First Look',
    2: 'Documents, Environments, and Communication',
    3: 'Industry Practice',
}

FRONT_SHARED = ['half-title', 'copyright', 'index', 'preface', 'conventions', '00-intro']

# Ordered (part file without .qmd, [chapter files without .qmd]) per
# volume. A part of None means the chapters appear with no part
# divider. This is the single source of truth for volume assignment,
# order, and (via the part file's own title) the part-level grouping
# shown in each volume's PDF.
VOLUME_STRUCTURE = {
    1: [
        ('vol1-preview', ['23-penguins', '24-adni', '25-synthesis']),
        ('vol1-part-1', ['01-why', '03-team-science']),
        ('part-2', ['04b-shell', '04-workstation', '05-git-solo', '05b-git-teams', '21-ai-coding']),
        ('vol1-part-3', ['12b-acquisition', '12c-apis', '13-wrangling', '14-types', '14b-functions',
                          '15-joins', '15b-databases', '16-graphics', '17-missing']),
    ],
    2: [
        ('part-4', ['11-quarto', '08-renv', '09-docker', '10-zzcollab', '10b-targets', '06-cloud']),
        ('vol2-part-7', ['25b-communicating', '25c-federal']),
    ],
    3: [
        ('vol3-compliance', ['02b-deidentification', '02c-deident-practice', '25d-ethics']),
        ('part-5', ['18-analysis-plan', '20-testing']),
        ('part-6', ['19-cdisc', '22-sas']),
    ],
}
# Each part entry is the actual filename (without .qmd) to use for
# that part's divider page in this volume. 'part-N' names reuse the
# single book's own part file unchanged; 'volN-...' names are new,
# volume-specific part files (see the module docstring) that exist
# because the single book's part-1.qmd, part-3.qmd, and part-7.qmd
# describe chapters this reorder moved to a different volume.


def build_anchor_map():
    anchor_to_file = {}
    heading_re = re.compile(r'\{#((?:sec|fig|tbl)-[A-Za-z0-9-]+)\}')
    label_re = re.compile(r"^\s*#\|\s*label:\s*((?:fig|tbl)-[A-Za-z0-9-]+)", re.M)
    all_parts = sorted({p for struct in VOLUME_STRUCTURE.values() for p, _ in struct})
    all_files = (list(CHAPTER_TITLES) + [f for f, *_ in APPENDIX_INFO]
                 + FRONT_SHARED + all_parts + ['references', 'credits', 'colophon'])
    for stem in all_files:
        p = REPORT / f'{stem}.qmd'
        if not p.exists():
            continue
        text = p.read_text(encoding='utf-8')
        for m in heading_re.finditer(text):
            anchor_to_file.setdefault(m.group(1), stem)
        for m in label_re.finditer(text):
            anchor_to_file.setdefault(m.group(1), stem)
    return anchor_to_file


def chapter_numbers_for(vol):
    """file -> chapter number within this volume's own numbering."""
    numbers = {'00-intro': 1}
    n = 2
    for _part, chapters in VOLUME_STRUCTURE[vol]:
        for ch in chapters:
            numbers[ch] = n
            n += 1
    return numbers


def build_location_table():
    """file -> (display label, volume), numbers computed per volume."""
    location = {}
    for vol in VOLUME_STRUCTURE:
        numbers = chapter_numbers_for(vol)
        for ch, num in numbers.items():
            if ch == '00-intro':
                continue  # never referenced cross-volume by name
            title = CHAPTER_TITLES[ch]
            location[ch] = (f"Chapter {num} ('{title}')", vol)
    for file, letter, title in APPENDIX_INFO:
        location[file] = (f"Appendix {letter} ('{title}')", 2)
    return location


def rewrite_text(text, anchor_to_file, in_volume_files, this_vol, location):
    ref_re = re.compile(r'@((?:sec|fig|tbl)-[A-Za-z0-9-]+)')
    changed = []

    def repl(m):
        anchor = m.group(1)
        src_file = anchor_to_file.get(anchor)
        if src_file is None or src_file in in_volume_files or src_file in FRONT_SHARED:
            return m.group(0)
        loc = location.get(src_file)
        if loc is None:
            return m.group(0)
        label, vol = loc
        if vol == this_vol:
            return m.group(0)
        changed.append((anchor, src_file, vol))
        return f'{label} in Volume {vol}'

    new_text = ref_re.sub(repl, text)
    return new_text, changed


def write_quarto_yml(vol_dir, vol, chapters_list, appendices_list):
    base = (REPORT / '_quarto.yml').read_text(encoding='utf-8')
    fmt_idx = base.index('\nformat:')
    fmt = yaml.safe_load(base[fmt_idx + 1:])

    doc = {
        'project': {'type': 'book', 'output-dir': '_book'},
        'book': {
            'title': f'Biostatistics Practicum, Volume {vol}',
            'subtitle': VOLUME_TITLE[vol],
            'author': 'The rgtlab Curriculum Project',
            'date': 'today',
            'date-format': 'YYYY-MM-DD',
            'chapters': chapters_list,
        },
    }
    if appendices_list:
        doc['book']['appendices'] = appendices_list
    # Carry over every sibling top-level key (filters, bibliography,
    # csl, execute, knitr, crossref, ...), narrowing format to pdf
    # only; the single-book HTML site is unaffected, built from the
    # main _quarto.yml.
    for key, value in fmt.items():
        if key == 'format':
            doc['format'] = {'pdf': value['pdf']}
        else:
            doc[key] = value

    with open(vol_dir / '_quarto.yml', 'w', encoding='utf-8') as f:
        yaml.safe_dump(doc, f, sort_keys=False, allow_unicode=True, width=100)


def main():
    anchor_to_file = build_anchor_map()
    location = build_location_table()
    print(f'{len(anchor_to_file)} anchors indexed')
    all_changes = []

    for vol in (1, 2, 3):
        vol_dir = REPORT.parent / f'report-vol{vol}'
        if vol_dir.exists():
            shutil.rmtree(vol_dir)
        vol_dir.mkdir(parents=True)

        structure = VOLUME_STRUCTURE[vol]
        in_volume_files = set(FRONT_SHARED)
        for part, chapters in structure:
            if part:
                in_volume_files.add(part)
            in_volume_files.update(chapters)
        appendices_in_vol = [f for f, *_ in APPENDIX_INFO] if vol == 2 else []
        in_volume_files.update(appendices_in_vol)
        if vol == 2:
            in_volume_files.update(['references', 'credits', 'colophon'])

        about_file = f'vol{vol}-about'
        chapters_yml = ['half-title.qmd', 'copyright.qmd', f'{about_file}.qmd',
                         'index.qmd', 'preface.qmd', 'conventions.qmd', '00-intro.qmd']
        for part, chapters in structure:
            if part:
                chapters_yml.append({
                    'part': f'{part}.qmd',
                    'chapters': [f'{c}.qmd' for c in chapters],
                })
            else:
                chapters_yml += [f'{c}.qmd' for c in chapters]
        if vol == 2:
            chapters_yml.append('references.qmd')

        appendices_yml = []
        if vol == 2:
            appendices_yml = [f'{f}.qmd' for f in appendices_in_vol] + ['credits.qmd', 'colophon.qmd']

        all_stems = list(FRONT_SHARED) + [about_file]
        for part, chapters in structure:
            if part:
                all_stems.append(part)
            all_stems += chapters
        all_stems += appendices_in_vol
        if vol == 2:
            all_stems += ['references', 'credits', 'colophon']

        for stem in all_stems:
            src = REPORT / f'{stem}.qmd'
            text = src.read_text(encoding='utf-8')
            new_text, changes = rewrite_text(text, anchor_to_file, in_volume_files, vol, location)
            for anchor, src_file, target_vol in changes:
                all_changes.append((vol, stem, anchor, src_file, target_vol))
            (vol_dir / f'{stem}.qmd').write_text(new_text, encoding='utf-8')

        for item in ['_pipeline.R', '_habits.md', 'references.bib', '_filters', 'images']:
            s = REPORT / item
            if s.exists():
                (vol_dir / item).symlink_to(s)

        write_quarto_yml(vol_dir, vol, chapters_yml, appendices_yml)
        print(f'volume {vol}: {len(all_stems)} files, '
              f'{len(appendices_in_vol)} appendices -> {vol_dir}')

    print(f'\n{len(all_changes)} cross-volume reference rewrites total')
    log_path = REPORT.parent / 'report-vol1' / 'rewrites.log'
    with open(log_path, 'w') as f:
        for vol, stem, anchor, src_file, target_vol in all_changes:
            f.write(f'vol{vol} {stem}.qmd: @{anchor} (defined in {src_file}.qmd, Volume {target_vol})\n')
    print(f'rewrite log: {log_path}')


if __name__ == '__main__':
    main()
