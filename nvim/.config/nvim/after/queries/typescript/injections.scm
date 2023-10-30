;; extends

; vue in storybook template strings
; { template: `<MyComponent />` }
(pair
    key: (property_identifier) @template_key (#eq? @template_key "template")
    value: (template_string) @injection.content
        (#set! injection.language "vue")
        (#offset! @injection.content 0 1 0 -1)
)

