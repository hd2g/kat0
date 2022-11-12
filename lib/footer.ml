open Tyxml

let render (config : Config.t) =
  let sns_list = Config.other_site_to_acons config.sns in
  Html.(
    footer
      ~a:
        [ a_class
            [ "footer"
            ; "bottom-0"
            ; "items-center"
            ; "p-12"
            ; "text-base-content"
            ; "bg-base-300"
            ]
        ]
      [ div
          ~a:[ a_class [ "items-center"; "grid-flow-col" ] ]
          [ p
              [ txt "Copyright(c) "
              ; a ~a:[ a_class [ "link" ]; a_href "/" ] [ txt config.title ]
              ; txt " All Right Reserved."
              ]
          ]
      ; div
          ~a:[ a_class [ "grid-flow-col"; "gap-4" ] ]
          [ a ~a:[ a_href (List.assoc "Twitter" sns_list) ] [ Icons.twitter ]
          ; a ~a:[ a_href (List.assoc "GitHub" sns_list) ] [ Icons.github ]
          ]
      ])
