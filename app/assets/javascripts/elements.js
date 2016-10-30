// Fetches all our elements so the rest of the application can
// refer to them

function ElementsFactory() {
  var $messageList = $("#message_list");
  var $chatMessageForm = $("#chat_message_form");
  var $usernameField = $chatMessageForm.find("#chat_message_form_username");
  var $messageField = $chatMessageForm.find("#chat_message_form_body");
  var $machineState = {
    ax: $("#register_ax")
  }

  return {
    $messageList: $messageList,
    $chatMessageForm: $chatMessageForm,
    $usernameField: $usernameField,
    $messageField: $messageField,
    $machineState: $machineState
  };
}
