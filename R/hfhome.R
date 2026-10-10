#' Generate the synthetic HF-HOME trial
#'
#' Simulates the HF-HOME randomized trial described in the worked
#' statistical analysis plan (SAP v1.0) of the analysis-plan chapter:
#' adults discharged alive after a heart-failure admission, randomized
#' 1:1 to a home-health program (at least one visit within 7 days of
#' discharge) or usual care, stratified by site and baseline ejection
#' fraction, with a primary outcome of all-cause readmission or death
#' within 30 days of index discharge.
#'
#' The design follows the SAP. With 25% vs 20% event rates, 80% power,
#' two-sided alpha of 0.05, and up to 10% unascertainable outcomes,
#' `power.prop.test()` gives 1,094 evaluable and 1,216 randomized
#' patients per arm, the default `n_per_arm`. The outcome model is
#' calibrated so that, averaged over the simulated patients, the
#' marginal 30-day risk is exactly 0.25 under assignment to usual care
#' and 0.20 under assignment to home health. That is the
#' treatment-policy (intention-to-treat) estimand of the SAP: risk
#' depends on the home-health care actually received, and
#' nonadherence (no visit within 7 days in the home-health arm,
#' home health outside the protocol in the usual-care arm) is more
#' common among older patients on more medications, so a per-protocol
#' or as-treated analysis is confounded while the as-randomized
#' comparison is not.
#'
#' About 6.3% of outcomes are unascertained. Unascertainment is driven
#' by an out-of-state address (visible in `demographics$zip`), which
#' is unrelated to the outcome, so the outcome is missing at random
#' given covariates.
#'
#' All identifiers are synthetic: names are random combinations from
#' short lists, MRNs carry the prefix `SYN-`, and telephone numbers
#' use the fictional 555-01xx exchange. ZIP codes are real codes so
#' that the de-identification exercises (three-digit prefixes,
#' restricted prefixes) behave as they would on real data.
#'
#' @param n_per_arm Integer number of patients randomized to each arm.
#'   At least 20.
#' @param seed Integer seed. The caller's random-number state is
#'   restored on exit, so calling the generator does not disturb a
#'   simulation that surrounds it.
#' @param messy Logical. If `TRUE`, plant the pathologies that the
#'   acquisition, joins, and wrangling chapters need: duplicated
#'   visit-test rows and an orphan (never randomized) patient in
#'   `labs`, and a `crf_export` table of raw character data with
#'   site-specific date formats and category coding, inconsistent
#'   site labels, three different missing-value conventions, and
#'   identifiers that lost their leading zeros at one site. If
#'   `FALSE`, every table is clean and `crf_export` is absent.
#'
#' @return A named list of data frames:
#'   \describe{
#'     \item{`demographics`}{One row per patient: `patient_id`, `mrn`,
#'       `first_name`, `last_name`, `dob`, `age`, `sex`, `race`,
#'       `ethnicity`, `zip`, `phone`.}
#'     \item{`randomization`}{One row per patient: `patient_id`,
#'       `site`, `ef_stratum`, `rand_seq`, `rand_date`, `arm` (a
#'       factor with levels `Usual care`, `Home health`).}
#'     \item{`baseline`}{One row per patient: `patient_id`,
#'       `discharge_date`, `ef_pct`, `discharge_med_count`,
#'       `sbp_discharge`, `weight_kg`.}
#'     \item{`visits`}{One row per contact: `visit_id`, `patient_id`,
#'       `visit_type` (`discharge`, `home_health`, `clinic_day30`),
#'       `visit_day`, `visit_date`.}
#'     \item{`labs`}{Long format, one row per visit and test:
#'       `patient_id`, `visit_id`, `test_code`, `value`, `unit`.}
#'     \item{`medications`}{One row per discharge medication:
#'       `patient_id`, `med_seq`, `med_text` (free-text dosing string
#'       such as `'Furosemide 40 mg BID'`).}
#'     \item{`outcomes`}{One row per patient: `patient_id`,
#'       `ascertained`, `event_30d`, `first_event`, `event_date`,
#'       `days_to_event`, `readmit_date`, `death_date`.}
#'     \item{`crf_export`}{Only when `messy = TRUE`. All-character
#'       raw case report form export, one row per patient:
#'       `patient_id`, `site`, `sex`, `dob`, `discharge_date`,
#'       `ef_pct`, `sbp_discharge`, `weight_kg`.}
#'   }
#'
#' @seealso [hfhome_write()] to write the tables as CSV files,
#'   [hfhome_sdtm()] for SDTM-like domains.
#'
#' @examples
#' hf <- hfhome_generate(n_per_arm = 100)
#' names(hf)
#' table(hf$randomization$arm)
#' head(hf$medications)
#' @export
hfhome_generate <- function(n_per_arm = 1216, seed = 20260423,
                            messy = TRUE) {
  stopifnot(
    is.numeric(n_per_arm), length(n_per_arm) == 1,
    n_per_arm >= 20, n_per_arm == round(n_per_arm),
    is.numeric(seed), length(seed) == 1,
    is.logical(messy), length(messy) == 1, !is.na(messy)
  )
  restore_rng <- hfhome_local_seed(seed)
  on.exit(restore_rng(), add = TRUE)

  n <- 2L * as.integer(n_per_arm)
  id_width <- max(4L, nchar(n + 1L))
  patient_id <- sprintf(paste0('%0', id_width, 'd'), seq_len(n))
  arms <- hfhome_arms()

  # Enrollment runs 2024-02-01 to 2025-11-30, so that the last
  # 30-day outcome precedes the SAP lock of 2026-04-23.
  discharge_date <- sort(as.Date('2024-02-01') +
                           sample(0:668, n, replace = TRUE))
  site <- sample(hfhome_sites(), n, replace = TRUE,
                 prob = c(0.28, 0.24, 0.20, 0.16, 0.12))

  sex <- sample(c('F', 'M'), n, replace = TRUE, prob = c(0.44, 0.56))
  age_cont <- pmin(pmax(stats::rnorm(n, 72, 11), 35), 99.5)
  dob <- discharge_date - round(age_cont * 365.25) -
    sample(0:30, n, replace = TRUE)
  age <- hfhome_age(dob, discharge_date)

  reduced <- stats::runif(n) < 0.5
  ef_pct <- ifelse(
    reduced,
    pmin(pmax(round(stats::rnorm(n, 28, 6)), 10), 39),
    pmin(pmax(round(stats::rnorm(n, 55, 8)), 40), 75)
  )
  ef_pct <- as.integer(ef_pct)
  ef_stratum <- ifelse(ef_pct < 40, 'Reduced EF', 'Preserved EF')

  med_count <- as.integer(pmin(stats::rpois(n, 7), 16))
  sbp <- as.integer(round(stats::rnorm(n, 124, 18)))
  sbp[stats::runif(n) < 0.03] <- NA_integer_
  weight_kg <- round(pmin(pmax(
    stats::rnorm(n, ifelse(sex == 'F', 76, 88), 17), 40), 180), 1)
  weight_kg[stats::runif(n) < 0.01] <- NA_real_

  ntprobnp <- round(exp(stats::rnorm(
    n, log(2600) + 0.5 * reduced + 0.01 * (age - 72), 0.9)))
  out_of_state <- stats::runif(n) < 0.08

  stratum <- paste(site, ef_stratum, sep = ' / ')
  arm <- factor(hfhome_randomize(stratum, arms), levels = arms)
  rand_seq <- as.integer(stats::ave(seq_len(n), stratum,
                                    FUN = seq_along))
  is_home <- arm == arms[2]

  frailty <- (age - 72) / 11 + 0.5 * (med_count - 7) / 2.6
  recv_if_home <- stats::runif(n) <
    stats::plogis(2.0 - 0.45 * frailty)
  recv_if_usual <- stats::runif(n) <
    stats::plogis(-2.9 + 0.5 * frailty)
  received <- ifelse(is_home, recv_if_home, recv_if_usual)

  site_effect <- c(0, 0.15, -0.10, 0.20, -0.15)
  lp <- 0.25 * (age - 72) / 10 -
    0.10 * (sex == 'F') -
    0.12 * (ef_pct - 40) / 10 +
    0.06 * (med_count - 7) +
    site_effect[match(site, hfhome_sites())] +
    0.35 * (log(ntprobnp) - log(2600)) / 0.9
  coef <- hfhome_calibrate(lp, recv_if_usual, recv_if_home,
                           p_usual = 0.25, p_home = 0.20)
  risk <- stats::plogis(coef[['b0']] + lp + coef[['b1']] * received)
  event <- stats::rbinom(n, 1, risk) == 1L

  event_day <- as.integer(pmax(1, ceiling(30 * stats::rbeta(n, 0.8, 1.3))))
  event_day[!event] <- NA_integer_
  death_first <- event & stats::runif(n) < 0.18
  readmit_day <- ifelse(event & !death_first, event_day, NA_integer_)
  death_day <- ifelse(death_first, event_day, NA_integer_)
  later_death <- !is.na(readmit_day) & readmit_day < 30 &
    stats::runif(n) < 0.06
  death_day[later_death] <- readmit_day[later_death] +
    vapply(30L - readmit_day[later_death],
           function(k) sample.int(k, 1), integer(1))

  # 0.08 * 0.55 + 0.92 * p_in = 0.063, the fraction 25b reports.
  p_unasc <- ifelse(out_of_state, 0.55, (0.063 - 0.08 * 0.55) / 0.92)
  ascertained <- stats::runif(n) >= p_unasc

  demographics <- hfhome_identifiers(patient_id, sex, out_of_state)
  demographics <- data.frame(
    patient_id = patient_id,
    mrn = demographics$mrn,
    first_name = demographics$first_name,
    last_name = demographics$last_name,
    dob = dob,
    age = age,
    sex = sex,
    race = sample(
      c('White', 'Black or African American', 'Asian',
        'American Indian or Alaska Native',
        'Native Hawaiian or Other Pacific Islander', 'Multiple',
        'Not reported'),
      n, replace = TRUE,
      prob = c(0.55, 0.14, 0.12, 0.01, 0.01, 0.03, 0.14)),
    ethnicity = sample(
      c('Hispanic or Latino', 'Not Hispanic or Latino', 'Not reported'),
      n, replace = TRUE, prob = c(0.30, 0.62, 0.08)),
    zip = demographics$zip,
    phone = demographics$phone,
    stringsAsFactors = FALSE
  )

  randomization <- data.frame(
    patient_id = patient_id,
    site = site,
    ef_stratum = ef_stratum,
    rand_seq = rand_seq,
    rand_date = discharge_date,
    arm = arm,
    stringsAsFactors = FALSE
  )

  baseline <- data.frame(
    patient_id = patient_id,
    discharge_date = discharge_date,
    ef_pct = ef_pct,
    discharge_med_count = med_count,
    sbp_discharge = sbp,
    weight_kg = weight_kg,
    stringsAsFactors = FALSE
  )

  event_date <- discharge_date + event_day
  outcomes <- data.frame(
    patient_id = patient_id,
    ascertained = ascertained,
    event_30d = ifelse(ascertained, as.integer(event), NA_integer_),
    first_event = ifelse(
      ascertained,
      ifelse(!event, 'none',
             ifelse(death_first, 'death', 'readmission')),
      NA_character_),
    event_date = ifelse(ascertained, event_date, NA),
    days_to_event = ifelse(ascertained, event_day, NA_integer_),
    readmit_date = ifelse(ascertained, discharge_date + readmit_day, NA),
    death_date = ifelse(ascertained, discharge_date + death_day, NA),
    stringsAsFactors = FALSE
  )
  date_cols <- c('event_date', 'readmit_date', 'death_date')
  outcomes[date_cols] <- lapply(outcomes[date_cols], as.Date,
                                origin = '1970-01-01')

  visits <- hfhome_visits(patient_id, discharge_date, is_home,
                          received, event_day, death_day, ascertained)
  labs <- hfhome_labs(visits, patient_id, reduced, ntprobnp)
  medications <- hfhome_medications(patient_id, med_count)

  stopifnot(
    !anyDuplicated(demographics$patient_id),
    !anyDuplicated(demographics$mrn),
    identical(demographics$patient_id, randomization$patient_id),
    identical(demographics$patient_id, baseline$patient_id),
    identical(demographics$patient_id, outcomes$patient_id),
    all(table(randomization$arm) == n_per_arm),
    all(visits$patient_id %in% patient_id),
    !anyDuplicated(visits$visit_id),
    all(labs$visit_id %in% visits$visit_id),
    !anyDuplicated(labs[c('visit_id', 'test_code')]),
    all(outcomes$days_to_event %in% c(NA, 1:30)),
    all(is.na(outcomes$event_30d) == !outcomes$ascertained),
    all(age >= 18)
  )
  med_per_patient <- tabulate(match(medications$patient_id, patient_id),
                              nbins = n)
  stopifnot(identical(med_per_patient, baseline$discharge_med_count))

  out <- list(
    demographics = demographics,
    randomization = randomization,
    baseline = baseline,
    visits = visits,
    labs = labs,
    medications = medications,
    outcomes = outcomes
  )
  if (messy) {
    out$labs <- hfhome_mess_labs(labs, patient_id, id_width)
    out$crf_export <- hfhome_crf_export(demographics, randomization,
                                        baseline)
    stopifnot(
      nrow(out$crf_export) == n,
      anyDuplicated(out$labs[c('visit_id', 'test_code')]) > 0
    )
  }
  out
}

