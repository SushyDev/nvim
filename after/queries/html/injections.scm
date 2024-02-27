;; extends

;; Alpine.js class
(attribute
  (attribute_name) @name (#match? @name "^[:@]|^x-")
  (quoted_attribute_value
    (attribute_value) @injection.content
    )
  (#set! injection.include-children)
  (#set! injection.language "javascript")
  )
