

all : 
	raco frog -b
	racket ./racket_scripts/mapping.rkt
	tinysearch ./mapping/mapping.json
debug : 
	raco frog -b
	racket ./racket_scripts/mapping.rkt
	tinysearch ./mapping/mapping.json 
	raco frog -p --watch

clean : 
	raco frog --clean