#' Write the HF-HOME tables as CSV files
#'
#' Writes each table returned by [hfhome_generate()] to
#' `<dir>/<table>.csv` in UTF-8 with Unix line endings, dates as ISO
#' 8601 (`YYYY-MM-DD`), and missing values as empty fields. The raw
#' CRF export, when present, is written the way a spreadsheet on
#' Windows would save it: with a UTF-8 byte-order mark, CRLF line
#' endings, unquoted fields, and its planted missing-value codes left
#' as they are.
#'
#' @param dir Directory to write to; created if it does not exist.
#' @param data A list from [hfhome_generate()]. If `NULL`, one is
#'   generated from `...`.
#' @param ... Arguments passed to [hfhome_generate()] when `data` is
#'   `NULL`.
#'
#' @return The written file paths, invisibly, named by table.
#'
#' @examples
#' dir <- file.path(tempdir(), 'hfhome')
#' paths <- hfhome_write(dir, n_per_arm = 50)
#' basename(paths)
#' readBin(paths[['crf_export']], 'raw', 3)
#' @export
hfhome_write <- function(dir, data = NULL, ...) {
  if (is.null(data)) data <- hfhome_generate(...)
  stopifnot(is.list(data), length(names(data)) == length(data))
  dir.create(dir, recursive = TRUE, showWarnings = FALSE)
  paths <- file.path(dir, paste0(names(data), '.csv'))
  names(paths) <- names(data)
  for (tbl in names(data)) {
    if (tbl == 'crf_export') {
      hfhome_write_csv(data[[tbl]], paths[[tbl]], bom = TRUE,
                       eol = '\r\n', na = 'NA', quote = FALSE)
    } else {
      hfhome_write_csv(data[[tbl]], paths[[tbl]])
    }
  }
  invisible(paths)
}

