;; No `;; extends`: this replaces nvim-treesitter's heex injections, because its
;; `(expression) -> elixir` rule would also claim every { } inside colocated
;; <script>/<style> bodies. The rules below are upstream's, plus the colocated ones.

; directives are standalone tags like '<%= @x %>'
;
; partial_expression_values are elixir code that is part of an expression that
; spans multiple directive nodes, so they must be combined. For example:
;     <%= if true do %>
;       <p>hello, tree-sitter!</p>
;     <% end %>
(directive
  [
    (partial_expression_value)
    (ending_expression_value)
  ] @injection.content
  (#set! injection.language "elixir")
  (#set! injection.include-children)
  (#set! injection.combined))

; Regular expression_values do not need to be combined
((directive
  (expression_value) @injection.content)
  (#set! injection.language "elixir"))

; expressions in attributes, components, slots, ...
;     <link href={ Routes.static_path(..) } />
((expression
  (expression_value) @injection.content) @_expr
  (#not-has-parent? @_expr tag)
  (#set! injection.language "elixir"))

; expressions in the body of a regular tag; <script>/<style> bodies are left out
;     <p>{@msg}</p>
(tag
  (start_tag
    (tag_name) @_tag (#not-any-of? @_tag "script" "style"))
  (expression
    (expression_value) @injection.content)
  (#set! injection.language "elixir"))

; HEEx comments
((comment) @injection.content
  (#set! injection.language "comment"))

;; Phoenix LiveView colocated JS and hooks (also inside ~H in .ex files):
;;   <script :type={Phoenix.LiveView.ColocatedJS} name="MyThing">...</script>
;;   <script :type={Phoenix.LiveView.ColocatedHook} name=".MyHook">...</script>
;; HEEx has no raw-text <script>, so the body comes through as (text) plus
;; (expression) wherever a { } appears. All of those nodes go into one JS document.
(tag
  (start_tag
    (tag_name) @_tag (#eq? @_tag "script")
    (attribute
      (attribute_name) @_attr (#eq? @_attr "type")
      (expression
        (expression_value) @_type (#match? @_type "Colocated(JS|Hook)$"))))
  [(text) (expression)]+ @injection.content
  (#set! injection.include-children)
  (#set! injection.language "javascript"))

;; Phoenix LiveView colocated CSS:
;;   <style :type={Phoenix.LiveView.ColocatedCSS}>...</style>
(tag
  (start_tag
    (tag_name) @_tag (#eq? @_tag "style")
    (attribute
      (attribute_name) @_attr (#eq? @_attr "type")
      (expression
        (expression_value) @_type (#match? @_type "ColocatedCSS$"))))
  [(text) (expression)]+ @injection.content
  (#set! injection.include-children)
  (#set! injection.language "css"))
