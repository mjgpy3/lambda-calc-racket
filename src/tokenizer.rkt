#lang racket

(define (tokenize text)
  (if (= 0 (string-length text))
    '()
    (cond
      [else (cons 'lparen (tokenize (substring text 1)))])))

(display (tokenize ""))
(newline)
(display (tokenize "("))
