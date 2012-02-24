;;; -*-Scheme-*-

(load-option 'xml)
(with-working-directory-pathname (directory-pathname (current-load-pathname))
  (lambda ()
    (package/system-loader "dfxp" '() 'query)))
(add-subsystem-identification! "DFXP" '(0 8))
