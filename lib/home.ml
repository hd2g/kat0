open Tyxml

let html (config : Config.t) =
  Layout.render
    config
    Html.(div ~a:[ a_class [ "markdown-body"; "bg-base-100" ] ] [ txt "{{{body}}}" ])


let output_file (config : Config.t) filename =
  let ch = open_out filename in
  try
    let fmt = Format.formatter_of_out_channel ch in
    Format.fprintf fmt "%a@." (Html.pp ~indent:true ()) (html config);
    close_out ch
  with
  | exn ->
    close_out ch;
    raise exn
