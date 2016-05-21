/*jslint browser: true, plusplus: true, devel: true */
var checked = 0, checkedArr = [];
function Check(element) {
    "use strict";
    var  indexOfUncheckedElement, noneSelected = document.getElementById("noneSlected");
    if (noneSelected.checked === true) {
        noneSelected.checked = false;
    }
    if (element.checked === true) {
        element.checked = false;
        if (checked === 3) {
            alert("Only 3 days can be selected. You have already selected" + " " + checkedArr.join(","));
        } else {
            element.checked = true;
            checked++;
            checkedArr.push(element.id);
        }
    } else {
        element.checked = false;
        checked--;
        indexOfUncheckedElement = checkedArr.indexOf(element.id);
        checkedArr.splice(indexOfUncheckedElement, 1);
    }
}

function unCheckAll() {
    "use strict";
    var checkBox = document.getElementsByName("days"), i;
    for (i = 0; i < checkBox.length; i++) {
        checkBox[i].checked = false;
    }
    checked = 0;
    checkedArr = [];
}