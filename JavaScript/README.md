User Class Exercise (Level 1) :-

        Create a class User with name and age as its attribute.

        Instantiate two objects user1 and user2 with some value

        Create a method compare that compares the age of user1 and user2

        The method should be called in this way:

        user1.compare(user2)

        this method should return output like

        "john is older than mary" or "mary is older than john" based on their age comparision.


-----------------------------------------------------------------------------------------------------------------------------------------

Exercise1 (Check all or none) :-

        Create a list of checkbox (red, green, yellow, white, black). Now create two links "Check all" and 'none'. When you click on check 
        all link all checkbox will be selected, and when you click on none link all checkbox will be deselected(working example is gmail).

-----------------------------------------------------------------------------------------------------------------------------------------

Exercise2 (Maximum 3 checkbox selected) :-

        Create a list of checkboxs(Sunday, Monday, Wednesday, Thursday, Tuesday, Friday, Saturday and none). Now when I start checking 
        these checkboxs, it should not let me check more than 3 checkboxes. When I try to check on 4th checkbox it should alert me as 
        "Only 3 days can be selected. You have already selected sunday, monday and tuesday".

        Now when I click on none, all other checkboxs should be deselected. Also when 'none' is selected and I select any other option
        (lets assume sunday), that option(sunday) will be selected and none will be deselected.


-----------------------------------------------------------------------------------------------------------------------------------------

Exercise3 (Dynamic Table - add rows, edit and delete existing rows) :-

        Create a table like https://www.dropbox.com/s/4g5jvz1srttm5jm/table_dom.png

        When you click on 'Add new row' button, it should add a new row in the table, in the name and email column there will a textfield 
        and in the action column there will be a button save. When you enter some value in textfields and click save, values will be saved 
        and textfields will be replaced by the values entered, and save button will be replace by edit / delete links. You should be able 
        to delete row by clicking on the delete link, and edit value by clicking on the edit link.

-----------------------------------------------------------------------------------------------------------------------------------------

Exercise4 (Parent Checkbox and their children checkbox - movies, drinks and bikes) :-

        Create a div with height 100 and scroll bars. Display a list of checkbox color, drinks, movies and bikes in this div. Now when you 
        click on color checkbox it should display four checkboxes(red, yellow, green, blue) as a child list and color checkbox should be 
        checked with its child list of checkboxes. Again when you click on color checkbox child list should be hidden and its child 
        checkboxes should get deselected(clear state). Same with movies, drink and bikes.

        movies: [Dar, Sir]
        drinks: [coke, pepsi, dew]
        bikes: [V-rod, pulsar, cbz]

        Remember: When you click on a parent checkbox and if child list checkboxes are out of visible area the div's scrollbars should 
        scroll and child list should be visible automatically. We should not scroll the div to see them(child list of checkboxes).

------------------------------------------------------------------------------------------------------------------------------------------

Exercise5 ( Form validation using js) :-

        Create a form like https://www.dropbox.com/s/qccm98brx2hdbrw/Form_validation.png and add JS validations to that form.When you 
        click on 'Go' JS will check all text fields, and give an alert like "Login Id can't be empty". One alert per empty field.

        For textarea it should check for empty and min length of 50 characters.

        If any field is invalid then it should not submit the form. Also It should also confirm "receive notification"

------------------------------------------------------------------------------------------------------------------------------------------

Exercise6 (Name input in Alert and Welcome in page content) :-

        Create a HTML page, when it opens in Browser, it should prompt twice. Once for first name and second for last name. When you enter 
        first and last name, it should alert you as "Hello firstname lastname."

        After alert it should put that text in html page.

        Note: Keep in mind when you take inputs from users, always consider cases where user has entered null or blank values(few white 
        spaces). In such cases you should not accept the input.

------------------------------------------------------------------------------------------------------------------------------------------

Exercise7 ( Input URL and open it) :-

        Write a Script that prompts you for a URL. If the input is an empty url it should alert you. Otherwise it should open that URL in 
        a new window of width 400px and height 450px, without any type of bar(status bar, scroll bars etc..).

------------------------------------------------------------------------------------------------------------------------------------------

Exercise8 (Move countries from one box to the other) :-

        Create two multiple selection box like https://www.dropbox.com/s/nxepahp6jc647a9/selection.png

        First box contains list of countries and when you select a country and click on add button. Selected country will disappear from 
        first box and appear in second button. And when you select a country from second box and click on remove button it will disappear 
        from second box and appear in first box

------------------------------------------------------------------------------------------------------------------------------------------

Exercise9 Email and URL format validation :-

        The form you create like https://www.dropbox.com/s/qccm98brx2hdbrw/Form_validation.png

        Add validations for the correct format of email and homepage(url) using regular expressions.

        Please use only Object oriented approach to write your code.

------------------------------------------------------------------------------------------------------------------------------------------

Exercise10 Matching numerical values and event propogation :-

        Create a form with two textfields labeled "Enter Number" and "Result". When I enter something in first textfield and submit the 
        form, it should write true in second textfield if entered value is numeric otherwise false. 
        Also if entered value is not numeric, form should not be submitted.

        Please use only Object oriented approach to write your code.

-------------------------------------------------------------------------------------------------------------------------------------------

Exercise11 domain/subdomain matching :- 

        Create a simple form with a textfield and a submit button. 
        When I enter a URL in this textfield and submit the form, it should alert me the domain name from the entered url. For example, if 
        I enter http://example.com/folder/file.html, then on submitting the form it should alert something like: "Domain: example.com".

        And when I enter a url with subdomain, it should alert the subdomain too. Example: If I enter http://vinsol.example.com/folder/
        file.html, then on submitting the form it should alert something like: "Domain: example.com, Subdomain: vinsol".

        Basic Idea is to extract domain name and subdomain from a URL.

        Note: Use Regular Expressions for this exercise.
        Please use only Object oriented approach to write your code.

-------------------------------------------------------------------------------------------------------------------------------------------

Exercise: Arithmetic Quiz :-

        Create a quiz, which asks 20 mathematical questions to the participant, one at a time.

        The quiz should generate two random numbers less than 20 and then pick an operator randomly ( add, subtract, divide, multiply)

        Ask the question to the user and evaluate it when the user moves to the next screen and show the score at the bottom.

        User should not be allowed to go back and edit answers.

        Show them the final score and correct answers for any wrong question on the last screen.

        Please take Object Oriented Approach


