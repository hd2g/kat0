open Tyxml

let sns_icons_of_config (config : Config.t) =
  config.sns
  |> List.map (fun { Config.Other_site.name; link } ->
       match List.assoc_opt name Icons.as_acons with
       | Some icon ->
         Html.a
           ~a:
             [ Html.a_href link
             ; Html.a_target "_blank"
             ; Html.a_rel [ `Noopener; `Noreferrer ]
             ]
           [ icon ]
       | None -> Html.a ~a:[ Html.a_href link; Html.a_class [ "link" ] ] [ Html.txt name ])


let render (config : Config.t) =
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
      ; div ~a:[ a_class [ "grid-flow-col"; "gap-4" ] ] (sns_icons_of_config config)
      ])
