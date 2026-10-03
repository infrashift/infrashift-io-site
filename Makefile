# infrashift.io site Makefile

BUN  ?= bun
PORT ?= 4321

# Run Astro under the bun runtime rather than node.
ASTRO := $(BUN) --bun astro

.PHONY: all install install-ci dev run dev-bg dev-stop dev-status dev-logs \
	build preview check ci clean distclean help

all: build

## Setup

# Re-install only when the manifest or lockfile changes.
node_modules: package.json bun.lock
	$(BUN) install
	@touch node_modules

install: node_modules ## Install dependencies

install-ci: ## Install dependencies exactly as locked (fails if bun.lock is stale)
	$(BUN) install --frozen-lockfile

## Development

dev: node_modules ## Run the dev server in the foreground (PORT=4321)
	$(ASTRO) dev --port $(PORT)

run: dev ## Alias of dev

dev-bg: node_modules ## Start the dev server in the background
	$(ASTRO) dev --background --port $(PORT)

dev-stop: ## Stop the background dev server
	$(ASTRO) dev stop

dev-status: ## Show whether a dev server is running
	$(ASTRO) dev status

dev-logs: ## Follow the background dev server logs
	$(ASTRO) dev logs --follow

## Build

build: node_modules ## Build the static site into dist/
	$(ASTRO) build

preview: build ## Build, then serve dist/ locally (PORT=4321)
	$(ASTRO) preview --port $(PORT)

## Quality

check: node_modules ## Type-check Astro, TS, and content collections
	$(ASTRO) check

## CI

ci: install-ci check build ## Golden CI path: frozen install, check, build

## Clean

clean: ## Remove build output and generated types
	rm -rf dist/ .astro/

distclean: clean ## Also remove node_modules
	rm -rf node_modules/

## Help

help: ## Show this help
	@echo "infrashift.io - terminal-style static site (Astro + bun)"
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'
