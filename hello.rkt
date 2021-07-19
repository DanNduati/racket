#lang slideshow
;An introduction to racket with pictures
;Basic picture constructors
(circle 10)
(rectangle 10 20)
;hc append - combine basic pictures
(hc-append(circle 10)(rectangle 10 20))
;definitions
(define c (circle 10))
(define r(rectangle 10 20))

(hc-append 20 c r c);hc-append accepts and optional no of arguments before the picture arguments
;function definitions
(define (drawsquare n)
  ; The expression below is the function body
  (filled-rectangle n n))
(drawsquare 10)
;local binding - the define form can be used in some places to create local binding
;example inside a function body
(define (four p)
  (define two-p(hc-append p p))
  (vc-append   two-p two-p))
(four c)
;more typical local binding - using let or let* form
;its advantage is that it can be used in any expression position
;it also binds many identifiers at once but the bindings cant refer to one another
;1. The let form
(define (checker p1 p2)
  (let ([p12 (hc-append p1 p2)]
        [p21 (hc-append p2 p1)])
    (vc-append p12 p21)))
(define c1 (colorize (drawsquare 10) "red"))
(define c2 (colorize (drawsquare 10) "black"))
(checker c1 c2)

;2.let* - allows later bindings to use earlier bindings
(define (checkerboard p)
  (let* ([rp (colorize p "red")]
         [bp (colorize p "black")]
         [c (checker rp bp)]
         [c4 (four c)])
    (four c4)))

(checkerboard (drawsquare 10))

;Function are values
;Since functions are values you can define functions that accept other functions as arguments
(define (series mk)
  (hc-append 4 (mk 5) (mk 10) (mk 20))
  )

(series circle)
(series drawsquare)

;when calling a function that accepts a function argument the argument function often isn't needed anywhere else
;Thus having to write down the function via define would be a hassle because you have to make up a name and a place to put the function definition
;The alternative is thus to use lambda which creates an anonymous function
(series (lambda (size) (checkerboard (drawsquare size))))
(series (lambda (dan) (drawsquare dan)))
;parenthisezed names after a lambda are the arguments of the function
;Expression after the argument names is the function body
;other examples
((lambda(x,y)(list y x)))

