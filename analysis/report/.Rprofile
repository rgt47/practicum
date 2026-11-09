# The book renders from this directory, so R starts here rather than at
# the repository root where renv.lock lives. Point renv at the real
# project before activating, or it treats this directory as a project
# of its own and builds a second, empty library.
Sys.setenv(RENV_PROJECT = normalizePath("../..", mustWork = TRUE))

# Quarto starts a fresh R for every chapter, and renv's startup check
# that the library matches renv.lock would run each time. Skip it
# during builds only; Quarto sets QUARTO_DOCUMENT_PATH, an interactive
# session does not, so renv::status() still reports drift there.
if (nzchar(Sys.getenv("QUARTO_DOCUMENT_PATH"))) {
  Sys.setenv(RENV_CONFIG_SYNCHRONIZED_CHECK = "FALSE")
}

source("../../renv/activate.R")
