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
    received: EventRouter('type', {
      newMessage: handleNewMessage,
      syncMessages: handleSyncMessages,
      stateChange: handleStateChange
    })
  });

  function handleNewMessage(message) {
    ChatService.submitMessage(message);
    Render.messageList(ChatService.getMessageList());
  }

  function handleSyncMessages(messages) {
    ChatService.replaceMessageList(messages)
    Render.messageList(ChatService.getMessageList())
  }

  function handleStateChange(state) {
    Render.machineState(state);
  }

  Elements.$chatMessageForm.on('submit', function(evt) {
    evt.preventDefault();

    var messageText = Elements.$messageField.val();
    var username = Elements.$usernameField.val();
    chatChannel.send({username: username, body: messageText});

    Render.messageForm("");
  });

  // We want to focus the message field, but focusing an element doesn't
  // 'stick' for a little while, so we wait 100ms or so
  setTimeout(function() {
    Elements.$messageField.focus();
  }, 100);
});
