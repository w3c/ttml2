;;; -*-Scheme-*-
;;; Package: (dfxp rxi)

;
; DFXP Reduced XML Infoset Load, Save, Transformer
;

(declare (usual-integrations))

;
; The default reverse binding for the XML namespace is represented
; by *XML-DEFAULT-REVERSE-BINDING*.
;
(define *xml-default-reverse-binding*
  '("http://www.w3.org/XML/1998/namespace" . "xml"))

;
; An RXI-BINDINGS structure consists of a BINDINGS slot that contains a
; stack represented as a list of association lists whose keys are XMLNS name
; prefixes and whose values are XMLNS namespace URIs. A binding for the
; "empty" or "null" namespace is designated by a prefix whose value is "".
;
(define-structure
  (rxi-bindings
    (conc-name rxi-bindings/)
    (constructor make-rxi-bindings (#!optional bindings)))
  (bindings '() read-only #f))

;
; Push a list of NEW bindings onto BINDINGS.
;
(define (rxi-bindings/push! bindings new)
  (set-rxi-bindings/bindings!
    bindings
    (cons new (rxi-bindings/bindings bindings))))
  
;
; Pop the list of bindings at the top of BINDINGS.
;
(define (rxi-bindings/pop! bindings)
  (set-rxi-bindings/bindings!
    bindings
    (let ((old (rxi-bindings/bindings bindings)))
      (if (pair? old)
          (cdr old)
          '()))))
  
;
; Look up a binding for the designated XMLNS name PREFIX in BINDINGS,
; returning either an associated XMLNS namespace URI string or '() if
; not found.
;

(define (rxi-bindings/lookup bindings prefix)
  (let find
      ((bindings (rxi-bindings/bindings bindings)))
    (cond ((null? bindings)
           '())
          (else
            (let
                ((b (find-matching-item
                      (car bindings)
                      (lambda (b) (string=? (car b) prefix)))))
              (if (not (false? b))
                  (cdr b)
                  (find (cdr bindings))))))))

;
; Resolve qualified name QNAME to (VALUES LOCAL NSURI) where LOCAL is
; the local (unqualified) component of QNAME and NSURI is the
; associated namespace URI or '() if there is no associated namepsace
; URI, where IS-ATTRIBUTE? indicates whether the QNAME is the name of
; an attribute or an element.
;
; N.B. the lack of a namespace URI is permitted only for unqualified
; attribute names; all element names must have an associated namespace URI
; or an error is signaled. This implies that there must exist a binding for
; the empty (null) namespace prefix when resolving unqualified element
; names.
;
(define (rxi-bindings/resolve bindings qname is-attribute?)
  (let* ((i (string-find-next-char qname #\:))
         (pfx (substring qname 0 (if (false? i) 0 i)))
         (local (string-tail qname (if (false? i) 0 (+ i 1)))))
    (values
      local
      (if (or (> (string-length pfx) 0) (not is-attribute?))
          (let ((uri (rxi-bindings/lookup bindings pfx)))
            (or uri
                (error "unbound XMLNS prefix on prefix" pfx)))
          '()))))
    
;
; An RXI-NAME structure represents the name and namespace properties of a
; reduced XML infoset element or attribute information item and consists of
; a local name LOCAL and an associated namespace NAMESPACE, a non-empty
; string or '(), denoting that the name is not namespace qualified. An
; RXI-NAME is essentially a representation of an XMLNS "expanded name".
;
(define-structure
  (rxi-name (conc-name rxi-name/))
  (local "" read-only #t)
  (namespace '() read-only #t))

;
; Convert an RXI-NAME instance NAME to a list consisting of its constituent
; slots.
;
(define (rxi-name->list name)
  (list (rxi-name/local name)
        (rxi-name/namespace name)))

;
; Transform an XML name IQNAME as defined by the XML package as an uninterned
; symbol to an RXI-NAME, resolving qualified names into their XMLNS
; "expanded name" form, where IS-ATTRIBUTE? indicates whether the QNAME is
; the name of an attribute or an element.
;
(define (rxi-name/transform-from-xml iqname is-attribute? bindings)
  (call-with-values
    (lambda ()
      (rxi-bindings/resolve bindings (symbol-name (xml-name-qname iqname)) is-attribute?))
    make-rxi-name))

;
; An RXI-ATTRIBUTE structure represents a reduced XML infoset attribute
; information item and consists of a NAME represented as an RXI-NAME
; instance and a VALUE represented as a string.
;
(define-structure
  (rxi-attribute (conc-name rxi-attribute/))
  (name '() read-only #t)
  (value "" read-only #t))

;
; Convert an RXI-ATTRIBUTE instance ATTRIBUTE to a list consisting of its
; constituent slots.
;
(define (rxi-attribute->list attribute)
  (list (rxi-name->list (rxi-attribute/name attribute))
        (rxi-attribute/value attribute)))

;
; Transform XML-ATTRIBUTE instance ATTRIBUTE to RXI-ATTRIBUTE instance,
; where BINDINGS is the current bindings stack.
;
(define (rxi-attribute/transform-from-xml attribute bindings)
  (let ((n (xml-attribute-name attribute)) (v (xml-attribute-value attribute)))
    (make-rxi-attribute (rxi-name/transform-from-xml n #t bindings) v)))

;
; An RXI-ELEMENT structure represents a reduced XML infoset element
; information item and consists of a NAME represented as an RXI-NAME
; instance, a possibly empty set of ATTRIBUTES represented as a list of
; RXI-ATTRIBUTE instances, and a possibly empty set of CHILDREN represented
; as a list of string or RXI-ELEMENT instances.
;
(define-structure
  (rxi-element (conc-name rxi-element/))
  (name "" read-only #t)
  (attributes '() read-only #f)
  (children '() read-only #f))

;
; Convert an RXI-ELEMENT instance ELEMENT to a list consisting of its
; constituent slots.
;
(define (rxi-element->list element)
  (list (rxi-name->list (rxi-element/name element))
        (map
          rxi-attribute->list
          (rxi-element/attributes element))
        (map
          (lambda (c)
            (if (string? c)
                c
                (rxi-element->list c)))
          (rxi-element/children element))))

;
; Determine if XML-ATTRIBUTE instance ATTRIBUTE
; is an XMLNS attribute or not, i.e., has a qualified name
; whose prefix is "xmlns" or is the unqualified name "xmlns".
;
(define (namespace-attribute? attribute)
  (let ((qname (symbol-name (xml-name-qname (xml-attribute-name attribute)))))
    (and (string-prefix? "xmlns" qname)
         (or (= (string-length qname) 5)
             (let ((i (string-find-next-char qname #\:)))
               (and (not (false? i)) (= i 5)))))))

;
; Given a list ATTRIBUTES of XML-ATTRIBUTE instances consisting only of
; XMLNS attributes as determined by NAMESPACE-ATTRIBUTE? above, return a set
; of bindings as an association list whose keys are namespace prefixes and
; whose values are the associated namespace URIs.
;
(define (extract-namespace-bindings attributes)
  (map
    (lambda (a)
      (let ((qname (symbol-name (xml-name-qname (xml-attribute-name a)))))
        (if (= (string-match-forward qname "xmlns") 5)
            (cons
             (if (>= (string-length qname) 6)
                 (string-tail qname 6)
                 "")
             (xml-attribute-value a))
            (error "Invalid namespace attribute" qname))))
    attributes))

;
; Transform XML-ELEMENT instance ELEMENT to RXI-ELEMENT instance,
; where BINDINGS is the current bindings stack.
;
(define (rxi-element/transform-from-xml element bindings)
  (let* ((attributes
           (xml-element-attributes element))
         (ns-attributes
           (keep-matching-items attributes namespace-attribute?))
         (other-attributes
           (keep-matching-items
             attributes
             (lambda (a) (not (namespace-attribute? a))))))
    (rxi-bindings/push! bindings (extract-namespace-bindings ns-attributes))
    (let ((rxi-element
            (make-rxi-element
              (rxi-name/transform-from-xml
                (xml-element-name element) #f bindings)
              (map
                (lambda (a) (rxi-attribute/transform-from-xml a bindings))
                other-attributes)
              (map
                (lambda (c)
		  (if (string? c)
		      c
		      (rxi-element/transform-from-xml c bindings)))
		(keep-matching-items
		  (xml-element-contents element)
		  (lambda (x) (or (string? x) (xml-element? x))))))))
      (rxi-bindings/pop! bindings)
      rxi-element)))

;
; An RXI-DOCUMENT structure represents a reduced XML infoset document
; information item and consists of an ANNOTATIONS association list, used for
; internal book-keeping purposes, and an RXI-ELEMENT instance representing
; the document's root element or '() if there is no root element.
;
(define-structure
  (rxi-document (conc-name rxi-document/))
  (annotations '() read-only #f)
  (root '() read-only #f))

;
; Look up value of annotation named KEY on RXI-DOCUMENT instance DOCUMENT.
;
(define (rxi-document/annotation document key)
  (assq key (rxi-document/annotations document)))

;
; Add annotation (KEY . VALUE) to RXI-DOCUMENT instance DOCUMENT.
;
(define (set-rxi-document/annotation! document key value)
  (set-rxi-document/annotations! document (cons (cons key value) (rxi-document/annotations document))))

;
; Remove all annotations named KEY from RXI-DOCUMENT instance DOCUMENT.
;
(define (rxi-document/remove-annotation! document key)
  (del-assq! key (rxi-document/annotations document)))

;
; Convert an RXI-DOCUMENT instance DOCUMENT to a list consisting of its
; constituent slots.
;
(define (rxi-document->list document)
  (list (rxi-document/annotations document)
        (rxi-element->list (rxi-document/root document))))

;
; Transform XML-DOCUMENT instance DOCUMENT to RXI-DOCUMENT instance.
;
(define (rxi-document/transform-from-xml document)
  (let
    ((bindings
      (make-rxi-bindings
        (list (list (cons (cdr *xml-default-reverse-binding*)
                          (car *xml-default-reverse-binding*)))))))
    (make-rxi-document
      '()
      (rxi-element/transform-from-xml (xml-document-root document) bindings))))

;
; Load XML document instance from PATHNAME using XML package's XML parser,
; then transform resulting XML-DOCUMENT instance to an RXI-DOCUMENT
; instance.
;
(define (rxi-document/load pathname)
  (rxi-document/transform-from-xml
    (call-with-input-file pathname
      (lambda (port)
        (read-xml port)))))

;
; An RXI-REVERSE-BINDINGS structure consists of a REVERSE-BINDINGS slot
; that contains an association list whose keys are XMLNS namespace URIs and
; whose values are XMLNS name prefixes. The URI component of a reverse
; binding entry MUST be a non-empty string.
;
(define-structure
  (rxi-reverse-bindings
    (conc-name rxi-reverse-bindings/)
    (constructor make-rxi-reverse-bindings (#!optional reverse-bindings)))
  (reverse-bindings '() read-only #f))

(define (rxi-reverse-bindings/lookup reverse-bindings uri)
  (if (and (string? uri)
           (not (string-null? uri)))
      (let find
          ((rb (rxi-reverse-bindings/reverse-bindings reverse-bindings)))
        (cond ((null? rb)
               '())
              (else
               (let
                   ((b (car rb)))
                 (if (string=? (car b) uri)
                     (cdr b)
                     (find (cdr rb)))))))
      (error "non-string or empty XMLNS namespace URI" uri)))

(define (rxi-reverse-bindings/generate-prefix reverse-bindings)
  (let ((g (lambda () (string-downcase (symbol-name (generate-uninterned-symbol)))))
        (rb (rxi-reverse-bindings/reverse-bindings reverse-bindings)))
    (let loop
        ((pfx '()))
      (cond ((null? pfx)
             (loop (g)))
            (else
             (if (not (find-matching-item
                        rb
                        (lambda (b)
                          (and (string? (cdr b)) (string=? (cdr b) pfx)))))
                 pfx
                 (loop (g))))))))

(define (rxi-reverse-bindings/add! reverse-bindings uri pfx)
  (set-rxi-reverse-bindings/reverse-bindings!
    reverse-bindings
    (cons (cons uri pfx) (rxi-reverse-bindings/reverse-bindings reverse-bindings))))
  
(define (rxi-reverse-bindings/sort! reverse-bindings)
  (let
      ((rb (rxi-reverse-bindings/reverse-bindings reverse-bindings)))
    (set-rxi-reverse-bindings/reverse-bindings!
      reverse-bindings
      (sort rb
            (lambda (x y)
              (string<? (cdr x) (cdr y)))))))

(define (rxi-reverse-bindings/normalize-preferred preferred-reverse-bindings)
  (let ((rbt (make-string-hash-table (length preferred-reverse-bindings)))
        (xrb *xml-default-reverse-binding*))
    (let loop
        ((prb preferred-reverse-bindings))
      (cond ((null? prb)
             (if (not (hash-table/get rbt (car xrb) #f))
                 (hash-table/put! rbt (car xrb) (cdr xrb)))
             (hash-table->alist rbt))
            (else
             (let ((b (car prb)))
               (if (not (pair? b))
                   (error "preferred reverse binding not a pair" b)
                   (let ((u (car b))
                         (p (cdr b)))
                     (if (not (hash-table/get rbt u #f))
                         (hash-table/put! rbt u p))
                     (loop (cdr prb))))))))))

;
; Transform an RXI-NAME instance NAME to an XML name IQNAME as defined by the
; XML package as an uninterned symbol, where IS-ATTRIBUTE? indicates whether
; the IQNAME is the name of an attribute or an element, and where REVERSE-BINDINGS
; is the current reverse bindings.
;
(define (rxi-name/transform-to-xml name is-attribute? reverse-bindings)
  (let ((uri (rxi-name/namespace name))
        (loc (rxi-name/local name)))
    (xml-intern
      (if (null? uri)
          loc
          (let ((pfx (rxi-reverse-bindings/lookup reverse-bindings uri)))
            (if (string-null? pfx)
                loc
                (string-append
                  pfx
                  (string-append ":" loc))))))))
  
;
; Transform RXI-ATTRIBUTE instance ATTRIBUTE to XML-ATTRIBUTE instance.
;
(define (rxi-attribute/transform-to-xml attribute reverse-bindings)
  (cons
    (rxi-name/transform-to-xml (rxi-attribute/name attribute) #t reverse-bindings)
    (rxi-attribute/value attribute)))

(define (maybe-add-reverse-binding! reverse-bindings name)
  (let ((uri (rxi-name/namespace name)))
    (if (not (null? uri))
        (if (not (rxi-reverse-bindings/lookup reverse-bindings uri))
            (rxi-reverse-bindings/add! reverse-bindings uri (rxi-reverse-bindings/generate-prefix reverse-bindings))))))

(define (rxi-element/collect-reverse-bindings element reverse-bindings)
  ;; collect element's binding
  (maybe-add-reverse-binding! reverse-bindings (rxi-element/name element))
  ;; collect attribute reverse-bindings
  (let ((attributes (rxi-element/attributes element)))
    (for-each
      (lambda (a)
        (maybe-add-reverse-binding! reverse-bindings (rxi-attribute/name a)))
      attributes))
  ;; collect childrens' reverse bindings
  (let ((children (rxi-element/children element)))
    (for-each 
      (lambda (c)
        (if (not (string? c))
            (rxi-element/collect-reverse-bindings c reverse-bindings)))
      children)))

;
; Transform RXI-ELEMENT instance ELEMENT to XML-ELEMENT instance.
;
(define (rxi-element/transform-to-xml element reverse-bindings)
  (make-xml-element
    (rxi-name/transform-to-xml (rxi-element/name element) #f reverse-bindings)
    (map
      (lambda (a)
        (rxi-attribute/transform-to-xml a reverse-bindings))
      (rxi-element/attributes element))
    (map
      (lambda (c)
        (if (string? c)
            c
            (rxi-element/transform-to-xml c reverse-bindings)))
      (rxi-element/children element))))

;
; Add XMLNS attributes that correspond with REVERSE-BINDINGS to the root
; element of XML-DOCUMENT instance DOCUMENT. If DOCUMENT has no root
; element, then do nothing.
;
(define (xml-document-add-bindings! document reverse-bindings)
  (let ((root (xml-document-root document)))
    (if (not (null? root))
        (set-xml-element-attributes!
          root
          (append
            (xml-element-attributes root)
            (map
              (lambda (b)
                (let*
                    ((prefix (cdr b))
                     (ns-attr-name
                       (if (string-null? prefix)
                           "xmlns"
                           (string-append "xmlns:" prefix))))
                  (cons (xml-intern ns-attr-name) (car b))))
              (rxi-reverse-bindings/reverse-bindings reverse-bindings)))))))
  
;
; Collect 
;
(define (rxi-document/collect-reverse-bindings document reverse-bindings)
  (let ((root (rxi-document/root document)))
    (if (not (null? root))
        (rxi-element/collect-reverse-bindings root reverse-bindings))
    (rxi-reverse-bindings/sort! reverse-bindings)
    reverse-bindings))

;
; Transform RXI-DOCUMENT instance DOCUMENT to XML-DOCUMENT instance.
;
(define (rxi-document/transform-to-xml document preferred-reverse-bindings)
  (let
      ((reverse-bindings
         (make-rxi-reverse-bindings
           (rxi-reverse-bindings/normalize-preferred preferred-reverse-bindings))))
    (rxi-document/collect-reverse-bindings document reverse-bindings)
    (let
        ((xml-document
          (make-xml-document
           '()                          ; declaration
           '()                          ; misc-1
           '()                          ; dtd
           '()                          ; misc-2
           (rxi-element/transform-to-xml
             (rxi-document/root document) reverse-bindings)
           '())))                       ; misc-3
      (xml-document-add-bindings! xml-document reverse-bindings)
      xml-document)))

;
; Save RXI-DOCUMENT instance DOCUMENT by transforming to an XML-DOCUMENT
; instance and serializing to PATHNAME using XML package's document serializer,
; where optional argument PREFERRED-REVERSE-BINDINGS, if specified, consists
; of an association list whose keys are namespace URIs and values are the
; preferred namespace prefixes to use to designate those namespaces.
;
; If a namepsace URI appears in DOCUMENT and it has no preferred binding
; specified, then a prefix is generated unless the namespace URI is
; "http://www.w3.org/XML/1998/namespace", in which case the prefix "xml" is
; used.
;
(define (rxi-document/save document pathname #!optional preferred-reverse-bindings)
  (let
      ((xml-document
         (rxi-document/transform-to-xml
          document
          (if (default-object? preferred-reverse-bindings)
              '()
              preferred-reverse-bindings))))
    (call-with-output-file pathname
      (lambda (port)
        (write-xml xml-document port)))))
