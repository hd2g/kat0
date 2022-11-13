open Tyxml

let render (config : Config.t) =
  let open Html in
  let description' =
    String.split_on_char '\n' config.description
    |> List.map (fun content ->
         p ~a:[ a_class [ "text-white"; "text-md" ] ] [ txt content ])
  in
  header
    ~a:[ a_class [ "container" ] ]
    [ div
        [ h1 [ strong ~a:[ a_class [ "text-4xl" ] ] [ txt config.title ] ]
        ; div ~a:[ a_class [ "pt-4"; "pb-8" ] ] description'
        ]
    ; p
        [ Elem.a_blank
            ~attrs:
              [ a_href config.contact.link
              ; a_role [ "button" ]
              ; a_onclick "event.preventDefault()"
              ]
            [ txt config.contact.name ]
        ]
    ]
