open Tyxml

let footer' copyright =
  Html.(
    footer
      ~a:
        [ a_class
            [ "footer"
            ; "bottom-0"
            ; "items-center"
            ; "p-12"
            ; "bg-base-200"
            ; "text-base-content"
            ]
        ]
      [ div ~a:[ a_class [ "items-center"; "grid-flow-col" ] ] [ copyright ]
      ; div
          ~a:[ a_class [ "grid-flow-col"; "gap-4" ] ]
          [ a
              ~a:[ a_href "#" ]
              [ svg
                  ~a:
                    Svg.
                      [ a_class [ "fill-current" ]
                      ; a_width (24., None)
                      ; a_viewBox (0., 0., 24., 24.)
                      ]
                  [ Svg.path
                      ~a:
                        Svg.
                          [ a_d
                              "M23.953 4.57a10 10 0 01-2.825.775 4.958 4.958 0 \
                               002.163-2.723c-.951.555-2.005.959-3.127 1.184a4.92 4.92 0 \
                               00-8.384 4.482C7.69 8.095 4.067 6.13 1.64 3.162a4.822 \
                               4.822 0 00-.666 2.475c0 1.71.87 3.213 2.188 4.096a4.904 \
                               4.904 0 01-2.228-.616v.06a4.923 4.923 0 003.946 4.827 \
                               4.996 4.996 0 01-2.212.085 4.936 4.936 0 004.604 3.417 \
                               9.867 9.867 0 01-6.102 2.105c-.39 \
                               0-.779-.023-1.17-.067a13.995 13.995 0 007.557 2.209c9.053 \
                               0 13.998-7.496 13.998-13.985 0-.21 0-.42-.015-.63A9.935 \
                               9.935 0 0024 4.59z"
                          ]
                      []
                  ]
              ]
          ; a
              ~a:[ a_href "#" ]
              [ svg
                  ~a:
                    Svg.
                      [ a_class [ "fill-current" ]
                      ; a_width (24., None)
                      ; a_viewBox (0., 0., 24., 24.)
                      ]
                  [ Svg.path
                      ~a:
                        Svg.
                          [ a_d
                              "M12 .297c-6.63 0-12 5.373-12 12 0 5.303 3.438 9.8 8.205 \
                               11.385.6.113.82-.258.82-.577 \
                               0-.285-.01-1.04-.015-2.04-3.338.724-4.042-1.61-4.042-1.61C4.422 \
                               18.07 3.633 17.7 3.633 17.7c-1.087-.744.084-.729.084-.729 \
                               1.205.084 1.838 1.236 1.838 1.236 1.07 1.835 2.809 1.305 \
                               3.495.998.108-.776.417-1.305.76-1.605-2.665-.3-5.466-1.332-5.466-5.93 \
                               0-1.31.465-2.38 1.235-3.22-.135-.303-.54-1.523.105-3.176 \
                               0 0 1.005-.322 3.3 1.23.96-.267 1.98-.399 3-.405 1.02.006 \
                               2.04.138 3 .405 2.28-1.552 3.285-1.23 3.285-1.23.645 \
                               1.653.24 2.873.12 3.176.765.84 1.23 1.91 1.23 3.22 0 \
                               4.61-2.805 5.625-5.475 5.92.42.36.81 1.096.81 2.22 0 \
                               1.606-.015 2.896-.015 3.286 0 .315.21.69.825.57C20.565 \
                               22.092 24 17.592 24 12.297c0-6.627-5.373-12-12-12"
                          ]
                      []
                  ]
              ]
          ]
      ])


let render ~site_title contents =
  Html.(
    html
      (head
         (title (txt site_title))
         [ meta ~a:[ a_charset "utf8" ] ()
         ; meta
             ~a:[ a_name "viewport"; a_content "width=device-width,initial-scale=1" ]
             ()
         ; link ~rel:[ `Stylesheet ] ~href:"/style.css" ()
         ])
      (body
         [ main
             ~a:[ a_class [ "drawer" ] ]
             [ input
                 ~a:
                   [ a_id "menu-button"
                   ; a_class [ "drawer-toggle" ]
                   ; a_input_type `Checkbox
                   ]
                 ()
             ; div
                 ~a:[ a_class [ "drawer-content" ] ]
                 [ div
                     ~a:[ a_class [ "flex"; "flex-col" ] ]
                     [ header
                         ~a:
                           [ a_class
                               [ "sticky"; "top-0"; "w-full"; "navbar"; "bg-base-300" ]
                           ]
                         [ div
                             ~a:[ a_class [ "flex" ] ]
                             [ label
                                 ~a:
                                   [ a_class [ "btb"; "btn-square"; "btn-ghost" ]
                                   ; a_label_for "menu-button"
                                   ]
                                 [ a
                                     [ svg
                                         ~a:
                                           Svg.
                                             [ a_class
                                                 [ "inline-block"
                                                 ; "w-6"
                                                 ; "h-6"
                                                 ; "stroke-current"
                                                 ; "content-items-center"
                                                 ; "justify-items-center"
                                                 ]
                                             ; a_fill `None
                                             ; a_viewBox (0., 0., 24., 24.)
                                             ]
                                         [ Svg.(
                                             path
                                               ~a:
                                                 [ a_stroke_linecap `Round
                                                 ; a_stroke_linejoin `Round
                                                 ; a_stroke_width (2., None)
                                                 ; a_d "M4 6h16M4 12h16M4 18h16"
                                                 ]
                                               [])
                                         ]
                                     ]
                                 ]
                             ]
                         ; h1
                             ~a:[ a_class [ "text-4xl"; "mx-4" ] ]
                             [ a ~a:[ a_href "/" ] [ txt site_title ] ]
                         ]
                     ]
                 ; div ~a:[ a_class [ "mx-8"; "my-8" ] ] [ contents ]
                 ; footer'
                     (p
                        [ txt "Copyright(c) "
                        ; a ~a:[ a_class [ "link" ]; a_href "/" ] [ txt site_title ]
                        ; txt " All Right Reserved."
                        ])
                 ]
             ; div
                 ~a:[ a_class [ "drawer-side" ] ]
                 [ label ~a:[ a_class [ "drawer-overlay" ]; a_label_for "menu-button" ] []
                 ; ul
                     ~a:
                       [ a_class
                           [ "menu"
                           ; "p-4"
                           ; "overflow-y-auto"
                           ; "w-80"
                           ; "bg-base-100"
                           ; "text-base-content"
                           ]
                       ]
                     [ li [ a ~a:[ a_href "/" ] [ txt "Home" ] ] ]
                 ]
             ]
         ]))
