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
	@ls -1 [0-9][0-9]-*.qmd | grep -v '^00-' | wc -l | awk \
	  '{ if ($$1 == 23) print "ok: 23 chapter files"; \
	     else { print "error: expected 23 chapters, found " $$1; \
	       exit 1 } }'

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
	             'RSQLite', 'dbplyr', 'duckdb', 'digest'))"

deps-py:
	python3 -m pip install -r requirements.txt
