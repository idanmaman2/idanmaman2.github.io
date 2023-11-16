function doSearch() {
    let value = document.getElementById("demo").value;
    console.log(`Search query: ${value}`);

    const results = search(value, 5);

    console.log(`Results: ${results}`);

    let ul = document.getElementById("results");
    ul.innerHTML = "";

    for (i = 0; i < results.length; i++) {
      var li = document.createElement("li");
      let [title, url] = results[i];
      let elemlink = document.createElement('a');
      elemlink.innerText = title;
      elemlink.setAttribute('href', url);
      li.appendChild(elemlink);
      li.setAttribute('class' , 'list-group-item dropdown-item overflow-auto');
      ul.appendChild(li);
    }
  }
function showDropdown(){
    let ul = document.getElementById("results");
    ul.style.display = 'block';
}
function hideDropdown(){
    setTimeout(function() {
    let ul = document.getElementById("results");
    ul.style.display = "none";}, 200)
}
