#' Draw the book's recurring analysis-pipeline diagram
#'
#' Every chapter opens with the same diagram so that the reader can
#' see where the chapter's topic sits in a reproducible analysis. The
#' stages along the top are the order of work; the two bands beneath
#' run under every stage.
#'
#' @param highlight Character vector of stage keys to emphasize. Valid
#'   keys: 'plan', 'acquire', 'wrangle', 'analyze', 'report', 'share',
#'   'git', 'environment'.
#' @return A ggplot object.
pipeline_diagram <- function(highlight = character(0)) {
  stages <- data.frame(
    key   = c('plan', 'acquire', 'wrangle', 'analyze', 'report',
              'share'),
    label = c('Plan\n(SAP)', 'Acquire\n(raw data)',
              'Wrangle\n(derived data)', 'Analyze\n(code, tests)',
              'Report\n(document)', 'Share\n(archive)'),
    xmin  = seq(0, 10, by = 2),
    ymin  = 2.2,
    ymax  = 3.6
  )
  stages$xmax <- stages$xmin + 1.7
  bands <- data.frame(
    key   = c('git', 'environment'),
    label = c('Version control (Git)',
              'Environment (renv, Docker)'),
    xmin  = 0,
    xmax  = 11.7,
    ymin  = c(1.2, 0.2),
    ymax  = c(1.9, 0.9)
  )
  boxes <- rbind(stages, bands)
  boxes$on <- boxes$key %in% highlight
  arrows <- data.frame(
    x    = stages$xmax[-nrow(stages)] + 0.03,
    xend = stages$xmin[-1] - 0.03,
    y    = 2.9
  )
  accent <- '#2c7a7b'
  ggplot2::ggplot(boxes) +
    ggplot2::geom_rect(
      ggplot2::aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax,
                   fill = on),
      color = 'grey40', linewidth = 0.3
    ) +
    ggplot2::geom_text(
      ggplot2::aes(x = (xmin + xmax) / 2, y = (ymin + ymax) / 2,
                   label = label, color = on),
      size = 3, lineheight = 0.9
    ) +
    ggplot2::geom_segment(
      data = arrows,
      ggplot2::aes(x = x, xend = xend, y = y, yend = y),
      arrow = grid::arrow(length = grid::unit(0.12, 'cm')),
      color = 'grey40'
    ) +
    ggplot2::scale_fill_manual(
      values = c(`FALSE` = 'grey95', `TRUE` = accent), guide = 'none'
    ) +
    ggplot2::scale_color_manual(
      values = c(`FALSE` = 'grey30', `TRUE` = 'white'), guide = 'none'
    ) +
    ggplot2::coord_fixed(ratio = 1, clip = 'off') +
    ggplot2::theme_void()
}

#' Alt text for the pipeline diagram
#'
#' @param highlight Character vector of stage keys, as for
#'   [pipeline_diagram()].
#' @return A single string for `fig-alt`.
pipeline_alt <- function(highlight) {
  names <- c(plan = 'Plan', acquire = 'Acquire', wrangle = 'Wrangle',
             analyze = 'Analyze', report = 'Report', share = 'Share',
             git = 'Version control', environment = 'Environment')
  paste0(
    'Diagram of the analysis pipeline: six stages in order (Plan, ',
    'Acquire, Wrangle, Analyze, Report, Share) above two bands that ',
    'run under every stage (Version control and Environment). ',
    'Highlighted for this chapter: ',
    paste(names[highlight], collapse = ' and '), '.'
  )
}
