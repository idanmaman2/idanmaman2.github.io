#lang scribble/manual

Title: My setup for apple M1/2
Date: 2023-11-13T00:00:00
Tags: M1,M2,Pwning,Reversing

@(require (for-label racket))
@(require racket/string)
The source of this post is Scribble format (not Markdown) - SO YEY I guess or somethind IDC.

So Today I am going to show you my setup .
that will include :
@tabular[#:sep @hspace[1]
         (list (list @bold{Subject} @bold{Tools})
               (list "Emulation"       "Using UTM4-qemu with ubuntu server or arch")
               (list "Virtualization"       "Using VMWARE Fusion")
               (list "Terminal"       "Using Warp")
               (list "Reversing tools"       (string-join `("Ghidra"
                                                            "IDA"
                                                            "XELF Viewer"
                                                            "PortExgui"
                                                            "Pe Bear" ) " , " )  )
          )
         ]


<!-- more -->

@section[#:style 'unnumbered]{Emulation}

So Emulation in macos in the m series is a nightmare everthing is so slow if we are trying to use any graphicl feature or something like that . 
this is why I recommend to install a server version or any os without desktop env . 
Personaly I use Ubuntu server . 

@subsection[#:style 'unnumbered]{Setup}

So firstly you need to Install  
@hyperlink["https://mac.getutm.app"
"UTM"].

UTM is just a gui warpper of qemu - so if you are in kernel pwning just use qemu directly . 

so after that we can add a machine - 

@image["img/posts/2023-11-13-m1-2-setup-for-pwning-and-reversing/Screenshot 2023-11-14 at 0.00.15.png"]

A @racket[codeblock] uses curly braces and @emph{does} retain
comments:

@codeblock{
;; Finds Racket sources in all subdirs
(for ([path (in-directory)])
  (when (regexp-match? #rx"[.]rkt$" path)
    (printf "source file: ~a\n" path)))
(define (foo #:bar bar)
  #t)
}

A @racket[racketblock] uses square brackets and does @emph{not}
retain comments:

@racketblock[
;; Finds Racket sources in all subdirs
(for ([path (in-directory)])
  (when (regexp-match? #rx"[.]rkt$" path)
    (printf "source file: ~a\n" path)))
(define (foo #:bar bar)
  #t)
]

Here is a @racket[interaction]:

@(require racket/sandbox
          scribble/eval)
@(define my-tr-evaluator
   (parameterize ([sandbox-output 'string]
                  [sandbox-error-output 'string]
                  [sandbox-memory-limit #f]
                  [sandbox-eval-limits #f])
     (make-evaluator 'typed/racket/base)))
@interaction[#:eval my-tr-evaluator
(: my-sqr (Real -> Real))
(define (my-sqr x)
(* x x))
(my-sqr 42)]

Here's a fancier one:

@interaction[
(require slideshow/pict)
(define rainbow-colors
  '("red" "orange" "yellow" "green" "blue" "purple"))
(for/list ([c rainbow-colors])
   (colorize (filled-rounded-rectangle 20 20) c))
(for/list ([c rainbow-colors]
           [dir (in-cycle '(right left))])
  (standard-fish 25 25 #:color c #:direction dir))
(cc-superimpose
 (cc-superimpose (cloud 100 80 "lightblue")
                 (cloud 90 70 "white"))
 (hc-append 10
  (standard-fish 30 30 #:color "red" #:direction 'right)
  (standard-fish 25 20 #:color "blue" #:direction 'left)))
]

Here's an example of using Pygments to syntax highlight non-Racket
code:

@(require frog/scribble)

@pygment-code[#:lang "js"]{
function foo() {
  return 7;
}
}