#' Write a data frame as CSV, optionally with a byte-order mark
#'
#' A small writer for producing realistic export files. With
#' `bom = TRUE` the file begins with the three bytes `EF BB BF`, as
#' files saved by spreadsheet software as 'CSV UTF-8' do; readers that
#' do not strip it see the first column named `\\ufeffpatient_id`
#' (printed as `X.U.FEFF.patient_id` or `ï»¿patient_id`).
#'
#' @param x A data frame.
#' @param path Output file path.
#' @param bom Logical; prepend a UTF-8 byte-order mark.
#' @param eol Line ending, `'\n'` or `'\r\n'`.
#' @param na String written for missing values.
#' @param quote Logical; quote character and factor fields.
#'
#' @return `path`, invisibly.
#'
#' @examples
#' f <- tempfile(fileext = '.csv')
#' hfhome_write_csv(data.frame(patient_id = c('007', '012')), f,
#'                  bom = TRUE)
#' names(utils::read.csv(f))
#' @export
hfhome_write_csv <- function(x, path, bom = FALSE, eol = '\n', na = '',
                             quote = TRUE) {
  stopifnot(is.data.frame(x), is.character(path), length(path) == 1)
  tmp <- tempfile(fileext = '.csv')
  on.exit(unlink(tmp), add = TRUE)
  utils::write.csv(x, tmp, row.names = FALSE, na = na, eol = eol,
                   quote = quote, fileEncoding = 'UTF-8')
  bytes <- readBin(tmp, 'raw', file.size(tmp))
  if (bom) bytes <- c(as.raw(c(0xef, 0xbb, 0xbf)), bytes)
  writeBin(bytes, path)
  invisible(path)
}

