# EmailNameTextfield

Text area entry tool that allows you to paste e-mail names and addresses from common
mail clients such as Gmail, Yahoo! and Outlook.  This tool will recognize the pasted
input and parse out the first and last name as well as validating the e-mail address.

## Demo

![](https://dl.dropboxusercontent.com/u/86731380/email_input_demo.gif)


## Requirements

* Rails
* CoffeeScript
* Backbone.js
* Underscore.js

## Installation

Add this line to your application's Gemfile:

    gem 'email_name_textfield'

And then execute:

    $ bundle

Add this line to your application.js file after the lines that require
Backbone.js and Underscore.js:

    //= require email_name_textfield

## Usage

Reference this text area by creating a new object:

    myemailnamefield = new EmailNameTextField.EmailInputAreaView(placeholder: "email@address.com")

The placeholder text is simply the text that will appear by default when no e-mail
addresses are shown.

Now, render this object to your view:

    $("mydiv").html(myemailnamefield.render())

Emails will be immediately validated upon pasting or losing the focus on the text area.

To access the resulting list of emails and names call:

    myemailnamefield.name_data()

Result will be an array of JSON objects in the format of:

    { firstName: "Mary", lastName: "Smith", email: "msmith@example.com" }

## Supported email formats

* Gmail -    "Mary Smith" <msmith@example.com>
* Yahoo! -   Mary Smith <msmith@example.com>
* Outlook -  Smith, Mary <msmith@example.com>
* Hotmail -  Mary Smith(msmith@example.com)

### Other formats

* msmith@example.com





## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
