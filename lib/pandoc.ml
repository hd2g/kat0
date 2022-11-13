module Props = struct
  type t =
    { format : string option
    ; to_ : string option
    ; output : string option
    }

  let names = [ "format"; "to"; "output" ]

  let list_of { format; to_; output } =
    List.filter_map (fun x -> x) [ format; to_; output ]

  let acons_of t =
    let names = List.map (fun name -> "--" ^ name) names in
    let values = list_of t in
    List.map2 (fun name value -> name, value) names values

  let string_of t =
    List.fold_left
      (fun acc (name, value) -> Printf.sprintf "%s %s %s" acc name value)
      ""
      (acons_of t)
end

let executable_name = "pandoc"
