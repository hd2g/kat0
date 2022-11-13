open Helpers
open Tyxml

let render (config : Config.t) =
  Layout.render
    config
    (get_css_path_opt () |> Option.get)
    Html.(div ~a:[ a_class [ "markdown-body"; "bg-base-100" ] ] [ txt "{{{body}}}" ])


let output_file (config : Config.t) = output_html_to_file_exn (render config) config
