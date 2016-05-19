#lang racket

(require racket/match)

(define (parse-single tokens)
  (match tokens
    [(list (list 'name name) rest ...)
       (cons (list 'name name) rest)]

    [(list 'lambda (list 'name name) 'dot rest ...)
       (let ([result (parse-single rest)])
	 (cons (list 'lambda name (car result)) (cdr result)))]

    [(list 'lparen rest ...)
       (letrec ([r1 (parse-single rest)]
		[r2 (parse-single (cdr r1))])
	 (cons (list 'application (car r1) (car r2)) (cdr r2)))]))

(define (parse tokens)
  (car (parse-single tokens)))

(display (parse (list (list 'name 'x))))
(newline)
(display (parse (list
		  'lambda
		  (list 'name 'x)
		  'dot
		  (list 'name 'x))))
(newline)
(display (parse (list
		  'lparen
		  'lambda
		  (list 'name 'x)
		  'dot
		  (list 'name 'x)
		  'lambda
		  (list 'name 'y)
		  'dot
		  (list 'name 'y)
		  'rparen)))