#' SDTM-like domains for the HF-HOME trial
#'
#' Builds minimal Demographics (DM), Exposure (EX), and Disposition
#' (DS) domains from [hfhome_generate()] output, for the CDISC
#' chapter's ADSL and ADTTE derivations. Only the variables those
#' derivations need are included. All `--DTC` variables are ISO 8601
#' character strings, as SDTM stores them; conversion to `Date`
#' belongs to ADaM.
#'
#' `DM` carries planned arm (`ARMCD`, `ARM`) and actual arm
#' (`ACTARMCD`, `ACTARM`), where actual is home health if a
#' home-health visit occurred within 7 days of discharge. `EX` has one
#' row per home-health visit. `DS` has a `RANDOMIZED` protocol
#' milestone for every subject (the source of `RANDDT`) and one
#' disposition event: `DEATH`, `LOST TO FOLLOW-UP` (unascertained
#' outcome), or `COMPLETED` at day 30.
#'
#' @param data A list from [hfhome_generate()]. Defaults to the clean
#'   default trial.
#'
#' @return A named list of data frames `dm`, `ex`, `ds`.
#'
#' @examples
#' sdtm <- hfhome_sdtm(hfhome_generate(n_per_arm = 50, messy = FALSE))
#' head(sdtm$dm)
#' table(sdtm$ds$DSDECOD)
#' @export
hfhome_sdtm <- function(data = hfhome_generate(messy = FALSE)) {
  stopifnot(all(c('demographics', 'randomization', 'visits',
                  'outcomes') %in% names(data)))
  iso <- function(x) ifelse(is.na(x), NA_character_,
                            format(x, '%Y-%m-%d'))
  studyid <- 'HFHOME'
  dem <- data$demographics
  rnd <- data$randomization
  out <- data$outcomes
  vis <- data$visits
  stopifnot(identical(dem$patient_id, rnd$patient_id),
            identical(dem$patient_id, out$patient_id))
  usubjid <- paste(studyid, dem$patient_id, sep = '-')
  arm_cd <- c('Usual care' = 'UC', 'Home health' = 'HH')

  hh <- vis[vis$visit_type == 'home_health', ]
  hh_7d <- unique(hh$patient_id[hh$visit_day <= 7])
  act_arm <- ifelse(dem$patient_id %in% hh_7d, 'Home health',
                    'Usual care')

  last_contact <- tapply(vis$visit_date, vis$patient_id, max)
  last_contact <- as.Date(last_contact[dem$patient_id],
                          origin = '1970-01-01')
  died <- out$ascertained & !is.na(out$death_date)
  disp_decod <- ifelse(!out$ascertained, 'LOST TO FOLLOW-UP',
                       ifelse(died, 'DEATH', 'COMPLETED'))
  disp_date <- ifelse(
    !out$ascertained, last_contact,
    ifelse(died, out$death_date, rnd$rand_date + 30))
  disp_date <- as.Date(disp_date, origin = '1970-01-01')

  dm <- data.frame(
    STUDYID = studyid,
    DOMAIN = 'DM',
    USUBJID = usubjid,
    SUBJID = dem$patient_id,
    SITEID = sprintf('%02d', match(rnd$site, hfhome_sites())),
    RFSTDTC = iso(rnd$rand_date),
    RFENDTC = iso(disp_date),
    AGE = dem$age,
    AGEU = 'YEARS',
    SEX = dem$sex,
    RACE = toupper(dem$race),
    ETHNIC = toupper(dem$ethnicity),
    ARMCD = unname(arm_cd[as.character(rnd$arm)]),
    ARM = as.character(rnd$arm),
    ACTARMCD = unname(arm_cd[act_arm]),
    ACTARM = act_arm,
    stringsAsFactors = FALSE
  )

  hh <- hh[order(hh$patient_id, hh$visit_day), ]
  ex_usubjid <- paste(studyid, hh$patient_id, sep = '-')
  rfst <- rnd$rand_date[match(hh$patient_id, rnd$patient_id)]
  ex <- data.frame(
    STUDYID = rep(studyid, nrow(hh)),
    DOMAIN = rep('EX', nrow(hh)),
    USUBJID = ex_usubjid,
    EXSEQ = as.integer(stats::ave(seq_len(nrow(hh)), ex_usubjid,
                                  FUN = seq_along)),
    EXTRT = rep('HOME HEALTH VISIT', nrow(hh)),
    EXDOSE = rep(1, nrow(hh)),
    EXDOSU = rep('VISIT', nrow(hh)),
    EXSTDTC = iso(hh$visit_date),
    EXENDTC = iso(hh$visit_date),
    EXSTDY = as.integer(hh$visit_date - rfst) + 1L,
    stringsAsFactors = FALSE
  )

  n <- nrow(dem)
  ds <- data.frame(
    STUDYID = studyid,
    DOMAIN = 'DS',
    USUBJID = rep(usubjid, each = 2),
    DSSEQ = rep(1:2, times = n),
    DSTERM = as.vector(rbind('RANDOMIZED', disp_decod)),
    DSDECOD = as.vector(rbind('RANDOMIZED', disp_decod)),
    DSCAT = rep(c('PROTOCOL MILESTONE', 'DISPOSITION EVENT'), times = n),
    DSSTDTC = as.vector(rbind(iso(rnd$rand_date), iso(disp_date))),
    stringsAsFactors = FALSE
  )

  stopifnot(
    !anyDuplicated(dm$USUBJID),
    all(ex$USUBJID %in% dm$USUBJID),
    nrow(ds) == 2 * nrow(dm),
    is.character(dm$RFSTDTC), is.character(ex$EXSTDTC),
    is.character(ds$DSSTDTC)
  )
  list(dm = dm, ex = ex, ds = ds)
}

