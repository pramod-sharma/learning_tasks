function checkForValidity() {
    var textFieldElement, input;
    textFieldElement = document.getElementsByName("textField");
    input = textFieldElement[0].value;
    if (isNaN(input)) {
        textFieldElement[1].value=false;
        return false;   
    } else {
        textFieldElement[1].setAttribute("value",true);
        return true;
    }
}