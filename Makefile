.PHONY: help render preview publish clean check deps deps-r deps-py

help:
	@echo 'Targets:'
	@echo '  render   Render the full book (HTML + PDF) to _book/'
	@echo '  preview  Live preview in browser'
	@echo '  publish  Publish to Netlify'
	@echo '  clean    Remove rendered outputs and freeze cache'
	@echo '  check    Validate scaffold structure'
	@echo '  deps     Install R and Python dependencies'
	@echo '  deps-r   Install R package dependencies via pak'
	@echo '  deps-py  Install Python dependencies (requirements.txt)'

render:
	quarto render

preview:
	quarto preview

publish:
	quarto publish netlify --no-prompt

clean:
	rm -rf _book _site _freeze .quarto

check:
	@test -f _quarto.yml || (echo 'missing _quarto.yml' && exit 1)
	@for f in index.qmd preface.qmd 00-intro.qmd references.qmd; do \
	  test -f $$f || (echo "missing $$f" && exit 1); \
	done
	@echo 'ok: top-level files present'
	@missing=0; \
	for f in *.qmd; do \
	  grep -q "$$f" _quarto.yml || { \
	    echo "error: $$f exists but is not listed in _quarto.yml"; \
	    missing=1; }; \
	done; \
	test $$missing -eq 0 || exit 1; \
	echo "ok: all $$(ls -1 *.qmd | wc -l | tr -d ' ') .qmd files registered in _quarto.yml"

deps: deps-r deps-py

# Keep this list in sync with .github/workflows/publish.yml. Chapters 13,
# 14, 15, and 16 execute Python chunks through reticulate, so a build
# without deps-py fails at 13-wrangling.qmd.
deps-r:
	Rscript -e "if (!requireNamespace('pak', quietly = TRUE)) \
	  install.packages('pak'); \
	  pak::pak(c('rmarkdown', 'knitr', 'tidyverse', 'palmerpenguins', \
	             'rrtools', 'renv', 'reticulate', 'broom', 'survival', \
	             'survminer', 'patchwork', 'naniar', 'mice', 'gt', \
	             'gtsummary', 'janitor', 'GGally', 'UpSetR', 'DBI', \
	             'RSQLite', 'dbplyr', 'duckdb', 'digest', 'jsonlite', \
	             'rvest', 'httr2', 'haven'))"

deps-py:
	python3 -m pip install -r requirements.txt
