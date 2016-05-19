#lang racket

(require racket/match)

(define (eval ast)
  (eval-env ast '()))

(define (eval-env ast env)
  (match ast
    [(list 'name name) (cadr (assoc name env))]
    [(list 'lambda arg body) (list 'closure arg body env)]
    [(list 'application fn arg) (let ([closure (eval-env fn env)]
				      [value (eval-env arg env)])
				  (eval-env
				    (caddr closure)
				    (append (list (list (cadr closure) value)) (cadddr closure) env)))]))



(define (l arg body)
  (list 'lambda arg body))

(define (n v)
  (list 'name v))

(define (a fn arg)
  (list 'application fn arg))

(display (eval (l 'x (n 'x))))
(newline)
(display (eval (a (l 'x (n 'x)) (l 'y (n 'y)))))
(newline)
(display (eval (a (a (l 'x (l 'z (n 'x))) (l 'z (n 'z))) (l 'c (n 'c)))))
