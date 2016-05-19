#lang racket

(require "parser.rkt")
(require "evaluator.rkt")
(require "tokenizer.rkt")
(require "pretty.rkt")

(require racket/cmdline)

(display
  (pretty
    (eval
      (parse
	(tokenize
	  (vector-ref (current-command-line-arguments) 0))))))
