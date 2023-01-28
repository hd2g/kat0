PORT := 8000
PUBLIC_DIR := ./docs

all: build/html build/css

.PHONE: format
format:
	dune build @fmt --auto-promote

.PHONE: build/html/resume
build/html/resume:
	pandoc resume.md -f gfm -o resume.html

# build/html/articles:
# 	bash scripts/build_html_articles.sh

build/html: build/html/resume # build/html/articles
	dune exec bin/main.exe

.PHONE: build/css
build/css:
	yarn build:css

.PHONE: watch
watch:
	find tailwind.config.js **/*.html *.md articles lib bin static -type f | entr sh -c "make all"

.PHONY: serve
serve:
	yarn serve $(PUBLIC_DIR) -p $(PORT)

.PHONY: new
new:
	@bash scripts/create_initialized_markdown_file.sh
