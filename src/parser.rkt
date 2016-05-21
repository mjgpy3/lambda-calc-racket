#lang racket

(require racket/match)

(provide parse)

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
	 (cons (list 'application (car r1) (car r2)) (cddr r2)))]))

(define (parse tokens)
  (car (parse-single tokens)))
