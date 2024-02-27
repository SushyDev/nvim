;; extends

;; Magento 2 Listy
(element
  (STag
    (Attribute
      (AttValue) @val (#eq? @val "\"listy_format\""))
    )
  (content (CharData) @injection.content)
  (#set! injection.language "json")
  )
