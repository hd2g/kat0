open Yocaml

type props =
  { track_binary_update : (unit, unit) Build.t
  ; article_file_fullname : string
  ; home_filename : string
  ; article_filename : string
  }

let article_destination pathname =
  let filename = basename pathname |> into "articles" in
  replace_extension filename "html"

let collect_articles ~root_dir track_binary_update =
  let open Build in
  collection
    (read_child_files root_dir (with_extension "md"))
    (fun source ->
      track_binary_update
      >>> Yocaml_yaml.read_file_with_metadata (module Metadata.Article) source
      >>^ fun (x, _) -> x, article_destination source)
    (fun x (meta, content) ->
      x
      |> Metadata.Articles.make
           ?title:(Metadata.Page.title meta)
           ?description:(Metadata.Page.description meta)
      |> Metadata.Articles.sort_articles_by_date
      |> fun x -> x, content)
