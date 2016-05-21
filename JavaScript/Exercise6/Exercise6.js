/*jslint browser: true, plusplus: true, devel:true*/
function askURLPrompt() {
    "use strict";
    var url;
    url = prompt("Please enter URL ", "");
    url = url.trim();
    if ((url === null) || (url.length === 0)) {
        alert("Enter a valid URL address");
    } else {
        window.open(url, "_blank", "height=450px width=400px  scrollbars=no status=no  location=no titlebar=no resizeable=no scrollable=no");
    }
}