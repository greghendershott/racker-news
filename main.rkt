#lang racket/base

(require json
         net/url)

(provide get-item
         get-user
         top-100-story-ids
         max-item-id)

(define (get-item id)
  (url->json (format "https://hacker-news.firebaseio.com/v0/item/~a.json"
                    id)))

(define (get-user id)
  (url->json (format "https://hacker-news.firebaseio.com/v0/user/~a.json"
                    id)))

(define (top-100-story-ids)
  (url->json "https://hacker-news.firebaseio.com/v0/topstories.json"))
  
(define (max-item-id)
  (url->json "https://hacker-news.firebaseio.com/v0/maxitem.json"))

(define (updates)
  (url->json "https://hacker-news.firebaseio.com/v0/updates.json"))

(define (url->json url)
  (call/input-url (string->url url) get-pure-port read-json))

(module+ test
  (require rackunit)
  (check-true (list? (top-100-story-ids)))
  (check-match (updates) (hash-table ['items (? list?)]
                                     ['profiles (? list?)]))
  (check-true (integer? (max-item-id)))
  (check-true (hash? (get-item (max-item-id))))
  (check-true (hash? (get-user "greghendershott"))))
