#lang racket

(require racket/match)

(provide pretty)

(define (pretty ast)
  (match (car ast)
    ['name (string (cadr ast))]
    ['application (string-append "(" (pretty (cadr ast)) " " (pretty (caddr ast)) ")")]
    [_ (string-append "\\" (string (cadr ast)) "." (pretty (caddr ast)))]))
