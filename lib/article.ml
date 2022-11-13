open Helpers
open Tyxml

let render (config : Config.t) =
  Layout.render
    config
    (get_css_path_opt () |> Option.get)
    Html.(
      div
        ~a:[ a_class [ "bg-base-100"; "flex"; "flex-col" ] ]
        [ div
            ~a:[ a_class [ "article-header"; "flex-1"; "my-8" ] ]
            [ p
                [ small ~a:[ a_class [ "text-gray-500" ] ] [ txt "{{ date.canonical }}" ]
                ]
            ; h2 ~a:[ a_class [ "text-2xl" ] ] [ txt "{{ article_title }}" ]
            ; p
                [ small
                    ~a:[ a_class [ "pt-8"; "text-gray-500"; "text-md" ] ]
                    [ txt "{{ article_description }}" ]
                ]
            ]
        ; div ~a:[ a_class [ "article-body"; "flex-1"; "my-8" ] ] [ txt "{{{ body }}}" ]
        ])

let output_file (config : Config.t) = output_html_to_file_exn (render config) config
