#!/bin/bash -eu

rm docs/articles/*.html
pushd articles
for md in *.md; do
  destination="html/${md/.md/.html}"

  printf "[INFO] convert ${md} to ${destination}..."
  pandoc -f gfm -t html -o ${destination} ${md}
  echo "ok"
done
popd
