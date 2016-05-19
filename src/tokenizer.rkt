#lang racket

(provide tokenize)

(define alphabet (list->set (string->list "abcdefghijklmnopqrstuvwxyz")))

(define (tokenize text)
  (if (= 0 (string-length text))
    '()
    (let ([first (string-ref text 0)]
             [rest (substring text 1)])
      (append (cond
	[(eq? #\( first) '(lparen)]
	[(eq? #\) first) '(rparen)]
	[(eq? #\\ first) '(lambda)]
	[(eq? #\. first) '(dot)]
	[(set-member? alphabet first) (list (list 'name first))]
	[else '()]) (tokenize rest)))))
