#!/bin/bash -eu

printf "New Article Title? "
read article_title
if [ -z $article_title ]; then
  exit 0
fi

printf "Is New Article filename the same as title?[Y/n]"
read is_same
case $(echo $is_same | tr A-Z a-z) in
  n)
    printf "New Article filename? "
    read article_filename

    if [ -z $article_filename ]; then
      echo "New Article filename is required" >&2
      exit 1
    fi
    ;;
  *)
    article_filename=$article_title
    ;;
esac

printf "New Article Description(default: \"\")? "
read article_description
if [ -z $article_description ]; then
  article_description='""'
fi


printf "New Article Tags(e.g. tag-a,tag-b)? "
read article_tags

{
echo "---"
echo "date: $(date '+%Y-%m-%d %H:%M:%S')"
echo "article_title: $article_title"
echo "article_description: $article_description"
if ! [ -z $article_tags ]; then
  echo "tags: "
  for tag in $(echo $article_tags | tr ',' ' '); do
    echo "  - $tag"
  done
fi
echo "---"
} > ./articles/$article_filename.md
