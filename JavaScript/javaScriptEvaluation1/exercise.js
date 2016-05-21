/*jslint browser: true, plusplus: true */
var jsonNameArray = { "nameArray": [{"name": "pramod"}, {"name": "pramit"},
                                {"name": "param"}, {"name": "mohit"},
                                {"name": "vishal"}, {"name": "sunil"},
                                {"name": "piyush"}, {"name": "shj"},
                                {"name": "Akshat"}, {"name": "alpha"},
                                {"name": "beta"}, {"name": "gamma"},
                                {"name": "tally"}, {"name": "name"},
                                {"name": "fake"}, {"name": "linus"},
                                {"name": "shell"}, {"name": "kamal"},
                                {"name": "akshat"}, {"name": "aprajit"}]
                    };
var displayBox, newselectBox, selectBox, enteredString, suggestionsArray = [];

function generateSuggestions() {
    "use strict";
    var loopVariable1, loopVariable2, nameInOtherBox, names;
    for (loopVariable1 = 0; loopVariable1 < jsonNameArray.nameArray.length; loopVariable1++) {
        names = jsonNameArray.nameArray[loopVariable1].name;
        if (displayBox.options.length !== 0) {
            for (loopVariable2 = 0; loopVariable2 < displayBox.options.length; loopVariable2++) {
                if (names === displayBox.options[loopVariable2].textContent) {
                    nameInOtherBox = true;
                    break;
                } else {
                    nameInOtherBox = false;
                }
            }
        } else {
            nameInOtherBox = false;
        }  
        if (names.indexOf(enteredString) === 0 && !nameInOtherBox) {
            suggestionsArray.push(names);
            suggestionsArray.push(loopVariable1); 
        }
    }
}

function displaySuggestions() {
    var loopVariable, newOption, text;
    while(selectBox.options.length !== 0) {
        optionToBeRemoved = selectBox.options[0];
        selectBox.removeChild(optionToBeRemoved);
    }        
    for (loopVariable = 0; loopVariable<suggestionsArray.length; loopVariable++) { 
        newOption = document.createElement("option");
        text = document.createTextNode(suggestionsArray[loopVariable]);
        loopVariable++;
        newOption.setAttribute("onclick", "transferName(" + suggestionsArray[loopVariable] + ")");
        newOption.setAttribute("id",suggestionsArray[loopVariable]);
        newOption.appendChild(text);
        selectBox.appendChild(newOption);
    }
    if (selectBox.options.length === 0) {
        selectBox.style.display = "none";
    } else {
        selectBox.style.display = "block";
    }
    selectBox.size = selectBox.options.length + 1;
}

function suggestName() {
    "use strict";
    var divSelectBox;
    suggestionsArray = [];
    enteredString = document.getElementById("textBox").value;
    selectBox = document.getElementById("selectBox");
    displayBox = document.getElementById("selectedNameDisplay");
    if (enteredString === "") {
        selectBox.style.display = "none";
    } else {
        generateSuggestions();
        displaySuggestions();
    }
}

function transferName(id) {
    "use strict";
    var selectBox, displayBox, optionToTransfer;
    selectBox = document.getElementById("selectBox");
    displayBox = document.getElementById("selectedNameDisplay");
    optionToTransfer = document.getElementById(id);
    optionToTransfer.removeAttribute("onclick");
    displayBox.style.display = "block";
    displayBox.appendChild(optionToTransfer);
    displayBox.size = displayBox.options.length + 1;
    if (selectBox.options.length === 0) {
        selectBox.style.display = "none";
    }
    selectBox.size = selectBox.options.length + 1;
}
