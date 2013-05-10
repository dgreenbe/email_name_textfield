class @EmailNameTextField.EmailInputAreaView extends Backbone.View
  IP_LOOK_ALIKE: "[^@]+@(\\d+\\.)+\\d+$"
  EMAIL_PATTERN:  "[\\w!#$%&'*+/=?^`{|}~-]+(?:\\.[\\w!#$%&'*+/=?^`{|}~-]+)*@(?:[\\w](?:[\\w-]*[\\w])?\\.)+[\\w](?:[\\w-]*[\\w])"
  NAME_PATTERN: "([\\w\\xC0-\\xFF'.-]+)(\\s*,)?([\\s,\\w\\xC0-\\xFF'.-]*)"

  events: ->
    'keydown #email_input'  : 'keydown_input'
    'paste #email_input'    : 'validate_input'
    'blur #email_input'     : 'validate_input'
    'click #input_wrapper'  : 'click_wrapper'

  render: =>
    @$el.html @custom_html()

  initialize: ->
    @placeholder = @options.placeholder

  custom_html: ->
    "<div id='input_wrapper'>
      <div class='example-text'>#{@placeholder}</div>
      <ul>
        <li class='input-target'>
          <textarea id='email_input' name='email_input'>
          </textarea>
        </li>
      </ul>

     </div>"

  reset: =>
    $(".email-node").remove()
    @reset_email_input()

  reset_email_input: =>
    $(".input-target").appendTo("#input_wrapper ul")
    $("#email_input").val("").focus()

  total_email_count: =>
    @valid_email_count() + @.invalid_email_count()

  valid_email_count: =>
    $(".pill-email").length

  invalid_email_count: =>
    $(".pill-invalid").length

  name_data: ->
    addrs = _.map $(".pill-email .email-node"), (node) ->
      [
        $(node).data("firstName"),
        $(node).data("lastName"),
        $(node).data("email")
      ]
    JSON.stringify(addrs)

  toggle_sample_text: =>
    if @total_email_count() == 0 then $(".example-text").show() else $(".example-text").hide()

  keydown_input: (e) =>
    @noblur = false
    $email_input = $("#email_input")
    if $email_input.val() != "" && e.which in ctct.keys 'enter tab'
      e.preventDefault()
      @check_email_input()
    if $email_input.val() == "" && e.which in ctct.keys 'backspace delete'
      $(e.currentTarget).parent().prev().remove()
      @trigger 'data_changed'

  click_wrapper: (e) =>
    $(".example-text").hide()
    $('#invalid_email').hide()
    $("#email_input").focus()

  validate_input: (e) =>
    @toggle_sample_text() if e.type == "focusout"
    return if @noblur and e.type == "focusout"
    _.delay 0, => @check_email_input()

  check_email_input: =>
    email_input = $("#email_input").val()
    email_input = email_input.replace(/\(/g, " (").replace(/,([^\s])/g, ", $1")
    return unless email_input?
    splitit = email_input.split(/[\n;]/)
    for inputemail in splitit
      while inputemail.length > 0
        email_match = inputemail.match @email_with_name_pattern()
        if email_match?
          extra_chars = ""
          [input, quote, first, comma, last, email] = email_match
          if (idx = inputemail.indexOf(input)) > 0
            extra_chars = inputemail.substr(0, idx)
            if extra_chars.match(email)
              input = extra_chars + input
              extra_chars = ""
            else
              @create_element(extra_chars.replace(/[,;'"]/g,""), "pill-invalid")
          ip_match = email.match @IP_LOOK_ALIKE
          if ip_match #immediately reject IP emails
            @create_element(input,"pill-invalid")
          else if email.length > 80
            @create_element(input,"pill-invalid")
          else
            @create_element(input,"pill-email")
            @add_name_data(first, comma, last, email)
          inputemail = inputemail.replace(extra_chars,"").replace(input,"")
        else
          @create_element(inputemail.replace(/[,;'"]/g,""), "pill-invalid")
          inputemail = ""
    @trigger 'data_changed'
    @reset_email_input()
    @noblur = true

  create_element: (input, pillclass) =>
    input = $.trim(input)
    input = input.slice(0,-1) if input.match(/[,;]$/)
    return unless input.length > 0
    new_element = $("<li/>").addClass("pill")
    @email_node = $("<span class='email-node'/>").text(input).click(@edit_element)
    delete_anchor = $("<a href='#' class='close delete-email'>&times;</a>").click(@remove_element)
    @email_node.appendTo new_element
    delete_anchor.appendTo new_element
    new_element.addClass pillclass
    new_element.insertBefore $("#email_input").parent()

  add_name_data: (first, comma, last, email) =>
    last = $.trim(last)
    [last, first] = [first, last] if comma?
    first = "" if first == email
    @email_node.data("first-name", first)
    @email_node.data("last-name", last)
    @email_node.data("email", email)

  edit_element: (e) =>
    @check_email_input()
    $email_input = $("#email_input")
    $email_element = $(e.target)
    $email_input.parent().insertBefore($email_element.parent())
    $email_input.val($email_element.text()).focus()
    $email_element.parent().remove()

  remove_element: (e) =>
    e.preventDefault()
    $(e.target).parent().remove()
    @trigger 'data_changed'
    @toggle_sample_text()

  email_with_name_pattern: ->
    ///
      (?:(["'])?
      #{@NAME_PATTERN}
      \1\s+)?       #find name as First Last or Last, First
      [<|(]?                           #start delimiter
      (#{@EMAIL_PATTERN})               #match e-mail
      [>|)]?,?                           #end delimiter
      (?:\s|$)
    ///
