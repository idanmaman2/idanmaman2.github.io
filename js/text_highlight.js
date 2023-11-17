let url_params = new URLSearchParams(window.location.search);
let search_var = url_params.get('search') ;
if(search_var){
    console.log(search_var);
    var search = document.evaluate(`/html/body//text()[contains(translate(., 
    'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
    'abcdefghijklmnopqrstuvwxyz'),
'${search_var}')]`,
   document, null, XPathResult.ANY_TYPE, null);
   let first_res = search.iterateNext();
   console.log(first_res);
}
else{
    console.log('ok dude')
}

