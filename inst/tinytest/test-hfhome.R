hf <- hfhome_generate()
hf_clean <- hfhome_generate(messy = FALSE)

arm_rate <- function(d, arm) {
  ev <- d$outcomes$event_30d[d$randomization$arm == arm]
  c(rate = mean(ev, na.rm = TRUE), n = sum(!is.na(ev)))
}

# Reproducibility and RNG hygiene ------------------------------------

expect_identical(hfhome_generate(n_per_arm = 60, seed = 7),
                 hfhome_generate(n_per_arm = 60, seed = 7),
                 info = 'same seed reproduces every table exactly')
expect_false(identical(hfhome_generate(n_per_arm = 60, seed = 7)$outcomes,
                       hfhome_generate(n_per_arm = 60, seed = 8)$outcomes),
             info = 'a different seed gives different outcomes')

set.seed(99)
before <- stats::runif(3)
set.seed(99)
invisible(hfhome_generate(n_per_arm = 30))
after <- stats::runif(3)
expect_identical(before, after,
                 info = 'the generator restores the caller RNG state')

# Design: arm sizes and stratification --------------------------------

expect_equal(as.vector(table(hf$randomization$arm)), c(1216L, 1216L),
             info = 'SAP: 1,216 randomized per arm by default')
expect_identical(levels(hf$randomization$arm),
                 c('Usual care', 'Home health'),
                 info = 'arm levels in trial order, as in 25b')
by_stratum <- table(paste(hf$randomization$site,
                          hf$randomization$ef_stratum),
                    hf$randomization$arm)
expect_true(all(abs(by_stratum[, 1] - by_stratum[, 2]) <= 4),
            info = 'permuted blocks keep each stratum balanced within 4')

# Statistical calibration ----------------------------------------------

# Monte Carlo tolerance: 3.5 binomial standard errors at the observed n.
for (spec in list(c('Usual care', 0.25), c('Home health', 0.20))) {
  p <- as.numeric(spec[2])
  r <- arm_rate(hf, spec[1])
  se <- sqrt(p * (1 - p) / r[['n']])
  expect_true(abs(r[['rate']] - p) < 3.5 * se,
              info = paste('default n:', spec[1], 'event rate near', p))
}

p_miss <- mean(!hf$outcomes$ascertained)
expect_true(abs(p_miss - 0.063) <
              3.5 * sqrt(0.063 * 0.937 / nrow(hf$outcomes)),
            info = 'unascertained fraction near 6.3%')

# A large trial shrinks Monte Carlo error enough to detect a
# miscalibrated outcome model (bias of 0.01 would fail).
big <- hfhome_generate(n_per_arm = 20000, seed = 11, messy = FALSE)
for (spec in list(c('Usual care', 0.25), c('Home health', 0.20))) {
  p <- as.numeric(spec[2])
  r <- arm_rate(big, spec[1])
  se <- sqrt(p * (1 - p) / r[['n']])
  expect_true(abs(r[['rate']] - p) < 3.5 * se,
              info = paste('n = 20,000 per arm:', spec[1], 'rate near', p))
}
expect_true(abs(mean(!big$outcomes$ascertained) - 0.063) < 0.006,
            info = 'n = 20,000 per arm: unascertained fraction near 6.3%')

# Missingness is unrelated to outcome given covariates, so it is
# similar across arms rather than concentrated in one.
miss_by_arm <- tapply(!big$outcomes$ascertained, big$randomization$arm,
                      mean)
expect_true(abs(diff(miss_by_arm)) < 0.01,
            info = 'unascertainment does not depend on arm')

# Treatment-policy structure ------------------------------------------

hh7 <- with(big$visits, unique(patient_id[visit_type == 'home_health' &
                                              visit_day <= 7]))
got_hh <- big$randomization$patient_id %in% hh7
by_arm <- tapply(got_hh, big$randomization$arm, mean)
expect_true(by_arm[['Home health']] > 0.75 &&
              by_arm[['Home health']] < 0.95,
            info = 'most but not all home-health patients get a 7-day visit')
expect_true(by_arm[['Usual care']] > 0.02 &&
              by_arm[['Usual care']] < 0.10,
            info = 'a minority of usual-care patients cross over')

# Nonadherence tracks frailty, so as-treated differs from as-randomized:
# the as-randomized difference stays near the SAP's 5 points.
ev <- big$outcomes$event_30d
arm_home <- big$randomization$arm == 'Home health'
rd_itt <- mean(ev[!arm_home], na.rm = TRUE) - mean(ev[arm_home],
                                                   na.rm = TRUE)
expect_true(abs(rd_itt - 0.05) < 0.015,
            info = 'as-randomized risk difference near 0.05')

# Composite outcome dates ---------------------------------------------

o <- hf$outcomes
dis <- hf$baseline$discharge_date
expect_true(all(is.na(o$event_30d) == !o$ascertained),
            info = 'event_30d is NA exactly when unascertained')
gap <- as.numeric(o$event_date - dis)
expect_true(all(gap[!is.na(gap)] >= 1 & gap[!is.na(gap)] <= 30),
            info = 'every event falls on days 1 to 30 after discharge')
first <- pmin(o$readmit_date, o$death_date, na.rm = TRUE)
expect_identical(o$event_date, first,
                 info = 'event_date is the first of readmission or death')

# Planted pathologies --------------------------------------------------

key <- c('visit_id', 'test_code')
expect_true(anyDuplicated(hf$labs[key]) > 0,
            info = 'messy: a duplicated visit-test lab row exists')
