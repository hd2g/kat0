let bucket ~init ~finally proc =
  let handle = init () in
  try
    let result = proc handle in
    finally handle;
    result
  with
  | exn ->
    finally handle;
    raise exn

let flip f y x = f x y

let output_html_to_file_exn document (config : Config.t) filename =
  bucket
    ~init:(fun () -> open_out filename)
    ~finally:(fun ch -> close_out ch)
    Tyxml.(
      fun ch ->
        let fmt = Format.formatter_of_out_channel ch in
        Format.fprintf fmt "%a@." (Html.pp ~indent:true ()) document)

let get_dotenv_pathname () =
  match
    [ "PRODUCT"; "DEVELOPMENT"; "TEST" ]
    |> List.filter (fun stage -> Sys.getenv_opt stage |> Option.is_some)
  with
  | [] -> ".env"
  | stage :: _ -> ".env." ^ String.lowercase_ascii stage

let get_css_path_opt () = Sys.getenv_opt "CSS_PATH"
