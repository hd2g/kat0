open Exssg
open Yocaml

let destination = "_site"

let index_filename = "index.html"
let index_file_fullname = Filename.concat destination "./index.html"

let () =
  Home.output_file index_filename

let track_binary_update = Build.watch Sys.argv.(0)

(* let task = *)
(*   process_files [ "pages/" ] (with_extension "html") (fun file -> *)
(*       let target = basename file |> into destination in *)
(*       let open Build in *)
(*       create_file *)
(*         target *)
(*         (track_binary_update *)
(*          >>> read_file "templates/header.html" *)
(*          >>> pipe_content file *)
(*          >>> pipe_content "templates/footer.html")) *)

(* let () = Yocaml_unix.execute task *)

