PORT := 8000
PUBLIC_DIR := ./docs

all: build build/css

build:
	pandoc resume.md -f gfm -o resume.html
	dune exec bin/main.exe

build/css:
	yarn build:css

build/watch:
	find resume.md lib bin static -type f | entr sh -c "make build && make build/css"

serve:
	yarn serve $(PUBLIC_DIR) -p $(PORT)
