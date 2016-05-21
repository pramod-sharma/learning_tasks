/*jslint browser: true, plusplus: true, devel:true */
var validURLPattern, url, subDomain, domain;
function findDomain(urlBoxId) {
    "use strict";
    url = document.getElementById(urlBoxId).value;
    url = url.trim();
    validURLPattern = /^(?:(?:http|https):\/\/)?((?:\w{3}\.)?(?:\w+\.)*)+(\w+)?(\.\w{2,4}){1}$/;
    if (validURLPattern.test(url)) {
        domain = RegExp.$2 + RegExp.$3;
        subDomain = RegExp.$1.replace(/\.$/,"");
        if (subDomain === "") {
            alert("Domain: " + domain);
        } else {
            alert("Domain: " + domain + " ," + " SubDomain: "  + subDomain);
        }
        return true;
    } else {
        alert("Please Enter Valid URL");
        return false;
    }
}