# Not executed. This file exists so that renv's dependency scan records
# packages the build needs but no chapter's code mentions. Without it an
# implicit snapshot drops them, and a restored library renders with
# warnings or not at all.

library(downlit)    # code-link: true in _quarto.yml
library(xml2)       # downlit's dependency for HTML rewriting
library(yaml)       # front-matter and renv metadata parsing
library(knitr)      # the execution engine
library(rmarkdown)  # pandoc plumbing Quarto still calls into
