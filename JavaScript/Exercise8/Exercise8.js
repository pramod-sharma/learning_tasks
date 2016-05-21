/*jslint browser: true, plusplus: true, devel:true */
function checkSubmit() {
    "use strict";
    var textFieldElement, data, textAreaElement, i, checkbox, str;
    textFieldElement = document.getElementsByClassName("textInput");
    for (i = 0; i < textFieldElement.length; i++) {
        data = textFieldElement[i].value;
        data = data.trim();
        if (data === "") {
            alert("Please enter valid value. you can't leave " + textFieldElement[i].id + " field blank");
            return false;
        }
    }
    textAreaElement = document.getElementById("AboutMe");
    data = textAreaElement.value;
    data = data.trim();
    if (data.length < 50) {
        alert("Please enter atleast 50 characters about you");
        return false;
    }
    checkbox = document.getElementById("notification");
    if (checkbox.checked) {
        str = "";
    } else {
        str = "do not";
    }
    if (confirm("Are you sure you " + str + " want to receive notifications")) {
        } else {
            checkbox.checked = !checkbox.checked;
        }
}