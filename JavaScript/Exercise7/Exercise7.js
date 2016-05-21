/*jslint browser: true, plusplus: true */
function addRemove(sourceBox, destinationBox) {
    "use strict";
    var dataAdditionBox, dataDeletionBox;
    dataAdditionBox = document.getElementById(destinationBox);
    dataDeletionBox = document.getElementById(sourceBox);
    while (dataDeletionBox.selectedIndex !== -1) {
        dataAdditionBox.appendChild(dataDeletionBox.options[dataDeletionBox.selectedIndex]);
    }
}