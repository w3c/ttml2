;;; -*-Scheme-*-

(declare (usual-integrations))

(define (hp x)
  (cond
   ((integer? x)
    (if (exact-integer? x)
	(exact-integer->hexadecimal x)
	(inexact-integer->hexadecimal x)))
   ((string? x)
    (string->hexadecimal x))
   ((wide-string? x)
    (wide-string->hexadecimal x))
   (else "*unknown*")))

(define (exact-integer->hexadecimal x)
  (number->string x 16))

(define (inexact-integer->hexadecimal x)
  (exact-integer->hexadecimal (inexact->exact x)))

(define (string->hexadecimal x)
  (vector-8b->hexadecimal x))

(define (wide-string->hexadecimal x)
  x)
