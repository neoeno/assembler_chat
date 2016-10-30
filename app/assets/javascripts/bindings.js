//= require chat_service
//= require render
//= require elements
//= require event_router

// Here we bind to all our events and also set up our object heirarchy,
// since that also needs to know about the DOM. We'll split that out
// at some point.

$(document).ready(function() {
  var ChatService = ChatServiceFactory();
  var Elements = ElementsFactory();
  var Render = RenderFactory(Elements);

  var chatChannel = App.cable.subscriptions.create("ChatChannel", {
    received: EventRouter('eventType', {
      newMessage: handleNewMessage,
      syncMessages: handleSyncMessages
    })
  });

  function handleNewMessage(evt) {
    ChatService.submitMessage(evt.message);
    Render.messageList(ChatService.getMessageList());
  }

  function handleSyncMessages(evt) {
    evt.messages.forEach(function(message) { ChatService.submitMessage(message); });
    Render.messageList(ChatService.getMessageList())
  }

  Elements.$chatMessageForm.on('submit', function(evt) {
    evt.preventDefault();

    var messageText = Elements.$messageField.val();
    var username = Elements.$usernameField.val();
    chatChannel.send({username: username, body: messageText});

    Render.messageForm("");
  });
});
