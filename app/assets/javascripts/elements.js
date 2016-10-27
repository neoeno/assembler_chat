// Fetches all our elements so the rest of the application can
// refer to them

function ElementsFactory() {
  var $messageList = $("#message_list");
  var $chatMessageForm = $("#chat_message_form");
  var $messageField = $chatMessageForm.find("#message");

  return {
    $messageList: $messageList,
    $chatMessageForm: $chatMessageForm,
    $messageField: $messageField
  };
}
