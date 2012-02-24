;;; package: (win32 win32-ext)

(declare (usual-integrations))

(define (uint16-offset-ref v offset)
  (let ((b1 (byte-offset-ref v offset))
	(b2 (byte-offset-ref v (1+ offset))))
    (fix:+ (fix:lsh b2 8) b1)))

(define (uint16-offset-set! v offset item)
  (let ((b1 (fix:and item #x00FF))
	(b2 (fix:lsh (fix:and item #xFF00) -8)))
    (byte-offset-set! v offset b1)
    (byte-offset-set! v (1+ offset) b2)
    unspecific))

(define (vector-8b-copy v from to)
  (substring v from to))

(define (utf16-le-substring-find-next-char-using-byte-offsets string start end char)
  (define-integrable (n i)
    (vector-8b-ref string i))
  (define-integrable (le-bytes->digit16 b0 b1)
    (fix:or (fix:lsh b1 8) b0))
  (define-integrable (high-surrogate? n)
    (fix:= #xD800 (fix:and #xFC00 n)))
  (define-integrable (low-surrogate? n)
    (fix:= #xDC00 (fix:and #xFC00 n)))
  (define-integrable (combine-surrogates d0 d1)
    (fix:+ (fix:+ (fix:lsh (fix:and d0 #x3FF) 10) (fix:and d1 #x3FF)) #x10000))
  (let ((code (char-code char)))
    (let loop ((i start))
      (if (fix:> (fix:+ i 2) end)
	  #f
	  (let ((d0 (le-bytes->digit16 (n (fix:+ i 0) ) (n (fix:+ i 1)))))
	    (if (not (high-surrogate? d0))
		(if (fix:= d0 code)
		    i
		    (loop (fix:+ i 2)))
		(if (fix:> (fix:+ i 4) end)
		    (error "Truncated UTF-16 input")
		    (let ((d1 (le-bytes->digit16 (n (fix:+ i 2)) (n (fix:+ i 3)))))
		      (if (not (low-surrogate? d1))
			  (error "Missing UTF-16 Low Surrogate")
			  (let ((c (combine-surrogates d0 d1)))
			    (if (fix:= c code)
				i
				(loop (fix:+ i 4)))))))))))))

(define (utf16-le-ensure-termination string)
  (if (not (utf16-le-string? string))
      (error:wrong-type-argument string "a UTF-16 LE string")
      (let ((nb (string-length string)))
	(if (utf16-le-substring-find-next-char-using-byte-offsets string 0 nb #\U+0)
	    string
	    (string-append string "\000")))))

(define-structure (point (conc-name point/)
                        (constructor %make-point))
  mem)

(define-integrable (point/x r) (int32-offset-ref (point/mem r) 0))
(define-integrable (point/y r) (int32-offset-ref (point/mem r) 4))

(define-integrable (set-point/x! r v) (int32-offset-set! (point/mem r) 0 v))
(define-integrable (set-point/y! r v) (int32-offset-set! (point/mem r) 4 v))

(define (make-point x y)
  (define p (%make-point (make-vector-8b 8 0)))
  (set-point/x! r x)
  (set-point/y! r y)
  p)

(define-structure (text-metrics
		   (conc-name text-metrics/)
		   (constructor %make-text-metrics)
		   (print-procedure
		    (standard-unparser-method 'win32-text-metrics
		      (lambda (object port)
			(text-metrics/unparse object port)))))
  mem)

(define (make-text-metrics)
  (let ((v (make-vector-8b 60 0)))
    (%make-text-metrics v)))

(define-integrable (text-metrics/height tm)
  (int32-offset-ref (text-metrics/mem tm) 0))
(define-integrable (text-metrics/ascent tm)
  (int32-offset-ref (text-metrics/mem tm) 4))
(define-integrable (text-metrics/descent tm)
  (int32-offset-ref (text-metrics/mem tm) 8))
(define-integrable (text-metrics/internal-leading tm)
  (int32-offset-ref (text-metrics/mem tm) 12))
(define-integrable (text-metrics/external-leading tm)
  (int32-offset-ref (text-metrics/mem tm) 16))
(define-integrable (text-metrics/average-width tm)
  (int32-offset-ref (text-metrics/mem tm) 20))
(define-integrable (text-metrics/maximum-width tm)
  (int32-offset-ref (text-metrics/mem tm) 24))
(define-integrable (text-metrics/weight tm)
  (int32-offset-ref (text-metrics/mem tm) 28))
(define-integrable (text-metrics/overhang tm)
  (int32-offset-ref (text-metrics/mem tm) 32))
(define-integrable (text-metrics/digitized-aspect-x tm)
  (int32-offset-ref (text-metrics/mem tm) 36))
(define-integrable (text-metrics/digitized-aspect-y tm)
  (int32-offset-ref (text-metrics/mem tm) 40))
(define-integrable (text-metrics/first-character tm)
  (uint16-offset-ref (text-metrics/mem tm) 44))
(define-integrable (text-metrics/last-character tm)
  (uint16-offset-ref (text-metrics/mem tm) 46))
(define-integrable (text-metrics/default-character tm)
  (uint16-offset-ref (text-metrics/mem tm) 48))
(define-integrable (text-metrics/break-character tm)
  (uint16-offset-ref (text-metrics/mem tm) 50))
(define-integrable (text-metrics/italic tm)
  (int->bool (byte-offset-ref (text-metrics/mem tm) 52)))
(define-integrable (text-metrics/underlined tm)
  (int->bool (byte-offset-ref (text-metrics/mem tm) 53)))
(define-integrable (text-metrics/struck-out tm)
  (int->bool (byte-offset-ref (text-metrics/mem tm) 54)))
(define-integrable (text-metrics/pitch-and-family tm)
  (byte-offset-ref (text-metrics/mem tm) 55))
(define-integrable (text-metrics/character-set tm)
  (byte-offset-ref (text-metrics/mem tm) 56))

(define (text-metrics/unparse tm port)
  (write-char #\newline port)
  (write-line `(height ,(text-metrics/height tm)) port)
  (write-line `(ascent ,(text-metrics/ascent tm)) port)
  (write-line `(descent ,(text-metrics/descent tm)) port)
  (write-line `(internal-leading ,(text-metrics/internal-leading tm)) port)
  (write-line `(external-leading ,(text-metrics/external-leading tm)) port)
  (write-line `(average-width ,(text-metrics/average-width tm)) port)
  (write-line `(maximum-width ,(text-metrics/maximum-width tm)) port)
  (write-line `(weight ,(text-metrics/weight tm)) port)
  (write-line `(overhang ,(text-metrics/overhang tm)) port)
  (write-line `(digitized-aspect-x ,(text-metrics/digitized-aspect-x tm)) port)
  (write-line `(digitized-aspect-y ,(text-metrics/digitized-aspect-y tm)) port)
  (write-line `(first-character ,(text-metrics/first-character tm)) port)
  (write-line `(last-character ,(text-metrics/last-character tm)) port)
  (write-line `(default-character ,(text-metrics/default-character tm)) port)
  (write-line `(break-character ,(text-metrics/break-character tm)) port)
  (write-line `(italic ,(text-metrics/italic tm)) port)
  (write-line `(underlined ,(text-metrics/underlined tm)) port)
  (write-line `(struck-out ,(text-metrics/struck-out tm)) port)
  (write-line `(pitch-and-family ,(text-metrics/pitch-and-family tm)) port)
  (write-line `(character-set ,(text-metrics/character-set tm)) port))

(define-structure (outline-text-metrics
		   (conc-name outline-text-metrics/)
		   (constructor %make-outline-text-metrics))
  mem)

(define (make-outline-text-metrics size)
  (let* ((v (make-vector-8b size 0))
	 (otm (%make-outline-text-metrics v)))
    (set-outline-text-metrics/size! otm size)
    otm))

(define (outline-text-metrics/extract-string otm offset)
  (let*  ((ba (outline-text-metrics/mem otm))
	  (balen (string-length ba))
	  (baoff (uint32-offset-ref ba offset))
	  (end (utf16-le-substring-find-next-char-using-byte-offsets ba baoff balen #\U+0)))
    (utf16-le-string->wide-string (vector-8b-copy ba baoff end))))

(define-integrable (outline-text-metrics/size otm)
  (int32-offset-ref (outline-text-metrics/mem otm) 0))
(define-integrable (set-outline-text-metrics/size! otm v)
  (int32-offset-set! (outline-text-metrics/mem otm) 0 v))
(define-integrable (outline-text-metrics/height otm)
  (int32-offset-ref (outline-text-metrics/mem otm) 4))
(define-integrable (outline-text-metrics/ascent otm)
  (int32-offset-ref (outline-text-metrics/mem otm) 8))
(define-integrable (outline-text-metrics/descent otm)
  (int32-offset-ref (outline-text-metrics/mem otm) 12))
(define-integrable (outline-text-metrics/internal-leading otm)
  (int32-offset-ref (outline-text-metrics/mem otm) 16))
(define-integrable (outline-text-metrics/external-leading otm)
  (int32-offset-ref (outline-text-metrics/mem otm) 20))
(define-integrable (outline-text-metrics/average-width otm)
  (int32-offset-ref (outline-text-metrics/mem otm) 24))
(define-integrable (outline-text-metrics/maximum-width otm)
  (int32-offset-ref (outline-text-metrics/mem otm) 28))
(define-integrable (outline-text-metrics/weight otm)
  (int32-offset-ref (outline-text-metrics/mem otm) 32))
(define-integrable (outline-text-metrics/overhang otm)
  (int32-offset-ref (outline-text-metrics/mem otm) 36))
(define-integrable (outline-text-metrics/digitized-aspect-x otm)
  (int32-offset-ref (outline-text-metrics/mem otm) 40))
(define-integrable (outline-text-metrics/digitized-aspect-y otm)
  (int32-offset-ref (outline-text-metrics/mem otm) 44))
(define-integrable (outline-text-metrics/first-character otm)
  (uint16-offset-ref (outline-text-metrics/mem otm) 48))
(define-integrable (outline-text-metrics/last-character otm)
  (uint16-offset-ref (outline-text-metrics/mem otm) 50))
(define-integrable (outline-text-metrics/default-character otm)
  (uint16-offset-ref (outline-text-metrics/mem otm) 52))
(define-integrable (outline-text-metrics/break-character otm)
  (uint16-offset-ref (outline-text-metrics/mem otm) 54))
(define-integrable (outline-text-metrics/italic otm)
  (int->bool (byte-offset-ref (outline-text-metrics/mem otm) 56)))
(define-integrable (outline-text-metrics/underlined otm)
  (int->bool (byte-offset-ref (outline-text-metrics/mem otm) 57)))
(define-integrable (outline-text-metrics/struck-out otm)
  (int->bool (byte-offset-ref (outline-text-metrics/mem otm) 58)))
(define-integrable (outline-text-metrics/pitch-and-family otm)
  (byte-offset-ref (outline-text-metrics/mem otm) 59))
(define-integrable (outline-text-metrics/character-set otm)
  (uint32-offset-ref (outline-text-metrics/mem otm) 60))
(define-integrable (outline-text-metrics/panose otm)
  (int32-offset-ref (outline-text-metrics/mem otm) 65))
(define-integrable (outline-text-metrics/selection otm)
  (uint32-offset-ref (outline-text-metrics/mem otm) 76))
(define-integrable (outline-text-metrics/type otm)
  (uint32-offset-ref (outline-text-metrics/mem otm) 80))
(define-integrable (outline-text-metrics/slope-rise otm)
  (int32-offset-ref (outline-text-metrics/mem otm) 84))
(define-integrable (outline-text-metrics/slope-run otm)
  (int32-offset-ref (outline-text-metrics/mem otm) 88))
(define-integrable (outline-text-metrics/italic-angle otm)
  (int32-offset-ref (outline-text-metrics/mem otm) 92))
(define-integrable (outline-text-metrics/em-square otm)
  (uint32-offset-ref (outline-text-metrics/mem otm) 96))
(define-integrable (outline-text-metrics/typographic-ascent otm)
  (int32-offset-ref (outline-text-metrics/mem otm) 100))
(define-integrable (outline-text-metrics/typographic-descent otm)
  (int32-offset-ref (outline-text-metrics/mem otm) 104))
(define-integrable (outline-text-metrics/line-gap otm)
  (uint32-offset-ref (outline-text-metrics/mem otm) 108))
(define-integrable (outline-text-metrics/capital-em-height otm)
  (uint32-offset-ref (outline-text-metrics/mem otm) 112))
(define-integrable (outline-text-metrics/x-height otm)
  (uint32-offset-ref (outline-text-metrics/mem otm) 116))
(define-integrable (outline-text-metrics/font-box otm)
  (make-rect (vector-8b-copy (outline-text-metrics/mem otm) 120 16)))
(define-integrable (outline-text-metrics/mac-ascent otm)
  (int32-offset-ref (outline-text-metrics/mem otm) 136))
(define-integrable (outline-text-metrics/mac-descent otm)
  (int32-offset-ref (outline-text-metrics/mem otm) 140))
(define-integrable (outline-text-metrics/mac-line-gap otm)
  (uint32-offset-ref (outline-text-metrics/mem otm) 144))
(define-integrable (outline-text-metrics/minimum-ppem otm)
  (uint32-offset-ref (outline-text-metrics/mem otm) 148))
(define-integrable (outline-text-metrics/subscript-size otm)
  (make-point (vector-8b-copy (outline-text-metrics/mem otm) 152 8)))
(define-integrable (outline-text-metrics/subscript-offset otm)
  (make-point (vector-8b-copy (outline-text-metrics/mem otm) 160 8)))
(define-integrable (outline-text-metrics/superscript-size otm)
  (make-point (vector-8b-copy (outline-text-metrics/mem otm) 168 8)))
(define-integrable (outline-text-metrics/superscript-offset otm)
  (make-point (vector-8b-copy (outline-text-metrics/mem otm) 176 8)))
(define-integrable (outline-text-metrics/strikeout-size otm)
  (uint32-offset-ref (outline-text-metrics/mem otm) 184))
(define-integrable (outline-text-metrics/strikeout-position otm)
  (int32-offset-ref (outline-text-metrics/mem otm) 188))
(define-integrable (outline-text-metrics/underscore-size otm)
  (int32-offset-ref (outline-text-metrics/mem otm) 192))
(define-integrable (outline-text-metrics/underscore-position otm)
  (int32-offset-ref (outline-text-metrics/mem otm) 196))
(define-integrable (outline-text-metrics/family-name otm)
   (outline-text-metrics/extract-string otm 200))
(define-integrable (outline-text-metrics/face-name otm)
   (outline-text-metrics/extract-string otm 204))
(define-integrable (outline-text-metrics/style-name otm)
   (outline-text-metrics/extract-string otm 208))
(define-integrable (outline-text-metrics/full-name otm)
   (outline-text-metrics/extract-string otm 212))

(define-structure (abc-metrics
		   (conc-name abc-metrics/)
		   (constructor %make-abc-metrics)
		   (print-procedure
		    (standard-unparser-method 'win32-abc-metrics
		      (lambda (object port)
			(abc-metrics/unparse object port)))))
  mem)

(define (make-abc-metrics)
  (let ((v (make-vector-8b 12 0)))
    (%make-abc-metrics v)))

(define-integrable (abc-metrics/a tm)
  (uint32-offset-ref (abc-metrics/mem tm) 0))
(define-integrable (abc-metrics/b tm)
  (int32-offset-ref (abc-metrics/mem tm) 4))
(define-integrable (abc-metrics/c tm)
  (uint32-offset-ref (abc-metrics/mem tm) 8))

(define (abc-metrics/unparse tm port)
  (write-char #\newline port)
  (write-line `(a ,(abc-metrics/a tm)) port)
  (write-line `(b ,(abc-metrics/b tm)) port)
  (write-line `(c ,(abc-metrics/c tm)) port))

(define-windows-type lpword
  (lambda (x) (and (vector-8b? x) (zero? (mod (vector-8b-length x) 2)))))

(define-windows-type lpword*
  (lambda (x) (or (eq? x #f)
		  (and (vector-8b? x) (zero? (mod (vector-8b-length x) 2))))))

(define-windows-type lpdword
  (lambda (x) (and (vector-8b? x) (zero? (mod (vector-8b-length x) 4)))))

(define-windows-type lpdword*
  (lambda (x) (or (eq? x #f)
		  (and (vector-8b? x) (zero? (mod (vector-8b-length x) 4))))))

(define-windows-type lplong
  (lambda (x) (and (vector-8b? x) (zero? (mod (vector-8b-length x) 4)))))

(define-windows-type lplong*
  (lambda (x) (or (eq? x #f)
		  (and (vector-8b? x) (zero? (mod (vector-8b-length x) 4))))))

(define-windows-type lpwstr
  (lambda (x) (wide-string? x))
  (lambda (x) (utf16-le-ensure-termination (wide-string->utf16-le-string x)))
  #f
  #f)

(define-windows-type lpwstr*
  (lambda (x) (or (eq? x #f) (wide-string? x)))
  (lambda (x) (and x (ensure-utf16-termination (wide-string->utf16-le-string x))))
  #f
  #f)

(define-windows-type point
  (lambda (x) (point? x))
  (lambda (x) (point/mem x))
  #f
  #f)

(define-windows-type point*
  (lambda (x) (or (eq? x #f) (point? x)))
  (lambda (x) (and x (point/mem x)))
  #f
  #f)

(define-windows-type rect*
  (lambda (x) (or (eq? x #f) (rect? x))
  (lambda (x) (and x (rect/mem x))))
  #f
  #f)

(define-windows-type text-metrics
  (lambda (x) (text-metrics? x))
  (lambda (x) (text-metrics/mem x))
  #f
  (lambda (x y) (set-text-metrics/mem! x y) unspecific))

(define-windows-type outline-text-metrics
  (lambda (x) (outline-text-metrics? x))
  (lambda (x) (outline-text-metrics/mem x))
  #f
  (lambda (x y) (set-outline-text-metrics/mem! x y) unspecific))

(define-windows-type outline-text-metrics*
  (lambda (x) (or (eq? x #f) (outline-text-metrics? x)))
  (lambda (x) (and x (outline-text-metrics/mem x)))
  #f
  (lambda (x y) (if (not (eq? x #f)) (set-outline-text-metrics/mem! x y)) unspecific))

(define-windows-type abc-metrics
  (lambda (x) (abc-metrics? x))
  (lambda (x) (abc-metrics/mem x))
  #f
  (lambda (x y) (set-abc-metrics/mem! x y) unspecific))

(define create-font
  (windows-procedure
   (create-font
    (height int)
    (width int)
    (escapementAngle int)
    (orientationAngle int)
    (weight int)
    (italic bool)
    (underline bool)
    (strikeOut bool)
    (charSet dword)
    (outputPrecision dword)
    (clipPrecision dword)
    (quality dword)
    (pitchAndFamily dword)
    (face lpwstr))
   handle gdi32.dll "CreateFontW"))

(define get-text-metrics
  (windows-procedure
   (get-text-metrics
    (hdc hdc)
    (tm text-metrics))
   handle gdi32.dll "GetTextMetricsW"))

(define get-outline-text-metrics
  (windows-procedure
   (get-outline-text-metrics
    (hdc hdc)
    (size uint)
    (otm outline-text-metrics*))
   handle gdi32.dll "GetOutlineTextMetricsW"))

(define (get-outline-text-metrics-size hdc)
  (get-outline-text-metrics hdc 0 #f))

(define get-abc-metrics
  (windows-procedure
   (get-abc-metrics
    (hdc hdc)
    (first-glyph uint)
    (num-glyphs uint)
    (glyphs lpword*)
    (metrics lpdword))
   handle gdi32.dll "GetCharABCWidthsI"))

(define ext-text-out
  (windows-procedure
   (ext-text-out
    (hdc hdc)
    (x int)
    (y int)
    (options uint)
    (dimensions rect*)
    (text lpwstr)
    (count uint)
    (escapements lplong*))
   bool gdi32.dll "ExtTextOutW"))

(define (win32-graphics/get-font-metrics device)
  (let* ((window (graphics-device/descriptor device))
	 (hdc (win32-device/hdc window))
	 (size (get-outline-text-metrics-size hdc))
	 (otm (make-outline-text-metrics size))
	 (success? (fix:= (get-outline-text-metrics hdc size (outline-text/metrics/mem otm)) size)))
    (if (not success?)
	(graphics-error "Cannot obtain outline font metrics")
	otm)))
