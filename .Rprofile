# Project .Rprofile for the Biostatistics Practicum book.
#
# Quarto renders Python chunks through reticulate. If RETICULATE_PYTHON is
# not already set in the environment, point reticulate at a local
# interpreter that has pandas/numpy/matplotlib/statsmodels/plotnine
# installed. Adjust the path below to match your machine, or export
# RETICULATE_PYTHON yourself before rendering.
local({
  if (Sys.getenv("RETICULATE_PYTHON") == "") {
    candidates <- c(
      "/opt/miniconda3/bin/python3",
      "/usr/local/bin/python3",
      Sys.which("python3")
    )
    hit <- candidates[file.exists(candidates) & nzchar(candidates)]
    if (length(hit) > 0) Sys.setenv(RETICULATE_PYTHON = hit[[1]])
  }
})
