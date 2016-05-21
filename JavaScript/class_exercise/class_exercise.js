/*jslint devel: true */
function User(name, age) {
    "use strict";
    this.name = name;
    this.age = age;
    this.compare = function (user) {
        if (this.age < user.age) {
            alert(user.name + " is older than " + this.name);
        } else if (this.age > user.age) {
            alert(this.name + " is older than " + user.name);
        } else {
            alert(this.name + " is of same age as " + user.name);
        }
    };
}
function createObject() {
    "use strict";
    var user1, user2;
    user1 = new User('kamit', 25);
    user2 =  new User('amit', 23);
    user1.compare(user2);
}
