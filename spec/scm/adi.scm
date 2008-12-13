;;; -*-Scheme-*-
;;; Package: (dfxp rxi adi)

;
; DFXP Abstrarct Document Instance Load, Save, Transformer
;

(declare (usual-integrations))

(define *dfxp-preferred-reverse-bindings*
  '(("http://www.w3.org/2006/10/ttaf1" . "")
    ("http://www.w3.org/2006/10/ttaf1#parameter" . "ttp")
    ("http://www.w3.org/2006/10/ttaf1#style" . "tts")
    ("http://www.w3.org/2006/10/ttaf1#style-extension" . "ttsx")
    ("http://www.w3.org/2006/10/ttaf1#metadata" . "ttm")
    ("http://www.w3.org/2006/10/ttaf1#metadata-extension" . "ttmx")))

(define *dfxp-namespaces-table*
  (let ((t (make-string-hash-table)))
    (for-each
      (lambda (b)
        (hash-table/put! t (car b) #t))
      *dfxp-preferred-reverse-bindings*)
    t))

(define *dfxp-empty-element-types*
  '(("br" . "http://www.w3.org/2006/10/ttaf1")
    ("metadata" . "http://www.w3.org/2006/10/ttaf1")))

(define (in-per-element-namespace? attr)
  (let* ((name (rxi-attribute/name attr))
         (namespace (rxi-name/namespace name)))
    (null? namespace)))

(define (in-dfxp-namespace? name)
  (hash-table/get *dfxp-namespaces-table* (rxi-name/namespace name) #f))

(define (in-xml-namespace? name)
  (string=? (rxi-name/namespace name) (car *xml-default-reverse-binding*)))

(define (in-dfxp-or-xml-namespace? name)
  (or (in-dfxp-namespace? name)
      (in-xml-namespace? name)))

(define (empty-dfxp-element-type? elt)
  (let* ((name (rxi-element/name elt))
         (local (rxi-name/local name))
         (namespace (rxi-name/namespace name)))
    (find-matching-item
      *dfxp-empty-element-types*
      (lambda (n)
        (and (string=? local (car n))
             (string=? namespace (cdr n)))))))
                        
(define (only-whitespace-children? elt)
  (let ((children (rxi-element/children elt)))
    (not
      (find-matching-item
        children
        (lambda (c)
          (or (not (string? c))
              (string-find-next-char-in-set c char-set:not-whitespace)))))))

(define (rxi-document/adi-transform-element elt)
  ;; prune and transform children
  (set-rxi-element/children!
    elt
    (delete-matching-items
      (map
        (lambda (c)
          (if (string? c)
              c
              (if (not (in-dfxp-namespace? (rxi-element/name c)))
                  '()
                  (rxi-document/adi-transform-element c))))
        (rxi-element/children elt))
      null?))
  ;; prune remaining children if empty element type and only whitespace remains
  (if (and (empty-dfxp-element-type? elt)
           (only-whitespace-children? elt))
      (set-rxi-element/children! elt '()))
  ;; prune foreign namespace attributes
  (set-rxi-element/attributes!
    elt
    (delete-matching-items
      (rxi-element/attributes elt)
      (lambda (a)
          (not (or (in-per-element-namespace? a)
                   (in-dfxp-or-xml-namespace? (rxi-attribute/name a)))))))
  elt)

(define (rxi-document/adi-transform document)
  (if (not (null? (rxi-document/annotation document 'adi-transform)))
      (warn "Document already transformed, ignoring re-transform.")
      (let ((root (rxi-document/root document)))
        (set-rxi-document/root! document (rxi-document/adi-transform-element root))
        (set-rxi-document/annotation! document 'adi-transform #t)))
  document)
  
;
; Load TT AF document instance from PATHNAME using RXI loader,
; then transform resulting RXI-DOCUMENT instance to an ADI-DOCUMENT
; instance.
;
(define (adi-document/load pathname)
  (rxi-document/adi-transform
    (rxi-document/load pathname)))

;
; Save ADI-DOCUMENT instance DOCUMENT, which was created by ADI-DOCUMENT/LOAD,
; to PATHNAME using underlying RXI-DOCUMENT's document serializer,
; where optional argument OTHER-REVERSE-BINDINGS, if specified, consists
; of an association list whose keys are namespace URIs and values are the
; namespace prefixes to use to designate those namespaces.
;
; By default the set of refeverse bindings defined by *DFXP-PREFERRED-REVERSE-BINDING*
; are used when serializaing. However, reverse bindings specified by using
; OTHER-REVERSE-BINDINGS take precedence, overriding default reverse bindings.
;
(define (adi-document/save document pathname #!optional other-reverse-bindings)
  (rxi-document/save document pathname
    (if (default-object? other-reverse-bindings)
        *dfxp-preferred-reverse-bindings*
        (append other-reverse-bindings *dfxp-preferred-reverse-bindings*))))
