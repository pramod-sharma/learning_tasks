Exercise1:-  Selecting

          Open the file /exercises/index.html in your browser. Use the file /exercises/js/sandbox.js to accomplish the following:

          Select all of the div elements that have a class of "module".

          Come up with three selectors that you could use to get the third item in the #myList unordered list. Which is the best to use? 
          Why?

          Select the label for the search input using an attribute selector.

          Figure out how many elements on the page are hidden

          Figure out how many image elements on the page have an alt attribute.

          Select all of the odd table rows in the table body.

-------------------------------------------------------------------------------------------------------------------------------------------

Exercise2:- Traversing

          Open the file /exercises/index.html in your browser. Use the file /exercises/js/sandbox.js to accomplish the following:

          Select all of the image elements on the page; log each image's alt attribute.

          Select the search input text box, then traverse up to the form and add a class to the form.

          Select the list item inside #myList that has a class of "current" and remove that class from it; add a class of "current" to the 
          next list item.

          Select the select element inside #specials; traverse your way to the submit button.

          Select the first list item in the #slideshow element; add the class "current" to it, and then add a class of "disabled" to its 
          sibling elements.

-------------------------------------------------------------------------------------------------------------------------------------------

Exercise3:-  Manipulating

          Open the file /exercises/index.html in your browser. Use the file /exercises/js/sandbox.js to accomplish the following:

          Add five new list items to the end of the unordered list #myList.
          Remove the odd list items
          Add another h2 and another paragraph to the last div.module
          Add another option to the select element; give the option the value "Wednesday"
          Add a new div.module to the page after the last one; put a copy of one of the existing images inside of it.

-------------------------------------------------------------------------------------------------------------------------------------------

Exercise:-  Create an input hint

          Open the file /exercises/index.html in your browser. Use the file /exercises/js/inputHint.js or work in Firebug. Your task is to 
          use the text of the label for the search input to create "hint" text for the search input. The steps are as follows:

          Set the value of the search input to the text of the label element

          Add a class of "hint" to the search input

          Remove the label element

          Bind a focus event to the search input that removes the hint text and the "hint" class

          Bind a blur event to the search input that restores the hint text and "hint" class if no search text was entered

-------------------------------------------------------------------------------------------------------------------------------------------

Exercise:- Add tabbed navigation.

          Open the file /exercises/index.html in your browser. Use the file /exercises/js/tabs.js. Your task is to create tabbed 
          navigation for the two div.module elements. To accomplish this:

          Hide all of the modules.
          Create an unordered list element before the first module.
          Iterate over the modules using $.fn.each. For each module, use the text of the h2 element as the text for a list item that you 
          add to the unordered list element.
          Bind a click event to the list item that:
          Shows the related module, and hides any other modules
          Adds a class of "current" to the clicked list item
          Removes the class "current" from the other list item
          Finally, show the first tab.

--------------------------------------------------------------------------------------------------------------------------------------------

Exercise:- Reveal hidden text.

          Open the file /exercises/index.html in your browser. Use the file /exercises/js/blog.js. Your task is to add some interactivity 
          to the blog section of the page. The spec for the feature is as follows:

          Clicking on a headline in the #blog div should slide down the excerpt paragraph

          Clicking on another headline should slide down its excerpt paragraph, and slide up any other currently showing excerpt 
          paragraphs.

--------------------------------------------------------------------------------------------------------------------------------------------

Exercise:- Create Drop down menus.

          Open the file /exercises/index.html in your browser. Use the file /exercises/js/navigation.js. Your task is to add dropdowns to 
          the main navigation at the top of the page.

          Hovering over an item in the main menu should show that item's submenu items, if any.

          Exiting an item should hide any submenu items.

          To accomplish this, use the $.fn.hover method to add and remove a class from the submenu items to control whether they're 
          visible or hidden. (The file at /exercises/css/styles.css includes the "hover" class for this purpose.)

          You might want to change the CSS files a little bit for this exercise.