hfhome_arms <- function() c('Usual care', 'Home health')

hfhome_sites <- function() paste('Site', LETTERS[1:5])

hfhome_local_seed <- function(seed) {
  env <- globalenv()
  had_seed <- exists('.Random.seed', envir = env, inherits = FALSE)
  old_seed <- if (had_seed) get('.Random.seed', envir = env)
  old_kind <- RNGkind()
  # Pin the generator so that the same seed gives the same trial
  # whatever RNGkind() the session happens to be using.
  RNGkind('Mersenne-Twister', 'Inversion', 'Rejection')
  set.seed(seed)
  function() {
    do.call(RNGkind, as.list(old_kind))
    if (had_seed) {
      assign('.Random.seed', old_seed, envir = env)
    } else if (exists('.Random.seed', envir = env, inherits = FALSE)) {
      rm('.Random.seed', envir = env)
    }
  }
}

hfhome_age <- function(dob, at) {
  b <- as.POSIXlt(dob)
  a <- as.POSIXlt(at)
  before_birthday <- a$mon < b$mon | (a$mon == b$mon & a$mday < b$mday)
  as.integer(a$year - b$year - before_birthday)
}

hfhome_randomize <- function(stratum, arms, block_size = 4L) {
  arm <- character(length(stratum))
  leftover <- integer(0)
  for (idx in split(seq_along(stratum), stratum)) {
    n_full <- (length(idx) %/% block_size) * block_size
    if (n_full > 0) {
      arm[idx[seq_len(n_full)]] <- unlist(lapply(
        seq_len(n_full / block_size),
        function(i) sample(rep(arms, block_size / 2))))
    }
    leftover <- c(leftover, idx[seq_along(idx) > n_full])
  }
  # Permuted blocks within strata leave incomplete final blocks; the
  # SAP randomizes exactly n per arm, so the stragglers are balanced
  # across the whole trial instead.
  arm[leftover] <- sample(rep(arms, length(leftover) / 2))
  arm
}

