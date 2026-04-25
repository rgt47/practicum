# Hosting two Quarto books on rgtlab.org via AWS Route 53, Netlify, and GitHub Actions
*2026-04-24 20:25 PDT*

This guide consolidates the end-to-end setup for hosting two
Quarto books, *Biostatistics Practicum* and *Statistical
Computing in the Age of AI*, under the custom domain
`rgtlab.org`. The deployment uses:

- **AWS Route 53** as the DNS provider for `rgtlab.org`.
- **Netlify** as the static-site host.
- **GitHub Actions** as the continuous-integration system
  that re-renders each book and re-deploys it on every push
  to `main`.

The guide is written for the case where each book has its
own GitHub repository (`rgt47/practicum` and `rgt47/scai`)
and each will be served at its own subdomain
(`practicum.rgtlab.org` and `scai.rgtlab.org`).

## Hosting options considered

Three configurations were considered before settling on the
subdomain approach.

### 1. Subdomains (chosen)

Each book gets its own subdomain:

- `practicum.rgtlab.org` for the practicum book.
- `scai.rgtlab.org` for the methods book.

Each subdomain points to a separate Netlify site. DNS is one
CNAME record per subdomain. Each book deploys
independently. This is the simplest configuration and the
one the rest of this guide describes.

### 2. Single site with subpaths

A single Netlify site rooted at `rgtlab.org` with both books
in subdirectories of one deploy:

```
rgtlab-site/
├── netlify.toml
├── practicum/                 # symlink or git submodule
│   └── _book/
├── scai/                      # symlink or git submodule
│   └── _book/
└── public/                    # final deploy directory
    ├── index.html             # landing page
    └── docs/
        ├── practicum/         # = practicum/_book contents
        └── scai/              # = scai/_book contents
```

`netlify.toml`:

```toml
[build]
  publish = 'public'
  command = './build.sh'
```

`build.sh`:

```bash
#!/usr/bin/env bash
set -e
(cd practicum && quarto render)
(cd scai && quarto render)
mkdir -p public/docs
cp -r practicum/_book public/docs/practicum
cp -r scai/_book public/docs/scai
```

URLs become `rgtlab.org/docs/practicum` and
`rgtlab.org/docs/scai`. Each book's `_quarto.yml` must set
`site-url` to the deployed subpath so internal links
resolve.

### 3. Proxy / rewrites

Each book stays in its own Netlify site
(`practicum.netlify.app` and `scai.netlify.app`). A third
'shell' Netlify site for `rgtlab.org` proxies requests:

```toml
[[redirects]]
  from = '/docs/practicum/*'
  to = 'https://practicum.netlify.app/:splat'
  status = 200

[[redirects]]
  from = '/docs/scai/*'
  to = 'https://scai.netlify.app/:splat'
  status = 200
```

Each book stays decoupled and deploys independently. The
trade-off is relative-path edge cases for assets such as
CSS and images, which sometimes resolve at the shell domain
rather than the proxied origin and require absolute URLs in
the books' Quarto configuration.

## Phase 1: Create Netlify sites for each book

This phase produces one Netlify site per book and obtains
the temporary `*.netlify.app` URLs needed for DNS.

1. Create a free account at
   <https://app.netlify.com/signup>. Sign in with GitHub if
   you intend to connect repositories later.

2. Install the Netlify command-line tool:

   ```bash
   npm install -g netlify-cli
   netlify login                  # opens browser; authorise
   ```

3. From the practicum directory, publish:

   ```bash
   cd ~/Dropbox/prj/tch/biostatistics-practicum
   quarto publish netlify
   ```

   On first run, Quarto prompts whether to create a new
   site. Confirm. Quarto builds the book, uploads `_book/`,
   and prints a URL such as
   `https://random-name-12345.netlify.app`. Record this
   URL.

4. Repeat for the methods book:

   ```bash
   cd ~/Dropbox/prj/tch/01-phb228-stat-computing/phb228-2026/textbook
   quarto publish netlify
   ```

   Record its `*.netlify.app` URL.

Each subsequent re-deploy is a single
`quarto publish netlify` from inside the relevant book
directory. CI in Phase 5 will automate this further.

## Phase 2: Add custom subdomains in Netlify

For each Netlify site:

1. Open <https://app.netlify.com> and click into the
   practicum site.

2. Navigate to **Site configuration** → **Domain
   management** → **Add a domain** → **Add a domain you
   already own**.

3. Enter `practicum.rgtlab.org` and click **Verify**, then
   **Add domain**.

