# Understanding the Methods

## Regular Expressions

There are 3 regular expressions used in this app:
* IP_LOOK_ALIKE: used to disallow an e-mail address with at domain made up of only numbers
* EMAIL_PATTERN: used to match properly formatted email addresses
* NAME_PATTERN: is looking for names in the format of John Doe, or Doe, John it also excepts
  multiple names, but will place the extra names as part of the lastName value

### email_with_name_pattern
This puts all the above regular expressions into one regular expression with groupings
around the:
* The full input string
* Quote (this is to make sure name strings are matched with 2 " or 2 ')
* The First name string
* A comma if found
* The Last name string
* The email address


##  Methods

### add_name_data
This takes in all the name data that has been returned by the regular expression groupings.
first name, last name and e-mail are added to the new element.  In this method, we
check for the comma, if a comma exists, then we assume the name was passed in in
the format of:  Last, First instead of First Last.  In this case, we simply
switch the first and last names.

### check_email_input
This is where all the validation is performed.

First, we get the text that has been entered into the text field.  "(" characters
are replaced with " (" for easier parsing, since Hotmail does not put a space between
the last name character and the beginning of the email string.  Also a space is insert after
any comma, to secure easier matching.

An initial split is done on the input data to break it up based on carriage returns and semi-colons
and then it loops through this array.

Each element is matched on the full name pattern, which will group out:
* The full input string
* Quote (this is to make sure name strings are matched with 2 " or 2 ')
* The First name string
* A comma if found
* The Last name string
* The email address

An email "pill" is created from this data.  If the e-mail is valid, it will display
as pill-email, otherwise it will display as pill-invalid.

The "extra-chars" is because the match algorithm will drop unmatched characters, so
by stripping off the matched e-mail, extra characters can be evaluated and at least
marked as invalid so all entered data is checked.

### click_wrapper
Hides the placeholder text and any existing error messages then places the focus on the
input text field

### create_element
This is passed in both the text and the class of the pill element to be created.
A new "li" element is crated and added the specified class.  From there the e-mail
address, first name and last name is added as the element's data.  Finally, the new element is
added to the div, just ahead of the input field.

### edit_element
This method is called when the user clicks on an e-mail pill that has already been
validated.  It turns the input data in the pill into an input text field and allows
the user to edit the content.

### invalid_email_count
Returns the number of invalid emails entered

### keydown_input
This is called when the user presses a key in the input field.  It checks to see if the
pressed key was the enter or tab, if so, it performs an e-mail validation on the
value that is in the input field.

If a Backspace or Delete key has been entered, it will remove the last email that
had been validated.

### name_data
Returns an array of objects containing the name and e-mail address of each email node
    { firstName: "Mary", lastName: "Smith", email: "msmith@example.com" }

### remove_element
This method is called when the user clicks on the X icon on the right if the pill.  It will
remove the email from the DOM.  This is also called if the user types a backspace or
delete.  In which case it will delete the pill just before the input field.

### reset
Removes all the email nodes from the input area (valid and invalid)

### reset_email_input
Places the input field at the end of whatever e-mail nodes may be apparent and sets
the focus on the input field.

### toggle_sample_text
Checks to see if there are any email nodes validated, if not, displays the placeholder text

### total_email_count
Returns the total number of emails validated (both invalid and valid)

### valid_email_count
Returns the number of valid emails entered

### validate_input
This is called when the user pastes an email list into the input textfield or when
a blur on the input field is triggered.  It simply changes the visibility (if necessary)
of the placeholder text and then goes into validation of the input text.