hfhome_calibrate <- function(lp, recv_if_usual, recv_if_home,
                             p_usual, p_home) {
  rate_at <- function(b0, b1, recv) mean(stats::plogis(b0 + lp + b1 * recv))
  solve_b0 <- function(b1) {
    stats::uniroot(function(b0) rate_at(b0, b1, recv_if_usual) - p_usual,
                   c(-15, 15), tol = 1e-10)$root
  }
  b1 <- stats::uniroot(
    function(b1) rate_at(solve_b0(b1), b1, recv_if_home) - p_home,
    c(-10, 5), tol = 1e-10)$root
  c(b0 = solve_b0(b1), b1 = b1)
}

hfhome_identifiers <- function(patient_id, sex, out_of_state) {
  n <- length(patient_id)
  first_f <- c('Ana', 'Beatriz', 'Carmen', 'Dana', 'Elena', 'Fatima',
               'Grace', 'Hana', 'Irene', 'Joan', 'Karen', 'Linh',
               'Maria', 'Nora', 'Olivia', 'Priya', 'Rosa', 'Sofia',
               'Teresa', 'Yolanda', 'Zoë', 'María', 'Ruth',
               'Gloria', 'Mei')
  first_m <- c('Aaron', 'Ben', 'Carlos', 'David', 'Eli', 'Frank',
               'George', 'Hector', 'Ivan', 'James', 'Kenji', 'Luis',
               'Mohammed', 'Nathan', 'Omar', 'Paul', 'Raj', 'Samuel',
               'Thomas', 'Victor', 'Walter', 'José', 'Duc',
               'Robert', 'Andre')
  last <- c('Alvarez', 'Brooks', 'Chen', 'Delgado', 'Edwards',
            'Fischer', 'Garcia', 'Haddad', 'Ibarra', 'Jensen', 'Kim',
            'Lopez', 'Morales', 'Nguyen', 'Okafor', 'Patel',
            'Quintero', 'Ramirez', 'Silva', 'Tran', 'Underwood',
            'Vasquez', 'Walsh', 'Xu', 'Yamamoto', 'Zimmerman',
            'Muñoz', 'Peña', 'Cole', 'Dey', 'Fox', 'Ruiz',
            'Santos', 'Reyes', 'Cohen', 'Murphy', 'Ali', 'Wong',
            'Bauer', 'Hughes')
  local_zip <- c('92037', '92093', '92103', '92104', '92105', '92108',
                 '92111', '92115', '92117', '92122', '92123', '92126',
                 '92129', '92131', '91910', '91911', '92020', '92021',
                 '92064', '92071')
  # Includes prefixes with a leading zero (021, 036, 059) and three on
  # the HHS Safe Harbor restricted-prefix list (036, 059, 821).
  away_zip <- c('85004', '89101', '97201', '59001', '03601', '05901',
                '82190', '02138', '10027', '60614')
  first_name <- ifelse(sex == 'F',
                       sample(first_f, n, replace = TRUE),
                       sample(first_m, n, replace = TRUE))
  list(
    mrn = sprintf('SYN-%07d', sample(1000000:9999999, n)),
    first_name = first_name,
    last_name = sample(last, n, replace = TRUE),
    zip = ifelse(out_of_state, sample(away_zip, n, replace = TRUE),
                 sample(local_zip, n, replace = TRUE)),
    phone = sprintf('(%s) 555-01%02d',
                    sample(c('619', '858', '760'), n, replace = TRUE),
                    sample(0:99, n, replace = TRUE))
  )
}

hfhome_visits <- function(patient_id, discharge_date, is_home, received,
                          event_day, death_day, ascertained) {
  n <- length(patient_id)
  first_hh <- rep(NA_integer_, n)
  first_hh[received] <- sample.int(7, sum(received), replace = TRUE)
  late <- is_home & !received & stats::runif(n) < 0.4
  first_hh[late] <- 7L + sample.int(7, sum(late), replace = TRUE)
  has_hh <- !is.na(first_hh)
  n_hh <- 1L + stats::rbinom(n, 2, 0.5)

  hh_who <- rep(which(has_hh), n_hh[has_hh])
  hh_k <- sequence(n_hh[has_hh])
  gap <- ifelse(hh_k == 1L, 0L,
                sample(3:7, length(hh_who), replace = TRUE))
  hh_day <- first_hh[hh_who] +
    as.integer(stats::ave(gap, hh_who, FUN = cumsum))
  # A visit cannot happen after the patient is readmitted or dies, so
  # an early event erases a planned visit: the immortal-time trap of
  # the intake chapter, built into the data.
  keep <- hh_day <= 30 & (is.na(event_day[hh_who]) |
                            hh_day < event_day[hh_who])
  hh_who <- hh_who[keep]
  hh_day <- hh_day[keep]

  alive_30 <- is.na(death_day) | death_day > 30
  attend <- alive_30 &
    stats::runif(n) < ifelse(ascertained, 0.75, 0.10)
  clinic_who <- which(attend)
  clinic_day <- sample(28:35, length(clinic_who), replace = TRUE)

  who <- c(seq_len(n), hh_who, clinic_who)
  visits <- data.frame(
    patient_id = patient_id[who],
    visit_type = c(rep('discharge', n), rep('home_health', length(hh_who)),
                   rep('clinic_day30', length(clinic_who))),
    visit_day = as.integer(c(rep(0L, n), hh_day, clinic_day)),
    stringsAsFactors = FALSE
  )
  visits <- visits[order(visits$patient_id, visits$visit_day), ]
  seq_in_patient <- stats::ave(seq_len(nrow(visits)), visits$patient_id,
                               FUN = seq_along)
  visits$visit_id <- paste0(visits$patient_id, '-',
                            sprintf('%02d', seq_in_patient))
  visits$visit_date <- discharge_date[match(visits$patient_id,
                                            patient_id)] +
    visits$visit_day
  rownames(visits) <- NULL
  visits[c('visit_id', 'patient_id', 'visit_type', 'visit_day',
           'visit_date')]
}

