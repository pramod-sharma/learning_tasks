/*jslint browser: true, plusplus: true, devel:true */
var  countRightAnswers = 0, questionsAsked = 0, correctAnswer, randomOperand1, randomOperand2, randomOperator, correctedAnswerString = "", operatorArray = ["+", "-", "*", "/"];
function askQuestion() {
    "use strict";
    if (questionsAsked < 20) {
        questionsAsked++;
        randomOperand1 = Math.floor(Math.random() * 21);
        randomOperand2 = Math.floor(Math.random() * 21);
        randomOperator = operatorArray[Math.floor(Math.random() * 4)];
        document.getElementById("questionToBeAsked").innerHTML = randomOperand1 + " " + randomOperator + " " + randomOperand2 + " " + "=";
    } else {
        document.body.removeChild(document.getElementById("userInput"));
        document.body.removeChild(document.getElementById("button"));
        document.getElementById("questionToBeAsked").innerHTML = "You have attempted " + countRightAnswers + " right Answers out of 20." + " Corrected Answers:- \n " + correctedAnswerString;
    }
}
function checkAnswer() {
    "use strict";
    var  userInput;
    switch (randomOperator) {
    case operatorArray[0]:
        correctAnswer = randomOperand1 + randomOperand2;
        break;
    case operatorArray[1]:
        correctAnswer = randomOperand1 - randomOperand2;
        break;
    case operatorArray[2]:
        correctAnswer = randomOperand1 * randomOperand2;
        break;
    case operatorArray[3]:
        correctAnswer = randomOperand1 / randomOperand2;
        correctAnswer = Math.round(correctAnswer * 10) / 10;
        break;
    }
    userInput = parseFloat(document.getElementById("userInput").value);
    if (userInput === correctAnswer) {
        countRightAnswers++;
    } else {
        correctedAnswerString = correctedAnswerString + "<br>" + questionsAsked + ") " + randomOperand1 + " " + randomOperator + " " + randomOperand2 + " " + "=" + correctAnswer;
    }
    document.getElementById("correctAnswerCount").innerHTML = "your score is: " + countRightAnswers;
    askQuestion();
}