# The book renders from this directory, so R starts here rather than at
# the repository root where renv.lock lives. Point renv at the real
# project before activating, or it treats this directory as a project
# of its own and builds a second, empty library.
Sys.setenv(RENV_PROJECT = normalizePath("../..", mustWork = TRUE))
source("../../renv/activate.R")