--------------------------------------------------------------------------------------------------------------------------------------------

Exercise:- Create a Slideshow

          This is a tough one if you do not know JS basics and particularly scopes.

          Open the file /exercises/index.html in your browser. Use the file /exercises/js/slideshow.js. Your task is to take a plain 
          semantic HTML page and enhance it with JavaScript by adding a slideshow.

          Move the #slideshow element to the top of the body.

          Write code to cycle through the list items inside the element; fade one in, display it for a few seconds, then fade it out and 
          fade in the next one.

          When you get to the end of the list, start again at the beginning.

          For an extra challenge, create a navigation area under the slideshow that shows how many images there are and which image you're 
          currently viewing. (Hint: $.fn.prevAll will come in handy for this.)

--------------------------------------------------------------------------------------------------------------------------------------------

Exercise :-  Load External Content

          Open the file /exercises/index.html in your browser. Use the file /exercises/js/load.js. Your task is to load the content of a 
          blog item when a user clicks on the title of the item.

          Create a target div after the headline for each blog post and store a reference to it on the headline element using $.fn.data.
          Bind a click event to the headline that will use the $.fn.load method to load the appropriate content from /exercises/data/
          blog.html into the target div. Don't forget to prevent the default action of the click event.

--------------------------------------------------------------------------------------------------------------------------------------------

Exercise :- Load content using JSON

          Open the file /exercises/index.html in your browser. Use the file /exercises/js/specials.js. Your task is to show the user 
          details about the special for a given day when the user selects a day from the select dropdown.

          Append a target div after the form that's inside the #specials element; this will be where you put information about the special 
          once you receive it.
          Bind to the change event of the select element; when the user changes the selection, send an Ajax request to /exercises/data/
          specials.json.

          When the request returns a response, use the value the user selected in the select (hint: $.fn.val) to look up information about 
          the special in the JSON response.
          Add some HTML about the special to the target div you created.
          Finally, because the form is now Ajax-enabled, remove the submit button from the form.
          Note: that we're loading the JSON every time the user changes their selection. How could we change the code so we only make the 
          request once, and then use a cached response when the user changes their choice in the select?

--------------------------------------------------------------------------------------------------------------------------------------------

Exercise :- .live() exercise

          Create a stack of divs. Initially an empty container should display
          - a button on right side says "add item", should add a div to the stack with an incremental number(starting from 1) 
          - clicking any item in the stack should highlight that item
          - clicking the last item on the stack should remove that item from the stack

          hint: use jquery live or delegate.

--------------------------------------------------------------------------------------------------------------------------------------------

Exercise:- Employee Role-Task Management Part One

          Refer this image - https://www.dropbox.com/s/zb9kgshy0lgjmh0/employee_role_task.jpg

          There are 3 sections in the exercise starting from the left
          - Roles section
          - Employees section
          - ToDos section

          "Roles sec" is comprised of All the roles that are there in the company eg:
          - ROR dev
          - Android dev
          etc..

          There is list of employees next to Roles section called "Employee sec".

          Roles sec and ToDos sec will already have Role headers(ROR dev, Android etc..) with no employees under them initially when the 
          page loads.

          Lets do this app in 2 phases:

          Following are the features required for Phase I

          1) User can drag drop employee from employees sec to "Roles sec" under a particular Role header. On dropping the employee there 
          an entry will be created for that employee under "Roles sec" as well as "ToDos sec" under respective
          Role header.

          2) If an employee is already assigned a role then dropping that
          employee under the same role(in "Roles sec") should simply do nothing.

          3) On hovering any employee in "Roles sec" a cross/cancel image will be shown next to that employee(see Hk in image), clicking 
          which a confirmation box will appear, obviously on clicking "OK" that employee's entry should get deleted from Roles sec and 
          Todos sec.

          4) under "ToDos sec" each Role header is collapsable/expandable(see blue minus sign in the image)

          CSS work
          May try to scroll Employees sec along as you scroll the page because Roles sec could attain more height as you add more 
          employees to it.

          IGNORE TODOS for this exercise

          IMP: Please don’t use JS variables local/global to hold any values to determine how an employee will be positioned under a Role 
          header under “ToDos sec”, try to determine that through jQuery by properly structuring your html, making proper use of classes, 
          parent - child methods, may consider storing information in custom attributes for tags etc...

