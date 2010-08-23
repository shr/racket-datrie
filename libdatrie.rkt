#lang scheme

(require ffi/unsafe)

(define libdatrie (ffi-lib "libdatrie.so"))

; integer types
(define _dword _uint32)
; alphabet type
(define _alpha-char _uint32)
(define alpha-char-error (cast -1 _int32 _uint32))
; unsigned char
(define _trie-char _uint8)

(define trie-char-term #\nul)
(define trie-char-max 255)

(define _trie-index _int32)
(define trie-index-max #x7fffffff)

(define _trie-data _int32)

(define _alpha-map (_cpointer/null "alpha-map"))

;;; function definitions
(define-syntax defdatrie
  (syntax-rules (:)
    [(_ name : type ...)
     (begin
       (define name (get-ffi-obj
                     (regexp-replaces 'name '((#rx"-" "_")))
                     libdatrie (_fun type ...))))]))

; from alpha-map.h
(defdatrie alpha-map-new : -> _alpha-map)
(defdatrie alpha-map-clone : _alpha-map -> _alpha-map)
(defdatrie alpha-map-free : _alpha-map -> _void)
(defdatrie alpha-map-add-range : _alpha-map _alpha-char _alpha-char -> _int)
(defdatrie alpha-char-strlen : _string/ucs-4 -> _int)