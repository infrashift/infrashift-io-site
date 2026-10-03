# infrashift.io

Source for [infrashift.io](https://infrashift.io): a terminal-style static site
built with [Astro](https://astro.build) and [bun](https://bun.sh), themed with
Tokyo Night and laid out as a tmux session.

## Usage

All workflows go through the Makefile:

```
make help      # list targets
make dev       # dev server at http://localhost:4321
make check     # type-check pages and content
make build     # static output in dist/
make preview   # build, then serve dist/
make ci        # frozen install + check + build (what CI runs)
```

## Layout

```
src/layouts/Terminal.astro     terminal window + tmux panes
src/components/StatusBar.astro tmux status bar / navigation (keys 1-6)
src/nav.ts                     window list
src/content/projects/*.md      ~/projects entries
src/content/news/*.md          news posts (git log style)
src/pages/                     one file per page
src/styles/global.css          Tokyo Night palette
```

## Deployment

Pushes to `main` build with `make ci` and deploy to GitHub Pages via
`.github/workflows/deploy.yml`. The custom domain `infrashift.io` is configured
in the repository's Pages settings.
