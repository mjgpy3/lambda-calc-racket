#lang racket

(define alphabet (string->list "abcdefghijklmnopqrstuvwxyz"))

(define (tokenize text)
  (if (= 0 (string-length text))
    '()
    (let ([first (string-ref text 0)]
          [rest (substring text 1)])
      (cond
	[(eq? #\( first) (cons 'lparen (tokenize rest))]
	[(eq? #\) first) (cons 'rparen (tokenize rest))]
	[(eq? #\\ first) (cons 'lambda (tokenize rest))]
	[(eq? #\. first) (cons 'dot (tokenize rest))]
	[(member first alphabet) (cons (list 'name first) (tokenize rest))]
	[else (tokenize rest)]))))

(display (tokenize ""))
(newline)
(display (tokenize "("))
(newline)
(display (tokenize "()"))
(newline)
(display (tokenize "(\\)"))
(newline)
(display (tokenize "( \\ .  )"))
(newline)
(display (tokenize "( \\ x . x  )"))
(newline)
(display (tokenize "( \\ x . xyz  )"))
