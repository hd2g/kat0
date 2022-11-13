open Tyxml

let render (config : Config.t) contents =
  Html.(
    html
      ~a:[ a_lang "ja" ]
      (head
         (title (txt config.title))
         [ meta ~a:[ a_charset "utf8" ] ()
         ; meta
             ~a:[ a_name "viewport"; a_content "width=device-width,initial-scale=1" ]
             ()
         ; link ~rel:[ `Stylesheet ] ~href:"https://hd2g.github.io/kat0/style.css" ()
         ])
      (body
         [ div
             ~a:[ a_class [ "header-image" ]; a_user_data "theme" "dark" ]
             [ Topbar.render config; Header.render config ]
         ; main ~a:[ a_class [ "container" ] ] [ contents ]
         ; Footer.render config
         ]))
