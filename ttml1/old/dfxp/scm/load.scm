;;; -*-Scheme-*-

(load-option 'xml)
(with-working-directory-pathname (directory-pathname (current-load-pathname))
  (lambda ()
    (load-package-set "dfxp")))
(add-subsystem-identification! "DFXP" '(0 8))