hfhome_lab_panel <- function() {
  data.frame(
    visit_type = c(rep('discharge', 5), rep('home_health', 2),
                   rep('clinic_day30', 4)),
    test_code = c('NTPROBNP', 'CREAT', 'K', 'SODIUM', 'HGB',
                  'CREAT', 'K',
                  'NTPROBNP', 'CREAT', 'K', 'SODIUM'),
    stringsAsFactors = FALSE
  )
}

hfhome_labs <- function(visits, patient_id, reduced, ntprobnp) {
  n <- length(patient_id)
  base <- data.frame(
    NTPROBNP = ntprobnp,
    CREAT = exp(stats::rnorm(n, log(1.3), 0.35)),
    K = stats::rnorm(n, 4.3, 0.45),
    SODIUM = stats::rnorm(n, 137, 3.5),
    HGB = stats::rnorm(n, 12.3 - 0.4 * reduced, 1.7)
  )
  units <- c(NTPROBNP = 'pg/mL', CREAT = 'mg/dL', K = 'mmol/L',
             SODIUM = 'mmol/L', HGB = 'g/dL')
  digits <- c(NTPROBNP = 0, CREAT = 2, K = 1, SODIUM = 0, HGB = 1)

  labs <- merge(visits[c('visit_id', 'patient_id', 'visit_type')],
                hfhome_lab_panel(), by = 'visit_type', sort = FALSE)
  pid <- match(labs$patient_id, patient_id)
  baseline_value <- base[cbind(pid, match(labs$test_code, names(base)))]
  follow_up <- labs$visit_type != 'discharge'
  m <- nrow(labs)
  drift <- ifelse(
    labs$test_code == 'NTPROBNP', exp(stats::rnorm(m, -0.3, 0.5)),
    ifelse(labs$test_code == 'CREAT', exp(stats::rnorm(m, 0, 0.12)),
           1))
  shift <- ifelse(labs$test_code == 'K', stats::rnorm(m, 0, 0.35),
                  ifelse(labs$test_code == 'SODIUM',
                         stats::rnorm(m, 0, 2), 0))
  value <- ifelse(follow_up, baseline_value * drift + shift,
                  baseline_value)
  labs$value <- round(value, digits[labs$test_code])
  labs$unit <- unname(units[labs$test_code])
  labs <- labs[order(labs$patient_id, labs$visit_id, labs$test_code), ]
  rownames(labs) <- NULL
  labs[c('patient_id', 'visit_id', 'test_code', 'value', 'unit')]
}

hfhome_mess_labs <- function(labs, patient_id, id_width) {
  discharge_bnp <- which(grepl('-01$', labs$visit_id) &
                           labs$test_code == 'NTPROBNP')
  discharge_k <- which(grepl('-01$', labs$visit_id) &
                         labs$test_code == 'K')
  exact <- labs[sample(discharge_bnp, 1), ]
  rerun <- labs[sample(discharge_k, 1), ]
  rerun$value <- round(rerun$value + 0.3, 1)
  orphan_id <- sprintf(paste0('%0', id_width, 'd'),
                       length(patient_id) + 1L)
  orphan <- labs[labs$patient_id == labs$patient_id[1] &
                   grepl('-01$', labs$visit_id), ]
  orphan$patient_id <- orphan_id
  orphan$visit_id <- paste0(orphan_id, '-01')
  messy <- rbind(labs, exact, rerun, orphan)
  messy <- messy[order(messy$patient_id, messy$visit_id,
                       messy$test_code), ]
  rownames(messy) <- NULL
  messy
}