expect_identical(anyDuplicated(hf_clean$labs[key]), 0L,
                 info = 'clean: no duplicated visit-test lab rows')
expect_false(all(hf$labs$patient_id %in% hf$demographics$patient_id),
             info = 'messy: an orphan lab patient breaks an inner join')

bnp <- hf$labs[hf$labs$test_code == 'NTPROBNP' &
                 grepl('-01$', hf$labs$visit_id), ]
naive <- merge(hf$demographics['patient_id'], bnp, by = 'patient_id')
expect_true(nrow(naive) > nrow(hf$demographics),
            info = 'messy: naive baseline-lab join adds rows')

expect_true(is.character(hf$demographics$patient_id),
            info = 'patient_id is character')
expect_true(all(grepl('^[0-9]{4}$', hf$demographics$patient_id)),
            info = 'patient_id keeps its four-digit leading-zero form')
expect_true('0001' %in% hf$demographics$patient_id,
            info = 'leading zeros survive in the clean tables')

crf <- hf$crf_export
expect_true(is.null(hf_clean$crf_export),
            info = 'clean: no raw CRF export')
expect_true(all(vapply(crf, is.character, logical(1))),
            info = 'CRF export is all character')
site_e <- trimws(tolower(crf$site)) == 'site e'
expect_false(any(grepl('^0', crf$patient_id[site_e])),
             info = 'Site E export lost its leading zeros')
expect_true(any(grepl('^[0-9]{2}/', crf$dob)) &&
              any(grepl('^[0-9]{2}-[A-Z]{3}-', crf$dob)) &&
              any(grepl('^[0-9]{8}$', crf$dob)) &&
              any(grepl('^[0-9]{4}-', crf$dob)),
            info = 'CRF dates come in four formats')
expect_true(length(unique(crf$sex)) > 2,
            info = 'CRF sex coding is inconsistent across sites')
expect_true(length(unique(crf$site)) > 5,
            info = 'CRF site labels vary in case and whitespace')
expect_true(any(crf$sbp_discharge == '', na.rm = TRUE) &&
              anyNA(crf$sbp_discharge) &&
              any(crf$sbp_discharge == '-99', na.rm = TRUE),
            info = 'CRF missing values: empty string, NA, and -99')

med_n <- table(factor(hf$medications$patient_id,
                      levels = hf$baseline$patient_id))
expect_equal(as.vector(med_n), hf$baseline$discharge_med_count,
             info = 'discharge_med_count equals rows in medications')
expect_true(any(grepl('BID', hf$medications$med_text)) &&
              any(grepl('[0-9]mg', hf$medications$med_text)),
            info = 'dosing strings vary in spacing and frequency codes')

# Written files ---------------------------------------------------------

dir <- file.path(tempdir(), 'hfhome-test')
paths <- hfhome_write(dir, data = hf)
expect_identical(readBin(paths[['crf_export']], 'raw', 3),
                 as.raw(c(0xef, 0xbb, 0xbf)),
                 info = 'crf_export.csv starts with a UTF-8 BOM')
expect_false(identical(readBin(paths[['demographics']], 'raw', 3),
                       as.raw(c(0xef, 0xbb, 0xbf))),
             info = 'other files have no BOM')
naive_read <- utils::read.csv(paths[['demographics']])
expect_true(is.numeric(naive_read$patient_id),
            info = 'an unspecified read.csv drops the leading zeros')
typed_read <- utils::read.csv(paths[['demographics']],
                              colClasses = c(patient_id = 'character',
                                             zip = 'character'))
expect_identical(typed_read$patient_id, hf$demographics$patient_id,
                 info = 'a typed read recovers the identifiers')
# Whether a reader strips the BOM depends on the reader and the R
# version (R 4.6 connections strip it), so the bytes are checked
# directly rather than through any one reader.
crf_head <- readBin(paths[['crf_export']], 'raw', 16)
expect_identical(rawToChar(crf_head[4:13]), 'patient_id',
                 info = 'the header follows the BOM bytes')
expect_true(grepl('\r\n', rawToChar(readBin(paths[['crf_export']],
                                            'raw', 200)), fixed = TRUE),
            info = 'crf_export.csv uses CRLF line endings')
crf_bom <- utils::read.csv(paths[['crf_export']], colClasses = 'character',
                           fileEncoding = 'UTF-8-BOM')
expect_identical(names(crf_bom)[1], 'patient_id',
                 info = 'UTF-8-BOM encoding restores the first name')
unlink(dir, recursive = TRUE)

# SDTM -----------------------------------------------------------------

sdtm <- hfhome_sdtm(hf_clean)
iso <- '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
dtc <- c(sdtm$dm$RFSTDTC, sdtm$dm$RFENDTC, sdtm$ex$EXSTDTC,
         sdtm$ex$EXENDTC, sdtm$ds$DSSTDTC)
expect_true(is.character(dtc), info = 'SDTM --DTC variables are character')
expect_true(all(grepl(iso, dtc)), info = 'SDTM dates are ISO 8601')
expect_false(anyNA(as.Date(dtc, format = '%Y-%m-%d')),
             info = 'SDTM dates parse as calendar dates')
expect_identical(nrow(sdtm$dm), nrow(hf_clean$demographics),
                 info = 'DM has one row per subject')
expect_identical(sum(sdtm$ds$DSDECOD == 'LOST TO FOLLOW-UP'),
                 sum(!hf_clean$outcomes$ascertained),
                 info = 'DS lost-to-follow-up matches unascertained')
expect_true(all(sdtm$ex$EXSTDY >= 2),
            info = 'home-health exposure starts after randomization')
