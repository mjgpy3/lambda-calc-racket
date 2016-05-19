#lang racket

(require racket/match)

(provide eval)

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
