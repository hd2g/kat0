open Exssg
open Yocaml

let () =
  Logs.set_level ~all:true (Some Logs.Debug);
  Logs.set_reporter (Logs_fmt.reporter ())

let () =
  let path = Helpers.get_dotenv_pathname () in
  Dotenv.export ~path ();
  Logs.info (fun m ->
    m "CSS_PATH setted %s" (Sys.getenv_opt "CSS_PATH" |> Option.value ~default:""))

let () = Logs.info (fun m -> m "loading site.config.yaml...")
let config = Config.of_file_exn "site.config.yaml"
let () = Logs.info (fun m -> m "loading site.config.yaml...ok")
let destination = "docs"
let index_filename = "index.html"
let index_file_fullname = Filename.concat destination index_filename

let () =
  Logs.info (fun m -> m "outputting index.html...");
  Home.output_file config index_filename;
  Logs.info (fun m -> m "outputting index.html...ok")

let track_binary_update = Build.watch Sys.argv.(0)
let resume_filename = "resume.html"
let resume_file_fullname = Filename.concat destination resume_filename

let home_filename = "home.md"

let task =
  let open Build in
  create_file
    index_file_fullname
    (track_binary_update
     >>> Yocaml_yaml.read_file_with_metadata (module Metadata.Page) home_filename
     >>> Yocaml_markdown.content_to_html ()
    (* TODO(#10)(#11): Wrap "pandoc" command and implement "Yocaml_markdown.pandoc ~style:`Gfm ()" *)
    (* >>> Yocaml_markdown.content_to_html () *)
    >>> Yocaml_mustache.apply_as_template (module Metadata.Page) index_filename
    >>^ Stdlib.snd)

let resume =
  let open Build in
  create_file
    resume_file_fullname
    (track_binary_update
     >>> Yocaml_yaml.read_file_with_metadata (module Metadata.Page) resume_filename
     >>> Yocaml_markdown.content_to_html ()
     >>> Yocaml_mustache.apply_as_template (module Metadata.Page) index_filename
     >>^ Stdlib.snd)

let articles = Filename.concat destination "articles"
let article_filename = "articles.html"
let article_file_fullname = Filename.concat destination article_filename

let article_destination file =
  let filename = basename file |> into "articles" in
  replace_extension filename "html"

let () =
  Logs.info (fun m -> m "outputting index.html...");
  Article.output_file config article_filename;
  Logs.info (fun m -> m "outputting index.html...ok")

let initialize_articles () =
  Sys.readdir articles
  |> Array.iter (fun file -> Sys.remove (Filename.concat articles file))

let blog =
  initialize_articles ();
  process_files [ "./articles" ] (with_extension "md") (fun file ->
    let destination =
      basename file |> into articles |> Helpers.flip replace_extension "html"
    in
    Logs.info (fun m -> m "Destinatino filename: %s" destination);
    let open Build in
    create_file
      destination
      (track_binary_update
      >>> Yocaml_yaml.read_file_with_metadata (module Metadata.Article) file
      >>> Yocaml_markdown.content_to_html ()
      >>> Yocaml_mustache.apply_as_template (module Metadata.Article) article_filename
      >>^ Stdlib.snd))

let resume =
  (* Articles.output_file config (Filename.concat destination "articles.html"); *)
  let open Build in
  let* articles =
    collection
      (read_child_files "articles/" (with_extension "md"))
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
  in
  create_file
    article_file_fullname
    (track_binary_update
     >>> Yocaml_yaml.read_file_with_metadata (module Metadata.Page) "articles.md"
     >>> Yocaml_markdown.content_to_html ()
     >>> articles
     >>> Yocaml_mustache.apply_as_template (module Metadata.Articles) "articles_list.html"
     >>> Yocaml_mustache.apply_as_template (module Metadata.Articles) index_filename
     >>^ Stdlib.snd)

let () = Yocaml_unix.execute (task >> resume >> blog)
