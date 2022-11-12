open Exssg
open Yocaml

let () =
  Logs.set_level ~all:true (Some Logs.Debug);
  Logs.set_reporter (Logs_fmt.reporter ())


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

let task =
  let open Build in
  create_file
    index_file_fullname
    (track_binary_update
    >>> Yocaml_yaml.read_file_with_metadata (module Metadata.Page) resume_filename
    (* >>> Yocaml_markdown.content_to_html () *)
    >>> Yocaml_mustache.apply_as_template (module Metadata.Page) index_filename
    >>^ Stdlib.snd)


let () =
  Logs.(
    set_level ~all:true (Some Debug);
    set_reporter (Logs_fmt.reporter ()))


let () = Yocaml_unix.execute task
