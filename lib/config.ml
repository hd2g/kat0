module Other_site = struct
  type t =
    { name : string
    ; link : string
    }

  let acons_of = List.map (fun other_site -> other_site.name, other_site.link)
end

type t =
  { title : string
  ; description : string
  ; contact : Other_site.t
  ; sns : Other_site.t list
  }

exception Config_parse_error

let of_file_exn pathname =
  assert (Sys.file_exists pathname);
  let yaml = Yaml_unix.of_file_exn Fpath.(v pathname) in
  let title = Ezjsonm.(find yaml [ "title" ] |> get_string) in
  let description = Ezjsonm.(find yaml [ "description" ] |> get_string) in
  let contact =
    { Other_site.name = Ezjsonm.(find yaml [ "contact"; "name" ] |> get_string)
    ; link = Ezjsonm.(find yaml [ "contact"; "link" ] |> get_string)
    }
  in
  let sns =
    Ezjsonm.(find yaml [ "sns" ] |> get_list get_dict)
    |> List.map (fun sns ->
         match sns with
         | [ ("name", `String name); ("link", `String link) ] -> { Other_site.name; link }
         | _ -> raise Config_parse_error)
  in
  { title; description; contact; sns }
