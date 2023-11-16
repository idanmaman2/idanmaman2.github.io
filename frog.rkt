#lang frog/config

(define/contract (init)
  (-> any)
  (current-scheme/host "https://idanmaman2.github.io")
  (current-title "IDHM.Blog")
  (current-author "Idan Maman")
  (current-posts-per-page 4)
 )



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
