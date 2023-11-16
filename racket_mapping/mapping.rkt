#lang racket/base
(require html-parsing)
(require racket/string)
(require racket/list)
; I am planning to go over the sitemap and search for anll the words and then use it with https://lunrjs.com
; to that since there is no know parser to scribbble and I am lazy I will parse the html .
; after that I will write the data to huge json file .
; and then I will send that json file to js that will lunar js will search inside for data .

(define content_tags
    (list 
        "h1"
        "h2"
        "h3"
        "h4"
        "h5"
        "h6"
        "div"
        "p"
        "a"
        "p"
        "span"
    )
)
(define black_list (list 
    "footer"
    "nav"
))



(define (read-file-lines in)
  (let ([line (read-line in)])
    (cond
      [(eof-object? line) (list)]
      [else (append (list line) (read-file-lines in))])))

(define (parse_usrl_endpoint url)
  (let* ([clean_url (string-replace (string-replace url "https://" "") "http://" "")]
         [splitted (string-split clean_url "/")])

    (string-join (take-right splitted (- (length splitted) 1)) "/")))


(define (analyze_html xexp_syntax)


)

(define (to_json )


)



(define sitemap (open-input-file "./sitemap.txt"))
(define test (open-output-file "idk.txt"))
(for ([i (map parse_usrl_endpoint (read-file-lines sitemap))])
  (displayln i)
  (write (html->xexp (string-join (read-file-lines (open-input-file i)) "\n")) 
  test) )
