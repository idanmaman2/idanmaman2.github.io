#lang frog/config

(define/contract (init)
  (-> any)
  (current-scheme/host "http://www.githu.com")
  (current-title "IDHM.Blog")
  (current-author "Idan Maman"))

;; Called once per post and non-post page, on the contents.
(define/contract (enhance-body xs)
  (-> (listof xexpr/c) (listof xexpr/c))
  ;; Here we pass the xexprs through a series of functions.
  (~> xs
      (syntax-highlight #:python-executable (if (eq? (system-type) 'windows)
                                                "python.exe"
                                                "python3")
                        #:line-numbers? #t
                        #:css-class "source")

      (add-racket-doc-links #:code? #t #:prose? #f)
      
  ))

;; Called from `raco frog --clean`.
(define/contract (clean)
  (-> any)
  (void))