4. Netlify shows a banner asking you to configure DNS at
   your registrar. Click **Check DNS configuration** to see
   the target. For a subdomain, the target is the site's
   full Netlify hostname (such as
   `random-name-12345.netlify.app`). Copy it.

5. Repeat for the methods book using `scai.rgtlab.org` and
   that site's `*.netlify.app` URL.

## Phase 3: Add CNAME records in Route 53

For each subdomain, create one CNAME record pointing to the
Netlify hostname recorded in Phase 2.

1. Sign in to the AWS console and open
   <https://console.aws.amazon.com/route53/v2/hostedzones>.

2. Click the hosted zone for **rgtlab.org**.

3. Click **Create record**. Set:

   - **Record name**: `practicum`. Route 53 appends
     `.rgtlab.org` automatically; do not type the full
     domain.
   - **Record type**: `CNAME`.
   - **Value**: the practicum site's `*.netlify.app`
     hostname from Phase 2 (such as
     `random-name-12345.netlify.app`). Do not include
     `https://` or a trailing slash.
   - **TTL**: `300` (5 minutes; lets you correct mistakes
     quickly).
   - **Routing policy**: Simple routing.

   Click **Create records**.

4. Click **Create record** again for the methods book:

   - **Record name**: `scai`.
   - **Record type**: `CNAME`.
   - **Value**: the methods site's `*.netlify.app`
     hostname.
   - Other fields as above.

   Click **Create records**.

## Phase 4: Verify DNS and SSL

1. DNS propagation for a fresh subdomain typically takes
   1 to 10 minutes. From a terminal:

   ```bash
   dig practicum.rgtlab.org CNAME +short
   dig scai.rgtlab.org CNAME +short
   ```

   Each should return the corresponding `*.netlify.app`
   value once DNS is live.

2. In the Netlify dashboard, the domain banner now shows a
   green checkmark. Netlify automatically requests a
   Let's Encrypt SSL certificate; provisioning takes
   another 1 to 5 minutes after DNS resolves.

3. Visit `https://practicum.rgtlab.org` and
   `https://scai.rgtlab.org`. Both should serve the books
   over HTTPS with no warnings.

## Phase 5: Update each book's `site-url`

Each book's `_quarto.yml` should record the deployed URL
so that absolute internal links, social-card metadata, and
the sitemap match the public location.

```yaml
# biostatistics-practicum/_quarto.yml
book:
  site-url: https://practicum.rgtlab.org
  ...
```

```yaml
# 01-phb228-stat-computing/phb228-2026/textbook/_quarto.yml
book:
  site-url: https://scai.rgtlab.org
  ...
```

Re-render and re-publish so the change is reflected in the
deployed copy:

```bash
quarto publish netlify          # in each book directory
```

## Phase 6: Set up continuous deployment with GitHub Actions

This phase replaces manual `quarto publish netlify` with
automatic re-render and re-deploy on every push to `main`.

### 6.1 Get Netlify credentials needed by GitHub Actions

1. **Personal access token** (one token, used by both
   repos):

   - Open
     <https://app.netlify.com/user/applications#personal-access-tokens>.
   - Click **New access token**.
   - Description: `github-actions-deploy`. Click
     **Generate token**.
   - Copy the token immediately. Netlify does not show it
     again.

2. **Site ID for each book**:

   - In the practicum site dashboard, click **Site
     configuration**. The **Site ID** is at the top of the
     page (a UUID such as `12345678-abcd-...`). Copy it.
   - Repeat for the methods site.

### 6.2 Add secrets to each GitHub repository

For each of `rgt47/practicum` and `rgt47/scai`:

1. Open the repository on GitHub.
2. Navigate to **Settings** → **Secrets and variables** →
   **Actions**.
3. Click **New repository secret** and add:
   - **Name**: `NETLIFY_AUTH_TOKEN`.
   - **Value**: the personal access token from 6.1 step 1.
4. Click **New repository secret** again and add:
   - **Name**: `NETLIFY_SITE_ID`.
   - **Value**: that book's Site ID from 6.1 step 2 (each
     repo gets its own book's Site ID).

### 6.3 Add the workflow file

Create `.github/workflows/publish.yml` in each repository
with the following content:

