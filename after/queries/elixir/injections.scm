;; extends

;; SQL in Ecto. A string with #{} is split around the interpolation, and each
;; piece is parsed as its own SQL snippet.

;; Ecto.Migration.execute: every string argument is SQL (up and down)
;;   execute "DROP TABLE x"
;;   execute("INSERT ...", "DELETE ...")
;;   execute """
;;   CREATE TRIGGER ...
;;   """
(call
  target: (identifier) @_fn (#eq? @_fn "execute")
  (arguments
    [
      (string (quoted_content) @injection.content)
      (sigil (quoted_content) @injection.content)
    ])
  (#set! injection.language "sql"))

;; Raw queries, the query is the first string argument:
;;   repo().query!("SELECT ...")            (inside execute(fn -> ... end))
;;   Repo.query("SELECT ...", [id])
;;   Ecto.Adapters.SQL.query!(Repo, "SELECT ...", [id])
(call
  target: (dot
    right: (identifier) @_fn (#any-of? @_fn "query" "query!" "query_many" "query_many!" "stream"))
  (arguments
    [
      (string (quoted_content) @injection.content)
      (sigil (quoted_content) @injection.content)
    ])
  (#set! injection.language "sql"))

;; Ecto.Query.fragment: only the first argument, the rest are bindings
;;   where: fragment("lower(?) = ?", u.email, ^email)
(call
  target: (identifier) @_fn (#eq? @_fn "fragment")
  (arguments
    .
    [
      (string (quoted_content) @injection.content)
      (sigil (quoted_content) @injection.content)
    ])
  (#set! injection.language "sql"))
