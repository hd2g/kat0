open Tyxml

let html =
  Layout.render
    ~site_name:"Resume"
    Html.(div ~a:[ a_class [ "markdown-body"; "bg-base-100" ] ] [ txt "{{ body }}" ])


let output_file filename =
  let ch = open_out filename in
  let fmt = Format.formatter_of_out_channel ch in
  Format.fprintf fmt "%a@." (Html.pp ~indent:true ()) html;
  close_out ch
