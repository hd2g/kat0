open Tyxml

let render (config : Config.t) css_path contents =
  Html.(
    html
      ~a:[ a_lang "ja" ]
      (head
         (title (txt config.title))
         [ meta ~a:[ a_charset "utf8" ] ()
         ; meta
             ~a:[ a_name "viewport"; a_content "width=device-width,initial-scale=1" ]
             ()
         ; link ~rel:[ `Stylesheet ] ~href:css_path ()
         ])
      (body
         ~a:[ a_class [ "flex"; "flex-col"; "h-screen" ] ]
         [ div
             ~a:[ a_class [ "header-image" ]; a_user_data "theme" "dark" ]
             [ Topbar.render config; Header.render config ]
         ; main ~a:[ a_class [ "container"; "flex-grow" ] ] [ contents ]
         ; Footer.render config
         ]))
