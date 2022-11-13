#!/bin/bash -eu

pushd articles
rm html/*.html 2> /dev/null
for md in *.md; do
  destination="html/${md/.md/.html}"

  printf "[INFO] convert ${md} to ${destination}..."
  pandoc -f gfm -t html -o ${destination} ${md}
  echo "ok"
done
popd