hfhome_drug_catalog <- function() {
  list(
    c('Furosemide 40 mg BID', 'furosemide 40mg bid',
      'Lasix 40 mg twice daily', 'Furosemide 20 mg daily',
      'FUROSEMIDE 80 MG QAM'),
    c('Torsemide 20 mg daily', 'torsemide 10mg qd'),
    c('Carvedilol 12.5 mg BID', 'carvedilol 6.25mg BID',
      'Coreg 25 mg b.i.d.'),
    c('Metoprolol succinate 50 mg daily', 'metoprolol XL 25mg QD',
      'Toprol XL 100 mg once daily'),
    c('Lisinopril 10 mg daily', 'lisinopril 5mg qd',
      'Lisinopril 20 MG once a day'),
    c('Sacubitril/valsartan 49/51 mg BID',
      'Entresto 24-26 mg twice daily',
      'sacubitril-valsartan 97/103mg bid'),
    c('Spironolactone 25 mg daily', 'spironolactone 12.5mg QD',
      'Aldactone 25 mg every day'),
    c('Empagliflozin 10 mg daily', 'Jardiance 10mg qd'),
    c('Dapagliflozin 10 mg daily', 'Farxiga 10 mg QAM'),
    c('Atorvastatin 40 mg qhs', 'atorvastatin 80mg at bedtime',
      'Lipitor 20 mg daily'),
    c('Aspirin 81 mg daily', 'ASA 81mg qd',
      'aspirin 81 mg EC once daily'),
    c('Apixaban 5 mg BID', 'Eliquis 2.5mg bid'),
    c('Potassium chloride 20 mEq daily', 'KCl 10 mEq BID',
      'K-Dur 20 meq qd'),
    c('Metformin 500 mg BID', 'metformin 1000mg bid with meals'),
    c('Insulin glargine 20 units qhs', 'Lantus 14 units at bedtime'),
    c('Amiodarone 200 mg daily', 'amiodarone 200mg qd'),
    c('Digoxin 0.125 mg daily', 'digoxin 125 mcg QD'),
    c('Hydralazine 25 mg TID', 'hydralazine 37.5mg tid'),
    c('Isosorbide dinitrate 20 mg TID', 'ISDN 10mg t.i.d.'),
    c('Levothyroxine 50 mcg daily', 'Synthroid 75mcg qam'),
    c('Pantoprazole 40 mg daily', 'pantoprazole 40mg QD before breakfast'),
    c('Allopurinol 100 mg daily', 'allopurinol 300mg qd'),
    c('Nitroglycerin 0.4 mg SL PRN chest pain', 'NTG 0.4mg SL q5min prn')
  )
}

hfhome_medications <- function(patient_id, med_count) {
  catalog <- hfhome_drug_catalog()
  stopifnot(max(med_count) <= length(catalog))
  who <- rep(seq_along(patient_id), med_count)
  drug <- unlist(lapply(med_count, function(k) {
    sample.int(length(catalog), k)
  }))
  med_text <- vapply(catalog[drug], function(v) v[sample.int(length(v), 1)],
                     character(1))
  data.frame(
    patient_id = patient_id[who],
    med_seq = as.integer(sequence(med_count)),
    med_text = unname(med_text),
    stringsAsFactors = FALSE
  )
}

hfhome_crf_export <- function(demographics, randomization, baseline) {
  n <- nrow(demographics)
  site <- randomization$site
  site_letter <- substr(site, 6, 6)

  fmt_date <- function(d) {
    lt <- as.POSIXlt(d)
    sas <- sprintf('%02d-%s-%04d', lt$mday, toupper(month.abb[lt$mon + 1]),
                   lt$year + 1900)
    out <- ifelse(site_letter == 'C', format(d, '%m/%d/%Y'),
                  ifelse(site_letter == 'D', sas,
                         ifelse(site_letter == 'E', format(d, '%Y%m%d'),
                                format(d, '%Y-%m-%d'))))
    ifelse(is.na(d), '', out)
  }

  sex <- demographics$sex
  sex_coded <- ifelse(
    site_letter == 'B', ifelse(sex == 'F', 'Female', 'Male'),
    ifelse(site_letter == 'C', tolower(sex),
           ifelse(site_letter == 'D', ifelse(sex == 'F', '2', '1'), sex)))

  site_label <- site
  variant <- sample(1:5, n, replace = TRUE,
                    prob = c(0.88, 0.03, 0.03, 0.03, 0.03))
  site_label[variant == 2] <- tolower(site[variant == 2])
  site_label[variant == 3] <- toupper(site[variant == 3])
  site_label[variant == 4] <- paste0(site[variant == 4], ' ')
  site_label[variant == 5] <- paste0(' ', site[variant == 5])

  # Each site's system writes a missing number differently: an empty
  # field, the literal NA, or a -99 sentinel.
  missing_code <- function(x) {
    out <- as.character(x)
    miss <- is.na(x)
    out[miss & site_letter %in% c('A', 'C')] <- ''
    out[miss & site_letter == 'D'] <- '-99'
    out
  }

  id <- demographics$patient_id
  id[site_letter == 'E'] <- sub('^0+', '', id[site_letter == 'E'])

  data.frame(
    patient_id = id,
    site = site_label,
    sex = sex_coded,
    dob = fmt_date(demographics$dob),
    discharge_date = fmt_date(baseline$discharge_date),
    ef_pct = as.character(baseline$ef_pct),
    sbp_discharge = missing_code(baseline$sbp_discharge),
    weight_kg = missing_code(baseline$weight_kg),
    stringsAsFactors = FALSE
  )
}
