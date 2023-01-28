open Tyxml

type 'a dropdown_elm =
  { attrs : 'a Html.attrib Html.list_wrap
  ; name : string
  ; link : string
  }

let dropdown brief elems =
  let open Html in
  let items =
    List.map
      (fun { attrs; name; link } ->
        li [ Elem.a_blank ~attrs:(List.append [ a_href link ] attrs) [ txt name ] ])
      elems
  in
  details
    ~a:[ a_role [ "list" ]; a_dir `Rtl ]
    (summary
       ~a:[ a_aria "haspopup" [ "listbox" ]; a_role [ "link" ]; a_class [ "contrast" ] ]
       [ txt brief ])
    [ ul ~a:[ a_role [ "listbox" ] ] items ]

let sns (config : Config.t) =
  dropdown
    "SNS"
    (List.map
       (fun (sns : Config.Other_site.t) ->
         { attrs = []; name = sns.name; link = sns.link })
       config.sns)

let render (config : Config.t) =
  Html.(
    nav
      ~a:[ a_class [ "container-fluid" ] ]
      [ ul
          [ li
              [ a
                  ~a:
                    [ a_href "/"
                    ; a_class [ "contrast" ]
                    ; a_onclick "evnet.preventDefault()"
                    ]
                  [ strong [ txt "" ] ]
              ]
          ]
      ; ul [ li [ sns config ] ]
      ])
