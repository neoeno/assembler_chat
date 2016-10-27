//= require chat_service
//= require render
//= require elements

// Here we bind to all our events and also set up our object heirarchy,
// since that also needs to know about the DOM. We'll split that out
// at some point.

$(document).ready(function() {
  var ChatService = ChatServiceFactory();
  var Elements = ElementsFactory();
  var Render = RenderFactory(Elements);

  Elements.$chatMessageForm.on('submit', function(evt) {
    evt.preventDefault();

    ChatService.submitMessage(Elements.$messageField.val());
    Render.messageList(ChatService.getMessageList());
    Render.messageForm("");
  });
});