--------------------------------------------------------------------------------------------------------------------------------------------

Exercise:- Employee Role-Task Management Part Two (including Todos)

          Refer to the following diagram : https://www.dropbox.com/s/llxgsvz4bwafji1/employee_role_task_with_todos.jpg

          On clicking + img in "ToDos sec" against each employee, add a todo input area with a save & cancel image links next to it.

          On saving, replace it with text in a div with edit & remove image links against it.

          -You can use an in-place edit plugin or can hand code it.
          
          - As ToDos start growing and gets more than 3 for one user, show a vertical scroll instead of occupying more vertical space(can 
          do it through css also)
          
          - Try using visual effects to play it nicely.

          Clicking remove link against the todo should delete that todo.
          If all Todos for a user are removed bring back the text "Add todos of user"

          Expand all/Collapse all buttons on top of "ToDos section" as shown in the image and should expand/collapse all the Role headers 
          with respective employee's data under them.

          There should be a Search field on the top of the page where user can put number of Todos and it should collapse all Role headers 
          but the ones that have employees under it meeting the search criteria and flashing the employee names for few seconds(just the 
          name on the left not todos)

          Obviously the other employees under the expanded Role header will be shown too but flashing will be done only on the ones that 
          meet the search criteria.

          During search, lets assume that none of the todos are in edit state or new todo state.

          Note: don't keep a count of Todos stored anywhere, structure the html properly so can count todo containers under each employee.
          Negative numbers, alphabets can't be entered.

          On hovering an employee under "Employees section" a delete image link will be show on right side, clicking which a confirmation 
          will be shown followed by removing that employee instances from all places on the page. Note: use the existing code thats 
          already written for removing employee from "Roles sec"

--------------------------------------------------------------------------------------------------------------------------------------------

Exercise:- Preserve Accordion state

          Get the jquery vertical accordion menu and html from the link http://dl.dropbox.com/u/4338625/accordian_implementation.tar.gz

          On clicking leaf/terminal node it should take you to a new page where the menu should retain its state and highlight the leaf 
          node(apply some class to highlight it).

          Please checkout the plugin options in jquery.dcjqaccordion.2.9.js file. 
          You can't use the cookie option thats in the plugin to retain menu state.

          Try writing down a generic function that should work for leaf node at nth sub-level

          Note: the plugin has an option to preserve the dropdown state through cookie, which is enabled by default in the latest FF 
          versions, noticed in 16.0 onwards. Please try this exercise in Chrome.

--------------------------------------------------------------------------------------------------------------------------------------------

Exercise:- Drag and Drop countries

          There is an exercise that you did in JAVASCRIPT track which was :

          Create two multiple selection box like https://www.dropbox.com/s/nxepahp6jc647a9/selection.png

          First box contains list of countries and when you select a country and click on add button. Selected country will disappear from 
          first box and appear in second button. And when you select a country from second box and click on remove button it will 
          disappear from second box and appear in first box

          Pretty simple. Now, in this drop the two buttons and implement the same using drag and drop feature using JQuery UI

          To help you with it , here is a link : 
          http://www.ericbieller.com/2010/06/24/how-to-create-a-simple-drag-and-drop-with-jquery/

--------------------------------------------------------------------------------------------------------------------------------------------

Exercise:- Chipotle Nutrition Calculator

          Refer following archive for text description and images of Chipotle Nutrition Calculator

          http://dl.dropbox.com/u/29811381/VTAPP/chipotle.zip

