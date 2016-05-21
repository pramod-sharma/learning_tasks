/*jslint browser: true, plusplus: true, devel:true */
var validURL, authenticSubmit, validId;
function validateURL(Url) {
    "use strict";
    validURL = /((http|https):\/\/)?(w{3}\.)?\w+(\.\w+)?(\.\w{2,3}){1}$/;
    if (validURL.test(Url) === false) {
        alert("please enter a valid URL ");
        authenticSubmit = false;
    }
    return authenticSubmit;
}
function validateEmail(mail) {
    "use strict";
    validId = /^\w+([\.\-]?\w+)?@\w+([\.\-]?\w+)*(\.\w{2,3})+$/;
    if (validId.test(mail) === false) {
        alert("please enter a valid email Id ");
        authenticSubmit = false;
    }
    return authenticSubmit;
}
function checkSubmit() {
    "use strict";
    var textFieldElement, data, authentic, textAreaElement, i, checkbox, authenticSubmit, msg;
    textFieldElement = document.getElementsByClassName("textField");
    for (i = 0; i < textFieldElement.length; i++) {
        authentic = true;
        data = textFieldElement[i].value.trim();
        if (data.length === 0) {
            authentic = false;
        }
          if (authentic === false) {
            alert("Please enter valid value. You can't leave " + textFieldElement[i].id + " field blank");
            authenticSubmit = false;
        } else if (textFieldElement[i].id === "Email") {
            authenticSubmit = validateEmail(data);
        } else if (textFieldElement[i].id === "HomePage") {
            authenticSubmit = validateURL(data);
        }
    }
    textAreaElement = document.getElementById("AboutMe");
    data = textAreaElement.value;
    data = data.trim();
    if (data.length < 50) {
        alert("Please enter atleast 50 characters about you");
        authenticSubmit = false;
    }
    checkbox = document.getElementById("notification");
    msg = checkbox.checked ? "" : " do not";
    if (!confirm("Are you sure you" + msg + " want to receive notification")) {
        checkbox.checked = !checkbox.checked;
    }
    return authenticSubmit;
}