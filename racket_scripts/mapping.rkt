#lang racket/base
(require html-parsing)
(require racket/string)
(require racket/list)
(require json)
; I am planning to go over the sitemap and search for anll the words and then use it with https://lunrjs.com
; to that since there is no know parser to scribbble and I am lazy I will parse the html .
; after that I will write the data to huge json file .
; and then I will send that json file to js that will lunar js will search inside for data .

(define (analyze_html html)

  (define content_tags (list 'h1 'h2 'h3 'h4 'h5 'h6 'div 'code 'a 'p 'span 'strong))
  (define black_list (list 'footer 'nav 'head 'script 'style '*COMMENT* 'href 'class '@ 'ul 'li))

  (let ([html-tag (list-ref html 3)] [res ""] [title ""])
    (define (analyze_rec tag)
      (cond
        [(not (member (car tag) black_list))
         (cond
           [(list? tag)
            (for ([itag (list-tail tag 1)])

              (cond
                [(string? itag)
                 (cond
                   [(member (car tag) content_tags)

                    (let ([cleaned
                           (string-trim (string-trim itag " " #:repeat? #t) "\n" #:repeat? #t)])
                      (cond
                        [(non-empty-string? cleaned) (set! res (string-append res " " cleaned))]))])]
                [(list? itag) (analyze_rec itag)]))])]))
    (analyze_rec html-tag)
    (for ([i (list-tail (list-ref html-tag 4) 1)])
        (cond 
          [
            (and (list? i) (string-ci=? "title" (symbol->string (car i))) ) 
            (set! title (list-ref i 1))
          ]
        )
    )
     (list title (string-normalize-spaces res "\n\r\t \n " #:repeat? #t) ) 
    
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

(define sitemap (open-input-file "./sitemap.txt"))
(define json_file (open-output-file "./mapping/mapping.json" #:exists 'replace))
(write-json
 (map (lambda (i)

       (let*  ([res (analyze_html (html->xexp (string-join (read-file-lines (open-input-file i))
                                                           "\n")))]
                [title (car res)]
                [text (car (cdr res))]
                                                           
                                                           ) (hash 
               'url (string-append  "/" i)
               'title title
               'body text
                    
                                                           
                                                           ) ) )
      (map parse_usrl_endpoint (read-file-lines sitemap))
 )
 
 
 
 json_file)