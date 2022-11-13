PORT := 8000
PUBLIC_DIR := ./docs

all: build/html build/css

build/html/resume:
	pandoc resume.md -f gfm -o resume.html

# build/html/articles:
	# bash scripts/build_html_articles.sh

build/html: build/html/resume # build/html/articles
	dune exec bin/main.exe

build/css:
	yarn build:css

build/watch:
	find tailwind.config.js resume.md articles lib bin static -type f | entr sh -c "make all"

serve:
	yarn serve $(PUBLIC_DIR) -p $(PORT)
