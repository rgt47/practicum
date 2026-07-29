#!/usr/bin/env Rscript

# Verify that every pkg::fn() call in the book's prose refers to a
# function or dataset the package actually exports.
#
# This exists because the book shipped several calls that did not:
# zztab2fig::to_pdf (no such package), zzrenvcheck::check,
# zzlongplot::longplot, zzpower::power_t_two_sample, and
# usethis::use_github_action_check_standard. All of them sat in static
# code blocks that the render never executes, so nothing caught them.
#
# Usage:  Rscript tools/check-calls.R
# Exit 0 if every resolvable call checks out, 1 otherwise.
# Packages that are not installed are reported but do not fail the run,
# so the check is useful on a machine without the full stack.

# Calls the book states deliberately because they do not exist. The
# AI-assisted coding chapter uses them as examples of hallucinated APIs.
known_fictional <- c(
  "dplyr::mutate_groups",
  "dplyr::summarise_groups",
  "tidyr::pivot_wider_with_progress"
)

# Placeholders in prose rather than real calls.
placeholders <- c(
  "package::function", "pkg::fn", "local::.", "any::testthat",
  "bioc::DESeq2", "dplyr::rows_"
)

qmd <- list.files(".", pattern = "[.]qmd$", full.names = TRUE)
qmd <- qmd[!grepl("^[.]/_(book|freeze)/", qmd)]

pattern <- "\\b[a-zA-Z][a-zA-Z0-9.]*::[a-zA-Z_.][a-zA-Z0-9._]*"
calls <- unlist(lapply(qmd, function(f) {
  regmatches(readLines(f, warn = FALSE),
             gregexpr(pattern, readLines(f, warn = FALSE)))
}))
calls <- sort(unique(unlist(calls)))
calls <- setdiff(calls, c(known_fictional, placeholders))

missing <- character(0)
absent  <- character(0)

for (call in calls) {
  parts <- strsplit(call, "::", fixed = TRUE)[[1]]
  pkg <- parts[1]
  fn  <- parts[2]
  if (!requireNamespace(pkg, quietly = TRUE)) {
    absent <- c(absent, call)
    next
  }
  exports <- tryCatch(getNamespaceExports(pkg),
                      error = function(e) character(0))
  datasets <- tryCatch(
    sub(" .*", "", utils::data(package = pkg)$results[, "Item"]),
    error = function(e) character(0))
  if (!(fn %in% exports || fn %in% datasets)) {
    missing <- c(missing, call)
  }
}

if (length(absent)) {
  cat("Not installed here, unverified:\n")
  cat(paste0("  ", absent, collapse = "\n"), "\n\n")
}

if (length(missing)) {
  cat("FAIL: these calls name something the package does not export:\n")
  cat(paste0("  ", missing, collapse = "\n"), "\n")
  cat("\nIf a call is fictional on purpose, add it to known_fictional",
      "in tools/check-calls.R.\n")
  quit(status = 1)
}

cat("ok:", length(calls) - length(absent), "resolvable calls verified,",
    length(absent), "unverifiable here\n")
