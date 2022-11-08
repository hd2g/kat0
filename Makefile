PORT := 8000

build:
	dune exec bin/main.exe

build/css:
	yarn build

build/watch:
	find lib/*.ml -type f | entr sh -c "make build && make build/css"

serve:
	yarn serve -p $(PORT)
