/*jslint browser: true, plusplus: true */
var callingCheckBoxId, childDivNode, childCheckBoxes, loopVariable;
function Check(element) {
    "use strict";
    callingCheckBoxId = element.name;
    childDivNode = document.getElementById(callingCheckBoxId);
    childCheckBoxes = childDivNode.getElementsByTagName("input");
    if (element.checked) {
        childDivNode.setAttribute("style", "display:block; margin-left:20px;");
        childDivNode.scrollIntoView(true);
    } else {
        childDivNode.setAttribute("style", "display:none; margin-left:20px;");
    }
    for (loopVariable = 0; loopVariable < childCheckBoxes.length; loopVariable++) {
            childCheckBoxes[loopVariable].checked = element.checked;
        }
}
