#lang racket

(require "main.rkt")

(for ([id (take (top-100-story-ids) 20)])
  (define item (get-item id))
  (printf "~a votes \"~a\" ~a comments.\n"
          (hash-ref item 'score)
          (hash-ref item 'title)
          (length (hash-ref item 'kids '()))))
