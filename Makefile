PORT := 8000
PUBLIC_DIR := ./docs

all: build/html build/css

build/html:
	pandoc resume.md -f gfm -o resume.html
	dune exec bin/main.exe

build/css:
	yarn build:css

build/watch:
	find resume.md lib bin static -type f | entr sh -c "make all"

serve:
	yarn serve $(PUBLIC_DIR) -p $(PORT)
