;;; -*-Scheme-*-

(load-option 'xml)
(load-option 'cref)
(with-working-directory-pathname (directory-pathname (current-load-pathname))
  (lambda ()
    (compile-file "rxi")
    (compile-file "adi")
    (compile-file "tir")
    (compile-file "fox")
    (compile-file "win32-ext")
    (compile-file "dtf")
    (cref/generate-constructors "dfxp")))
