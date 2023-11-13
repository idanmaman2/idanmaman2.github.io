#lang at-exp racket/base

(require racket/require
         (for-syntax racket/base
                     racket/syntax)
         (multi-in racket (contract/base format string function))
         scribble/srcdoc
         (for-doc racket/base
                  scribble/manual))

(define (github-follow-button [name string?]
                                   [label (or/c #f string?) #f]
                                   list?)
  @{Typically used in a @secref["page-template"].}
  (let ([label (or label (string-append "HELLO WORLD " name))])
    @list{
          <a href="https://twitter.com/@|name|"
             class="twitter-follow-button"
             data-show-count="false"
             data-lang="en">
            "@|label|"
          </a>
          <script type="text/javascript">
            !function(d,s,id){
                var js,fjs=d.getElementsByTagName(s)[0];
                if(!d.getElementById(id)){
                    js=d.createElement(s);
                    js.id=id;
                    js.src="//platform.twitter.com/widgets.js";
                    fjs.parentNode.insertBefore(js,fjs);
                }
            }(document,"script","twitter-wjs");
          </script>
          }))
