(* open Helpers *)
(* open Tyxml *)

(*
let render (config : Config.t) =
  Layout.render config (get_css_path_opt () |> Option.get)
    Html.(
    div
      [ txt "{{{body}}}"
      ; h1 [ txt "Articles" ]
      ; ol
          [ txt "{{#articles}}"
          ; li
              [ span
                  [ txt "{{#date}}{{canonical}}{{/date}}"
                  ]
              ; a ~a:[ a_href "{{url}}" ]
                  [ txt "{{article_title}}" ]
              ; p [ txt "{{article_description}}" ]]
          ; txt "{{/articles}}" ]])

let output_file (config : Config.t) = output_html_to_file_exn (render config) config
 *)