```yaml
name: Render and deploy to Netlify

on:
  push:
    branches: [main]
  workflow_dispatch:

jobs:
  publish:
    runs-on: ubuntu-latest
    steps:
      - name: Check out repository
        uses: actions/checkout@v4

      - name: Set up Quarto
        uses: quarto-dev/quarto-actions/setup@v2
        with:
          version: '1.5.55'

      - name: Set up R
        uses: r-lib/actions/setup-r@v2
        with:
          use-public-rspm: true

      - name: Install R package dependencies
        uses: r-lib/actions/setup-r-dependencies@v2
        with:
          packages: |
            any::knitr
            any::rmarkdown
            any::dplyr
            any::ggplot2
            any::broom
            any::tibble
            any::survival
            any::palmerpenguins

      - name: Render book
        run: quarto render

      - name: Deploy to Netlify
        uses: nwtgck/actions-netlify@v3
        with:
          publish-dir: ./_book
          production-branch: main
          production-deploy: true
          deploy-message: "GHA: ${{ github.event.head_commit.message }}"
          enable-pull-request-comment: false
          overwrites-pull-request-comment: false
        env:
          NETLIFY_AUTH_TOKEN: ${{ secrets.NETLIFY_AUTH_TOKEN }}
          NETLIFY_SITE_ID: ${{ secrets.NETLIFY_SITE_ID }}
        timeout-minutes: 5
```

The R package list covers the dependencies the books
actually evaluate during render (mostly the CDISC chapter
and a few worked examples). Add packages as needed; CI
errors will identify what is missing.

### 6.4 Commit and push the workflow

For each repository:

```bash
cd ~/Dropbox/prj/tch/biostatistics-practicum
mkdir -p .github/workflows
# (paste publish.yml into .github/workflows/publish.yml)
git add .github/workflows/publish.yml
git commit -m "Add GitHub Actions: render and deploy to Netlify"
git push
```

Repeat for the methods book in
`01-phb228-stat-computing/phb228-2026/textbook/`.

### 6.5 Verify the workflow

1. Open the repository on GitHub and click the **Actions**
   tab. The push triggers the workflow; you can watch it
   run.
2. First run: 4 to 8 minutes (R package installation
   dominates). Subsequent runs: 2 to 3 minutes (the R cache
   is reused).
3. When the run finishes green, visit the deployed
   subdomain. The new content is live.
4. If the run fails, click into it and read the failing
   step. Common causes:

   - Missing R package. Add it to the `packages:` list in
     the workflow.
   - Quarto error. Reproduce locally with `quarto render`
     to debug.
   - Netlify auth failure. Re-check that
     `NETLIFY_AUTH_TOKEN` and `NETLIFY_SITE_ID` are set
     correctly in repository secrets.

## Phase 7: Optional speed-up via the Quarto freeze cache

Both books have `execute: freeze: auto` in their
`_quarto.yml`. Committing the `_freeze/` directory lets CI
reuse cached chunk output instead of re-executing every
chunk on every push.

```bash
echo '!_freeze/' >> .gitignore           # un-ignore if previously ignored
git add _freeze
git commit -m "Commit Quarto freeze cache"
git push
```

CI will then re-execute only chunks whose source has
changed, reducing render time substantially. Trade-off: the
repository grows because cached output is committed. For
typical book chunks (small data, deterministic output),
the size overhead is acceptable.

## Future maintenance

Day-to-day editing now follows a single workflow:

```bash
# edit chapter
git add 13-wrangling.qmd
git commit -m "Clarify pivot example"
git push
```

GitHub Actions runs automatically. The deployed book updates
at `https://practicum.rgtlab.org` (or the corresponding
methods URL) within a few minutes. No manual
`quarto publish netlify`, no DNS changes, no Netlify
dashboard interaction.

If a chapter introduces a new R package dependency, add the
package to the `packages:` list in
`.github/workflows/publish.yml`, commit, and push. The next
CI run installs it.

If the deployed URL changes (for example, switching from
subdomain to subpath), update each book's `site-url` in
`_quarto.yml`, the Netlify domain configuration, and the
Route 53 record, then push.

## Summary checklist

| Phase | Where         | Action                                              |
|-------|---------------|-----------------------------------------------------|
| 1     | Local + Netlify | `quarto publish netlify` to create each Netlify site |
| 2     | Netlify         | Add custom subdomain to each site                  |
| 3     | Route 53        | CNAME record per subdomain → `*.netlify.app`       |
| 4     | Browser         | Verify DNS, HTTPS, content                         |
| 5     | Local           | Update `site-url` in each `_quarto.yml`; republish |
| 6     | GitHub          | Secrets + `.github/workflows/publish.yml`; push    |
| 7     | Local           | (optional) commit `_freeze/` cache for faster CI   |

---
*Rendered on 2026-04-24 at 20:29 PDT.*<br>
*Source: ~/Dropbox/prj/tch/hosting-setup.md*
