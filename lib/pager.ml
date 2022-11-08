(* open Tyxml *)

module type Config = sig
  val site_title : string
  val contents : Html_types.div Tyxml_html.elt
end

(* module Make (Config : Config) = struct *)
(*   let html = Layout.render ~site_title:Config.site_title Config.contents *)
(* end *)
