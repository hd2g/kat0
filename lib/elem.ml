open Tyxml

let a_blank ~attrs contents =
  Html.(
    a
      ~a:(List.append [ a_target "_blank"; a_rel [ `Noopener; `Noreferrer ] ] attrs)
      contents)
